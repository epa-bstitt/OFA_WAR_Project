"use server";

import { convertToTerse, isRetryableError, delay } from "@/lib/ai/service";
import { TerseResult, AIError } from "@/lib/ai/types";
import { auth } from "@/lib/auth";

/**
 * Rate limiting store (in-memory, per instance)
 * In production, use Redis or similar
 */
const rateLimitStore = new Map<string, { count: number; resetTime: number }>();
const RATE_LIMIT_MAX = 10; // 10 requests per minute
const RATE_LIMIT_WINDOW = 60 * 1000; // 1 minute

/**
 * Check rate limit for user
 */
function checkRateLimit(userId: string): boolean {
  const now = Date.now();
  const record = rateLimitStore.get(userId);

  if (!record || now > record.resetTime) {
    // New window
    rateLimitStore.set(userId, {
      count: 1,
      resetTime: now + RATE_LIMIT_WINDOW,
    });
    return true;
  }

  if (record.count >= RATE_LIMIT_MAX) {
    return false;
  }

  record.count++;
  return true;
}

/**
 * Server Action: Convert raw text to terse format
 * Implements timeout, retry, caching, and rate limiting
 */
export async function convertToTerseAction(
  rawText: string,
  settings: { serviceUrl?: string; apiKey?: string; model?: string },
  retries: number = 0
): Promise<
  | { success: true; result: TerseResult }
  | { success: false; error: AIError; fallback?: boolean }
> {
  try {
    // 1. Check authentication
    const session = await auth();
    if (!session?.user?.id) {
      return {
        success: false,
        error: {
          code: "UNAUTHORIZED",
          message: "Authentication required. Please sign in.",
          retryable: false,
        },
      };
    }

    // 2. Check rate limit
    if (!checkRateLimit(session.user.id)) {
      return {
        success: false,
        error: {
          code: "RATE_LIMITED",
          message: "Too many conversion requests. Please wait a minute and try again.",
          retryable: true,
        },
      };
    }

    // 3. Validate input
    if (!rawText || rawText.trim().length < 10) {
      return {
        success: false,
        error: {
          code: "INVALID_INPUT",
          message: "Text must be at least 10 characters long.",
          retryable: false,
        },
      };
    }

    if (rawText.length > 5000) {
      return {
        success: false,
        error: {
          code: "INVALID_INPUT",
          message: "Text cannot exceed 5000 characters.",
          retryable: false,
        },
      };
    }

    // 4. Call AI service with provided settings
    const { result, error } = await convertToTerse(rawText, {
      timeout: 5000,
      maxLength: 500,
      style: "epa-war",
      serviceSettings: {
        serviceUrl: settings.serviceUrl,
        apiKey: settings.apiKey,
        model: settings.model || "gpt-4o-mini",
      },
    });

    // 5. Handle success
    if (result) {
      return {
        success: true,
        result,
      };
    }

    // 6. Handle error with retry logic
    if (error && isRetryableError(error) && retries < 2) {
      await delay(1000 * (retries + 1)); // Exponential backoff
      return convertToTerseAction(rawText, settings, retries + 1);
    }

    // 7. Final error - return with fallback option
    return {
      success: false,
      error: error || {
        code: "UNKNOWN_ERROR",
        message: "Failed to convert text. Please try again.",
        retryable: false,
      },
      fallback: true,
    };
  } catch (error) {
    console.error("Convert to terse action error:", error);

    return {
      success: false,
      error: {
        code: "SERVER_ERROR",
        message: "An unexpected error occurred. Please try again.",
        retryable: true,
      },
      fallback: true,
    };
  }
}

/**
 * Type export for client usage
 */
export type { TerseResult, AIError };
