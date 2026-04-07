/**
 * Types for AI terse conversion service
 */

export interface ConvertOptions {
  /** Optional prompt template ID to use */
  promptTemplateId?: string;
  /** Timeout in milliseconds (default: 5000) */
  timeout?: number;
  /** Maximum length of output */
  maxLength?: number;
  /** Style guide to follow */
  style?: "epa-war" | "epa-standard";
  /** AI Service settings (URL, API key, etc.) */
  serviceSettings?: {
    serviceUrl?: string;
    apiKey?: string;
    model?: string;
  };
}

export interface TerseResult {
  /** The converted terse text */
  terseText: string;
  /** Confidence score (0-1) */
  confidence: number;
  /** Processing time in milliseconds */
  processingTime: number;
  /** Model version used for conversion */
  modelVersion: string;
}

export interface AIError {
  /** Error code */
  code: string;
  /** Human-readable error message */
  message: string;
  /** Whether the error is retryable */
  retryable: boolean;
}

export interface ConvertResult {
  /** Whether the conversion was successful */
  success: boolean;
  /** The conversion result (if successful) */
  result?: TerseResult;
  /** Error details (if failed) */
  error?: AIError;
  /** Whether to fallback to manual entry */
  fallback?: boolean;
}

/** Cache entry for conversion results */
export interface CacheEntry {
  result: TerseResult;
  timestamp: number;
}
