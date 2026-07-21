/**
 * Testes de integração para as rotas de Contrato, Declaração e Procuração PA.
 */
import { describe, it, expect } from "vitest";
import request from "supertest";
import express from "express";
import { documentosRouter } from "./documentos";

// App de teste isolado
const app = express();
app.use(express.json());
app.use("/api", documentosRouter);

// Dados válidos comuns (outorgante)
const outorgante = {
  nome: "MARIA DA SILVA SOUZA",
  genero: "brasileira",
  estadoCivil: "solteira",
  profissao: "professora",
  cpf: "123.456.789-00",
  rg: "1234567",
  naturalidade: "Goiânia-GO",
  nomePai: "João da Silva",
  nomeMae: "Ana da Silva",
  rua: "Rua das Flores, nº 10",
  cidade: "Goiânia",
  estado: "GO",
  cep: "74000-000",
};

// Token longo o suficiente para passar a validação (>= 20 chars) mas inexistente no banco
const TOKEN_INVALIDO = "aaaabbbbccccddddeeee1234";

// ─── Contrato ─────────────────────────────────────────────────────────────────
describe("POST /api/contrato", () => {
  it("retorna 400 quando dados estão ausentes", async () => {
    const res = await request(app).post("/api/contrato").send({});
    expect(res.status).toBe(400);
    expect(res.body).toHaveProperty("erro");
  });

  it("retorna 200 com sucesso e id ao receber dados válidos (apenas dados do cliente)", async () => {
    const res = await request(app).post("/api/contrato").send({
      ...outorgante,
      dataContrato: "08/06/2026",
    });
    expect(res.status).toBe(200);
    expect(res.body).toHaveProperty("sucesso", true);
    expect(res.body).toHaveProperty("id");
  });
});

// ─── Download de Contrato por Token ───────────────────────────────────────────
describe("GET /api/download-contrato/:token", () => {
  it("retorna 404 para token válido mas inexistente no banco", async () => {
    const res = await request(app).get(`/api/download-contrato/${TOKEN_INVALIDO}`);
    expect(res.status).toBe(404);
  });

  it("retorna 400 para token muito curto", async () => {
    const res = await request(app).get("/api/download-contrato/curto");
    expect(res.status).toBe(400);
  });
});

// ─── Declaração ───────────────────────────────────────────────────────────────
describe("POST /api/declaracao", () => {
  it("retorna 400 quando dados estão ausentes", async () => {
    const res = await request(app).post("/api/declaracao").send({});
    expect(res.status).toBe(400);
  });

  it("retorna 200 com sucesso e id ao receber dados válidos", async () => {
    const res = await request(app).post("/api/declaracao").send({
      ...outorgante,
      dataDeclaracao: "08/06/2026",
    });
    expect(res.status).toBe(200);
    expect(res.body).toHaveProperty("sucesso", true);
    expect(res.body).toHaveProperty("id");
  });
});

describe("GET /api/download-declaracao/:token", () => {
  it("retorna 404 para token válido mas inexistente no banco", async () => {
    const res = await request(app).get(`/api/download-declaracao/${TOKEN_INVALIDO}`);
    expect(res.status).toBe(404);
  });

  it("retorna 400 para token muito curto", async () => {
    const res = await request(app).get("/api/download-declaracao/curto");
    expect(res.status).toBe(400);
  });
});

// ─── Procuração PA ────────────────────────────────────────────────────────────
describe("POST /api/procuracao-pa", () => {
  it("retorna 400 quando dados estão ausentes", async () => {
    const res = await request(app).post("/api/procuracao-pa").send({});
    expect(res.status).toBe(400);
  });

  it("retorna 200 com sucesso e id ao receber dados válidos", async () => {
    const res = await request(app).post("/api/procuracao-pa").send({
      ...outorgante,
      nomeMenor: "PEDRO DA SILVA",
      cpfMenor: "987.654.321-00",
      dataNascimento: "15/03/2023",
    });
    expect(res.status).toBe(200);
    expect(res.body).toHaveProperty("sucesso", true);
    expect(res.body).toHaveProperty("id");
  });
});

describe("GET /api/download-procuracao-pa/:token", () => {
  it("retorna 404 para token válido mas inexistente no banco", async () => {
    const res = await request(app).get(`/api/download-procuracao-pa/${TOKEN_INVALIDO}`);
    expect(res.status).toBe(404);
  });

  it("retorna 400 para token muito curto", async () => {
    const res = await request(app).get("/api/download-procuracao-pa/curto");
    expect(res.status).toBe(400);
  });
});

// ─── Proteção admin ───────────────────────────────────────────────────────────
describe("GET /api/contrato-por-id/:id (admin)", () => {
  it("retorna 401 sem autenticação", async () => {
    const res = await request(app).get("/api/contrato-por-id/1");
    expect(res.status).toBe(401);
  });
});

describe("GET /api/declaracao-por-id/:id (admin)", () => {
  it("retorna 401 sem autenticação", async () => {
    const res = await request(app).get("/api/declaracao-por-id/1");
    expect(res.status).toBe(401);
  });
});

describe("GET /api/procuracao-pa-por-id/:id (admin)", () => {
  it("retorna 401 sem autenticação", async () => {
    const res = await request(app).get("/api/procuracao-pa-por-id/1");
    expect(res.status).toBe(401);
  });
});
