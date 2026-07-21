import { date, int, mysqlEnum, mysqlTable, text, timestamp, varchar, boolean } from "drizzle-orm/mysql-core";

export const users = mysqlTable("users", {
  id: int("id").autoincrement().primaryKey(),
  openId: varchar("openId", { length: 64 }).unique(),
  name: text("name"),
  email: varchar("email", { length: 320 }).unique(),
  cpf: varchar("cpf", { length: 14 }).unique(),
  passwordHash: text("passwordHash"),
  loginMethod: varchar("loginMethod", { length: 64 }),
  role: mysqlEnum("role", ["user", "admin", "cliente"]).default("user").notNull(),
  cidade: varchar("cidade", { length: 100 }),
  estado: varchar("estado", { length: 50 }),
  fotoUrl: text("fotoUrl"),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
  lastSignedIn: timestamp("lastSignedIn").defaultNow().notNull(),
});

export type User = typeof users.$inferSelect;
export type InsertUser = typeof users.$inferInsert;

export const processos = mysqlTable("processos", {
  id: int("id").autoincrement().primaryKey(),
  userId: int("userId").notNull(),
  numeroCnj: varchar("numeroCnj", { length: 50 }).notNull(),
  tribunal: varchar("tribunal", { length: 30 }).notNull(),
  dataLimite: date("dataLimite"),
  tipoManifestacao: mysqlEnum("tipoManifestacao", ["Recurso", "Resposta", "Apelação", "Embargos de declaração", "Autos conclusos", "Conciliação", "Audiência", "Contestação", "Impugnação", "Outro"]),
  horario: varchar("horario", { length: 5 }),
  dataIntimacao: date("dataIntimacao"),
  cliente: varchar("cliente", { length: 255 }),
  clienteCpf: varchar("clienteCpf", { length: 14 }),
  anotacao: text("anotacao"),
  ativo: boolean("ativo").default(true).notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
});

export type Processo = typeof processos.$inferSelect;
export type InsertProcesso = typeof processos.$inferInsert;

export const novidades = mysqlTable("novidades", {
  id: int("id").autoincrement().primaryKey(),
  userId: int("userId").notNull(),
  processoId: int("processoId"),
  titulo: varchar("titulo", { length: 255 }).notNull(),
  conteudo: text("conteudo"),
  lida: boolean("lida").default(false).notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
});

export type Novidade = typeof novidades.$inferSelect;
export type InsertNovidade = typeof novidades.$inferInsert;

export const leads = mysqlTable("leads", {
  id: int("id").autoincrement().primaryKey(),
  nome: varchar("nome", { length: 255 }).notNull(),
  telefone: varchar("telefone", { length: 20 }).notNull(),
  advogado: varchar("advogado", { length: 255 }).notNull(),
  mensagem: text("mensagem"),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
});

export type Lead = typeof leads.$inferSelect;
export type InsertLead = typeof leads.$inferInsert;

export const artigos = mysqlTable("artigos", {
  id: int("id").autoincrement().primaryKey(),
  userId: int("userId").notNull(),
  titulo: varchar("titulo", { length: 255 }).notNull(),
  conteudo: text("conteudo").notNull(),
  tipo: varchar("tipo", { length: 50 }).default("Artigo").notNull(),
  categoria: varchar("categoria", { length: 100 }).default("Geral").notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
});

export type Artigo = typeof artigos.$inferSelect;
export type InsertArtigo = typeof artigos.$inferInsert;

export const curtidas = mysqlTable("curtidas", {
  id: int("id").autoincrement().primaryKey(),
  userId: int("userId").notNull(),
  artigoId: int("artigoId").notNull(),
});

export type Curtida = typeof curtidas.$inferSelect;
export type InsertCurtida = typeof curtidas.$inferInsert;

export const salvos = mysqlTable("salvos", {
  id: int("id").autoincrement().primaryKey(),
  userId: int("userId").notNull(),
  artigoId: int("artigoId").notNull(),
});

export type Salvo = typeof salvos.$inferSelect;
export type InsertSalvo = typeof salvos.$inferInsert;

export const comentarios = mysqlTable("comentarios", {
  id: int("id").autoincrement().primaryKey(),
  userId: int("userId").notNull(),
  artigoId: int("artigoId").notNull(),
  texto: text("texto").notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
});

export type Comentario = typeof comentarios.$inferSelect;
export type InsertComentario = typeof comentarios.$inferInsert;
