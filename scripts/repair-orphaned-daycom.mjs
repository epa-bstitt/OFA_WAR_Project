import sqliteClientPackage from "../prisma/generated/sqlite-client/index.js";

const { PrismaClient } = sqliteClientPackage;
const prisma = new PrismaClient({
  datasources: { db: { url: "file:./dev-db.sqlite" } },
});

const orphanProjectId = "cmrjd4cam0000ixymq3f9h2a0";
const activeProjectId = "cmrjdfyb90005ixymfnzz87lj";

function comparisonKey(submission) {
  return JSON.stringify({
    weekOf: submission.weekOf,
    rawText: submission.rawText,
    terseText: submission.terseText,
    status: submission.status,
    userId: submission.userId,
  });
}

try {
  const [orphanRows, activeRows] = await Promise.all([
    prisma.submission.findMany({ where: { projectId: orphanProjectId } }),
    prisma.submission.findMany({ where: { projectId: activeProjectId } }),
  ]);

  if (orphanRows.length !== 10 || activeRows.length !== 10) {
    throw new Error(
      `Expected 10 orphan and 10 active Daycom rows; found ${orphanRows.length} and ${activeRows.length}.`,
    );
  }

  const activeKeys = new Set(activeRows.map(comparisonKey));
  const unmatched = orphanRows.filter((submission) => !activeKeys.has(comparisonKey(submission)));

  if (unmatched.length > 0) {
    throw new Error(`Refusing repair: ${unmatched.length} orphan rows are not exact duplicates.`);
  }

  const result = await prisma.submission.deleteMany({ where: { projectId: orphanProjectId } });
  console.log(`Deleted ${result.count} duplicate orphaned Daycom submissions.`);
} finally {
  await prisma.$disconnect();
}