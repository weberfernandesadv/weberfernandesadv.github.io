import { int, mysqlEnum, mysqlTable, text, timestamp, varchar } from "drizzle-orm/mysql-core";

/**
 * Core user table backing auth flow.
 * Extend this file with additional tables as your product grows.
 * Columns use camelCase to match both database fields and generated types.
 */
export const users = mysqlTable("users", {
  /**
   * Surrogate primary key. Auto-incremented numeric value managed by the database.
   * Use this for relations between tables.
   */
  id: int("id").autoincrement().primaryKey(),
  /** Manus OAuth identifier (openId) returned from the OAuth callback. Unique per user. Optional for local auth. */
  openId: varchar("openId", { length: 64 }).unique(),
  name: text("name"),
  email: varchar("email", { length: 320 }).unique(),
  passwordHash: text("passwordHash"),
  loginMethod: varchar("loginMethod", { length: 64 }),
  role: mysqlEnum("role", ["user", "admin"]).default("user").notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
  lastSignedIn: timestamp("lastSignedIn").defaultNow().notNull(),
});

export type User = typeof users.$inferSelect;
export type InsertUser = typeof users.$inferInsert;

// Tabela de histórico de procurações geradas
export const procuracoes = mysqlTable("procuracoes", {
  id: int("id").autoincrement().primaryKey(),
  nome: varchar("nome", { length: 255 }).notNull(),
  genero: varchar("genero", { length: 64 }).notNull(),
  estadoCivil: varchar("estadoCivil", { length: 64 }).notNull(),
  profissao: varchar("profissao", { length: 128 }).notNull(),
  cpf: varchar("cpf", { length: 14 }).notNull(),
  naturalidade: varchar("naturalidade", { length: 128 }).notNull(),
  filiacao: text("filiacao").notNull(),
  rua: varchar("rua", { length: 255 }).notNull(),
  quadra: varchar("quadra", { length: 64 }),
  lote: varchar("lote", { length: 64 }),
  cidade: varchar("cidade", { length: 128 }).notNull(),
  cep: varchar("cep", { length: 9 }).notNull(),
  criadoEm: timestamp("criadoEm").defaultNow().notNull(),
  status: mysqlEnum("status", ["pendente", "gerada"]).default("pendente").notNull(),
  downloadToken: varchar("downloadToken", { length: 64 }),
  observacoes: text("observacoes"),
});

export type Procuracao = typeof procuracoes.$inferSelect;
export type InsertProcuracao = typeof procuracoes.$inferInsert;

// ─── Campos comuns do outorgante (reutilizados em todos os documentos) ─────────
const outorganteCols = {
  nome: varchar("nome", { length: 255 }).notNull(),
  genero: varchar("genero", { length: 64 }).notNull(),
  estadoCivil: varchar("estadoCivil", { length: 64 }).notNull(),
  profissao: varchar("profissao", { length: 128 }).notNull(),
  cpf: varchar("cpf", { length: 14 }).notNull(),
  rg: varchar("rg", { length: 20 }).notNull(),
  naturalidade: varchar("naturalidade", { length: 128 }).notNull(),
  nomePai: varchar("nomePai", { length: 255 }).notNull(),
  nomeMae: varchar("nomeMae", { length: 255 }).notNull(),
  rua: varchar("rua", { length: 255 }).notNull(),
  quadra: varchar("quadra", { length: 64 }),
  lote: varchar("lote", { length: 64 }),
  setor: varchar("setor", { length: 128 }),
  cidade: varchar("cidade", { length: 128 }).notNull(),
  estado: varchar("estado", { length: 64 }),
  cep: varchar("cep", { length: 9 }).notNull(),
};

// Tabela de contratos de honorários
// Seção I+II (qualificação + endereço) preenchida pelo cliente.
// Seção III (dados do processo) + honorários preenchidos pelo advogado no Admin.
export const contratos = mysqlTable("contratos", {
  id: int("id").autoincrement().primaryKey(),
  ...outorganteCols,
  dataContrato: varchar("dataContrato", { length: 10 }).notNull(),
  // Seção III — preenchida pelo advogado no Admin (nullable até o advogado completar)
  tipoAcao: text("tipoAcao"),
  tribunal: varchar("tribunal", { length: 255 }),
  faseProcessual: text("faseProcessual"),
  valorTotal: varchar("valorTotal", { length: 64 }),
  valorEntrada: varchar("valorEntrada", { length: 64 }),
  dataEntrada: varchar("dataEntrada", { length: 10 }),
  numParcelas: int("numParcelas"),
  valorParcela: varchar("valorParcela", { length: 64 }),
  dataPrimeiraParcela: varchar("dataPrimeiraParcela", { length: 10 }),
  criadoEm: timestamp("criadoEm").defaultNow().notNull(),
  status: mysqlEnum("status", ["pendente", "gerada"]).default("pendente").notNull(),
  downloadToken: varchar("downloadToken", { length: 64 }),
  observacoes: text("observacoes"),
});

