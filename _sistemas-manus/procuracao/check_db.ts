import "dotenv/config";
import { getDb } from "./server/db";
import { users } from "./drizzle/schema";

async function main() {
  const db = await getDb();
  if (!db) {
    console.error("Database connection failed");
    return;
  }
  
  const { seedAdminUser } = await import("./server/db");
  await seedAdminUser();

  const allUsers = await db.select().from(users);
  console.log("Users in Database:", allUsers);
  process.exit(0);
}

main().catch(console.error);
