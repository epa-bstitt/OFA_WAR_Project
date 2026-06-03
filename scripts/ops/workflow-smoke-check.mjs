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
  const now = new Date();
  const period = getCurrentSubmissionPeriod(now);

  const submissions = await prisma.submission.findMany({
    where: {
      deletedAt: null,
      weekOf: {
        gte: period.start,
        lte: period.end,
      },
    },
    orderBy: { updatedAt: "desc" },
    select: {
      id: true,
      status: true,
      weekOf: true,
      userId: true,
      updatedAt: true,
      reviews: {
        orderBy: { createdAt: "desc" },
        take: 1,
        select: {
          status: true,
          reviewerId: true,
          createdAt: true,
        },
      },
    },
  });

  const statusSummary = submissions.reduce((acc, item) => {
    acc[item.status] = (acc[item.status] ?? 0) + 1;
    return acc;
  }, {});

  const recentAudit = await prisma.auditLog.findMany({
    where: {
      action: {
        in: [
          "SUBMISSION_CREATED",
          "SUBMISSION_APPROVED",
          "SUBMISSION_REJECTED",
          "SUBMISSION_REJECTED_BY_OVERSEER",
        ],
      },
      createdAt: {
        gte: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000),
      },
    },
    orderBy: { createdAt: "desc" },
    take: 12,
    select: {
      action: true,
      userId: true,
      resourceId: true,
      createdAt: true,
    },
  });

  console.log(
    JSON.stringify(
      {
        now: now.toISOString(),
        period,
        submissionCountInPeriod: submissions.length,
        statusSummary,
        submissions,
        recentAudit,
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
