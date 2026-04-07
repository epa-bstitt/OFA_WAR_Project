import { ConvertOptions, TerseResult, AIError } from "./types";
import { formatPrompt } from "./prompts";
import { getCachedResult, cacheResult } from "./cache";

// Default configuration from environment variables (fallback only)
const DEFAULT_AI_SERVICE_URL = process.env.AI_SERVICE_URL || "https://internal-epa-ai.gov/api/v1/convert";
const DEFAULT_AI_SERVICE_API_KEY = process.env.AI_SERVICE_API_KEY || "";
const AI_SERVICE_TIMEOUT_MS = parseInt(process.env.AI_SERVICE_TIMEOUT_MS || "5000", 10);
const AI_SERVICE_MAX_RETRIES = parseInt(process.env.AI_SERVICE_MAX_RETRIES || "2", 10);

/**
 * AI Service HTTP client for terse conversion
 */
export async function convertToTerse(
  rawText: string,
  options?: ConvertOptions
): Promise<{ result?: TerseResult; error?: AIError }> {
  const startTime = Date.now();

  // Use provided settings or fall back to defaults
  const serviceUrl = options?.serviceSettings?.serviceUrl || DEFAULT_AI_SERVICE_URL;
  const apiKey = options?.serviceSettings?.apiKey || DEFAULT_AI_SERVICE_API_KEY;

  // Check cache first
  const cached = getCachedResult(rawText, options?.promptTemplateId);
  if (cached) {
    return { result: cached.result };
  }

  // Format the prompt
  const prompt = formatPrompt(rawText, options?.promptTemplateId);

  // Prepare request body
  const requestBody = {
    text: rawText,
    prompt,
    model: options?.serviceSettings?.model || "gpt-4o-mini",
    options: {
      format: "terse",
      maxLength: options?.maxLength || 500,
      style: options?.style || "epa-war",
    },
  };

  // Make HTTP request with timeout
  try {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), options?.timeout || AI_SERVICE_TIMEOUT_MS);

    const response = await fetch(serviceUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${apiKey}`,
        "X-Request-ID": generateRequestId(),
      },
      body: JSON.stringify(requestBody),
      signal: controller.signal,
    });

    clearTimeout(timeoutId);

    // Handle HTTP errors
    if (!response.ok) {
      const error = await parseErrorResponse(response);
      return { error };
    }

    // Parse successful response
    const data = await response.json();

    const result: TerseResult = {
      terseText: data.terseText || data.text || "",
      confidence: data.confidence || 0,
      processingTime: data.processingTimeMs || Date.now() - startTime,
      modelVersion: data.modelVersion || options?.serviceSettings?.model || "unknown",
    };

    // Cache the result
    cacheResult(rawText, result, options?.promptTemplateId);

    return { result };
  } catch (error) {
    // Handle fetch/timeout errors
    if (error instanceof Error) {
      if (error.name === "AbortError") {
        return {
          error: {
            code: "TIMEOUT",
            message: "AI service request timed out. Please try again.",
            retryable: true,
          },
        };
      }

      return {
        error: {
          code: "NETWORK_ERROR",
          message: `Failed to connect to AI service at ${serviceUrl}. Please check your settings.`,
          retryable: true,
        },
      };
    }

    return {
      error: {
        code: "UNKNOWN_ERROR",
        message: "An unexpected error occurred.",
        retryable: false,
      },
    };
  }
}

/**
 * Parse error response from AI service
 */
async function parseErrorResponse(response: Response): Promise<AIError> {
  const status = response.status;
  
  // Default error
  let error: AIError = {
    code: "SERVICE_ERROR",
    message: "AI service returned an error.",
    retryable: true,
  };

  try {
    const data = await response.json();
    if (data.error) {
      error = {
        code: data.error.code || `HTTP_${status}`,
        message: data.error.message || error.message,
        retryable: isRetryableStatus(status),
      };
    }
  } catch {
    // Could not parse error response, use defaults
    switch (status) {
      case 503:
        error = {
          code: "SERVICE_UNAVAILABLE",
          message: "AI service is temporarily unavailable.",
          retryable: true,
        };
        break;
      case 429:
        error = {
          code: "RATE_LIMITED",
          message: "Too many requests. Please wait a moment.",
          retryable: true,
        };
        break;
      case 400:
        error = {
          code: "INVALID_INPUT",
          message: "Invalid input. Please check your text.",
          retryable: false,
        };
        break;
    }
  }

  return error;
}

/**
 * Determine if an HTTP status code indicates a retryable error
 */
function isRetryableStatus(status: number): boolean {
  return status === 503 || status === 504 || status === 429 || status >= 500;
}

/**
 * Check if an error is retryable
 */
export function isRetryableError(error: AIError): boolean {
  return error.retryable;
}

/**
 * Generate a unique request ID for tracing
 */
function generateRequestId(): string {
  return `${Date.now()}-${Math.random().toString(36).substring(2, 11)}`;
}

/**
 * Delay helper for retry logic
 */
export function delay(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
