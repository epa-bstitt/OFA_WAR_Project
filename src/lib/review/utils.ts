/**
 * Utility functions for review-related calculations
 * These are NOT server actions and can be imported from client components
 */

/**
 * Calculate priority based on submission age
 */
export function calculatePriority(createdAt: Date): "urgent" | "high" | "normal" {
  const now = new Date();
  const daysSinceSubmission = Math.floor(
    (now.getTime() - createdAt.getTime()) / (1000 * 60 * 60 * 24)
  );

  if (daysSinceSubmission > 14) return "urgent";
  if (daysSinceSubmission > 7) return "high";
  return "normal";
}

/**
 * Get days since submission
 */
export function getDaysSinceSubmission(createdAt: Date): number {
  const now = new Date();
  return Math.floor((now.getTime() - createdAt.getTime()) / (1000 * 60 * 60 * 24));
}
