import { eq, desc, asc, and, lt } from "drizzle-orm";
import { drizzle } from "drizzle-orm/mysql2";
import {
  InsertUser,
  users,
  clients,
  installments,
  InsertClient,
  InsertInstallment,
} from "../drizzle/schema";
import { ENV } from "./_core/env";
import { hashPassword } from "./authHelper";

let _db: ReturnType<typeof drizzle> | null = null;
let _seeded = false;

export async function getDb() {
  if (!_db && process.env.DATABASE_URL) {
    try {
      _db = drizzle(process.env.DATABASE_URL);
      if (!_seeded) {
        _seeded = true;
        setTimeout(() => seedAdminUser(), 100);
      }
    } catch (error) {
      console.warn("[Database] Failed to connect:", error);
      _db = null;
    }
  }
  return _db;
}

// ─── Users ───────────────────────────────────────────────────────────────────

export async function upsertUser(user: InsertUser): Promise<void> {
  if (!user.openId) throw new Error("User openId is required for upsert");
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot upsert user: database not available");
    return;
  }
  try {
    const values: InsertUser = { openId: user.openId };
    const updateSet: Record<string, unknown> = {};
    const textFields = ["name", "email", "loginMethod"] as const;
    type TextField = (typeof textFields)[number];
    const assignNullable = (field: TextField) => {
      const value = user[field];
      if (value === undefined) return;
      const normalized = value ?? null;
      values[field] = normalized;
      updateSet[field] = normalized;
    };
    textFields.forEach(assignNullable);
    if (user.lastSignedIn !== undefined) {
      values.lastSignedIn = user.lastSignedIn;
      updateSet.lastSignedIn = user.lastSignedIn;
    }
    if (user.role !== undefined) {
      values.role = user.role;
      updateSet.role = user.role;
    } else if (user.openId === ENV.ownerOpenId) {
      values.role = "admin";
      updateSet.role = "admin";
    }
    if (!values.lastSignedIn) values.lastSignedIn = new Date();
    if (Object.keys(updateSet).length === 0) updateSet.lastSignedIn = new Date();
    await db.insert(users).values(values).onDuplicateKeyUpdate({ set: updateSet });
  } catch (error) {
    console.error("[Database] Failed to upsert user:", error);
    throw error;
  }
}

export async function getUserByOpenId(openId: string) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user: database not available");
    return undefined;
  }
  const result = await db
    .select()
    .from(users)
    .where(eq(users.openId, openId))
    .limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function getUserByEmail(email: string) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user by email: database not available");
    return undefined;
  }
  const result = await db
    .select()
    .from(users)
    .where(eq(users.email, email))
    .limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function getUserById(id: number) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user by id: database not available");
    return undefined;
  }
  const result = await db
    .select()
    .from(users)
    .where(eq(users.id, id))
    .limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function seedAdminUser() {
  const email = process.env.ADMIN_EMAIL;
  const password = process.env.ADMIN_PASSWORD;
  if (!email || !password) {
    console.warn("[Seed] ADMIN_EMAIL or ADMIN_PASSWORD not configured. Skipping seeding.");
    return;
  }

  const db = await getDb();
  if (!db) return;

  try {
    const user = await getUserByEmail(email);
    const pwdHash = hashPassword(password);

    if (!user) {
      console.log(`[Seed] Creating admin user: ${email}`);
      await db.insert(users).values({
        openId: `local-${email}`,
        name: "Administrador",
        email,
        passwordHash: pwdHash,
        role: "admin",
        loginMethod: "local",
        lastSignedIn: new Date()
      });
    } else {
      console.log(`[Seed] Updating admin password for: ${email}`);
      await db.update(users).set({
        passwordHash: pwdHash,
        role: "admin"
      }).where(eq(users.id, user.id));
    }
  } catch (error) {
    console.error("[Seed] Failed to seed admin user:", error);
  }
}

// ─── Clients ─────────────────────────────────────────────────────────────────

export async function listClients() {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(clients).orderBy(desc(clients.createdAt));
}

export async function listClientsAlpha() {
  const db = await getDb();
  if (!db) return [];
  const allClients = await db
    .select()
    .from(clients)
    .orderBy(asc(clients.name));

  const allInstallments = await db.select().from(installments);

  return allClients.map((client) => {
    const clientInstallments = allInstallments.filter(
      (i) => i.clientId === client.id
    );
    const paidCount = clientInstallments.filter((i) => i.status === "paid").length;
    const totalInstallments = clientInstallments.length;
    return { ...client, paidCount, totalInstallments };
  });
}

