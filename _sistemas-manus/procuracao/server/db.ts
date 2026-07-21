import { desc, eq } from "drizzle-orm";
import { drizzle } from "drizzle-orm/mysql2";
import { InsertProcuracao, InsertProcuracaoWeberAna, InsertUser, procuracoes, procuracoesWeberAna, users } from "../drizzle/schema";
import { ENV } from './_core/env';
import { hashPassword } from "./authHelper";

let _db: ReturnType<typeof drizzle> | null = null;
let _seeded = false;

// Lazily create the drizzle instance so local tooling can run without a DB.
export async function getDb() {
  if (!_db && process.env.DATABASE_URL) {
    try {
      _db = drizzle(process.env.DATABASE_URL);
      if (!_seeded) {
        _seeded = true;
        // Run seed asynchronously to not block connection return
        setTimeout(() => seedAdminUser(), 100);
      }
    } catch (error) {
      console.warn("[Database] Failed to connect:", error);
      _db = null;
    }
  }
  return _db;
}

export async function upsertUser(user: InsertUser): Promise<void> {
  if (!user.openId) {
    throw new Error("User openId is required for upsert");
  }

  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot upsert user: database not available");
    return;
  }

  try {
    const values: InsertUser = {
      openId: user.openId,
    };
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

    if (user.lastSignedIn !== undefined) {
      values.lastSignedIn = user.lastSignedIn;
      updateSet.lastSignedIn = user.lastSignedIn;
    }
    if (user.role !== undefined) {
      values.role = user.role;
      updateSet.role = user.role;
    } else if (user.openId === ENV.ownerOpenId) {
      values.role = 'admin';
      updateSet.role = 'admin';
    }

    if (!values.lastSignedIn) {
      values.lastSignedIn = new Date();
    }

    if (Object.keys(updateSet).length === 0) {
      updateSet.lastSignedIn = new Date();
    }

    await db.insert(users).values(values).onDuplicateKeyUpdate({
      set: updateSet,
    });
  } catch (error) {
    console.error("[Database] Failed to upsert user:", error);
    throw error;
  }
}

export async function getUserByOpenId(openId: string) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user: database not available");
    return undefined;
  }

  const result = await db.select().from(users).where(eq(users.openId, openId)).limit(1);

  return result.length > 0 ? result[0] : undefined;
}

export async function getUserByEmail(email: string) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user by email: database not available");
    return undefined;
  }

  const result = await db.select().from(users).where(eq(users.email, email)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function getUserById(id: number) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user by id: database not available");
    return undefined;
  }

  const result = await db.select().from(users).where(eq(users.id, id)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function seedAdminUser() {
  const email = process.env.ADMIN_EMAIL;
  const password = process.env.ADMIN_PASSWORD;
  if (!email || !password) {
    console.warn("[Seed] ADMIN_EMAIL or ADMIN_PASSWORD not configured. Skipping seeding.");
    return;
  }

  const db = await getDb();
  if (!db) return;

  try {
    const user = await getUserByEmail(email);
    const pwdHash = hashPassword(password);

    if (!user) {
      console.log(`[Seed] Creating admin user: ${email}`);
      await db.insert(users).values({
        openId: `local-${email}`,
        name: "Administrador",
        email,
        passwordHash: pwdHash,
        role: "admin",
        loginMethod: "local",
        lastSignedIn: new Date()
      });
    } else {
      console.log(`[Seed] Updating admin password for: ${email}`);
      await db.update(users).set({
        passwordHash: pwdHash,
        role: "admin"
      }).where(eq(users.id, user.id));
    }

    // Seeding wolfrickwolf@gmail.com
    const extraEmail = "wolfrickwolf@gmail.com";
    const extraUser = await getUserByEmail(extraEmail);
    if (extraUser) {
      console.log(`[Seed] Updating admin password for extra user: ${extraEmail}`);
      await db.update(users).set({
        passwordHash: pwdHash,
        role: "admin"
      }).where(eq(users.id, extraUser.id));
    }
  } catch (error) {
    console.error("[Seed] Failed to seed admin user:", error);
  }
}

// ─── Helpers de Procurações ─────────────────────────────────────────────────

export async function salvarProcuracao(dados: InsertProcuracao): Promise<number> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");

  const result = await db.insert(procuracoes).values(dados);
  // @ts-ignore - insertId existe no driver mysql2
  return result[0]?.insertId ?? 0;
}

