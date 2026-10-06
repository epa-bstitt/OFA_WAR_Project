import bcrypt from "bcryptjs";
import { PrismaClient as PostgresPrismaClient } from "@prisma/client";
import { PrismaClient as SqlitePrismaClient } from "../prisma/generated/sqlite-client/index.js";

const PrismaClient = process.env.DATABASE_URL?.startsWith("file:")
  ? SqlitePrismaClient
  : PostgresPrismaClient;
const prisma = new PrismaClient();
const shouldApply = process.argv.includes("--apply");
const supportedRoles = new Set([
  "CONTRIBUTOR",
  "AGGREGATOR",
  "PROGRAM_OVERSEER",
  "ADMINISTRATOR",
]);

async function main() {
  const temporaryPassword = process.env.INITIAL_USER_PASSWORD;
  if (!temporaryPassword) {
    throw new Error("INITIAL_USER_PASSWORD must be set for the bootstrap command.");
  }

  const users = await prisma.user.findMany({
    where: {
      isActive: true,
      passwordHash: null,
    },
    select: {
      id: true,
      role: true,
    },
    orderBy: { id: "asc" },
  });

  const invalidUsers = users.filter((user) => !supportedRoles.has(user.role));
  if (invalidUsers.length > 0) {
    console.error("Bootstrap blocked: unsupported roles found for user IDs:");
    for (const user of invalidUsers) {
      console.error(`- ${user.id}: ${user.role}`);
    }
    process.exitCode = 1;
    return;
  }

  const roleTotals = users.reduce((totals, user) => {
    totals[user.role] = (totals[user.role] ?? 0) + 1;
    return totals;
  }, {});

  console.log(shouldApply ? "Bootstrap apply" : "Bootstrap dry run");
  console.log(`Eligible active users: ${users.length}`);
  for (const role of supportedRoles) {
    console.log(`${role}: ${roleTotals[role] ?? 0}`);
  }

  if (!shouldApply || users.length === 0) {
    console.log(shouldApply ? "No users required changes." : "No database changes made. Re-run with --apply to proceed.");
    return;
  }

  for (const user of users) {
    const passwordHash = await bcrypt.hash(temporaryPassword, 12);
    await prisma.user.update({
      where: { id: user.id },
      data: {
        passwordHash,
        mustChangePassword: true,
        passwordChangedAt: null,
        sessionVersion: { increment: 1 },
      },
    });
  }

  console.log(`Bootstrapped users: ${users.length}`);
}

main()
  .catch((error) => {
    console.error(error instanceof Error ? error.message : "Bootstrap failed.");
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });