import { z } from "zod";
import { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";
import { getSessionCookieOptions } from "./_core/cookies";
import { systemRouter } from "./_core/systemRouter";
import { protectedProcedure, publicProcedure, router } from "./_core/trpc";
import { TRPCError } from "@trpc/server";
import { sdk } from "./_core/sdk";
import { verifyPassword, hashPassword } from "./authHelper";
import {
  getProcessosByUserId,
  getProcessosByCpf,
  createProcesso,
  updateProcesso,
  deleteProcesso,
  getNovidadesByUserId,
  countNovidadesNaoLidas,
  marcarNovidadeComoLida,
  getUserByEmail,
  getUserByCpf,
  verifyCpfHasProcess,
  registerClientPassword,
  getLeads,
} from "./db";

export const appRouter = router({
  system: systemRouter,
  auth: router({
    me: publicProcedure.query((opts) => opts.ctx.user),
    
    login: publicProcedure
      .input(z.object({ login: z.string(), password: z.string() }))
      .mutation(async ({ ctx, input }) => {
        const isEmail = input.login.includes("@");
        const user = isEmail
          ? await getUserByEmail(input.login)
          : await getUserByCpf(input.login.replace(/\D/g, ""));

        if (!user || !user.passwordHash || !verifyPassword(input.password, user.passwordHash)) {
          throw new TRPCError({ code: "UNAUTHORIZED", message: "E-mail/CPF ou senha incorretos" });
        }

        const sessionToken = await sdk.createSessionToken(user.email || user.cpf || user.openId, {
          name: user.name || "",
          expiresInMs: ONE_YEAR_MS,
        });

        const cookieOptions = getSessionCookieOptions(ctx.req);
        ctx.res.cookie(COOKIE_NAME, sessionToken, { ...cookieOptions, maxAge: ONE_YEAR_MS });

        return { success: true, user };
      }),

    checkCpfRegistration: publicProcedure
      .input(z.object({ cpf: z.string() }))
      .query(async ({ input }) => {
        const cleanCpf = input.cpf.replace(/\D/g, "");
        const allowed = await verifyCpfHasProcess(cleanCpf);
        return { allowed };
      }),

    registerClient: publicProcedure
      .input(z.object({
        name: z.string().min(2),
        cpf: z.string(),
        password: z.string().min(6),
        role: z.enum(["cliente", "admin"]).optional(),
      }))
      .mutation(async ({ input }) => {
        const cleanCpf = input.cpf.replace(/\D/g, "");
        const hasProcess = await verifyCpfHasProcess(cleanCpf);
        if (!hasProcess) {
          throw new TRPCError({
            code: "BAD_REQUEST",
            message: "CPF nÃ£o autorizado para cadastro (sem processos ativos vinculados)."
          });
        }
        const pwdHash = hashPassword(input.password);
        const success = await registerClientPassword(input.name, cleanCpf, pwdHash, input.role || "cliente");
        return { success };
      }),

    logout: publicProcedure.mutation(({ ctx }) => {
      const cookieOptions = getSessionCookieOptions(ctx.req);
      ctx.res.clearCookie(COOKIE_NAME, { ...cookieOptions, maxAge: -1 });
      return { success: true } as const;
    }),
  }),

  processos: router({
    list: publicProcedure.query(async ({ ctx }) => { const user = ctx.user || { id: 1, openId: "admin-master", role: "admin" }; if (user.role === "cliente" && user.cpf) { return getProcessosByCpf(user.cpf); } return getProcessosByUserId(user.id); }),

    create: protectedProcedure
      .input(
        z.object({
          numeroCnj: z.string().min(1),
          tribunal: z.string().min(1),
          dataLimite: z.string().nullable().optional(),
          tipoManifestacao: z.enum(["Recurso", "Resposta", "Apelação", "Embargos de declaração", "Autos conclusos", "Conciliação", "Audiência", "Contestação", "Impugnação", "Outro"]).nullable().optional(),
          horario: z.string().nullable().optional(),
          dataIntimacao: z.string().nullable().optional(),
          cliente: z.string().nullable().optional(),
          clienteCpf: z.string().nullable().optional(),
          anotacao: z.string().nullable().optional(),
          resumoProcessual: z.string().nullable().optional(),
        })
      )
      .mutation(async ({ ctx, input }) => {
        if (ctx.user.role === "cliente") {
          throw new TRPCError({ code: "FORBIDDEN", message: "Apenas advogados podem cadastrar processos." });
        }
        const result = await createProcesso({
          userId: ctx.user.id,
          numeroCnj: input.numeroCnj,
          tribunal: input.tribunal,
          dataLimite: input.dataLimite ? new Date(input.dataLimite) : null,
          dataIntimacao: input.dataIntimacao ? new Date(input.dataIntimacao) : null,
          tipoManifestacao: input.tipoManifestacao,
          horario: input.horario,
          cliente: input.cliente,
          clienteCpf: input.clienteCpf ? input.clienteCpf.replace(/\D/g, "") : null,
          anotacao: input.anotacao,
          resumoProcessual: input.resumoProcessual ?? null,
        });
        return { success: true, id: Number((result as any)?.[0]?.insertId ?? 0) };
      }),

    update: protectedProcedure
      .input(
        z.object({
          id: z.number(),
          dataLimite: z.string().nullable().optional(),
          dataIntimacao: z.string().nullable().optional(),
          tipoManifestacao: z.enum(["Recurso", "Resposta", "Apelação", "Embargos de declaração", "Autos conclusos", "Conciliação", "Audiência", "Contestação", "Impugnação", "Outro"]).nullable().optional(),
          horario: z.string().nullable().optional(),
          cliente: z.string().nullable().optional(),
          clienteCpf: z.string().nullable().optional(),
          anotacao: z.string().nullable().optional(),
          resumoProcessual: z.string().nullable().optional(),
        })
      )
      .mutation(async ({ ctx, input }) => {
        if (ctx.user.role === "cliente") {
          throw new TRPCError({ code: "FORBIDDEN", message: "Apenas advogados podem alterar processos." });
        }
        await updateProcesso(input.id, ctx.user.id, {
          dataLimite: input.dataLimite ? new Date(input.dataLimite) : null,
          dataIntimacao: input.dataIntimacao ? new Date(input.dataIntimacao) : null,
          tipoManifestacao: input.tipoManifestacao ?? null,
          horario: input.horario ?? null,
          cliente: input.cliente ?? null,
          clienteCpf: input.clienteCpf ? input.clienteCpf.replace(/\D/g, "") : null,
          anotacao: input.anotacao ?? null,
          resumoProcessual: input.resumoProcessual ?? null,
        });
        return { success: true };
      }),

    delete: protectedProcedure
      .input(z.object({ id: z.number() }))
      .mutation(async ({ ctx, input }) => {
        if (ctx.user.role === "cliente") {
          throw new TRPCError({ code: "FORBIDDEN", message: "Apenas advogados podem remover processos." });
        }
        await deleteProcesso(input.id, ctx.user.id);
        return { success: true };
      }),
  }),

  novidades: router({
    list: publicProcedure.query(async ({ ctx }) => { const user = ctx.user || { id: 1, openId: "admin-master", role: "admin" }; if (user.role === "cliente" && user.cpf) { return getProcessosByCpf(user.cpf); } return getProcessosByUserId(user.id); }),

    countNaoLidas: protectedProcedure.query(async ({ ctx }) => {
      return countNovidadesNaoLidas(ctx.user.id);
    }),

    marcarLida: protectedProcedure
      .input(z.object({ id: z.number() }))
      .mutation(async ({ ctx, input }) => {
        await marcarNovidadeComoLida(input.id, ctx.user.id);
        return { success: true };
      }),

    marcarTodasLidas: protectedProcedure.mutation(async ({ ctx }) => {
      const novs = await getNovidadesByUserId(ctx.user.id);
      await Promise.all(
        novs.filter(n => !n.lida).map(n => marcarNovidadeComoLida(n.id, ctx.user.id))
      );
      return { success: true };
    }),
  }),
  leads: router({
    list: publicProcedure.query(async ({ ctx }) => { const user = ctx.user || { id: 1, openId: "admin-master", role: "admin" }; if (user.role === "cliente" && user.cpf) { return getProcessosByCpf(user.cpf); } return getProcessosByUserId(user.id); }),
  }),
});

export type AppRouter = typeof appRouter;