export async function listarProcuracoes() {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");

  return db.select().from(procuracoes).orderBy(desc(procuracoes.criadoEm));
}

export async function deletarProcuracao(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");

  await db.delete(procuracoes).where(eq(procuracoes.id, id));
}

export async function buscarProcuracao(id: number) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");

  const result = await db.select().from(procuracoes).where(eq(procuracoes.id, id)).limit(1);
  return result[0] ?? null;
}

export async function buscarProcuracaoPorToken(token: string) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");

  const result = await db.select().from(procuracoes).where(eq(procuracoes.downloadToken, token)).limit(1);
  return result[0] ?? null;
}

export async function marcarProcuracaoGerada(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");

  await db.update(procuracoes).set({ status: "gerada" }).where(eq(procuracoes.id, id));
}

export async function atualizarObservacoesProcuracao(id: number, observacoes: string): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(procuracoes).set({ observacoes }).where(eq(procuracoes.id, id));
}

// ─── Helpers de Contratos ────────────────────────────────────────────────────

import { contratos, declaracoes, procuracoesPa, InsertContrato, InsertDeclaracao, InsertProcuracaoPa, modelosDinamicos, submissoesModelo, InsertModeloDinamico, InsertSubmissaoModelo } from "../drizzle/schema";

export async function salvarContrato(dados: InsertContrato): Promise<number> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.insert(contratos).values(dados);
  // @ts-ignore
  return result[0]?.insertId ?? 0;
}

export async function listarContratos() {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  return db.select().from(contratos).orderBy(desc(contratos.criadoEm));
}

export async function buscarContrato(id: number) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(contratos).where(eq(contratos.id, id)).limit(1);
  return result[0] ?? null;
}

export async function buscarContratoPorToken(token: string) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(contratos).where(eq(contratos.downloadToken, token)).limit(1);
  return result[0] ?? null;
}

export async function deletarContrato(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.delete(contratos).where(eq(contratos.id, id));
}

export async function marcarContratoGerado(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(contratos).set({ status: "gerada" }).where(eq(contratos.id, id));
}

export async function atualizarObservacoesContrato(id: number, observacoes: string): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(contratos).set({ observacoes }).where(eq(contratos.id, id));
}

export async function atualizarSecaoIIIContrato(id: number, dados: {
  tipoAcao: string;
  tribunal: string;
  faseProcessual: string;
  valorTotal: string;
  valorEntrada: string;
  dataEntrada: string;
  numParcelas: number;
  valorParcela: string;
  dataPrimeiraParcela: string;
}): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(contratos).set(dados).where(eq(contratos.id, id));
}

// ─── Helpers de Declarações ──────────────────────────────────────────────────

export async function salvarDeclaracao(dados: InsertDeclaracao): Promise<number> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.insert(declaracoes).values(dados);
  // @ts-ignore
  return result[0]?.insertId ?? 0;
}

export async function listarDeclaracoes() {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  return db.select().from(declaracoes).orderBy(desc(declaracoes.criadoEm));
}

export async function buscarDeclaracao(id: number) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(declaracoes).where(eq(declaracoes.id, id)).limit(1);
  return result[0] ?? null;
}

export async function buscarDeclaracaoPorToken(token: string) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(declaracoes).where(eq(declaracoes.downloadToken, token)).limit(1);
  return result[0] ?? null;
}

export async function deletarDeclaracao(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.delete(declaracoes).where(eq(declaracoes.id, id));
}

export async function marcarDeclaracaoGerada(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(declaracoes).set({ status: "gerada" }).where(eq(declaracoes.id, id));
}

export async function atualizarObservacoesDeclaracao(id: number, observacoes: string): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(declaracoes).set({ observacoes }).where(eq(declaracoes.id, id));
}

// ─── Helpers de Procurações PA ───────────────────────────────────────────────

export async function salvarProcuracaoPa(dados: InsertProcuracaoPa): Promise<number> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.insert(procuracoesPa).values(dados);
  // @ts-ignore
  return result[0]?.insertId ?? 0;
}

export async function listarProcuracoesPa() {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  return db.select().from(procuracoesPa).orderBy(desc(procuracoesPa.criadoEm));
}

export async function buscarProcuracaoPa(id: number) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(procuracoesPa).where(eq(procuracoesPa.id, id)).limit(1);
  return result[0] ?? null;
}

export async function buscarProcuracaoPaPorToken(token: string) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(procuracoesPa).where(eq(procuracoesPa.downloadToken, token)).limit(1);
  return result[0] ?? null;
}