export type Contrato = typeof contratos.$inferSelect;
export type InsertContrato = typeof contratos.$inferInsert;

// Tabela de declarações de hipossuficiência
export const declaracoes = mysqlTable("declaracoes", {
  id: int("id").autoincrement().primaryKey(),
  ...outorganteCols,
  dataDeclaracao: varchar("dataDeclaracao", { length: 10 }).notNull(),
  criadoEm: timestamp("criadoEm").defaultNow().notNull(),
  status: mysqlEnum("status", ["pendente", "gerada"]).default("pendente").notNull(),
  downloadToken: varchar("downloadToken", { length: 64 }),
  observacoes: text("observacoes"),
});

export type Declaracao = typeof declaracoes.$inferSelect;
export type InsertDeclaracao = typeof declaracoes.$inferInsert;

// Tabela de procurações PA (para menores)
export const procuracoesPa = mysqlTable("procuracoes_pa", {
  id: int("id").autoincrement().primaryKey(),
  // Dados do menor
  nomeMenor: varchar("nomeMenor", { length: 255 }).notNull(),
  cpfMenor: varchar("cpfMenor", { length: 14 }).notNull(),
  dataNascimento: varchar("dataNascimento", { length: 10 }).notNull(),
  // Dados da genitora/representante
  ...outorganteCols,
  criadoEm: timestamp("criadoEm").defaultNow().notNull(),
  status: mysqlEnum("status", ["pendente", "gerada"]).default("pendente").notNull(),
  downloadToken: varchar("downloadToken", { length: 64 }),
  observacoes: text("observacoes"),
});

export type ProcuracaoPa = typeof procuracoesPa.$inferSelect;
export type InsertProcuracaoPa = typeof procuracoesPa.$inferInsert;

// Tabela de procurações Weber e Ana Laura (dois outorgados)
export const procuracoesWeberAna = mysqlTable("procuracoes_weber_ana", {
  id: int("id").autoincrement().primaryKey(),
  ...outorganteCols,
  criadoEm: timestamp("criadoEm").defaultNow().notNull(),
  status: mysqlEnum("status", ["pendente", "gerada"]).default("pendente").notNull(),
  downloadToken: varchar("downloadToken", { length: 64 }),
  observacoes: text("observacoes"),
});

export type ProcuracaoWeberAna = typeof procuracoesWeberAna.$inferSelect;
export type InsertProcuracaoWeberAna = typeof procuracoesWeberAna.$inferInsert;

// ─── Modelos dinâmicos (upload pelo admin) ───────────────────────────────────
// O admin faz upload de um .docx com os mesmos placeholders do modelo padrão.
// O sistema gera um link público /modelo/:slug para o cliente preencher.
export const modelosDinamicos = mysqlTable("modelos_dinamicos", {
  id: int("id").autoincrement().primaryKey(),
  nome: varchar("nome", { length: 255 }).notNull(),
  slug: varchar("slug", { length: 128 }).notNull().unique(),
  descricao: text("descricao"),
  fileKey: varchar("fileKey", { length: 512 }).notNull(),
  ativo: int("ativo").default(1).notNull(),
  criadoEm: timestamp("criadoEm").defaultNow().notNull(),
});

export type ModeloDinamico = typeof modelosDinamicos.$inferSelect;
export type InsertModeloDinamico = typeof modelosDinamicos.$inferInsert;

// Submissões dos clientes para modelos dinâmicos
export const submissoesModelo = mysqlTable("submissoes_modelo", {
  id: int("id").autoincrement().primaryKey(),
  modeloId: int("modeloId").notNull(),
  ...outorganteCols,
  dataAssinatura: varchar("dataAssinatura", { length: 10 }).notNull(),
  downloadToken: varchar("downloadToken", { length: 64 }),
  status: mysqlEnum("status", ["pendente", "gerada"]).default("pendente").notNull(),
  observacoes: text("observacoes"),
  criadoEm: timestamp("criadoEm").defaultNow().notNull(),
});

export type SubmissaoModelo = typeof submissoesModelo.$inferSelect;
export type InsertSubmissaoModelo = typeof submissoesModelo.$inferInsert;
