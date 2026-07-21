import { z } from "zod";
import { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";
import { getSessionCookieOptions } from "./_core/cookies";
import { systemRouter } from "./_core/systemRouter";
import { protectedProcedure, publicProcedure, router } from "./_core/trpc";
import { TRPCError } from "@trpc/server";
import { sdk } from "./_core/sdk";
import { verifyPassword } from "./authHelper";
import {
  listClients,
  listClientsAlpha,
  getClientById,
  createClientAndGetId,
  updateClient,
  deleteClient,
  markClientSettled,
  markClientUnsettled,
  createInstallments,
  deleteInstallmentsByClientId,
  getInstallmentsByClientId,
  markInstallmentPaid,
  markInstallmentUnpaid,
  updateInstallmentDueDate,
  getAllInstallmentsWithClients,
  syncOverdueInstallments,
  getUserByEmail,
} from "./db";

export const appRouter = router({
  system: systemRouter,
  auth: router({
    me: publicProcedure.query((opts) => opts.ctx.user),
    
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

  clients: router({
    list: protectedProcedure.query(async () => {
      await syncOverdueInstallments();
      return listClients();
    }),

    listAlpha: protectedProcedure.query(async () => {
      await syncOverdueInstallments();
      return listClientsAlpha();
    }),

    getById: protectedProcedure
      .input(z.object({ id: z.number() }))
      .query(async ({ input }) => {
        await syncOverdueInstallments();
        const client = await getClientById(input.id);
        if (!client) return null;
        const installments = await getInstallmentsByClientId(input.id);
        return { ...client, installments };
      }),

    create: protectedProcedure
      .input(
        z.object({
          name: z.string().min(1, "Nome é obrigatório"),
          totalFees: z.number().positive("Valor total deve ser positivo"),
          installmentCount: z.number().int().min(1).max(120),
          installmentValue: z.number().positive("Valor da parcela deve ser positivo"),
          startDate: z.number(),
          notes: z.string().optional(),
        })
      )
      .mutation(async ({ input }) => {
        const newClientId = await createClientAndGetId({
          name: input.name,
          totalFees: String(input.totalFees),
          installmentCount: input.installmentCount,
          installmentValue: String(input.installmentValue),
          startDate: input.startDate,
          notes: input.notes ?? null,
        });
        const newClient = await getClientById(newClientId);
        if (!newClient) throw new Error("Falha ao criar cliente");

        const now = Date.now();
        const installmentsData = Array.from(
          { length: input.installmentCount },
          (_, i) => {
            const dueDate = new Date(input.startDate);
            dueDate.setMonth(dueDate.getMonth() + i);
            const dueDateMs = dueDate.getTime();
            const status: "pending" | "overdue" =
              dueDateMs < now ? "overdue" : "pending";
            return {
              clientId: newClient.id,
              number: i + 1,
              dueDate: dueDateMs,
              paidAt: null,
              status,
            };
          }
        );

        await createInstallments(installmentsData);
        return newClient;
      }),

    update: protectedProcedure
      .input(
        z.object({
          id: z.number(),
          name: z.string().min(1).optional(),
          totalFees: z.number().positive().optional(),
          installmentCount: z.number().int().min(1).max(120).optional(),
          installmentValue: z.number().positive().optional(),
          startDate: z.number().optional(),
          notes: z.string().optional().nullable(),
        })
      )
      .mutation(async ({ input }) => {
        const { id, ...fields } = input;
        const updateData: Record<string, unknown> = {};
        if (fields.name !== undefined) updateData.name = fields.name;
        if (fields.totalFees !== undefined)
          updateData.totalFees = String(fields.totalFees);
        if (fields.installmentCount !== undefined)
          updateData.installmentCount = fields.installmentCount;
        if (fields.installmentValue !== undefined)
          updateData.installmentValue = String(fields.installmentValue);
        if (fields.startDate !== undefined)
          updateData.startDate = fields.startDate;
        if (fields.notes !== undefined) updateData.notes = fields.notes;

        await updateClient(id, updateData as any);
        return { success: true };
      }),

    regenerateInstallments: protectedProcedure
      .input(
        z.object({
          id: z.number(),
          installmentCount: z.number().int().min(1).max(120),
          installmentValue: z.number().positive(),
          startDate: z.number(),
        })
      )
      .mutation(async ({ input }) => {
        await deleteInstallmentsByClientId(input.id);
        const now = Date.now();
        const installmentsData = Array.from(
          { length: input.installmentCount },
          (_, i) => {
            const dueDate = new Date(input.startDate);
            dueDate.setMonth(dueDate.getMonth() + i);
            const dueDateMs = dueDate.getTime();
            const status: "pending" | "overdue" =
              dueDateMs < now ? "overdue" : "pending";
            return {
              clientId: input.id,
              number: i + 1,
              dueDate: dueDateMs,
              paidAt: null,
              status,
            };
          }
        );
        await createInstallments(installmentsData);
        return { success: true };
      }),

    markSettled: protectedProcedure
      .input(z.object({ id: z.number() }))
      .mutation(async ({ input }) => {
        const settledAt = Date.now();
        await markClientSettled(input.id, settledAt);
        return { success: true, settledAt };
      }),

    markUnsettled: protectedProcedure
      .input(z.object({ id: z.number() }))
      .mutation(async ({ input }) => {
        await markClientUnsettled(input.id);
        return { success: true };
      }),

    delete: protectedProcedure
      .input(z.object({ id: z.number() }))
      .mutation(async ({ input }) => {
        await deleteClient(input.id);
        return { success: true };
      }),
  }),

  installments: router({
    markPaid: protectedProcedure
      .input(z.object({ id: z.number() }))
      .mutation(async ({ input }) => {
        const paidAt = Date.now();
        await markInstallmentPaid(input.id, paidAt);
        return { success: true, paidAt };
      }),

    markUnpaid: protectedProcedure
      .input(z.object({ id: z.number() }))
      .mutation(async ({ input }) => {
        await markInstallmentUnpaid(input.id);
        return { success: true };
      }),

    updateDueDate: protectedProcedure
      .input(z.object({ id: z.number(), dueDate: z.number() }))
      .mutation(async ({ input }) => {
        await updateInstallmentDueDate(input.id, input.dueDate);
        return { success: true };
      }),

    carne: protectedProcedure.query(async () => {
      await syncOverdueInstallments();
      return getAllInstallmentsWithClients();
    }),
  }),
});

export type AppRouter = typeof appRouter;
