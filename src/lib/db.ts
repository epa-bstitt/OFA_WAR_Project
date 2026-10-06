import { PrismaClient } from "@prisma/client";
import { PrismaClient as SqlitePrismaClient } from "../../prisma/generated/sqlite-client";

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined;
};

function createPrismaClient(): PrismaClient {
  if (process.env.DATABASE_URL?.startsWith("file:")) {
    return new SqlitePrismaClient({
      datasources: { db: { url: process.env.DATABASE_URL } },
    }) as unknown as PrismaClient;
  }

  return new PrismaClient();
}

export const prisma = globalForPrisma.prisma ?? createPrismaClient();

if (process.env.NODE_ENV !== "production") globalForPrisma.prisma = prisma;

// Connection health check
export async function checkDatabaseConnection(): Promise<boolean> {
  try {
    await prisma.$queryRaw`SELECT 1`;
    return true;
  } catch (error) {
    console.error("Database connection failed:", error);
    return false;
  }
}

// Graceful shutdown handler
export async function disconnectDatabase(): Promise<void> {
  await prisma.$disconnect();
}
