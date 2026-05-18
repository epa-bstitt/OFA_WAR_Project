#!/usr/bin/env node
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

function getNthWeekdayOfMonth(year, monthIndex, weekday, nth) {
  const firstOfMonth = new Date(year, monthIndex, 1, 0, 0, 0, 0);
  const firstWeekdayOffset = (7 + weekday - firstOfMonth.getDay()) % 7;
  const dayOfMonth = 1 + firstWeekdayOffset + (nth - 1) * 7;
  return new Date(year, monthIndex, dayOfMonth, 17, 0, 0, 0);
}

function getMonthDeadlines(year, monthIndex) {
  const firstTuesday = getNthWeekdayOfMonth(year, monthIndex, 2, 1);
  const thirdTuesday = getNthWeekdayOfMonth(year, monthIndex, 2, 3);
  return [firstTuesday, thirdTuesday];
}

function getPeriodId(year, monthIndex, slot) {
  const month = String(monthIndex + 1).padStart(2, "0");
  return `${year}-${month}-P${slot}`;
}

function buildPeriodsForWindow(startMonth, monthsToGenerate) {
  const periods = [];
  let previousDeadline = new Date(startMonth);
  previousDeadline.setDate(1);
  previousDeadline.setMonth(previousDeadline.getMonth() - 1);
  previousDeadline = getMonthDeadlines(previousDeadline.getFullYear(), previousDeadline.getMonth())[1];

  for (let i = 0; i < monthsToGenerate; i += 1) {
    const cursor = new Date(startMonth);
    cursor.setDate(1);
    cursor.setMonth(startMonth.getMonth() + i);

    const year = cursor.getFullYear();
    const monthIndex = cursor.getMonth();
    const [firstTuesdayDeadline, thirdTuesdayDeadline] = getMonthDeadlines(year, monthIndex);

    const firstPeriodStart = new Date(previousDeadline.getTime() + 1);
    periods.push({
      id: getPeriodId(year, monthIndex, 1),
      start: firstPeriodStart,
      end: new Date(firstTuesdayDeadline),
    });

    const secondPeriodStart = new Date(firstTuesdayDeadline.getTime() + 1);
    periods.push({
      id: getPeriodId(year, monthIndex, 2),
      start: secondPeriodStart,
      end: new Date(thirdTuesdayDeadline),
    });

    previousDeadline = thirdTuesdayDeadline;
  }

  return periods;
}

function getSubmissionPeriodId(date) {
  const windowStart = new Date(date);
  windowStart.setDate(1);
  windowStart.setMonth(windowStart.getMonth() - 2);

  const periods = buildPeriodsForWindow(windowStart, 6);
  const current = periods.find((period) => date >= period.start && date <= period.end);

  if (current) {
    return current.id;
  }

  const next = periods.find((period) => date < period.start);
  return (next ?? periods[periods.length - 1]).id;
}

function sortByLatest(a, b) {
  const aTime = new Date(a.updatedAt ?? a.createdAt).getTime();
  const bTime = new Date(b.updatedAt ?? b.createdAt).getTime();
  return bTime - aTime;
}

async function main() {
  const dryRun = process.argv.includes("--dry-run");

  const submissions = await prisma.submission.findMany({
    where: { deletedAt: null },
    select: {
      id: true,
      userId: true,
      projectId: true,
      contractId: true,
      componentId: true,
      weekOf: true,
      createdAt: true,
      updatedAt: true,
    },
    orderBy: { createdAt: "desc" },
  });

  const groups = new Map();

  for (const submission of submissions) {
    const periodId = getSubmissionPeriodId(new Date(submission.weekOf));
    const contractKey = submission.projectId || submission.contractId || submission.componentId || "unscoped";
    const key = `${submission.userId}|${contractKey}|${periodId}`;
    const bucket = groups.get(key) || [];
    bucket.push(submission);
    groups.set(key, bucket);
  }

  const toSoftDelete = [];

  for (const bucket of groups.values()) {
    if (bucket.length <= 1) {
      continue;
    }

    bucket.sort(sortByLatest);
    const duplicates = bucket.slice(1);
    for (const duplicate of duplicates) {
      toSoftDelete.push(duplicate.id);
    }
  }

  console.log(`Scanned ${submissions.length} non-deleted submissions.`);
  console.log(`Detected ${toSoftDelete.length} duplicate submissions across ${groups.size} period buckets.`);

  if (toSoftDelete.length === 0) {
    console.log("No duplicate submissions found. Nothing to clean.");
    return;
  }

  if (dryRun) {
    console.log("Dry run enabled. No rows were modified.");
    return;
  }

  const now = new Date();
  const batchSize = 200;
  let updated = 0;

  for (let i = 0; i < toSoftDelete.length; i += batchSize) {
    const chunk = toSoftDelete.slice(i, i + batchSize);
    const result = await prisma.submission.updateMany({
      where: { id: { in: chunk }, deletedAt: null },
      data: { deletedAt: now },
    });
    updated += result.count;
  }

  console.log(`Soft-deleted ${updated} duplicate submissions.`);
}

main()
  .catch((error) => {
    console.error("Failed to dedupe submissions:", error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
