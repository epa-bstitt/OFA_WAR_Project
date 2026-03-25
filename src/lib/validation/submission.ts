import { z } from "zod";
import { isFuture, isWeekValid, getWeekDate, getCurrentWeek, getISOWeekYear } from "@/lib/date-utils";

/**
 * Zod schema for WAR submission validation
 */
export const submissionSchema = z.object({
  weekOf: z.preprocess(
    (val) => (val instanceof Date ? val : new Date(val as string)),
    z.date()
  )
    .refine(
      (date) => !isFuture(date),
      "Cannot select future weeks"
    )
    .refine(
      (date) => {
        const week = getCurrentWeek();
        const year = getISOWeekYear(date);
        return isWeekValid(week, year);
      },
      "Week is too old to submit (only current week and previous week allowed)"
    ),
  rawText: z.string()
    .min(10, "Status update must be at least 10 characters")
    .max(5000, "Status update cannot exceed 5000 characters")
    .refine(
      (text) => !/<script|javascript:|on\w+=/i.test(text),
      "HTML tags and scripts are not allowed"
    ),
});

/**
 * Type for validated submission input
 */
export type SubmissionInput = z.infer<typeof submissionSchema>;

/**
 * Extended schema for AI conversion (used in Story 2.2)
 */
export const submissionWithTerseSchema = submissionSchema.extend({
  terseVersion: z.string().optional(),
  isAiGenerated: z.boolean().default(false),
});

export type SubmissionWithTerseInput = z.infer<typeof submissionWithTerseSchema>;

/**
 * Helper to validate week number directly
 * Used when week is selected as a number
 */
export function validateWeekNumber(weekNumber: number, year?: number): boolean {
  return isWeekValid(weekNumber, year);
}

/**
 * Helper to get validation error message for a week
 */
export function getWeekValidationError(weekNumber: number, year?: number): string | null {
  const targetYear = year || new Date().getFullYear();
  
  if (weekNumber < 1 || weekNumber > 53) {
    return "Invalid week number. Must be between 1 and 53.";
  }
  
  if (!isWeekValid(weekNumber, targetYear)) {
    const currentWeek = getCurrentWeek();
    if (weekNumber > currentWeek && targetYear >= new Date().getFullYear()) {
      return "Cannot select future weeks.";
    }
    return "Week is too old to submit. Only current week and previous week are allowed.";
  }
  
  return null;
}

/**
 * Sanitize raw text input
 * Removes HTML tags and trims whitespace
 */
export function sanitizeRawText(text: string): string {
  return text
    .replace(/<[^>]*>/g, "") // Remove HTML tags
    .replace(/[<>]/g, "") // Remove angle brackets
    .trim();
}
