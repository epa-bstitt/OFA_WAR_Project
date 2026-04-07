/**
 * Date utility functions for Bi-Weekly Activity Report calculations
 * Uses ISO 8601 week date system (week starts on Monday)
 */

/**
 * Get the current bi-weekly period number (1-26)
 * Each bi-weekly period consists of 2 weeks
 */
export function getCurrentBiWeek(): number {
  const now = new Date();
  const week = getISOWeek(now);
  return Math.ceil(week / 2);
}

/**
 * Get bi-weekly period number for a specific date
 */
export function getBiWeekFromDate(date: Date): number {
  const week = getISOWeek(date);
  return Math.ceil(week / 2);
}

/**
 * Get the start (Monday) and end (Sunday) dates for a given bi-weekly period
 */
export function getBiWeekRange(biWeekNumber: number, year?: number): { start: Date; end: Date } {
  const targetYear = year || new Date().getFullYear();
  
  // Calculate start week of the bi-weekly period
  const startWeek = (biWeekNumber - 1) * 2 + 1;
  
  // Get the Monday of the first week
  const { start } = getWeekRange(startWeek, targetYear);
  
  // Get the Sunday of the second week (14 days later)
  const end = new Date(start);
  end.setUTCDate(start.getUTCDate() + 13);
  
  return { start, end };
}

/**
 * Format bi-weekly date range as a readable string
 */
export function formatBiWeekRange(biWeekNumber: number, year?: number): string {
  const { start, end } = getBiWeekRange(biWeekNumber, year);
  
  const formatOptions: Intl.DateTimeFormatOptions = { month: "short", day: "numeric" };
  const startStr = start.toLocaleDateString("en-US", formatOptions);
  const endStr = end.toLocaleDateString("en-US", { ...formatOptions, year: "numeric" });
  
  return `Period ${biWeekNumber}: ${startStr} - ${endStr}`;
}

/**
 * Get bi-weekly options for a dropdown (current period and 1 period back)
 */
export function getBiWeekOptions(): { value: number; label: string }[] {
  const currentBiWeek = getCurrentBiWeek();
  const currentYear = new Date().getFullYear();
  const options: { value: number; label: string }[] = [];
  
  // Current bi-weekly period
  options.push({
    value: currentBiWeek,
    label: formatBiWeekRange(currentBiWeek, currentYear),
  });
  
  // Previous bi-weekly period
  if (currentBiWeek > 1) {
    options.push({
      value: currentBiWeek - 1,
      label: formatBiWeekRange(currentBiWeek - 1, currentYear),
    });
  }
  
  return options;
}

/**
 * Validate if a bi-weekly period is valid for submission
 * Cannot be future, cannot be too old (more than 1 period in the past)
 */
export function isBiWeekValid(biWeekNumber: number, year?: number): boolean {
  const currentBiWeek = getCurrentBiWeek();
  const currentYear = new Date().getFullYear();
  const targetYear = year || currentYear;
  
  // Check if period is valid (1-26)
  if (biWeekNumber < 1 || biWeekNumber > 26) {
    return false;
  }
  
  // If different year
  if (targetYear < currentYear) {
    return false;
  }
  
  if (targetYear > currentYear) {
    return false;
  }
  
  // Same year - check if more than 1 period in the past
  if (biWeekNumber < currentBiWeek - 1) {
    return false;
  }
  
  // Cannot submit for future periods
  if (biWeekNumber > currentBiWeek) {
    return false;
  }
  
  return true;
}

/**
 * Get the date for a specific bi-weekly period (Monday of the first week)
 * Used for storing periodOf in database
 */
export function getBiWeekDate(biWeekNumber: number, year?: number): Date {
  const { start } = getBiWeekRange(biWeekNumber, year);
  return start;
}

/**
 * Parse a bi-week string (format: "YYYY-BW##") to bi-week number and year
 */
export function parseBiWeekString(biWeekString: string): { biWeek: number; year: number } | null {
  const match = biWeekString.match(/^(\d{4})-BW(\d{1,2})$/);
  if (!match) return null;
  
  const year = parseInt(match[1], 10);
  const biWeek = parseInt(match[2], 10);
  
  return { biWeek, year };
}

/**
 * Format bi-week as bi-week string (e.g., "2024-BW01")
 */
export function formatBiWeekString(biWeekNumber: number, year?: number): string {
  const targetYear = year || new Date().getFullYear();
  const paddedBiWeek = biWeekNumber.toString().padStart(2, "0");
  return `${targetYear}-BW${paddedBiWeek}`;
}

/**
 * Get the current ISO week number
 * Week 1 is the week with the first Thursday of the year
 */
export function getCurrentWeek(): number {
  const now = new Date();
  return getISOWeek(now);
}

/**
 * Get ISO week number for a specific date
 */
export function getISOWeek(date: Date): number {
  const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
  const dayNum = d.getUTCDay() || 7;
  d.setUTCDate(d.getUTCDate() + 4 - dayNum);
  const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
  return Math.ceil(((d.getTime() - yearStart.getTime()) / 86400000 + 1) / 7);
}

