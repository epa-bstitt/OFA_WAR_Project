import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();
const RUN_TAG = `e2e-smoke-${Date.now()}`;

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
      id: `${year}-${String(monthIndex + 1).padStart(2, "0")}-P1`,
      start: firstPeriodStart,
      end: new Date(firstTuesdayDeadline),
      deadline: new Date(firstTuesdayDeadline),
    });

    const secondPeriodStart = new Date(firstTuesdayDeadline.getTime() + 1);
    periods.push({
      id: `${year}-${String(monthIndex + 1).padStart(2, "0")}-P2`,
      start: secondPeriodStart,
      end: new Date(thirdTuesdayDeadline),
      deadline: new Date(thirdTuesdayDeadline),
    });

    previousDeadline = thirdTuesdayDeadline;
  }

  return periods;
}

function getCurrentSubmissionPeriod(now = new Date()) {
  const windowStart = new Date(now);
  windowStart.setDate(1);
  windowStart.setMonth(windowStart.getMonth() - 2);

  const periods = buildPeriodsForWindow(windowStart, 6);
  const current = periods.find((period) => now >= period.start && now <= period.end);
  if (current) {
    return current;
  }

  const next = periods.find((period) => now < period.start);
  return next ?? periods[periods.length - 1];
}

async function countByState(period) {
  const [submitted, inReview, approved] = await Promise.all([
    prisma.submission.count({
      where: {
        deletedAt: null,
        status: "SUBMITTED",
        weekOf: { gte: period.start, lte: period.end },
      },
    }),
    prisma.submission.count({
      where: {
        deletedAt: null,
        status: "IN_REVIEW",
        weekOf: { gte: period.start, lte: period.end },
      },
    }),
    prisma.submission.count({
      where: {
        deletedAt: null,
        status: "APPROVED",
        weekOf: { gte: period.start, lte: period.end },
      },
    }),
  ]);

  return { submitted, inReview, approved };
}

async function main() {
  const now = new Date();
  const period = getCurrentSubmissionPeriod(now);

  const contributor =
    (await prisma.user.findUnique({
      where: { id: "demo-contributor" },
      select: { id: true, email: true, name: true },
    })) ||
    (await prisma.user.findFirst({
      where: { role: "CONTRIBUTOR", isActive: true },
      orderBy: { createdAt: "asc" },
      select: { id: true, email: true, name: true },
    }));

  const overseer =
    (await prisma.user.findUnique({
      where: { id: "demo-overseer" },
      select: { id: true, email: true, name: true },
    })) ||
    (await prisma.user.findFirst({
      where: { role: "PROGRAM_OVERSEER", isActive: true },
      orderBy: { createdAt: "asc" },
      select: { id: true, email: true, name: true },
    }));

  if (!contributor) {
    throw new Error("No active contributor found for smoke test.");
  }

  if (!overseer) {
    throw new Error("No active Program Overseer found for smoke test.");
  }

  const before = await countByState(period);

  let createdSubmissionId = null;
  let createdReviewId = null;
  const createdAuditIds = [];

  try {
    const submission = await prisma.submission.create({
      data: {
        userId: contributor.id,
        weekOf: now,
        rawText: `[${RUN_TAG}] smoke test submission`,
        status: "SUBMITTED",
        isAiGenerated: false,
      },
      select: { id: true, status: true, createdAt: true },
    });
    createdSubmissionId = submission.id;

    const createAudit = await prisma.auditLog.create({
      data: {
        action: "SUBMISSION_CREATED",
        userId: contributor.id,
        resourceType: "submission",
        resourceId: submission.id,
        metadata: JSON.stringify({ runTag: RUN_TAG, step: "create" }),
      },
      select: { id: true },
    });
    createdAuditIds.push(createAudit.id);

    const afterCreate = await countByState(period);

    await prisma.submission.update({
      where: { id: submission.id },
      data: { status: "APPROVED", updatedAt: new Date() },
    });

    const review = await prisma.review.create({
      data: {
        submissionId: submission.id,
        reviewerId: overseer.id,
        status: "APPROVED",
        comment: `[${RUN_TAG}] smoke test approval`,
      },
      select: { id: true },
    });
    createdReviewId = review.id;

    const approveAudit = await prisma.auditLog.create({
      data: {
        action: "SUBMISSION_APPROVED",
        userId: overseer.id,
        resourceType: "submission",
        resourceId: submission.id,
        metadata: JSON.stringify({ runTag: RUN_TAG, step: "approve" }),
      },
      select: { id: true },
    });
    createdAuditIds.push(approveAudit.id);

    const afterApprove = await countByState(period);

    console.log(
      JSON.stringify(
        {
          runTag: RUN_TAG,
          period,
          users: { contributor, overseer },
          before,
          afterCreate,
          afterApprove,
          createdSubmissionId: submission.id,
          checks: {
            pendingIncreasedOnSubmit: afterCreate.submitted === before.submitted + 1,
            pendingClearedOnApprove: afterApprove.submitted === before.submitted,
            approvedIncreasedOnApprove: afterApprove.approved === before.approved + 1,
          },
        },
        null,
        2
      )
    );
  } finally {
    if (createdReviewId) {
      await prisma.review.deleteMany({ where: { id: createdReviewId } });
    }

    if (createdAuditIds.length > 0) {
      await prisma.auditLog.deleteMany({ where: { id: { in: createdAuditIds } } });
    }

    if (createdSubmissionId) {
      await prisma.workflowState.deleteMany({ where: { submissionId: createdSubmissionId } });
      await prisma.submission.deleteMany({ where: { id: createdSubmissionId } });
    }
  }

  const afterCleanup = await countByState(period);

  console.log(
    JSON.stringify(
      {
        runTag: RUN_TAG,
        afterCleanup,
        restoredToBaseline:
          afterCleanup.submitted === before.submitted &&
          afterCleanup.inReview === before.inReview &&
          afterCleanup.approved === before.approved,
      },
      null,
      2
    )
  );
}

main()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
