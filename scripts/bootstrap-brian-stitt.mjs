import bcrypt from "bcryptjs";
import { PrismaClient } from "@prisma/client";
import { getDatabaseUrlFromServices } from "./database-url.cjs";

const databaseUrl = process.env.DATABASE_URL ?? getDatabaseUrlFromServices();

if (!databaseUrl) {
  throw new Error("DATABASE_URL is not set and no PostgreSQL service binding was found.");
}

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: databaseUrl,
    },
  },
});

async function main() {
  const temporaryPassword = process.env.INITIAL_USER_PASSWORD;
  if (!temporaryPassword) {
    throw new Error("INITIAL_USER_PASSWORD must be set for the bootstrap command.");
  }

  const email = "stitt.brian@epa.gov";
  const name = "Brian Stitt";
  const passwordHash = await bcrypt.hash(temporaryPassword, 12);

  const user = await prisma.user.upsert({
    where: { email },
    create: {
      email,
      name,
      role: "CONTRIBUTOR",
      isActive: true,
      passwordHash,
      mustChangePassword: true,
      passwordChangedAt: null,
      sessionVersion: 0,
    },
    update: {
      name,
      role: "CONTRIBUTOR",
      isActive: true,
      passwordHash,
      mustChangePassword: true,
      passwordChangedAt: null,
      sessionVersion: { increment: 1 },
    },
    select: {
      id: true,
      email: true,
      name: true,
      role: true,
      isActive: true,
      mustChangePassword: true,
      passwordChangedAt: true,
    },
  });

  console.log(JSON.stringify({ user }, null, 2));
}

main()
  .catch((error) => {
    console.error(error instanceof Error ? error.message : error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });