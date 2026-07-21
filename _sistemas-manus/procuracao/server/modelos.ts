/**
 * Rotas para Modelos Dinâmicos.
 * O administrador faz upload de um .docx com os mesmos placeholders do modelo padrão.
 * O sistema gera um link público /modelo/:slug para o cliente preencher.
 *
 * POST   /api/admin/modelos              → upload .docx, salva no storage e banco
 * GET    /api/admin/modelos              → lista todos os modelos (admin)
 * PATCH  /api/admin/modelos/:id/toggle   → ativar/desativar modelo (admin)
 * DELETE /api/admin/modelos/:id          → excluir modelo (admin)
 * GET    /api/modelo/:slug               → dados do modelo (público, para o formulário)
 * POST   /api/modelo/:slug               → cliente envia dados → gera doc → notifica admin
 * GET    /api/admin/modelos/:id/submissoes → lista submissões de um modelo (admin)
 * GET    /api/admin/submissoes/:id/download → download do documento gerado (admin)
 * GET    /api/download-modelo/:token     → download público por token
 */
import { Router, Request, Response } from "express";
import { z } from "zod";
import path from "path";
import PizZip from "pizzip";
import { randomUUID } from "crypto";
import multer, { FileFilterCallback } from "multer";
import {
  salvarModeloDinamico, listarModelosDinamicos, buscarModeloPorSlug, buscarModeloPorId,
  toggleModeloAtivo, deletarModeloDinamico,
  salvarSubmissaoModelo, listarSubmissoesPorModelo, buscarSubmissaoPorToken, buscarSubmissaoPorId,
  marcarSubmissaoGerada,
} from "./db";
import { notifyOwner } from "./_core/notification";
import { sdk } from "./_core/sdk";
import { storagePut, storageGet } from "./storage";
import { substituirNoXml, dataPorExtenso } from "./procuracao";

export const modelosRouter = Router();

// ─── Multer: armazena em memória (máx 10 MB) ─────────────────────────────────
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 },
  fileFilter: (_req: Request, file: Express.Multer.File, cb: FileFilterCallback) => {
    if (file.mimetype === "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      || file.originalname.endsWith(".docx")) {
      cb(null, true);
    } else {
      cb(new Error("Apenas arquivos .docx são aceitos"));
    }
  },
});

// ─── Middleware de autenticação admin ─────────────────────────────────────────
async function requireAdmin(req: Request, res: Response, next: () => void) {
  try {
    const user = await sdk.authenticateRequest(req);
    if (!user || user.role !== "admin") {
      res.status(403).json({ erro: "Acesso negado — apenas administradores" });
      return;
    }
    next();
  } catch {
    res.status(401).json({ erro: "Não autenticado" });
  }
}

// ─── Schema do outorgante (mesmo do formulário padrão) ────────────────────────
const OutorganteSchema = z.object({
  nome: z.string().min(3, "Nome completo é obrigatório"),
  genero: z.string().min(2, "Gênero é obrigatório"),
  estadoCivil: z.string().min(2, "Estado civil é obrigatório"),
  profissao: z.string().min(2, "Profissão é obrigatória"),
  cpf: z.string().regex(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/, "CPF inválido"),
  rg: z.string().min(3, "RG é obrigatório"),
  naturalidade: z.string().min(2, "Naturalidade é obrigatória"),
  nomePai: z.string().min(2, "Nome do pai é obrigatório"),
  nomeMae: z.string().min(2, "Nome da mãe é obrigatória"),
  rua: z.string().min(3, "Rua/Avenida é obrigatória"),
  quadra: z.string().optional(),
  lote: z.string().optional(),
  setor: z.string().optional(),
  cidade: z.string().min(2, "Cidade é obrigatória"),
  estado: z.string().optional(),
  cep: z.string().regex(/^\d{5}-\d{3}$/, "CEP inválido"),
  dataAssinatura: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/, "Data inválida — use DD/MM/AAAA"),
});

// ─── Gerador de slug a partir do nome ────────────────────────────────────────
function gerarSlug(nome: string): string {
  return nome
    .toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .substring(0, 80)
    + "-" + randomUUID().substring(0, 6);
}

