import { PrismaClient } from "@prisma/client";
import { PrismaClient as SqlitePrismaClient } from "../../prisma/generated/sqlite-client";
import { resolveDatabaseRuntime } from "./database-runtime";

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined;
};

function createPrismaClient(): PrismaClient {
  const configuration = resolveDatabaseRuntime(process.env);
  if (configuration.provider === "sqlite") {
    return new SqlitePrismaClient({
      datasources: { db: { url: configuration.url } },
    }) as unknown as PrismaClient;
  }

  return new PrismaClient({ datasources: { db: { url: configuration.url } } });
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
