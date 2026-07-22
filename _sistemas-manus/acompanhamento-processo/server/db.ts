import { eq, and, desc, asc, isNull, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/mysql2";
import { 
  InsertUser, users, processos, novidades, InsertProcesso, InsertNovidade, leads, InsertLead,
  artigos, InsertArtigo, curtidas, InsertCurtida, salvos, InsertSalvo, comentarios, InsertComentario
} from "../drizzle/schema";
import { ENV } from './_core/env';
import { hashPassword } from "./authHelper";

let _db: ReturnType<typeof drizzle> | null = null;
let _seeded = false;

export async function getDb() {
  if (!_db && process.env.DATABASE_URL) {
    try {
      let dbUrl = process.env.DATABASE_URL.trim();
      const schemeIndex = dbUrl.indexOf("://");
      if (schemeIndex !== -1) {
        const prefix = dbUrl.substring(0, schemeIndex + 3);
        const rest = dbUrl.substring(schemeIndex + 3);
        const lastAt = rest.lastIndexOf("@");
        if (lastAt !== -1) {
          const userPass = rest.substring(0, lastAt);
          const hostDb = rest.substring(lastAt + 1);
          const colonIndex = userPass.indexOf(":");
          if (colonIndex !== -1) {
            const user = userPass.substring(0, colonIndex);
            const pass = userPass.substring(colonIndex + 1);
            dbUrl = `${prefix}${user}:${encodeURIComponent(decodeURIComponent(pass))}@${hostDb}`;
          }
        }
      }
      _db = drizzle(dbUrl);
      if (!_seeded) {
        _seeded = true;
        setTimeout(() => { seedAdminUser().catch(e => console.error("[Seed Admin Error]", e)); }, 100);
        setTimeout(() => { verifyLeadsTable().catch(e => console.error("[Verify Leads Error]", e)); }, 150);
        setTimeout(() => { verifyCollaborativeTables().catch(e => console.error("[Verify Tables Error]", e)); }, 200);
      }
    } catch (error) {
      console.warn("[Database] Failed to connect:", error);
      _db = null;
    }
  }
  return _db;
}

export async function upsertUser(user: InsertUser): Promise<void> {
  if (!user.openId) throw new Error("User openId is required for upsert");
  const db = await getDb();
  if (!db) { console.warn("[Database] Cannot upsert user: database not available"); return; }
  try {
    const values: InsertUser = { openId: user.openId };
    const updateSet: Record<string, unknown> = {};
    const textFields = ["name", "email", "loginMethod"] as const;
    type TextField = (typeof textFields)[number];
    const assignNullable = (field: TextField) => {
      const value = user[field];
      if (value === undefined) return;
      const normalized = value ?? null;
      values[field] = normalized;
      updateSet[field] = normalized;
    };
    textFields.forEach(assignNullable);
    if (user.lastSignedIn !== undefined) { values.lastSignedIn = user.lastSignedIn; updateSet.lastSignedIn = user.lastSignedIn; }
    if (user.role !== undefined) { values.role = user.role; updateSet.role = user.role; }
    else if (user.openId === ENV.ownerOpenId) { values.role = 'admin'; updateSet.role = 'admin'; }
    if (!values.lastSignedIn) values.lastSignedIn = new Date();
    if (Object.keys(updateSet).length === 0) updateSet.lastSignedIn = new Date();
    await db.insert(users).values(values).onDuplicateKeyUpdate({ set: updateSet });
  } catch (error) {
    console.error("[Database] Failed to upsert user:", error);
    throw error;
  }
}

export async function getUserByOpenId(openId: string) {
  const db = await getDb();
  if (!db) { console.warn("[Database] Cannot get user: database not available"); return undefined; }
  const result = await db.select().from(users).where(eq(users.openId, openId)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function getUserByEmail(email: string) {
  const db = await getDb();
  if (!db) { console.warn("[Database] Cannot get user by email: database not available"); return undefined; }
  const result = await db.select().from(users).where(eq(users.email, email)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function getUserByCpf(cpf: string) {
  const db = await getDb();
  if (!db) { console.warn("[Database] Cannot get user by cpf: database not available"); return undefined; }
  const clean = cpf.replace(/\D/g, "");
  const formatted = clean.length === 11 
    ? `${clean.slice(0,3)}.${clean.slice(3,6)}.${clean.slice(6,9)}-${clean.slice(9)}`
    : cpf;
  const result = await db.select().from(users).where(
    or(
      eq(users.cpf, cpf),
      eq(users.cpf, clean),
      eq(users.cpf, formatted)
    )
  ).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function getUserById(id: number) {
  const db = await getDb();
  if (!db) { console.warn("[Database] Cannot get user by id: database not available"); return undefined; }
  const result = await db.select().from(users).where(eq(users.id, id)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function seedAdminUser() {
  const db = await getDb();
  if (!db) return;

  const adminName = "Weber Fernandes Pereira";
  const adminCpf = "11111111111";
  const adminEmail = process.env.ADMIN_EMAIL || "contato@weberfernandes.adv.br";
  const password = process.env.ADMIN_PASSWORD || "admin123";
  const pwdHash = hashPassword(password);

  try {
    let user = await getUserByCpf(adminCpf);
    if (!user) {
      user = await getUserByEmail(adminEmail);
    }

    if (!user) {
      console.log(`[Seed] Creating admin user: ${adminName} (${adminCpf})`);
      await db.insert(users).values({
        openId: `local-${adminCpf}`,
        name: adminName,
        email: adminEmail,
        cpf: adminCpf,
        passwordHash: pwdHash,
        role: "admin",
        loginMethod: "local",
        cidade: "Jataí",
        estado: "GO",
        fotoUrl: "",
        lastSignedIn: new Date()
      });
    } else {
      console.log(`[Seed] Updating admin user: ${adminName} (${adminCpf})`);
      await db.update(users).set({
        name: adminName,
        email: adminEmail,
        cpf: adminCpf,
        passwordHash: pwdHash,
        role: "admin",
        cidade: "Jataí",
        estado: "GO"
      }).where(eq(users.id, user.id));
    }

    // Seed default articles if none exist
    try {
      const adminUser = await getUserByEmail(email);
      if (adminUser) {
        const existingArticles = await db.select().from(artigos).limit(1);
        if (existingArticles.length === 0) {
          console.log("[Seed] Seeding default articles...");
          await db.insert(artigos).values([
            {
              userId: adminUser.id,
              titulo: "A Importância da Regularização Fundiária e a Usucapião Extrajudicial",
              conteudo: "A usucapião realizada diretamente perante os cartórios de registro de imóveis trouxe celeridade para a garantia do direito de propriedade. Abordamos os principais requisitos documentais e as vantagens da via administrativa frente ao trâmite judicial comum.\n\nO procedimento extrajudicial, regulamentado pelo Provimento nº 65/2017 do CNJ, permite que o cidadão obtenha o registro de propriedade de forma célere, desde que haja consenso entre os confrontantes e a documentação esteja em conformidade com as exigências legais.\n\nA atuação do advogado é indispensável nesse trâmite, cabendo a ele analisar a cadeia possessória, coletar as assinaturas necessárias, elaborar a petição fundamentada e acompanhar o andamento junto ao Oficial de Registro de Imóveis.",
              tipo: "Artigo",
              categoria: "Direito Imobiliário"
            },
            {
              userId: adminUser.id,
              titulo: "Garantias Constitucionais e o Devido Processo Legal em Sindicâncias e PAD",
              conteudo: "O Processo Administrativo Disciplinar (PAD) deve estrita obediência aos ditames da ampla defesa e contraditório. Analisamos nulidades comuns que ocorrem pela ausência de defesa técnica especializada na colheita de depoimentos e fases instrutórias iniciais.\n\nServidores públicos sob investigação muitas vezes desconhecem seus direitos fundamentais, permitindo que a comissão processante cometa abusos ou ignore formalidades essenciais que viciam o processo.\n\nA presença de um defensor técnico desde a fase de sindicância garante a lisura do procedimento, evita autoincriminações e assegura que qualquer punição eventualmente aplicada seja baseada em provas válidas e em obediência às garantias constitucionais.",
              tipo: "Artigo",
              categoria: "Direito Administrativo"
            }
          ]);
          console.log("[Seed] Default articles seeded.");
        }
      }
    } catch (error) {
      console.error("[Seed] Failed to seed default articles:", error);
    }

  } catch (error) {
    console.error("[Seed] Failed to seed admin user:", error);
  }
}

// ---- Processos ----

export async function getProcessosByUserId(userId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(processos)
    .where(and(eq(processos.userId, userId), eq(processos.ativo, true)))
    .orderBy(
      sql`CASE WHEN ${processos.dataLimite} IS NULL OR ${processos.tipoManifestacao} = 'Autos conclusos' OR ${processos.tipoManifestacao} = 'Outro' THEN 1 ELSE 0 END`,
      asc(processos.dataLimite),
      desc(processos.createdAt)
    );
}

export async function getProcessosByCpf(cpf: string) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(processos)
    .where(and(eq(processos.clienteCpf, cpf), eq(processos.ativo, true)))
    .orderBy(
      sql`CASE WHEN ${processos.dataLimite} IS NULL OR ${processos.tipoManifestacao} = 'Autos conclusos' OR ${processos.tipoManifestacao} = 'Outro' THEN 1 ELSE 0 END`,
      asc(processos.dataLimite),
      desc(processos.createdAt)
    );
}

export async function createProcesso(data: InsertProcesso) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(processos).values(data);
  
  // Automatically create a notification entry
  // @ts-ignore
  const insertId = result[0]?.insertId;
  if (insertId && data.userId) {
    try {
      // 1. Notification for lawyer
      await db.insert(novidades).values({
        userId: data.userId,
        processoId: insertId,
        titulo: `Processo ${data.numeroCnj} cadastrado`,
        conteudo: `O processo ${data.numeroCnj} (${data.tribunal}) foi adicionado ao seu monitoramento.`,
        lida: false
      });

      // 2. Notification for client (if user exists for clientCpf)
      if (data.clienteCpf) {
        const clientUser = await getUserByCpf(data.clienteCpf);
        if (clientUser) {
          await db.insert(novidades).values({
            userId: clientUser.id,
            processoId: insertId,
            titulo: `Processo ${data.numeroCnj} cadastrado`,
            conteudo: `O processo ${data.numeroCnj} (${data.tribunal}) foi adicionado ao seu monitoramento.`,
            lida: false
          });
        }
      }
    } catch (e) {
      console.error("Failed to create novidade:", e);
    }
  }
  return result;
}

export async function updateProcesso(
  id: number,
  userId: number,
  data: Partial<Pick<typeof processos.$inferInsert, 'dataLimite' | 'dataIntimacao' | 'tipoManifestacao' | 'horario' | 'cliente' | 'clienteCpf' | 'anotacao'>>
) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  
  // Note: we fetch by id to verify ownership or admin, but generally it's filtered by userId.
  return db.update(processos)
    .set({ ...data, updatedAt: new Date() })
    .where(and(eq(processos.id, id), eq(processos.userId, userId)));
}

export async function deleteProcesso(id: number, userId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  return db.update(processos)
    .set({ ativo: false })
    .where(and(eq(processos.id, id), eq(processos.userId, userId)));
}

export async function getProcessoById(id: number, userId: number) {
  const db = await getDb();
  if (!db) return undefined;
  const result = await db.select().from(processos)
    .where(and(eq(processos.id, id), eq(processos.userId, userId)))
    .limit(1);
  return result[0];
}

// ---- Client Portal Helpers ----

export async function verifyCpfHasProcess(cpf: string): Promise<boolean> {
  const db = await getDb();
  if (!db) return false;
  const result = await db.select().from(processos)
    .where(and(eq(processos.clienteCpf, cpf), eq(processos.ativo, true)))
    .limit(1);
  return result.length > 0;
}

export async function registerClientPassword(name: string, cpf: string, passwordHash: string, role: 'cliente' | 'admin' = 'cliente'): Promise<boolean> {
  const db = await getDb();
  if (!db) return false;

  const existing = await getUserByCpf(cpf);
  if (existing) {
    await db.update(users).set({
      name,
      passwordHash,
      role,
      updatedAt: new Date()
    }).where(eq(users.id, existing.id));
  } else {
    await db.insert(users).values({
      openId: `local-cpf-${cpf}`,
      name,
      cpf,
      passwordHash,
      role,
      loginMethod: 'local',
      lastSignedIn: new Date()
    });
  }
  return true;
}

// ---- Novidades ----

export async function getNovidadesByUserId(userId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(novidades)
    .where(eq(novidades.userId, userId))
    .orderBy(desc(novidades.createdAt));
}

export async function createNovidade(data: InsertNovidade) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  return db.insert(novidades).values(data);
}

export async function marcarNovidadeComoLida(id: number, userId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  return db.update(novidades)
    .set({ lida: true })
    .where(and(eq(novidades.id, id), eq(novidades.userId, userId)));
}

export async function countNovidadesNaoLidas(userId: number) {
  const db = await getDb();
  if (!db) return 0;
  const result = await db.select().from(novidades)
    .where(and(eq(novidades.userId, userId), eq(novidades.lida, false)));
  return result.length;
}

// ─── Helpers de Leads ────────────────────────────────────────────────────────

export async function verifyLeadsTable(): Promise<void> {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot verify leads table: database not available");
    return;
  }
  try {
    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS leads (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(255) NOT NULL,
        telefone VARCHAR(20) NOT NULL,
        advogado VARCHAR(255) NOT NULL,
        mensagem TEXT,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
      )
    `);
    console.log("[Database] Leads table verified/created.");
  } catch (error) {
    console.error("[Database] Failed to verify/create leads table:", error);
  }
}

export async function saveLead(data: InsertLead): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.insert(leads).values(data);
}

export async function getLeads() {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  return db.select().from(leads).orderBy(desc(leads.createdAt));
}

export async function verifyCollaborativeTables(): Promise<void> {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot verify collaborative tables: database not available");
    return;
  }
  try {
    // Alter users table to add cidade, estado, and fotoUrl if they don't exist
    try {
      await db.execute(sql`ALTER TABLE users ADD COLUMN cidade VARCHAR(100) NULL`);
      console.log("[Database] Column 'cidade' added to users table.");
    } catch (e) {}
    try {
      await db.execute(sql`ALTER TABLE users ADD COLUMN estado VARCHAR(50) NULL`);
      console.log("[Database] Column 'estado' added to users table.");
    } catch (e) {}
    try {
      await db.execute(sql`ALTER TABLE users ADD COLUMN fotoUrl TEXT NULL`);
      console.log("[Database] Column 'fotoUrl' added to users table.");
    } catch (e) {}

    // Create artigos table
    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS artigos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        userId INT NOT NULL,
        titulo VARCHAR(255) NOT NULL,
        conteudo TEXT NOT NULL,
        tipo VARCHAR(50) DEFAULT 'Artigo' NOT NULL,
        categoria VARCHAR(100) DEFAULT 'Geral' NOT NULL,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
      )
    `);
    console.log("[Database] 'artigos' table verified/created.");

    // Create curtidas table
    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS curtidas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        userId INT NOT NULL,
        artigoId INT NOT NULL
      )
    `);
    console.log("[Database] 'curtidas' table verified/created.");

    // Create salvos table
    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS salvos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        userId INT NOT NULL,
        artigoId INT NOT NULL
      )
    `);
    console.log("[Database] 'salvos' table verified/created.");

    // Create comentarios table
    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS comentarios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        userId INT NOT NULL,
        artigoId INT NOT NULL,
        texto TEXT NOT NULL,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
      )
    `);
    console.log("[Database] 'comentarios' table verified/created.");

  } catch (error) {
    console.error("[Database] Failed to verify/create collaborative tables:", error);
  }
}

export async function createArtigo(data: InsertArtigo) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  return db.insert(artigos).values(data);
}

export async function getArtigos(currentUserId?: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  // Query articles with author information and interaction counts
  const rows = await db.execute(sql`
    SELECT 
      a.id, 
      a.userId, 
      a.titulo, 
      a.conteudo, 
      a.tipo, 
      a.categoria, 
      a.createdAt,
      u.name as authorName,
      u.fotoUrl as authorFoto,
      u.cidade as authorCidade,
      u.estado as authorEstado,
      u.role as authorRole
      , (SELECT COUNT(*) FROM curtidas c WHERE c.artigoId = a.id) as likesCount
      , (SELECT COUNT(*) FROM comentarios co WHERE co.artigoId = a.id) as commentsCount
      , (SELECT COUNT(*) FROM salvos s WHERE s.artigoId = a.id) as savesCount
      ${currentUserId ? sql`, EXISTS(SELECT 1 FROM curtidas c2 WHERE c2.artigoId = a.id AND c2.userId = ${currentUserId}) as isLikedByMe` : sql`, 0 as isLikedByMe`}
      ${currentUserId ? sql`, EXISTS(SELECT 1 FROM salvos s2 WHERE s2.artigoId = a.id AND s2.userId = ${currentUserId}) as isSavedByMe` : sql`, 0 as isSavedByMe`}
    FROM artigos a
    JOIN users u ON a.userId = u.id
    ORDER BY a.createdAt DESC
  `);
  
  // Return the rows
  // @ts-ignore
  return rows[0] || [];
}

export async function toggleLike(userId: number, artigoId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  const existing = await db.select().from(curtidas)
    .where(and(eq(curtidas.userId, userId), eq(curtidas.artigoId, artigoId)))
    .limit(1);

  if (existing.length > 0) {
    await db.delete(curtidas).where(eq(curtidas.id, existing[0].id));
    return { liked: false };
  } else {
    await db.insert(curtidas).values({ userId, artigoId });
    return { liked: true };
  }
}

export async function toggleSave(userId: number, artigoId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  const existing = await db.select().from(salvos)
    .where(and(eq(salvos.userId, userId), eq(salvos.artigoId, artigoId)))
    .limit(1);

  if (existing.length > 0) {
    await db.delete(salvos).where(eq(salvos.id, existing[0].id));
    return { saved: false };
  } else {
    await db.insert(salvos).values({ userId, artigoId });
    return { saved: true };
  }
}

export async function getComentarios(artigoId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  const rows = await db.execute(sql`
    SELECT 
      c.id, 
      c.userId, 
      c.artigoId, 
      c.texto, 
      c.createdAt,
      u.name as userName,
      u.fotoUrl as userFoto,
      u.cidade as userCidade,
      u.estado as userEstado
    FROM comentarios c
    JOIN users u ON c.userId = u.id
    WHERE c.artigoId = ${artigoId}
    ORDER BY c.createdAt ASC
  `);

  // @ts-ignore
  return rows[0] || [];
}

export async function addComentario(data: InsertComentario) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  return db.insert(comentarios).values(data);
}

export async function registerPublicUser(name: string, email: string, passwordHash: string, cidade: string, estado: string, fotoUrl: string): Promise<boolean> {
  const db = await getDb();
  if (!db) return false;

  const existing = await getUserByEmail(email);
  if (existing) {
    throw new Error("Este e-mail já está cadastrado.");
  }
  
  await db.insert(users).values({
    openId: `local-email-${email}`,
    name,
    email,
    passwordHash,
    cidade,
    estado,
    fotoUrl: fotoUrl || null,
    role: "user",
    loginMethod: 'local',
    lastSignedIn: new Date()
  });
  return true;
}
