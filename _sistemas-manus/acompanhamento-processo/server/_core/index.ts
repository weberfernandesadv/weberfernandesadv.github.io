import "dotenv/config";
import express from "express";
import { createServer } from "http";
import net from "net";
import { createExpressMiddleware } from "@trpc/server/adapters/express";
import { registerOAuthRoutes } from "./oauth";
import { registerStorageProxy } from "./storageProxy";
import { appRouter } from "../routers";
import { createContext } from "./context";
import { serveStatic, setupVite } from "./vite";
import { parse as parseCookie } from "cookie";

function isPortAvailable(port: number): Promise<boolean> {
  return new Promise(resolve => {
    const server = net.createServer();
    server.listen(port, () => {
      server.close(() => resolve(true));
    });
    server.on("error", () => resolve(false));
  });
}

async function findAvailablePort(startPort: number = 3000): Promise<number> {
  for (let port = startPort; port < startPort + 20; port++) {
    if (await isPortAvailable(port)) {
      return port;
    }
  }
  throw new Error(`No available port found starting from ${startPort}`);
}

async function startServer() {
  const app = express();
  const server = createServer(app);

  // Configure CORS headers
  app.use((req, res, next) => {
    const origin = req.headers.origin;
    if (origin) {
      res.header("Access-Control-Allow-Origin", origin);
      res.header("Access-Control-Allow-Credentials", "true");
    } else {
      res.header("Access-Control-Allow-Origin", "*");
    }
    res.header("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS");
    res.header("Access-Control-Allow-Headers", "Content-Type, Authorization, Cookie");
    if (req.method === "OPTIONS") {
      return res.sendStatus(200);
    }
    next();
  });

  // Configure body parser with larger size limit for file uploads
  app.use(express.json({ limit: "50mb" }));
  app.use(express.urlencoded({ limit: "50mb", extended: true }));
  registerStorageProxy(app);
  registerOAuthRoutes(app);

  // Public endpoint to save leads from the website
  app.post("/api/leads", async (req, res) => {
    try {
      const { nome, telefone, advogado, mensagem } = req.body;
      if (!nome || !telefone || !advogado) {
        return res.status(400).json({ error: "Nome, telefone e advogado são obrigatórios." });
      }
      const { saveLead } = await import("../db");
      await saveLead({
        nome,
        telefone,
        advogado,
        mensagem: mensagem || null
      });
      console.log(`[API Leads] Saved lead for ${advogado}: ${nome} (${telefone})`);
      return res.status(200).json({ success: true });
    } catch (error: any) {
      console.error("[API Leads] Error saving lead:", error);
      return res.status(500).json({ error: error.message || "Erro interno do servidor." });
    }
  });

  // Public Endpoint to login from Astro site and set session cookie
  app.post("/api/login", async (req, res) => {
    try {
      const { login, password } = req.body;
      if (!login || !password) {
        return res.status(400).json({ error: "E-mail/CPF e senha são obrigatórios." });
      }
      
      const { getUserByEmail, getUserByCpf } = await import("../db");
      const { verifyPassword } = await import("../authHelper");
      
      const isEmail = login.includes("@");
      const user = isEmail
        ? await getUserByEmail(login)
        : await getUserByCpf(login.replace(/\D/g, ""));
        
      if (!user || !user.passwordHash || !verifyPassword(password, user.passwordHash)) {
        return res.status(401).json({ error: "E-mail/CPF ou senha incorretos." });
      }
      
      const { sdk } = await import("./sdk");
      const sessionToken = await sdk.createSessionToken(user.email || user.cpf || user.openId, {
        name: user.name || "",
        expiresInMs: 31536000000 // 1 year
      });
      
      res.cookie("app_session_id", sessionToken, {
        maxAge: 31536000000,
        httpOnly: false, // Let the frontend check or clear it
        path: "/",
        sameSite: "lax"
      });
      
      return res.status(200).json({
        success: true,
        token: sessionToken,
        user: {
          name: user.name,
          email: user.email,
          cpf: user.cpf,
          role: user.role
        }
      });
    } catch (e: any) {
      console.error("[API Login] Error:", e);
      return res.status(500).json({ error: e.message || "Erro interno do servidor." });
    }
  });

  // Public Endpoint to logout and clear session cookie
  app.post("/api/logout", (req, res) => {
    res.clearCookie("app_session_id", { path: "/" });
    return res.status(200).json({ success: true });
  });

  // Endpoint to check session from the Astro website
  app.get("/api/user-session", async (req, res) => {
    try {
      const user = await authenticateSession(req);
      if (!user) {
        return res.status(200).json({ loggedIn: false });
      }
      
      return res.status(200).json({
        loggedIn: true,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          cpf: user.cpf,
          role: user.role,
          cidade: user.cidade,
          estado: user.estado,
          fotoUrl: user.fotoUrl
        }
      });
    } catch (e: any) {
      console.error("[API Session] Error:", e);
      return res.status(200).json({ loggedIn: false });
    }
  });

  // Helper function to authenticate session cookies and Authorization Bearer headers
  async function authenticateSession(req: express.Request): Promise<any | null> {
    try {
      let sessionCookie: string | undefined;

      const authHeader = req.headers.authorization;
      if (authHeader && authHeader.startsWith("Bearer ")) {
        sessionCookie = authHeader.substring(7);
      } else if (req.headers.cookie) {
        const parsedCookies = parseCookie(req.headers.cookie);
        sessionCookie = parsedCookies["app_session_id"];
      }

      if (!sessionCookie) return null;
      
      const { sdk } = await import("./sdk");
      const session = await sdk.verifySession(sessionCookie);
      if (!session) return null;
      
      const { getUserByEmail, getUserByOpenId } = await import("../db");
      let user;
      if (session.openId.includes("@")) {
        user = await getUserByEmail(session.openId);
      } else {
        user = await getUserByOpenId(session.openId);
      }
      return user || null;
    } catch (e) {
      return null;
    }
  }

  // API to register public users (Name, Email, Password, City, State, Photo)
  app.post("/api/public-register", async (req, res) => {
    try {
      const { name, email, password, cidade, estado, fotoUrl } = req.body;
      if (!name || !email || !password || !cidade || !estado) {
        return res.status(400).json({ error: "Todos os campos (nome, e-mail, senha, cidade, estado) são obrigatórios." });
      }
      const { registerPublicUser } = await import("../db");
      const { hashPassword } = await import("../authHelper");
      
      const passwordHash = hashPassword(password);
      await registerPublicUser(name, email, passwordHash, cidade, estado, fotoUrl || "");
      
      // Auto-login after registration! Set cookie so they are logged in right away!
      const { sdk } = await import("./sdk");
      const sessionToken = await sdk.createSessionToken(email, {
        name: name,
        expiresInMs: 31536000000 // 1 year
      });
      
      res.cookie("app_session_id", sessionToken, {
        maxAge: 31536000000,
        httpOnly: false,
        path: "/",
        sameSite: "lax"
      });
      
      return res.status(200).json({
        success: true,
        token: sessionToken,
        user: {
          name,
          email,
          role: "user"
        }
      });
    } catch (error: any) {
      console.error("[API Public Register] Error:", error);
      return res.status(500).json({ error: error.message || "Erro interno do servidor." });
    }
  });

  // API to get list of collaborative articles
  app.get("/api/artigos", async (req, res) => {
    try {
      const user = await authenticateSession(req);
      const { getArtigos } = await import("../db");
      const articles = await getArtigos(user?.id);
      return res.status(200).json({ artigos: articles });
    } catch (error: any) {
      console.error("[API Get Artigos] Error:", error);
      return res.status(500).json({ error: error.message || "Erro interno do servidor." });
    }
  });

  // API to create a collaborative article
  app.post("/api/artigos", async (req, res) => {
    try {
      const user = await authenticateSession(req);
      if (!user) {
        return res.status(401).json({ error: "Não autorizado. Faça o login." });
      }

      if (user.role !== "admin") {
        return res.status(403).json({ error: "Apenas advogados autorizados podem publicar artigos." });
      }
      
      const { titulo, conteudo, tipo, categoria } = req.body;
      if (!titulo || !conteudo) {
        return res.status(400).json({ error: "Título e Conteúdo são obrigatórios." });
      }
      
      const { createArtigo } = await import("../db");
      await createArtigo({
        userId: user.id,
        titulo,
        conteudo,
        tipo: tipo || "Artigo",
        categoria: categoria || "Geral"
      });
      
      return res.status(200).json({ success: true });
    } catch (error: any) {
      console.error("[API Create Artigo] Error:", error);
      return res.status(500).json({ error: error.message || "Erro interno do servidor." });
    }
  });

  // API to toggle like on article
  app.post("/api/artigos/curtir", async (req, res) => {
    try {
      const user = await authenticateSession(req);
      if (!user) {
        return res.status(401).json({ error: "Não autorizado. Faça o login." });
      }
      const { artigoId } = req.body;
      if (!artigoId) {
        return res.status(400).json({ error: "ID do artigo é obrigatório." });
      }
      
      const { toggleLike } = await import("../db");
      const result = await toggleLike(user.id, parseInt(artigoId));
      return res.status(200).json({ success: true, ...result });
    } catch (error: any) {
      console.error("[API Like Artigo] Error:", error);
      return res.status(500).json({ error: error.message || "Erro interno do servidor." });
    }
  });

  // API to toggle save on article
  app.post("/api/artigos/salvar", async (req, res) => {
    try {
      const user = await authenticateSession(req);
      if (!user) {
        return res.status(401).json({ error: "Não autorizado. Faça o login." });
      }
      const { artigoId } = req.body;
      if (!artigoId) {
        return res.status(400).json({ error: "ID do artigo é obrigatório." });
      }
      
      const { toggleSave } = await import("../db");
      const result = await toggleSave(user.id, parseInt(artigoId));
      return res.status(200).json({ success: true, ...result });
    } catch (error: any) {
      console.error("[API Save Artigo] Error:", error);
      return res.status(500).json({ error: error.message || "Erro interno do servidor." });
    }
  });

  // API to get comments for article
  app.get("/api/artigos/comentarios", async (req, res) => {
    try {
      const { artigoId } = req.query;
      if (!artigoId) {
        return res.status(400).json({ error: "ID do artigo é obrigatório." });
      }
      const { getComentarios } = await import("../db");
      const comments = await getComentarios(parseInt(artigoId as string));
      return res.status(200).json({ comentarios: comments });
    } catch (error: any) {
      console.error("[API Get Comentarios] Error:", error);
      return res.status(500).json({ error: error.message || "Erro interno do servidor." });
    }
  });

  // API to add comment to article
  app.post("/api/artigos/comentarios", async (req, res) => {
    try {
      const user = await authenticateSession(req);
      if (!user) {
        return res.status(401).json({ error: "Não autorizado. Faça o login." });
      }
      
      const { artigoId, texto } = req.body;
      if (!artigoId || !texto) {
        return res.status(400).json({ error: "ID do artigo e texto do comentário são obrigatórios." });
      }
      
      const { addComentario } = await import("../db");
      await addComentario({
        userId: user.id,
        artigoId: parseInt(artigoId),
        texto
      });
      
      return res.status(200).json({ success: true });
    } catch (error: any) {
      console.error("[API Add Comentario] Error:", error);
      return res.status(500).json({ error: error.message || "Erro interno do servidor." });
    }
  });

  // tRPC API
  app.use(
    "/api/trpc",
    createExpressMiddleware({
      router: appRouter,
      createContext,
    })
  );
  // development mode uses Vite, production mode uses static files
  if (process.env.NODE_ENV === "development") {
    await setupVite(app, server);
  } else {
    serveStatic(app);
  }

  const preferredPort = parseInt(process.env.PORT || "3000");
  const port = await findAvailablePort(preferredPort);

  if (port !== preferredPort) {
    console.log(`Port ${preferredPort} is busy, using port ${port} instead`);
  }

  server.listen(port, () => {
    console.log(`Server running on http://localhost:${port}/`);
  });
}

startServer().catch(console.error);