export async function getClientById(id: number) {
  const db = await getDb();
  if (!db) return undefined;
  const result = await db
    .select()
    .from(clients)
    .where(eq(clients.id, id))
    .limit(1);
  return result[0];
}

export async function createClient(data: InsertClient) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(clients).values(data);
  return result[0];
}

export async function createClientAndGetId(data: InsertClient): Promise<number> {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(clients).values(data);
  const insertId = (result[0] as any).insertId as number;
  if (!insertId) throw new Error("Não foi possível obter o ID do cliente inserido");
  return insertId;
}

export async function updateClient(
  id: number,
  data: Partial<InsertClient>
) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  await db.update(clients).set(data).where(eq(clients.id, id));
}

export async function deleteClient(id: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  await db.delete(installments).where(eq(installments.clientId, id));
  await db.delete(clients).where(eq(clients.id, id));
}

export async function markClientSettled(id: number, settledAt: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  await db
    .update(clients)
    .set({ settledAt })
    .where(eq(clients.id, id));
}

export async function markClientUnsettled(id: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  await db
    .update(clients)
    .set({ settledAt: null })
    .where(eq(clients.id, id));
}

// ─── Installments ─────────────────────────────────────────────────────────────

export async function createInstallments(data: InsertInstallment[]) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  if (data.length === 0) return;
  await db.insert(installments).values(data);
}

export async function getInstallmentsByClientId(clientId: number) {
  const db = await getDb();
  if (!db) return [];
  return db
    .select()
    .from(installments)
    .where(eq(installments.clientId, clientId))
    .orderBy(asc(installments.number));
}

export async function deleteInstallmentsByClientId(clientId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  await db.delete(installments).where(eq(installments.clientId, clientId));
}

export async function markInstallmentPaid(id: number, paidAt: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  await db
    .update(installments)
    .set({ paidAt, status: "paid", updatedAt: new Date() })
    .where(eq(installments.id, id));
}

export async function markInstallmentUnpaid(id: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const now = Date.now();
  const result = await db
    .select()
    .from(installments)
    .where(eq(installments.id, id))
    .limit(1);
  if (!result[0]) return;
  const status = result[0].dueDate < now ? "overdue" : "pending";
  await db
    .update(installments)
    .set({ paidAt: null, status, updatedAt: new Date() })
    .where(eq(installments.id, id));
}

export async function updateInstallmentDueDate(id: number, dueDate: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const now = Date.now();
  const result = await db
    .select()
    .from(installments)
    .where(eq(installments.id, id))
    .limit(1);
  if (!result[0]) return;
  if (result[0].status === "paid") {
    await db
      .update(installments)
      .set({ dueDate, updatedAt: new Date() })
      .where(eq(installments.id, id));
  } else {
    const status = dueDate < now ? "overdue" : "pending";
    await db
      .update(installments)
      .set({ dueDate, status, updatedAt: new Date() })
      .where(eq(installments.id, id));
  }
}

export async function updateInstallmentValue(
  clientId: number,
  installmentValue: string
) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  await db
    .update(clients)
    .set({ installmentValue })
    .where(eq(clients.id, clientId));
}

export async function getAllInstallmentsWithClients() {
  const db = await getDb();
  if (!db) return [];
  const rows = await db
    .select({
      installmentId: installments.id,
      installmentNumber: installments.number,
      dueDate: installments.dueDate,
      paidAt: installments.paidAt,
      status: installments.status,
      clientId: clients.id,
      clientName: clients.name,
      installmentValue: clients.installmentValue,
      installmentCount: clients.installmentCount,
      totalFees: clients.totalFees,
    })
    .from(installments)
    .innerJoin(clients, eq(installments.clientId, clients.id))
    .orderBy(asc(clients.name), asc(installments.number));
  return rows;
}

export async function syncOverdueInstallments() {
  const db = await getDb();
  if (!db) return;
  const now = Date.now();
  const pending = await db
    .select()
    .from(installments)
    .where(eq(installments.status, "pending"));
  for (const inst of pending) {
    if (inst.dueDate < now) {
      await db
        .update(installments)
        .set({ status: "overdue", updatedAt: new Date() })
        .where(eq(installments.id, inst.id));
    }
  }
}
