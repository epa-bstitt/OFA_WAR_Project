"use server";

import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";

export interface DatabaseConnectionResult {
  success: boolean;
  message: string;
  details?: {
    version?: string;
    database?: string;
    schemas?: string[];
    tableCount?: number;
    vectorExtension?: boolean;
  };
  error?: string;
}

/**
 * Test database connection and return status information
 */
export async function testDatabaseConnection(): Promise<DatabaseConnectionResult> {
  try {
    // Check authentication - only admins can test DB connection
    const session = await auth();
    if (!session?.user?.id) {
      return {
        success: false,
        message: "Authentication required",
        error: "Not authenticated",
      };
    }

    const allowedRoles = ["ADMINISTRATOR", "PROGRAM_OVERSEER"];
    if (!allowedRoles.includes(session.user.role as string)) {
      return {
        success: false,
        message: "Insufficient permissions",
        error: "Admin access required",
      };
    }

    // Test connection by querying database version
    const versionResult = await prisma.$queryRaw<{ version: string }[]>`
      SELECT version()
    `;

    // Check if pgvector extension is installed
    const vectorResult = await prisma.$queryRaw<{ installed: boolean }[]>`
      SELECT EXISTS (
        SELECT 1 FROM pg_extension WHERE extname = 'vector'
      ) as installed
    `;

    // Get list of tables
    const tablesResult = await prisma.$queryRaw<{ table_name: string }[]>`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
      AND table_type = 'BASE TABLE'
      ORDER BY table_name
    `;

    // Get current database name
    const dbResult = await prisma.$queryRaw<{ current_database: string }[]>`
      SELECT current_database()
    `;

    return {
      success: true,
      message: "Database connection successful",
      details: {
        version: versionResult[0]?.version,
        database: dbResult[0]?.current_database,
        schemas: ["public"],
        tableCount: tablesResult.length,
        vectorExtension: vectorResult[0]?.installed,
      },
    };
  } catch (error) {
    console.error("Database connection test failed:", error);
    
    let errorMessage = "Failed to connect to database";
    if (error instanceof Error) {
      errorMessage = error.message;
    }

    return {
      success: false,
      message: "Database connection failed",
      error: errorMessage,
    };
  }
}

/**
 * Get database migration status
 */
export async function getMigrationStatus(): Promise<{
  success: boolean;
  migrations?: {
    pending: number;
    applied: number;
    lastApplied?: Date;
  };
  error?: string;
}> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Query Prisma migrations table
    const migrations = await prisma.$queryRaw<{ 
      migration_name: string; 
      finished_at: Date | null;
      applied_steps_count: number;
    }[]>`
      SELECT migration_name, finished_at, applied_steps_count
      FROM _prisma_migrations
      ORDER BY finished_at DESC
    `;

    const applied = migrations.filter((m: typeof migrations[0]) => m.finished_at !== null).length;
    const pending = migrations.filter((m: typeof migrations[0]) => m.finished_at === null).length;
    const lastApplied = migrations.find((m: typeof migrations[0]) => m.finished_at !== null)?.finished_at;

    return {
      success: true,
      migrations: {
        applied,
        pending,
        lastApplied,
      },
    };
  } catch (error) {
    console.error("Error fetching migration status:", error);
    return {
      success: false,
      error: "Failed to fetch migration status",
    };
  }
}
