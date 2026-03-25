/**
 * Utility for retrying operations with exponential backoff
 */

export interface RetryOptions {
  maxRetries: number;
  initialDelay: number;
  maxDelay: number;
  backoffMultiplier: number;
}

const defaultOptions: RetryOptions = {
  maxRetries: 3,
  initialDelay: 1000,
  maxDelay: 10000,
  backoffMultiplier: 2,
};

/**
 * Check if an error is retryable based on HTTP status code or error type
 */
export function isRetryableError(error: unknown): boolean {
  if (error instanceof Error) {
    // Check for specific HTTP status codes in the message
    const message = error.message.toLowerCase();
    
    // Retry on rate limit (429), service unavailable (503), or network errors
    if (message.includes("429") || message.includes("503")) {
      return true;
    }
    
    // Retry on auth errors (401/403) - token might need refresh
    if (message.includes("401") || message.includes("403")) {
      return true;
    }
    
    // Retry on network-related errors
    if (
      message.includes("network") ||
      message.includes("timeout") ||
      message.includes("econnreset") ||
      message.includes("etimedout")
    ) {
      return true;
    }
  }
  
  return false;
}

/**
 * Delay execution for specified milliseconds
 */
export function delay(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

/**
 * Calculate delay with exponential backoff
 */
function calculateDelay(attempt: number, options: RetryOptions): number {
  const delay = options.initialDelay * Math.pow(options.backoffMultiplier, attempt - 1);
  return Math.min(delay, options.maxDelay);
}

/**
 * Execute a function with retry logic
 */
export async function withRetry<T>(
  fn: () => Promise<T>,
  options: Partial<RetryOptions> = {}
): Promise<{ success: true; data: T } | { success: false; error: string; attempts: number }> {
  const opts = { ...defaultOptions, ...options };
  let lastError: Error | null = null;

  for (let attempt = 1; attempt <= opts.maxRetries; attempt++) {
    try {
      const result = await fn();
      return { success: true, data: result };
    } catch (error) {
      lastError = error instanceof Error ? error : new Error(String(error));
      
      // Don't retry if it's a non-retryable error
      if (!isRetryableError(error)) {
        return {
          success: false,
          error: lastError.message,
          attempts: attempt,
        };
      }

      // If this was the last attempt, return failure
      if (attempt === opts.maxRetries) {
        break;
      }

      // Wait before retrying
      const waitTime = calculateDelay(attempt, opts);
      console.log(`Retry ${attempt}/${opts.maxRetries}: Waiting ${waitTime}ms before retry...`);
      await delay(waitTime);
    }
  }

  return {
    success: false,
    error: lastError?.message || "Operation failed after maximum retries",
    attempts: opts.maxRetries,
  };
}

/**
 * Retry configuration for Microsoft Graph API calls
 */
export const graphRetryOptions: RetryOptions = {
  maxRetries: 3,
  initialDelay: 1000,
  maxDelay: 8000,
  backoffMultiplier: 2,
};
