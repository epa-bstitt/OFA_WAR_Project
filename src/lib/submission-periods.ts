interface SubmissionPeriod {
  id: string;
  label: string;
  start: Date;
  end: Date;
  deadline: Date;
}

function getNthWeekdayOfMonth(year: number, monthIndex: number, weekday: number, nth: number): Date {
  const firstOfMonth = new Date(year, monthIndex, 1, 0, 0, 0, 0);
  const firstWeekdayOffset = (7 + weekday - firstOfMonth.getDay()) % 7;
  const dayOfMonth = 1 + firstWeekdayOffset + (nth - 1) * 7;
  return new Date(year, monthIndex, dayOfMonth, 17, 0, 0, 0);
}

function getMonthDeadlines(year: number, monthIndex: number): Date[] {
  const firstTuesday = getNthWeekdayOfMonth(year, monthIndex, 2, 1);
  const thirdTuesday = getNthWeekdayOfMonth(year, monthIndex, 2, 3);
  return [firstTuesday, thirdTuesday];
}

function getPeriodId(year: number, monthIndex: number, slot: 1 | 2): string {
  const month = String(monthIndex + 1).padStart(2, "0");
  return `${year}-${month}-P${slot}`;
}

function getPeriodLabel(year: number, monthIndex: number, slot: 1 | 2): string {
  const monthLabel = new Date(year, monthIndex, 1).toLocaleDateString("en-US", {
    month: "short",
    year: "numeric",
  });
  const slotLabel = slot === 1 ? "1st Tuesday" : "3rd Tuesday";
  return `${monthLabel} (${slotLabel} Deadline)`;
}

function buildPeriodsForWindow(startMonth: Date, monthsToGenerate: number): SubmissionPeriod[] {
  const periods: SubmissionPeriod[] = [];
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
      label: getPeriodLabel(year, monthIndex, 1),
      start: firstPeriodStart,
      end: new Date(firstTuesdayDeadline),
      deadline: new Date(firstTuesdayDeadline),
    });

    const secondPeriodStart = new Date(firstTuesdayDeadline.getTime() + 1);
    periods.push({
      id: getPeriodId(year, monthIndex, 2),
      label: getPeriodLabel(year, monthIndex, 2),
      start: secondPeriodStart,
      end: new Date(thirdTuesdayDeadline),
      deadline: new Date(thirdTuesdayDeadline),
    });

    previousDeadline = thirdTuesdayDeadline;
  }

  return periods;
}

export function isFirstOrThirdTuesday(date: Date): boolean {
  if (date.getDay() !== 2) {
    return false;
  }

  const day = date.getDate();
  return (day >= 1 && day <= 7) || (day >= 15 && day <= 21);
}

export function isSubmissionWindowOpen(now: Date = new Date()): boolean {
  if (!isFirstOrThirdTuesday(now)) {
    return false;
  }

  const hours = now.getHours();
  const minutes = now.getMinutes();
  const seconds = now.getSeconds();

  if (hours < 8 || hours > 17) {
    return false;
  }

  if (hours === 17 && (minutes > 0 || seconds > 0)) {
    return false;
  }

  return true;
}

export function getCurrentSubmissionPeriod(now: Date = new Date()): SubmissionPeriod {
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

export function getRecentSubmissionPeriods(now: Date = new Date(), count: number = 8): SubmissionPeriod[] {
  const current = getCurrentSubmissionPeriod(now);
  const [year, monthString] = current.id.split("-");
  const monthIndex = Number(monthString) - 1;

  const windowStart = new Date(Number(year), monthIndex, 1);
  windowStart.setMonth(windowStart.getMonth() - 5);

  const periods = buildPeriodsForWindow(windowStart, 12);
  const currentIndex = periods.findIndex((period) => period.id === current.id);
  const startIndex = Math.max(0, currentIndex - (count - 1));

  return periods.slice(startIndex, currentIndex + 1).reverse();
}

export type { SubmissionPeriod };
