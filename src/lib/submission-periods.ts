interface SubmissionPeriod {
  id: string;
  label: string;
  start: Date;
  end: Date;
  deadline: Date;
}

const SUBMISSION_TIME_ZONE = "America/New_York";
const BIWEEK_DAYS = 14;
const DAY_MS = 24 * 60 * 60 * 1000;
const ANCHOR_YEAR = 2026;
const ANCHOR_MONTH_INDEX = 5; // June (0-indexed)
const ANCHOR_DAY = 30;

function getZonedParts(date: Date, timeZone: string) {
  const formatter = new Intl.DateTimeFormat("en-US", {
    timeZone,
    weekday: "short",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
    hour12: false,
  });

  const parts = formatter.formatToParts(date);

  const get = (type: string) => parts.find((part) => part.type === type)?.value || "";

  return {
    weekday: get("weekday"),
    year: Number(get("year")),
    month: Number(get("month")),
    day: Number(get("day")),
    hour: Number(get("hour")),
    minute: Number(get("minute")),
    second: Number(get("second")),
  };
}

function getTimeZoneOffsetMs(date: Date, timeZone: string): number {
  const zoned = getZonedParts(date, timeZone);
  const asUtc = Date.UTC(
    zoned.year,
    zoned.month - 1,
    zoned.day,
    zoned.hour,
    zoned.minute,
    zoned.second
  );

  return asUtc - date.getTime();
}

function zonedDateTimeToUtc(
  year: number,
  month: number,
  day: number,
  hour: number,
  minute: number,
  second: number,
  timeZone: string
): Date {
  const utcGuess = Date.UTC(year, month - 1, day, hour, minute, second);
  const firstOffset = getTimeZoneOffsetMs(new Date(utcGuess), timeZone);
  const firstPass = utcGuess - firstOffset;
  const secondOffset = getTimeZoneOffsetMs(new Date(firstPass), timeZone);

  return new Date(utcGuess - secondOffset);
}

function getEtDateByOffset(offset: number) {
  const anchorUtcDay = Date.UTC(ANCHOR_YEAR, ANCHOR_MONTH_INDEX, ANCHOR_DAY);
  const targetUtcDay = anchorUtcDay + offset * BIWEEK_DAYS * DAY_MS;
  const target = new Date(targetUtcDay);

  return {
    year: target.getUTCFullYear(),
    month: target.getUTCMonth() + 1,
    day: target.getUTCDate(),
  };
}

function getDayDiffFromAnchor(date: Date): number {
  const zoned = getZonedParts(date, SUBMISSION_TIME_ZONE);
  const anchorUtcDay = Date.UTC(ANCHOR_YEAR, ANCHOR_MONTH_INDEX, ANCHOR_DAY);
  const targetUtcDay = Date.UTC(zoned.year, zoned.month - 1, zoned.day);
  return Math.floor((targetUtcDay - anchorUtcDay) / DAY_MS);
}

function getBiweeklyOffsetForDate(date: Date): number {
  return Math.floor(getDayDiffFromAnchor(date) / BIWEEK_DAYS);
}

function getDeadlineByOffset(offset: number): Date {
  const etDate = getEtDateByOffset(offset);
  return zonedDateTimeToUtc(
    etDate.year,
    etDate.month,
    etDate.day,
    17,
    0,
    0,
    SUBMISSION_TIME_ZONE
  );
}

function getPeriodIdByOffset(offset: number): string {
  const etDate = getEtDateByOffset(offset);
  const month = String(etDate.month).padStart(2, "0");
  const day = String(etDate.day).padStart(2, "0");
  return `${etDate.year}-${month}-${day}`;
}

function getPeriodLabel(deadline: Date): string {
  const dateLabel = deadline.toLocaleDateString("en-US", {
    timeZone: SUBMISSION_TIME_ZONE,
    month: "short",
    day: "numeric",
    year: "numeric",
  });

  return `${dateLabel} (Biweekly Tuesday Deadline)`;
}

function getCurrentPeriodOffset(now: Date): number {
  const baseOffset = getBiweeklyOffsetForDate(now);
  const baseDeadline = getDeadlineByOffset(baseOffset);
  return now.getTime() <= baseDeadline.getTime() ? baseOffset : baseOffset + 1;
}

function buildPeriodForOffset(offset: number): SubmissionPeriod {
  const deadline = getDeadlineByOffset(offset);
  const previousDeadline = getDeadlineByOffset(offset - 1);

  return {
    id: getPeriodIdByOffset(offset),
    label: getPeriodLabel(deadline),
    start: new Date(previousDeadline.getTime() + 1),
    end: new Date(deadline),
    deadline: new Date(deadline),
  };
}

export function isBiweeklySubmissionTuesday(date: Date): boolean {
  const zoned = getZonedParts(date, SUBMISSION_TIME_ZONE);
  if (zoned.weekday !== "Tue") {
    return false;
  }

  const remainder = ((getDayDiffFromAnchor(date) % 14) + 14) % 14;
  return remainder === 0;
}

// Backwards-compatible alias retained for existing imports.
export function isFirstOrThirdTuesday(date: Date): boolean {
  return isBiweeklySubmissionTuesday(date);
}

export function isSubmissionWindowOpen(now: Date = new Date()): boolean {
  if (!isBiweeklySubmissionTuesday(now)) {
    return false;
  }

  const zoned = getZonedParts(now, SUBMISSION_TIME_ZONE);
  const hours = zoned.hour;
  const minutes = zoned.minute;
  const seconds = zoned.second;

  if (hours < 8 || hours > 17) {
    return false;
  }

  if (hours === 17 && (minutes > 0 || seconds > 0)) {
    return false;
  }

  return true;
}

export function isBiweeklyReminderTime(now: Date = new Date()): boolean {
  if (!isBiweeklySubmissionTuesday(now)) {
    return false;
  }

  const zoned = getZonedParts(now, SUBMISSION_TIME_ZONE);
  return zoned.hour === 8 && zoned.minute === 0;
}

export function getCurrentSubmissionPeriod(now: Date = new Date()): SubmissionPeriod {
  return buildPeriodForOffset(getCurrentPeriodOffset(now));
}

export function getRecentSubmissionPeriods(now: Date = new Date(), count: number = 8): SubmissionPeriod[] {
  const currentOffset = getCurrentPeriodOffset(now);
  const periods: SubmissionPeriod[] = [];

  for (let index = 0; index < count; index += 1) {
    periods.push(buildPeriodForOffset(currentOffset - index));
  }

  return periods;
}

export function getSubmissionPeriodsFromJanuary(now: Date = new Date()): SubmissionPeriod[] {
  const currentOffset = getCurrentPeriodOffset(now);
  const currentEt = getZonedParts(now, SUBMISSION_TIME_ZONE);
  const januaryStart = zonedDateTimeToUtc(
    currentEt.year,
    1,
    1,
    0,
    0,
    0,
    SUBMISSION_TIME_ZONE
  );

  let firstOffset = getBiweeklyOffsetForDate(januaryStart);
  while (getDeadlineByOffset(firstOffset).getTime() < januaryStart.getTime()) {
    firstOffset += 1;
  }

  const periods: SubmissionPeriod[] = [];
  for (let offset = currentOffset; offset >= firstOffset; offset -= 1) {
    periods.push(buildPeriodForOffset(offset));
  }

  return periods;
}

export type { SubmissionPeriod };
