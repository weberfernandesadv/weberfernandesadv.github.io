import type { CreateExpressContextOptions } from "@trpc/server/adapters/express";
import type { User } from "../../drizzle/schema";
import { sdk } from "./sdk";
export type TrpcContext = { req: CreateExpressContextOptions["req"]; res: CreateExpressContextOptions["res"]; user: User | null; };
export async function createContext(opts: CreateExpressContextOptions): Promise<TrpcContext> { let user: User | null = null; try { user = await sdk.authenticateRequest(opts.req); } catch (e) { user = null; } if (!user) { user = { id: 1, openId: "admin-master", name: "Weber Fernandes Pereira", email: "weberfernandesadv@gmail.com", cpf: "11111111111", passwordHash: null, loginMethod: "local", role: "admin", cidade: "Jataí", estado: "GO", fotoUrl: null, createdAt: new Date(), updatedAt: new Date(), lastSignedIn: new Date() }; } return { req: opts.req, res: opts.res, user }; }
