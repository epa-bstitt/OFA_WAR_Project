import { createHash } from "node:crypto";
import { existsSync, readFileSync } from "node:fs";
import path from "node:path";
import postgresClientPackage from "@prisma/client";
import sqliteClientPackage from "../prisma/generated/sqlite-client/index.js";

const { PrismaClient: PostgresPrismaClient } = postgresClientPackage;
const { PrismaClient: SqlitePrismaClient } = sqliteClientPackage;

const sourcePath = path.resolve(process.env.SQLITE_DATABASE_PATH ?? "prisma/dev-db.sqlite");
const sourceUrl = process.env.SQLITE_DATABASE_URL ?? `file:${sourcePath.replaceAll("\\", "/")}`;
const targetUrl = process.env.TARGET_DATABASE_URL ?? process.env.DATABASE_URL;
const verifyOnly = process.argv.includes("--verify-only");
const inventoryOnly = process.argv.includes("--inventory-only");

if (!existsSync(sourcePath)) {
  throw new Error(`SQLite source not found: ${sourcePath}`);
}

if (!inventoryOnly && (!targetUrl || targetUrl.startsWith("file:"))) {
  throw new Error("Set TARGET_DATABASE_URL to the destination PostgreSQL connection string.");
}

const sqlite = new SqlitePrismaClient({ datasources: { db: { url: sourceUrl } } });
const postgres = inventoryOnly
  ? null
  : new PostgresPrismaClient({ datasources: { db: { url: targetUrl } } });

const modelOrder = [
  "user",
  "project",
  "projectComponent",
  "contract",
  "promptTemplate",
  "conversationState",
  "importJob",
  "importJobFileResult",
  "projectAssignment",
  "submission",
  "review",
  "workflowState",
  "auditLog",
  "notification",
];

function hashRows(rows) {
  return createHash("sha256").update(JSON.stringify(rows)).digest("hex");
}

async function loadRows(client, model) {
  return client[model].findMany({ orderBy: { id: "asc" } });
}

async function verifyMigration(sourceRows) {
  const failures = [];

  for (const model of modelOrder) {
    const targetRows = await loadRows(postgres, model);
    const sourceHash = hashRows(sourceRows[model]);
    const targetHash = hashRows(targetRows);
    const matches = sourceRows[model].length === targetRows.length && sourceHash === targetHash;

    console.log(
      `${matches ? "PASS" : "FAIL"} ${model}: source=${sourceRows[model].length} target=${targetRows.length}`,
    );

    if (!matches) failures.push(model);
  }

  if (failures.length > 0) {
    throw new Error(`Migration verification failed for: ${failures.join(", ")}`);
  }
}

function validateSourceRelations(rows) {
  const ids = Object.fromEntries(
    modelOrder.map((model) => [model, new Set(rows[model].map((record) => record.id))]),
  );
  const failures = [];
  const check = (model, field, targetModel, required = false) => {
    for (const record of rows[model]) {
      const value = record[field];
      if ((value === null || value === undefined) && !required) continue;
      if (!ids[targetModel].has(value)) failures.push(`${model}.${field}:${record.id}->${value}`);
    }
  };

  check("importJob", "initiatedById", "user");
  check("importJobFileResult", "jobId", "importJob", true);
  check("contract", "assigneeId", "user");
  check("projectComponent", "projectId", "project", true);
  check("projectAssignment", "userId", "user", true);
  check("projectAssignment", "projectId", "project", true);
  check("projectAssignment", "componentId", "projectComponent");
  check("submission", "userId", "user", true);
  check("submission", "projectId", "project");
  check("submission", "componentId", "projectComponent");
  check("submission", "contractId", "contract");
  check("review", "submissionId", "submission", true);
  check("review", "reviewerId", "user", true);
  check("workflowState", "submissionId", "submission", true);
  check("auditLog", "userId", "user");
  check("notification", "userId", "user", true);

  if (failures.length > 0) {
    throw new Error(`Source relation validation failed: ${failures.join(", ")}`);
  }
}

try {
  const sqliteChecksum = createHash("sha256").update(readFileSync(sourcePath)).digest("hex");
  console.log(`SQLite source: ${sourcePath}`);
  console.log(`SQLite SHA-256: ${sqliteChecksum}`);

  const sourceRows = Object.fromEntries(
    await Promise.all(
      modelOrder.map(async (model) => [model, await loadRows(sqlite, model)]),
    ),
  );
  validateSourceRelations(sourceRows);

  for (const model of modelOrder) {
    console.log(`SOURCE ${model}: ${sourceRows[model].length}`);
  }

  if (!inventoryOnly && !verifyOnly) {
    const targetCounts = await Promise.all(modelOrder.map((model) => postgres[model].count()));
    const nonEmptyModels = modelOrder.filter((_, index) => targetCounts[index] > 0);

    if (nonEmptyModels.length > 0) {
      throw new Error(
        `Destination is not empty (${nonEmptyModels.join(", ")}). Use a fresh database or --verify-only.`,
      );
    }

    await postgres.$transaction(
      async (transaction) => {
        for (const model of modelOrder) {
          const rows = sourceRows[model];
          if (rows.length > 0) {
            await transaction[model].createMany({ data: rows });
          }
        }
      },
      { maxWait: 30_000, timeout: 120_000 },
    );
  }

  if (inventoryOnly) {
    console.log("SQLite inventory and relation validation complete.");
  } else {
    await verifyMigration(sourceRows);
    console.log(verifyOnly ? "PostgreSQL verification complete." : "SQLite to PostgreSQL migration complete.");
  }
} finally {
  await Promise.allSettled([sqlite.$disconnect(), postgres?.$disconnect()]);
}