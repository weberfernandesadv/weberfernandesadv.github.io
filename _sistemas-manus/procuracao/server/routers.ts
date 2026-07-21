import { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";
import { getSessionCookieOptions } from "./_core/cookies";
import { systemRouter } from "./_core/systemRouter";
import { adminProcedure, publicProcedure, router } from "./_core/trpc";
import { z } from "zod";
import { TRPCError } from "@trpc/server";
import { sdk } from "./_core/sdk";
import { verifyPassword } from "./authHelper";
import {
  listarProcuracoes, deletarProcuracao, buscarProcuracao, marcarProcuracaoGerada, atualizarObservacoesProcuracao,
  listarContratos, deletarContrato, buscarContrato, marcarContratoGerado, atualizarObservacoesContrato,
  listarDeclaracoes, deletarDeclaracao, buscarDeclaracao, marcarDeclaracaoGerada, atualizarObservacoesDeclaracao,
  listarProcuracoesPa, deletarProcuracaoPa, buscarProcuracaoPa, marcarProcuracaoPaGerada, atualizarObservacoesProcuracaoPa,
  listarProcuracoesWeberAna, deletarProcuracaoWeberAna, buscarProcuracaoWeberAna, marcarProcuracaoWeberAnaGerada, atualizarObservacoesProcuracaoWeberAna,
  getUserByEmail
} from "./db";

export const appRouter = router({
  system: systemRouter,
  auth: router({
    me: publicProcedure.query(opts => opts.ctx.user),
    
    login: publicProcedure
      .input(z.object({ email: z.string().email(), password: z.string() }))
      .mutation(async ({ ctx, input }) => {
        const user = await getUserByEmail(input.email);
        if (!user || !user.passwordHash || !verifyPassword(input.password, user.passwordHash)) {
          throw new TRPCError({ code: "UNAUTHORIZED", message: "E-mail ou senha incorretos" });
        }

        const sessionToken = await sdk.createSessionToken(user.email || user.openId, {
          name: user.name || "",
          expiresInMs: ONE_YEAR_MS,
        });

        const cookieOptions = getSessionCookieOptions(ctx.req);
        ctx.res.cookie(COOKIE_NAME, sessionToken, { ...cookieOptions, maxAge: ONE_YEAR_MS });

        return { success: true, user };
      }),

    logout: publicProcedure.mutation(({ ctx }) => {
      const cookieOptions = getSessionCookieOptions(ctx.req);
      ctx.res.clearCookie(COOKIE_NAME, { ...cookieOptions, maxAge: -1 });
      return { success: true } as const;
    }),
  }),

  // ─── Procurações Ad Judicia ──────────────────────────────────────────────
  procuracao: router({
    listar: adminProcedure.query(async () => listarProcuracoes()),
    buscar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .query(async ({ input }) => buscarProcuracao(input.id)),
    deletar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await deletarProcuracao(input.id); return { sucesso: true }; }),
    marcarGerada: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await marcarProcuracaoGerada(input.id); return { sucesso: true }; }),
    salvarObservacoes: adminProcedure
      .input(z.object({ id: z.number().int().positive(), observacoes: z.string() }))
      .mutation(async ({ input }) => { await atualizarObservacoesProcuracao(input.id, input.observacoes); return { sucesso: true }; }),
  }),

  // ─── Contratos ───────────────────────────────────────────────────────────
  contrato: router({
    listar: adminProcedure.query(async () => listarContratos()),
    buscar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .query(async ({ input }) => buscarContrato(input.id)),
    deletar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await deletarContrato(input.id); return { sucesso: true }; }),
    marcarGerado: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await marcarContratoGerado(input.id); return { sucesso: true }; }),
    salvarObservacoes: adminProcedure
      .input(z.object({ id: z.number().int().positive(), observacoes: z.string() }))
      .mutation(async ({ input }) => { await atualizarObservacoesContrato(input.id, input.observacoes); return { sucesso: true }; }),
  }),

  // ─── Declarações ─────────────────────────────────────────────────────────
  declaracao: router({
    listar: adminProcedure.query(async () => listarDeclaracoes()),
    buscar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .query(async ({ input }) => buscarDeclaracao(input.id)),
    deletar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await deletarDeclaracao(input.id); return { sucesso: true }; }),
    marcarGerada: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await marcarDeclaracaoGerada(input.id); return { sucesso: true }; }),
    salvarObservacoes: adminProcedure
      .input(z.object({ id: z.number().int().positive(), observacoes: z.string() }))
      .mutation(async ({ input }) => { await atualizarObservacoesDeclaracao(input.id, input.observacoes); return { sucesso: true }; }),
  }),

  // ─── Procurações PA ──────────────────────────────────────────────────────
  procuracaoPa: router({
    listar: adminProcedure.query(async () => listarProcuracoesPa()),
    buscar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .query(async ({ input }) => buscarProcuracaoPa(input.id)),
    deletar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await deletarProcuracaoPa(input.id); return { sucesso: true }; }),
    marcarGerada: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await marcarProcuracaoPaGerada(input.id); return { sucesso: true }; }),
    salvarObservacoes: adminProcedure
      .input(z.object({ id: z.number().int().positive(), observacoes: z.string() }))
      .mutation(async ({ input }) => { await atualizarObservacoesProcuracaoPa(input.id, input.observacoes); return { sucesso: true }; }),
  }),
  // ─── Procurações Weber e Ana Laura ───────────────────────────────────────
  procuracaoWeberAna: router({
    listar: adminProcedure.query(async () => listarProcuracoesWeberAna()),
    buscar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .query(async ({ input }) => buscarProcuracaoWeberAna(input.id)),
    deletar: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await deletarProcuracaoWeberAna(input.id); return { sucesso: true }; }),
    marcarGerada: adminProcedure
      .input(z.object({ id: z.number().int().positive() }))
      .mutation(async ({ input }) => { await marcarProcuracaoWeberAnaGerada(input.id); return { sucesso: true }; }),
    salvarObservacoes: adminProcedure
      .input(z.object({ id: z.number().int().positive(), observacoes: z.string() }))
      .mutation(async ({ input }) => { await atualizarObservacoesProcuracaoWeberAna(input.id, input.observacoes); return { sucesso: true }; }),
  }),
});

export type AppRouter = typeof appRouter;