// ─── Gerador de documento dinâmico ───────────────────────────────────────────
async function gerarDocumentoDinamico(fileKey: string, d: z.infer<typeof OutorganteSchema>): Promise<Buffer> {
  // Busca o arquivo do storage
  const { url } = await storageGet(fileKey);
  // Faz download do arquivo do storage
  const resp = await fetch(url);
  if (!resp.ok) throw new Error("Erro ao baixar modelo do storage");
  const arrayBuffer = await resp.arrayBuffer();
  const content = Buffer.from(arrayBuffer).toString("binary");

  const zip = new PizZip(content);
  let xml = zip.file("word/document.xml")!.asText();

  const nome = d.nome.trim().toUpperCase();

  // Montar endereço
  let endereco = d.rua;
  if (d.quadra) endereco += `, Quadra ${d.quadra}`;
  if (d.lote) endereco += `, Lote ${d.lote}`;
  if (d.setor) endereco += `, ${d.setor}`;
  if (d.cidade) endereco += `, ${d.cidade}`;
  if (d.estado) endereco += `/${d.estado}`;
  if (d.cep) endereco += `, CEP ${d.cep}`;

  // Formatar data de assinatura como "Goiânia, X de mês de ano"
  const MESES = ['', 'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
    'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  const [dia, mes, ano] = d.dataAssinatura.trim().split('/');
  const dataFormatada = `Goiânia, ${parseInt(dia, 10)} de ${MESES[parseInt(mes, 10)]} de ${ano}`;

  // Aspas tipográficas Unicode usadas no documento Word
  const AO = '\u201c';
  const AF = '\u201d';
  const q = (s: string) => `${AO}${s}${AF}`;

  // Concordância de gênero
  const feminino = d.genero.trim() === 'brasileira';
  const termoBrasileiro = feminino ? 'brasileira' : 'brasileiro';
  const termoInscrito = feminino ? 'inscrita' : 'inscrito';
  const termoFilho = feminino ? 'filha' : 'filho';
  const termoDomiciliado = feminino ? 'domiciliada' : 'domiciliado';

  // Filiação: "nome do pai" e "nome da mãe"
  const [nomePai, nomeMae] = d.nomePai && d.nomeMae
    ? [d.nomePai.trim(), d.nomeMae.trim()]
    : d.naturalidade.includes(" e ") ? d.naturalidade.split(" e ") : [d.naturalidade, ""];

  const substituicoes: [string, string][] = [
    // Nome em maiúsculas
    [q('Nome'), nome],
    [q('nome'), nome],
    // Gênero
    [', brasileiro(a)', `, ${termoBrasileiro}`],
    ['brasileiro(a)', termoBrasileiro],
    ['brasileiro (a)', termoBrasileiro],
    ['inscrito(a)', termoInscrito],
    ['inscrito (a)', termoInscrito],
    ['filho de', `${termoFilho} de`],
    ['residente e domiciliado na ', `residente e ${termoDomiciliado} na `],
    ['residente e domiciliada na ', `residente e ${termoDomiciliado} na `],
    // Dados pessoais
    [q('estado civil'), d.estadoCivil],
    [q('Profissão'), d.profissao],
    [q('profissão'), d.profissao],
    [q('CPF'), d.cpf],
    [q('RG'), d.rg],
    [q('naturalidade'), d.naturalidade],
    [q('Naturalidade'), d.naturalidade],
    [q('nome do pai'), d.nomePai],
    [q('nome da mãe'), d.nomeMae],
    [q('nome da mae'), d.nomeMae],
    // Endereço
    [q('endereço completo'), endereco],
    [q('logradouro, quadra, lote, setor, cidade/UF, CEP'), endereco],
    [q('logradouro, n°, Quadra, Lote, Setor, Cidade/UF, CEP'), endereco],
    // Data
    [q('data'), dataFormatada],
    [q('Data'), dataFormatada],
    // CPF e RG separados (alguns modelos usam placeholders diferentes)
    [q('xxx.xxx.xxx-xx'), d.cpf],
    [q('00.000.000-0'), d.rg],
  ];

  xml = substituirNoXml(xml, substituicoes);

  zip.file("word/document.xml", xml);
  return Buffer.from(zip.generate({ type: "nodebuffer", compression: "DEFLATE" }));
}

// ─── POST /api/admin/modelos — upload de novo modelo ─────────────────────────
modelosRouter.post(
  "/admin/modelos",
  requireAdmin as any,
  upload.single("arquivo") as any,
  async (req: Request, res: Response) => {
    try {
      const reqWithFile = req as Request & { file?: Express.Multer.File };
    if (!reqWithFile.file) {
        res.status(400).json({ erro: "Arquivo .docx é obrigatório" });
        return;
      }

      const { nome, descricao } = req.body as { nome?: string; descricao?: string };
      if (!nome || nome.trim().length < 3) {
        res.status(400).json({ erro: "Nome do modelo é obrigatório (mínimo 3 caracteres)" });
        return;
      }

      const slug = gerarSlug(nome.trim());
      const fileKey = `modelos-dinamicos/${slug}.docx`;

      // Salva no storage
      await storagePut(fileKey, reqWithFile.file!.buffer, "application/vnd.openxmlformats-officedocument.wordprocessingml.document");

      // Salva no banco
      const id = await salvarModeloDinamico({
        nome: nome.trim(),
        slug,
        descricao: descricao?.trim() || null,
        fileKey,
        ativo: 1,
      });

      res.status(201).json({ id, slug, mensagem: "Modelo cadastrado com sucesso" });
    } catch (err: any) {
      console.error("[modelos] Erro ao fazer upload:", err);
      res.status(500).json({ erro: err.message ?? "Erro interno" });
    }
  }
);

// ─── GET /api/admin/modelos — lista todos os modelos ─────────────────────────
modelosRouter.get("/admin/modelos", requireAdmin as any, async (_req: Request, res: Response) => {
  try {
    const modelos = await listarModelosDinamicos();
    res.json(modelos);
  } catch (err: any) {
    res.status(500).json({ erro: err.message ?? "Erro interno" });
  }
});

// ─── PATCH /api/admin/modelos/:id/toggle — ativar/desativar ──────────────────
modelosRouter.patch("/admin/modelos/:id/toggle", requireAdmin as any, async (req: Request, res: Response) => {
  try {
    const id = parseInt(req.params.id, 10);
    const modelo = await buscarModeloPorId(id);
    if (!modelo) { res.status(404).json({ erro: "Modelo não encontrado" }); return; }
    await toggleModeloAtivo(id, modelo.ativo ? 0 : 1);
    res.json({ mensagem: "Status atualizado" });
  } catch (err: any) {
    res.status(500).json({ erro: err.message ?? "Erro interno" });
  }
});

// ─── DELETE /api/admin/modelos/:id — excluir modelo ──────────────────────────
modelosRouter.delete("/admin/modelos/:id", requireAdmin as any, async (req: Request, res: Response) => {
  try {
    const id = parseInt(req.params.id, 10);
    await deletarModeloDinamico(id);
    res.json({ mensagem: "Modelo excluído" });
  } catch (err: any) {
    res.status(500).json({ erro: err.message ?? "Erro interno" });
  }
});

// ─── GET /api/modelo/:slug — dados do modelo (público) ───────────────────────
modelosRouter.get("/modelo/:slug", async (req: Request, res: Response) => {
  try {
    const modelo = await buscarModeloPorSlug(req.params.slug);
    if (!modelo || !modelo.ativo) {
      res.status(404).json({ erro: "Modelo não encontrado ou inativo" });
      return;
    }
    res.json({ id: modelo.id, nome: modelo.nome, descricao: modelo.descricao, slug: modelo.slug });
  } catch (err: any) {
    res.status(500).json({ erro: err.message ?? "Erro interno" });
  }
});

// ─── POST /api/modelo/:slug — cliente envia dados ────────────────────────────
modelosRouter.post("/modelo/:slug", async (req: Request, res: Response) => {
  try {
    const modelo = await buscarModeloPorSlug(req.params.slug);
    if (!modelo || !modelo.ativo) {
      res.status(404).json({ erro: "Modelo não encontrado ou inativo" });
      return;
    }

    const parsed = OutorganteSchema.safeParse(req.body);
    if (!parsed.success) {
      res.status(400).json({ erros: parsed.error.flatten().fieldErrors });
      return;
    }

    const d = parsed.data;
    const token = randomUUID();

    // Gera o documento
    const docBuffer = await gerarDocumentoDinamico(modelo.fileKey, d);

    // Salva o documento gerado no storage
    const docKey = `submissoes-modelos/${modelo.slug}/${token}.docx`;
    await storagePut(docKey, docBuffer, "application/vnd.openxmlformats-officedocument.wordprocessingml.document");

    // Salva submissão no banco
    await salvarSubmissaoModelo({
      modeloId: modelo.id,
      nome: d.nome,
      genero: d.genero,
      estadoCivil: d.estadoCivil,
      profissao: d.profissao,
      cpf: d.cpf,
      rg: d.rg,
      naturalidade: d.naturalidade,
      nomePai: d.nomePai,
      nomeMae: d.nomeMae,
      rua: d.rua,
      quadra: d.quadra ?? null,
      lote: d.lote ?? null,
      setor: d.setor ?? null,
      cidade: d.cidade,
      estado: d.estado ?? null,
      cep: d.cep,
      dataAssinatura: d.dataAssinatura,
      downloadToken: token,
      status: "gerada",
    });

    // Notifica o admin
    const siteUrl = process.env.VITE_APP_ID
      ? `https://procuracao-9hxvmh7v.manus.space`
      : "http://localhost:3000";
    await notifyOwner({
      title: `Novo documento: ${modelo.nome}`,
      content: `Cliente: ${d.nome.toUpperCase()}\nCPF: ${d.cpf}\nModelo: ${modelo.nome}\n\nAcesse o painel para baixar o documento:\n${siteUrl}/admin`,
    });

    res.status(201).json({ token, mensagem: "Documento gerado com sucesso" });
  } catch (err: any) {
    console.error("[modelos] Erro ao gerar documento:", err);
    res.status(500).json({ erro: err.message ?? "Erro interno" });
  }
});

// ─── GET /api/admin/modelos/:id/submissoes — lista submissões ─────────────────
modelosRouter.get("/admin/modelos/:id/submissoes", requireAdmin as any, async (req: Request, res: Response) => {
  try {
    const id = parseInt(req.params.id, 10);
    const submissoes = await listarSubmissoesPorModelo(id);
    res.json(submissoes);
  } catch (err: any) {
    res.status(500).json({ erro: err.message ?? "Erro interno" });
  }
});

// ─── GET /api/admin/submissoes/:id/download — download pelo admin ─────────────
modelosRouter.get("/admin/submissoes/:id/download", requireAdmin as any, async (req: Request, res: Response) => {
  try {
    const id = parseInt(req.params.id, 10);
    const submissao = await buscarSubmissaoPorId(id);
    if (!submissao || !submissao.downloadToken) {
      res.status(404).json({ erro: "Submissão não encontrada" });
      return;
    }
    const modelo = await buscarModeloPorId(submissao.modeloId);
    const docKey = `submissoes-modelos/${modelo?.slug ?? submissao.modeloId}/${submissao.downloadToken}.docx`;
    const { url } = await storageGet(docKey);
    res.redirect(url);
  } catch (err: any) {
    res.status(500).json({ erro: err.message ?? "Erro interno" });
  }
});

// ─── GET /api/download-modelo/:token — download público por token ─────────────
modelosRouter.get("/download-modelo/:token", async (req: Request, res: Response) => {
  try {
    const submissao = await buscarSubmissaoPorToken(req.params.token);
    if (!submissao) {
      res.status(404).json({ erro: "Link inválido ou expirado" });
      return;
    }
    const modelo = await buscarModeloPorId(submissao.modeloId);
    const docKey = `submissoes-modelos/${modelo?.slug ?? submissao.modeloId}/${submissao.downloadToken}.docx`;
    const { url } = await storageGet(docKey);
    await marcarSubmissaoGerada(submissao.id);
    res.redirect(url);
  } catch (err: any) {
    res.status(500).json({ erro: err.message ?? "Erro interno" });
  }
});
