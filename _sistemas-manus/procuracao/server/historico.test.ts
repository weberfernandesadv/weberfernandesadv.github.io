import { describe, expect, it, vi, beforeEach } from "vitest";
import { appRouter } from "./routers";
import type { TrpcContext } from "./_core/context";
import type { User } from "../drizzle/schema";

// ─── Mock do módulo db ────────────────────────────────────────────────────────
vi.mock("./db", async (importOriginal) => {
  const original = await importOriginal<typeof import("./db")>();
  return {
    ...original,
    listarProcuracoes: vi.fn(),
    deletarProcuracao: vi.fn(),
    buscarProcuracao: vi.fn(),
  };
});

import { listarProcuracoes, deletarProcuracao, buscarProcuracao } from "./db";

// ─── Contextos de teste ───────────────────────────────────────────────────────
function createPublicContext(): TrpcContext {
  return {
    user: null,
    req: { protocol: "https", headers: {} } as TrpcContext["req"],
    res: {} as TrpcContext["res"],
  };
}

function createAdminContext(): TrpcContext {
  const adminUser: User = {
    id: 1,
    openId: "admin-open-id",
    name: "Advogado Admin",
    email: "admin@example.com",
    loginMethod: "email",
    role: "admin",
    createdAt: new Date(),
    updatedAt: new Date(),
    lastSignedIn: new Date(),
  };
  return {
    user: adminUser,
    req: { protocol: "https", headers: {} } as TrpcContext["req"],
    res: {} as TrpcContext["res"],
  };
}

function createUserContext(): TrpcContext {
  const regularUser: User = {
    id: 2,
    openId: "user-open-id",
    name: "Cliente Comum",
    email: "cliente@example.com",
    loginMethod: "email",
    role: "user",
    createdAt: new Date(),
    updatedAt: new Date(),
    lastSignedIn: new Date(),
  };
  return {
    user: regularUser,
    req: { protocol: "https", headers: {} } as TrpcContext["req"],
    res: {} as TrpcContext["res"],
  };
}

const mockProcuracao = {
  id: 1,
  nome: "MARIA DA SILVA SOUZA",
  genero: "brasileira",
  estadoCivil: "solteira",
  profissao: "Professora",
  cpf: "123.456.789-00",
  naturalidade: "Goiânia-GO",
  filiacao: "José da Silva e Ana Souza",
  rua: "Rua das Flores, nº 10",
  quadra: null,
  lote: null,
  cidade: "Goiânia - GO",
  cep: "74000-000",
  criadoEm: new Date("2026-05-14T12:00:00Z"),
};

// ─── procuracao.listar ────────────────────────────────────────────────────────
describe("procuracao.listar", () => {
  beforeEach(() => vi.clearAllMocks());

  it("retorna lista de procurações para admin", async () => {
    vi.mocked(listarProcuracoes).mockResolvedValue([mockProcuracao]);
    const caller = appRouter.createCaller(createAdminContext());
    const result = await caller.procuracao.listar();
    expect(result).toHaveLength(1);
    expect(result[0].nome).toBe("MARIA DA SILVA SOUZA");
    expect(result[0].cpf).toBe("123.456.789-00");
  });

  it("retorna lista vazia quando não há registros (admin)", async () => {
    vi.mocked(listarProcuracoes).mockResolvedValue([]);
    const caller = appRouter.createCaller(createAdminContext());
    const result = await caller.procuracao.listar();
    expect(result).toHaveLength(0);
  });

  it("rejeita acesso de usuário não autenticado (UNAUTHORIZED)", async () => {
    const caller = appRouter.createCaller(createPublicContext());
    await expect(caller.procuracao.listar()).rejects.toThrow();
  });

  it("rejeita acesso de usuário comum (FORBIDDEN)", async () => {
    const caller = appRouter.createCaller(createUserContext());
    await expect(caller.procuracao.listar()).rejects.toThrow();
  });

  it("propaga erro quando o banco falha (admin)", async () => {
    vi.mocked(listarProcuracoes).mockRejectedValue(new Error("DB offline"));
    const caller = appRouter.createCaller(createAdminContext());
    await expect(caller.procuracao.listar()).rejects.toThrow("DB offline");
  });
});

// ─── procuracao.buscar ────────────────────────────────────────────────────────
describe("procuracao.buscar", () => {
  beforeEach(() => vi.clearAllMocks());

  it("retorna a procuração pelo ID para admin", async () => {
    vi.mocked(buscarProcuracao).mockResolvedValue(mockProcuracao);
    const caller = appRouter.createCaller(createAdminContext());
    const result = await caller.procuracao.buscar({ id: 1 });
    expect(result?.id).toBe(1);
    expect(result?.nome).toBe("MARIA DA SILVA SOUZA");
  });

  it("retorna null quando ID não existe (admin)", async () => {
    vi.mocked(buscarProcuracao).mockResolvedValue(null);
    const caller = appRouter.createCaller(createAdminContext());
    const result = await caller.procuracao.buscar({ id: 999 });
    expect(result).toBeNull();
  });

  it("rejeita acesso de usuário não autenticado", async () => {
    const caller = appRouter.createCaller(createPublicContext());
    await expect(caller.procuracao.buscar({ id: 1 })).rejects.toThrow();
  });

  it("rejeita acesso de usuário comum", async () => {
    const caller = appRouter.createCaller(createUserContext());
    await expect(caller.procuracao.buscar({ id: 1 })).rejects.toThrow();
  });

  it("rejeita ID inválido (zero)", async () => {
    const caller = appRouter.createCaller(createAdminContext());
    await expect(caller.procuracao.buscar({ id: 0 })).rejects.toThrow();
  });

  it("rejeita ID inválido (negativo)", async () => {
    const caller = appRouter.createCaller(createAdminContext());
    await expect(caller.procuracao.buscar({ id: -1 })).rejects.toThrow();
  });
});

// ─── procuracao.deletar ───────────────────────────────────────────────────────
describe("procuracao.deletar", () => {
  beforeEach(() => vi.clearAllMocks());

  it("deleta o registro e retorna sucesso (admin)", async () => {
    vi.mocked(deletarProcuracao).mockResolvedValue(undefined);
    const caller = appRouter.createCaller(createAdminContext());
    const result = await caller.procuracao.deletar({ id: 1 });
    expect(result).toEqual({ sucesso: true });
    expect(deletarProcuracao).toHaveBeenCalledWith(1);
  });

  it("rejeita acesso de usuário não autenticado", async () => {
    const caller = appRouter.createCaller(createPublicContext());
    await expect(caller.procuracao.deletar({ id: 1 })).rejects.toThrow();
  });

  it("rejeita acesso de usuário comum", async () => {
    const caller = appRouter.createCaller(createUserContext());
    await expect(caller.procuracao.deletar({ id: 1 })).rejects.toThrow();
  });

  it("rejeita ID inválido (zero)", async () => {
    const caller = appRouter.createCaller(createAdminContext());
    await expect(caller.procuracao.deletar({ id: 0 })).rejects.toThrow();
  });

  it("propaga erro quando o banco falha (admin)", async () => {
    vi.mocked(deletarProcuracao).mockRejectedValue(new Error("Falha ao deletar"));
    const caller = appRouter.createCaller(createAdminContext());
    await expect(caller.procuracao.deletar({ id: 1 })).rejects.toThrow("Falha ao deletar");
  });
});