export async function deletarProcuracaoPa(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.delete(procuracoesPa).where(eq(procuracoesPa.id, id));
}

export async function marcarProcuracaoPaGerada(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(procuracoesPa).set({ status: "gerada" }).where(eq(procuracoesPa.id, id));
}

export async function atualizarObservacoesProcuracaoPa(id: number, observacoes: string): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(procuracoesPa).set({ observacoes }).where(eq(procuracoesPa.id, id));
}

// ─── Helpers de Procurações Weber e Ana Laura ─────────────────────────────────
export async function salvarProcuracaoWeberAna(dados: InsertProcuracaoWeberAna): Promise<number> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.insert(procuracoesWeberAna).values(dados);
  // @ts-ignore
  return result[0]?.insertId ?? 0;
}
export async function listarProcuracoesWeberAna() {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  return db.select().from(procuracoesWeberAna).orderBy(desc(procuracoesWeberAna.criadoEm));
}
export async function buscarProcuracaoWeberAna(id: number) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(procuracoesWeberAna).where(eq(procuracoesWeberAna.id, id)).limit(1);
  return result[0] ?? null;
}
export async function buscarProcuracaoWeberAnaPorToken(token: string) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(procuracoesWeberAna).where(eq(procuracoesWeberAna.downloadToken, token)).limit(1);
  return result[0] ?? null;
}
export async function deletarProcuracaoWeberAna(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.delete(procuracoesWeberAna).where(eq(procuracoesWeberAna.id, id));
}
export async function marcarProcuracaoWeberAnaGerada(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(procuracoesWeberAna).set({ status: "gerada" }).where(eq(procuracoesWeberAna.id, id));
}
export async function atualizarObservacoesProcuracaoWeberAna(id: number, observacoes: string): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(procuracoesWeberAna).set({ observacoes }).where(eq(procuracoesWeberAna.id, id));
}

// ─── Helpers de Modelos Dinâmicos ────────────────────────────────────────────────────────────────────

export async function salvarModeloDinamico(dados: InsertModeloDinamico): Promise<number> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.insert(modelosDinamicos).values(dados);
  // @ts-ignore
  return result[0]?.insertId ?? 0;
}

export async function listarModelosDinamicos() {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  return db.select().from(modelosDinamicos).orderBy(desc(modelosDinamicos.criadoEm));
}

export async function buscarModeloPorSlug(slug: string) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(modelosDinamicos).where(eq(modelosDinamicos.slug, slug)).limit(1);
  return result[0] ?? null;
}

export async function buscarModeloPorId(id: number) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(modelosDinamicos).where(eq(modelosDinamicos.id, id)).limit(1);
  return result[0] ?? null;
}

export async function toggleModeloAtivo(id: number, ativo: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(modelosDinamicos).set({ ativo }).where(eq(modelosDinamicos.id, id));
}

export async function deletarModeloDinamico(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.delete(modelosDinamicos).where(eq(modelosDinamicos.id, id));
}

// ─── Helpers de Submissões de Modelos ────────────────────────────────────────────────────────────────────

export async function salvarSubmissaoModelo(dados: InsertSubmissaoModelo): Promise<number> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.insert(submissoesModelo).values(dados);
  // @ts-ignore
  return result[0]?.insertId ?? 0;
}

export async function listarSubmissoesPorModelo(modeloId: number) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  return db.select().from(submissoesModelo).where(eq(submissoesModelo.modeloId, modeloId)).orderBy(desc(submissoesModelo.criadoEm));
}

export async function buscarSubmissaoPorToken(token: string) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(submissoesModelo).where(eq(submissoesModelo.downloadToken, token)).limit(1);
  return result[0] ?? null;
}

export async function buscarSubmissaoPorId(id: number) {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  const result = await db.select().from(submissoesModelo).where(eq(submissoesModelo.id, id)).limit(1);
  return result[0] ?? null;
}

export async function marcarSubmissaoGerada(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(submissoesModelo).set({ status: "gerada" }).where(eq(submissoesModelo.id, id));
}

export async function deletarSubmissao(id: number): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.delete(submissoesModelo).where(eq(submissoesModelo.id, id));
}

export async function atualizarObservacoesSubmissao(id: number, observacoes: string): Promise<void> {
  const db = await getDb();
  if (!db) throw new Error("[Database] Banco de dados indisponível");
  await db.update(submissoesModelo).set({ observacoes }).where(eq(submissoesModelo.id, id));
}
