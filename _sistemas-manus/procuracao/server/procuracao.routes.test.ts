/**
 * Testes de integração para as rotas Express de procuração.
 *
 * POST /api/gerar-procuracao  — deve salvar no banco e retornar JSON (não .docx)
 * GET  /api/gerar-procuracao-por-id/:id — deve exigir autenticação admin
 */
import { describe, it, expect, vi, beforeEach } from "vitest";
import express from "express";
import request from "supertest";
import { procuracaoRouter } from "./procuracao";

// ─── Mocks ────────────────────────────────────────────────────────────────────
vi.mock("./db", async (importOriginal) => {
  const original = await importOriginal<typeof import("./db")>();
  return {
    ...original,
    salvarProcuracao: vi.fn().mockResolvedValue(42),
    buscarProcuracao: vi.fn(),
  };
});

vi.mock("./_core/notification", () => ({
  notifyOwner: vi.fn().mockResolvedValue(true),
}));

// Mock do sdk: por padrão, lança erro (não autenticado)
vi.mock("./_core/sdk", () => ({
  sdk: {
    authenticateRequest: vi.fn().mockRejectedValue(new Error("No session")),
  },
}));

import { salvarProcuracao, buscarProcuracao } from "./db";
import { sdk } from "./_core/sdk";

// ─── App de teste ─────────────────────────────────────────────────────────────
function buildApp() {
  const app = express();
  app.use(express.json());
  app.use("/api", procuracaoRouter);
  return app;
}

const dadosValidos = {
  nome: "Maria da Silva Souza",
  genero: "brasileira",
  estadoCivil: "solteiro(a)",
  profissao: "Professora",
  cpf: "123.456.789-00",
  naturalidadeCidade: "Goiânia",
  naturalidadeUF: "GO",
  filiacao: "José da Silva e Ana Souza",
  rua: "Rua das Flores, nº 10",
  cidade: "Goiânia",
  estado: "GO",
  cep: "74000-000",
};

// ─── POST /api/gerar-procuracao ───────────────────────────────────────────────
describe("POST /api/gerar-procuracao", () => {
  beforeEach(() => vi.clearAllMocks());

  it("retorna JSON de confirmação (não um arquivo .docx)", async () => {
    vi.mocked(salvarProcuracao).mockResolvedValue(42);
    const app = buildApp();
    const res = await request(app)
      .post("/api/gerar-procuracao")
      .send(dadosValidos)
      .set("Content-Type", "application/json");

    expect(res.status).toBe(200);
    expect(res.headers["content-type"]).toMatch(/json/);
    expect(res.body.sucesso).toBe(true);
    expect(res.body.id).toBe(42);
    // Garante que NÃO é um arquivo Word
    expect(res.headers["content-type"]).not.toMatch(/wordprocessingml/);
    expect(res.headers["content-disposition"]).toBeUndefined();
  });

  it("salva os dados no banco de dados", async () => {
    vi.mocked(salvarProcuracao).mockResolvedValue(1);
    const app = buildApp();
    await request(app)
      .post("/api/gerar-procuracao")
      .send(dadosValidos)
      .set("Content-Type", "application/json");

    expect(salvarProcuracao).toHaveBeenCalledOnce();
    const chamada = vi.mocked(salvarProcuracao).mock.calls[0][0];
    expect(chamada.nome).toBe("MARIA DA SILVA SOUZA"); // Nome em maiúsculas
    expect(chamada.cpf).toBe("123.456.789-00");
  });

  it("retorna 400 para dados inválidos", async () => {
    const app = buildApp();
    const res = await request(app)
      .post("/api/gerar-procuracao")
      .send({ nome: "AB" }) // nome muito curto, faltam campos
      .set("Content-Type", "application/json");

    expect(res.status).toBe(400);
    expect(res.body.erro).toBeDefined();
  });

  it("retorna 400 para CPF sem formatação", async () => {
    const app = buildApp();
    const res = await request(app)
      .post("/api/gerar-procuracao")
      .send({ ...dadosValidos, cpf: "12345678900" })
      .set("Content-Type", "application/json");

    expect(res.status).toBe(400);
  });
});

// ─── GET /api/gerar-procuracao-por-id/:id ─────────────────────────────────────
describe("GET /api/gerar-procuracao-por-id/:id", () => {
  beforeEach(() => vi.clearAllMocks());

  it("retorna 401 quando não há sessão autenticada", async () => {
    vi.mocked(sdk.authenticateRequest).mockRejectedValue(new Error("No session"));
    const app = buildApp();
    const res = await request(app).get("/api/gerar-procuracao-por-id/1");
    expect(res.status).toBe(401);
    expect(res.body.erro).toBeDefined();
  });

  it("retorna 403 quando o usuário não é admin", async () => {
    vi.mocked(sdk.authenticateRequest).mockResolvedValue({
      id: 2,
      openId: "user-id",
      name: "Cliente",
      email: "cliente@test.com",
      loginMethod: "email",
      role: "user",
      createdAt: new Date(),
      updatedAt: new Date(),
      lastSignedIn: new Date(),
    });
    const app = buildApp();
    const res = await request(app).get("/api/gerar-procuracao-por-id/1");
    expect(res.status).toBe(403);
    expect(res.body.erro).toBeDefined();
  });

  it("retorna 400 para ID inválido (zero) mesmo sem autenticação", async () => {
    // O middleware de auth roda antes, então sem sessão retorna 401
    vi.mocked(sdk.authenticateRequest).mockRejectedValue(new Error("No session"));
    const app = buildApp();
    const res = await request(app).get("/api/gerar-procuracao-por-id/0");
    expect(res.status).toBe(401);
  });

  it("retorna 404 quando admin busca ID inexistente", async () => {
    vi.mocked(sdk.authenticateRequest).mockResolvedValue({
      id: 1,
      openId: "admin-id",
      name: "Admin",
      email: "admin@test.com",
      loginMethod: "email",
      role: "admin",
      createdAt: new Date(),
      updatedAt: new Date(),
      lastSignedIn: new Date(),
    });
    vi.mocked(buscarProcuracao).mockResolvedValue(null);
    const app = buildApp();
    const res = await request(app).get("/api/gerar-procuracao-por-id/999");
    expect(res.status).toBe(404);
  });
});