/**
 * Get ISO week year for a specific date
 * (Needed because week 1 of next year might be in December)
 */
export function getISOWeekYear(date: Date): number {
  const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
  const dayNum = d.getUTCDay() || 7;
  d.setUTCDate(d.getUTCDate() + 4 - dayNum);
  return d.getUTCFullYear();
}

/**
 * Get the start (Monday) and end (Sunday) dates for a given ISO week
 */
export function getWeekRange(weekNumber: number, year?: number): { start: Date; end: Date } {
  const targetYear = year || new Date().getFullYear();
  
  // Find the first Thursday of the year (defines week 1)
  const jan4 = new Date(Date.UTC(targetYear, 0, 4));
  const jan4Day = jan4.getUTCDay() || 7;
  const week1Monday = new Date(Date.UTC(targetYear, 0, 4 - jan4Day + 1));
  
  // Calculate the Monday of the requested week
  const targetMonday = new Date(week1Monday);
  targetMonday.setUTCDate(week1Monday.getUTCDate() + (weekNumber - 1) * 7);
  
  // Calculate the Sunday
  const targetSunday = new Date(targetMonday);
  targetSunday.setUTCDate(targetMonday.getUTCDate() + 6);
  
  return { start: targetMonday, end: targetSunday };
}

/**
 * Format date range as a readable string
 */
export function formatWeekRange(weekNumber: number, year?: number): string {
  const { start, end } = getWeekRange(weekNumber, year);
  
  const formatOptions: Intl.DateTimeFormatOptions = { month: "short", day: "numeric" };
  const startStr = start.toLocaleDateString("en-US", formatOptions);
  const endStr = end.toLocaleDateString("en-US", { ...formatOptions, year: "numeric" });
  
  return `Week ${weekNumber}: ${startStr} - ${endStr}`;
}

/**
 * Check if a date is in the future (after today)
 */
export function isFuture(date: Date): boolean {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const checkDate = new Date(date);
  checkDate.setHours(0, 0, 0, 0);
  return checkDate > today;
}

/**
 * Check if a week is too old (more than 1 week in the past)
 * Grace period: can submit for current week or previous week
 */
export function isWeekTooOld(weekNumber: number, year?: number): boolean {
  const currentWeek = getCurrentWeek();
  const currentYear = new Date().getFullYear();
  const targetYear = year || currentYear;
  
  // If different year, check if it's more than 1 week past
  if (targetYear < currentYear) {
    // Previous year weeks are too old
    return true;
  }
  
  if (targetYear > currentYear) {
    // Future year - not too old (but should be rejected by isFuture check)
    return false;
  }
  
  // Same year - check if more than 1 week in the past
  return weekNumber < currentWeek - 1;
}

/**
 * Validate if a week is valid for submission
 * Cannot be future, cannot be too old
 */
export function isWeekValid(weekNumber: number, year?: number): boolean {
  const targetYear = year || new Date().getFullYear();
  
  // Check if week is valid (1-53)
  if (weekNumber < 1 || weekNumber > 53) {
    return false;
  }
  
  // Check if week is too old
  if (isWeekTooOld(weekNumber, targetYear)) {
    return false;
  }
  
  // Check if week is in the future
  const currentWeek = getCurrentWeek();
  const currentYear = new Date().getFullYear();
  
  if (targetYear > currentYear) {
    return false;
  }
  
  if (targetYear === currentYear && weekNumber > currentWeek) {
    return false;
  }
  
  return true;
}

/**
 * Get the date for a specific week (Monday of that week)
 * Used for storing weekOf in database
 */
export function getWeekDate(weekNumber: number, year?: number): Date {
  const { start } = getWeekRange(weekNumber, year);
  return start;
}

/**
 * Get week options for a dropdown (current week and 2 weeks back)
 */
export function getWeekOptions(): { value: number; label: string }[] {
  const currentWeek = getCurrentWeek();
  const currentYear = new Date().getFullYear();
  const options: { value: number; label: string }[] = [];
  
  // Current week
  options.push({
    value: currentWeek,
    label: formatWeekRange(currentWeek, currentYear),
  });
  
  // Previous week
  if (currentWeek > 1) {
    options.push({
      value: currentWeek - 1,
      label: formatWeekRange(currentWeek - 1, currentYear),
    });
  }
  
  return options;
}

/**
 * Parse a week string (format: "YYYY-W##") to week number and year
 */
export function parseWeekString(weekString: string): { week: number; year: number } | null {
  const match = weekString.match(/^(\d{4})-W(\d{1,2})$/);
  if (!match) return null;
  
  const year = parseInt(match[1], 10);
  const week = parseInt(match[2], 10);
  
  return { week, year };
}

/**
 * Format week as ISO week string (e.g., "2024-W01")
 */
export function formatWeekString(weekNumber: number, year?: number): string {
  const targetYear = year || new Date().getFullYear();
  const paddedWeek = weekNumber.toString().padStart(2, "0");
  return `${targetYear}-W${paddedWeek}`;
}
