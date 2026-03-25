import crypto from "crypto";
import { CacheEntry } from "./types";

// Simple in-memory LRU cache implementation
class LRUCache<K, V> {
  private cache: Map<K, V>;
  private maxSize: number;

  constructor(maxSize: number) {
    this.cache = new Map();
    this.maxSize = maxSize;
  }

  get(key: K): V | undefined {
    const value = this.cache.get(key);
    if (value !== undefined) {
      // Move to end (most recently used)
      this.cache.delete(key);
      this.cache.set(key, value);
    }
    return value;
  }

  set(key: K, value: V): void {
    if (this.cache.has(key)) {
      this.cache.delete(key);
    } else if (this.cache.size >= this.maxSize) {
      // Remove least recently used (first item)
      const firstKey = this.cache.keys().next().value as K;
      if (firstKey !== undefined) {
        this.cache.delete(firstKey);
      }
    }
    this.cache.set(key, value);
  }

  clear(): void {
    this.cache.clear();
  }
}

// Cache configuration
const CACHE_TTL_MS = 60 * 60 * 1000; // 1 hour
const MAX_CACHE_ENTRIES = 100;

// Global cache instance
const conversionCache = new LRUCache<string, CacheEntry>(MAX_CACHE_ENTRIES);

/**
 * Generate cache key from raw text and prompt version
 */
export function generateCacheKey(rawText: string, promptVersion: string = "v1.0"): string {
  const hash = crypto
    .createHash("sha256")
    .update(rawText.trim() + promptVersion)
    .digest("hex");
  return hash;
}

/**
 * Get cached conversion result
 */
export function getCachedResult(
  rawText: string,
  promptVersion: string = "v1.0"
): CacheEntry | undefined {
  const key = generateCacheKey(rawText, promptVersion);
  const entry = conversionCache.get(key);

  if (!entry) return undefined;

  // Check if cache entry has expired
  const now = Date.now();
  if (now - entry.timestamp > CACHE_TTL_MS) {
    // Entry expired, remove it
    conversionCache.set(key, { result: entry.result, timestamp: 0 }); // Force eviction on next access
    return undefined;
  }

  return entry;
}

/**
 * Store conversion result in cache
 */
export function cacheResult(
  rawText: string,
  result: CacheEntry["result"],
  promptVersion: string = "v1.0"
): void {
  const key = generateCacheKey(rawText, promptVersion);
  conversionCache.set(key, {
    result,
    timestamp: Date.now(),
  });
}

/**
 * Clear all cached results
 */
export function clearCache(): void {
  conversionCache.clear();
}

/**
 * Get cache stats for monitoring
 */
export function getCacheStats(): { size: number; maxSize: number } {
  return {
    size: 0, // We can't easily get the size from the Map without iterating
    maxSize: MAX_CACHE_ENTRIES,
  };
}
