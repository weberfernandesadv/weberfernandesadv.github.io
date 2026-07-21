import { describe, expect, it, vi } from "vitest";
import { appRouter } from "./routers";
import type { TrpcContext } from "./_core/context";

// Mock db functions
vi.mock("./db", () => ({
  getProcessosByUserId: vi.fn().mockResolvedValue([
    {
      id: 1,
      userId: 1,
      numeroCnj: "0000001-00.2024.9.09.0000",
      tribunal: "TJGO",
      dataLimite: new Date("2026-05-26"),
      tipoManifestacao: "Resposta",
      cliente: "João Silva",
      anotacao: "Urgente",
      ativo: true,
      createdAt: new Date(),
      updatedAt: new Date(),
    },
  ]),
  createProcesso: vi.fn().mockResolvedValue({ insertId: 2 }),
  updateProcesso: vi.fn().mockResolvedValue({}),
  deleteProcesso: vi.fn().mockResolvedValue({}),
  getNovidadesByUserId: vi.fn().mockResolvedValue([]),
  createNovidade: vi.fn().mockResolvedValue({}),
  marcarNovidadeComoLida: vi.fn().mockResolvedValue({}),
  countNovidadesNaoLidas: vi.fn().mockResolvedValue(0),
}));

vi.mock("./_core/notification", () => ({
  notifyOwner: vi.fn().mockResolvedValue(true),
}));

function createAuthContext(): TrpcContext {
  return {
    user: {
      id: 1,
      openId: "test-user",
      email: "test@example.com",
      name: "Test User",
      loginMethod: "manus",
      role: "user",
      createdAt: new Date(),
      updatedAt: new Date(),
      lastSignedIn: new Date(),
    },
    req: { protocol: "https", headers: {} } as TrpcContext["req"],
    res: { clearCookie: vi.fn() } as unknown as TrpcContext["res"],
  };
}

describe("processos.list", () => {
  it("retorna lista de processos do usuário com novos campos", async () => {
    const ctx = createAuthContext();
    const caller = appRouter.createCaller(ctx);
    const result = await caller.processos.list();
    expect(Array.isArray(result)).toBe(true);
    expect(result[0].tribunal).toBe("TJGO");
    expect(result[0].tipoManifestacao).toBe("Resposta");
    expect(result[0].cliente).toBe("João Silva");
  });
});

describe("processos.create", () => {
  it("cria um processo com todos os campos", async () => {
    const ctx = createAuthContext();
    const caller = appRouter.createCaller(ctx);
    const result = await caller.processos.create({
      numeroCnj: "0000001-00.2024.9.09.0000",
      tribunal: "TJGO",
      dataLimite: "2026-05-26",
      tipoManifestacao: "Resposta",
      cliente: "Maria",
      anotacao: "Prazo improrrogável",
    });
    expect(result.success).toBe(true);
  });

  it("cria um processo sem campos opcionais", async () => {
    const ctx = createAuthContext();
    const caller = appRouter.createCaller(ctx);
    const result = await caller.processos.create({
      numeroCnj: "0000001-00.2024.9.09.0000",
      tribunal: "TJGO",
    });
    expect(result.success).toBe(true);
  });

  it("rejeita processo sem número CNJ", async () => {
    const ctx = createAuthContext();
    const caller = appRouter.createCaller(ctx);
    await expect(
      caller.processos.create({ numeroCnj: "", tribunal: "TJGO" })
    ).rejects.toThrow();
  });
});

describe("processos.update", () => {
  it("atualiza campos de um processo", async () => {
    const ctx = createAuthContext();
    const caller = appRouter.createCaller(ctx);
    const result = await caller.processos.update({
      id: 1,
      dataLimite: "2026-06-01",
      tipoManifestacao: "Recurso",
      cliente: "Pedro",
      anotacao: "Nova anotação",
    });
    expect(result.success).toBe(true);
  });
});

describe("processos.delete", () => {
  it("remove um processo com sucesso", async () => {
    const ctx = createAuthContext();
    const caller = appRouter.createCaller(ctx);
    const result = await caller.processos.delete({ id: 1 });
    expect(result.success).toBe(true);
  });
});

describe("novidades.countNaoLidas", () => {
  it("retorna contagem de novidades não lidas", async () => {
    const ctx = createAuthContext();
    const caller = appRouter.createCaller(ctx);
    const count = await caller.novidades.countNaoLidas();
    expect(typeof count).toBe("number");
  });
});
