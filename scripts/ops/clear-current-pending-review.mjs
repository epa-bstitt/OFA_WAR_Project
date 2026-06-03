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

async function main() {
  const apply = process.argv.includes("--apply");
  const now = new Date();
  const period = getCurrentSubmissionPeriod(now);

  const pendingInReview = await prisma.submission.findMany({
    where: {
      status: "IN_REVIEW",
      deletedAt: null,
      weekOf: {
        gte: period.start,
        lte: period.end,
      },
    },
    orderBy: { updatedAt: "desc" },
    select: {
      id: true,
      userId: true,
      weekOf: true,
      status: true,
      updatedAt: true,
      user: {
        select: {
          id: true,
          name: true,
          email: true,
        },
      },
      reviews: {
        orderBy: { createdAt: "desc" },
        take: 1,
        select: {
          id: true,
          status: true,
          reviewerId: true,
          createdAt: true,
        },
      },
    },
  });

  const pendingSubmitted = await prisma.submission.findMany({
    where: {
      status: "SUBMITTED",
      deletedAt: null,
      weekOf: {
        gte: period.start,
        lte: period.end,
      },
    },
    orderBy: { updatedAt: "desc" },
    select: {
      id: true,
      userId: true,
      weekOf: true,
      status: true,
      updatedAt: true,
      user: {
        select: {
          id: true,
          name: true,
          email: true,
        },
      },
      reviews: {
        orderBy: { createdAt: "desc" },
        take: 1,
        select: {
          id: true,
          status: true,
          reviewerId: true,
          createdAt: true,
        },
      },
    },
  });

  const overseer = await prisma.user.findFirst({
    where: {
      role: "PROGRAM_OVERSEER",
      isActive: true,
    },
    orderBy: { createdAt: "asc" },
    select: {
      id: true,
      name: true,
      email: true,
    },
  });

  console.log(
    JSON.stringify(
      {
        now: now.toISOString(),
        period,
        pendingInReviewCount: pendingInReview.length,
        pendingInReview,
        pendingSubmittedCount: pendingSubmitted.length,
        pendingSubmitted,
        overseer,
        mode: apply ? "apply" : "dry-run",
      },
      null,
      2
    )
  );

  if (!apply) {
    return;
  }

  const target = pendingSubmitted[0] ?? pendingInReview[0];

  if (!target) {
    console.log("No pending SUBMITTED or IN_REVIEW submissions found for the current period. Nothing to clear.");
    return;
  }

  if (!overseer) {
    throw new Error("No active PROGRAM_OVERSEER user found.");
  }

  await prisma.$transaction(async (tx) => {
    await tx.submission.update({
      where: { id: target.id },
      data: {
        status: "APPROVED",
        updatedAt: new Date(),
      },
    });

    await tx.review.create({
      data: {
        submissionId: target.id,
        reviewerId: overseer.id,
        status: "APPROVED",
        comment: "Cleared pending review by Program Overseer for current bi-weekly period.",
      },
    });

    await tx.auditLog.create({
      data: {
        action: "SUBMISSION_APPROVED",
        userId: overseer.id,
        resourceType: "submission",
        resourceId: target.id,
        metadata: JSON.stringify({
          source: "ops-script",
          reason: "Clear pending review for current bi-weekly submission",
          periodId: period.id,
          approvedAt: new Date().toISOString(),
        }),
      },
    });
  });

  const remaining = await prisma.submission.count({
    where: {
      status: { in: ["SUBMITTED", "IN_REVIEW"] },
      deletedAt: null,
      weekOf: {
        gte: period.start,
        lte: period.end,
      },
    },
  });

  console.log(
    JSON.stringify(
      {
        updatedSubmissionId: target.id,
        previousStatus: target.status,
        updatedToStatus: "APPROVED",
        remainingPendingSubmittedOrInReviewInCurrentPeriod: remaining,
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
