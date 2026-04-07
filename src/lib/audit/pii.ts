/**
 * PII (Personally Identifiable Information) Masking Utility
 * Ensures sensitive data is not stored in audit logs
 */

// Types that might contain PII
export type PIIData = Record<string, unknown>;

// Email regex pattern
const EMAIL_REGEX = /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/g;

// Phone number patterns (US and international)
const PHONE_REGEX = /(\+?1?[-.\s]?)?\(?[0-9]{3}\)?[-.\s]?[0-9]{3}[-.\s]?[0-9]{4}/g;

// SSN pattern
const SSN_REGEX = /\b\d{3}-\d{2}-\d{4}\b/g;

// Credit card pattern (basic)
const CREDIT_CARD_REGEX = /\b(?:\d[ -]*?){13,16}\b/g;

// UUID pattern (might be sensitive IDs)
const UUID_REGEX = /[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/gi;

// Fields that should always be masked
const SENSITIVE_FIELDS = new Set([
  "email",
  "emails",
  "emailAddress",
  "email_address",
  "mail",
  "e_mail",
  "phone",
  "phoneNumber",
  "phone_number",
  "tel",
  "telephone",
  "mobile",
  "ssn",
  "socialSecurityNumber",
  "social_security_number",
  "password",
  "passwd",
  "pwd",
  "secret",
  "token",
  "apiKey",
  "api_key",
  "apiKeyId",
  "creditCard",
  "credit_card",
  "cardNumber",
  "card_number",
  "cvv",
  "cvc",
  "name",
  "firstName",
  "first_name",
  "lastName",
  "last_name",
  "fullName",
  "full_name",
  "displayName",
  "display_name",
  "userName",
  "user_name",
  "username",
  "address",
  "street",
  "streetAddress",
  "street_address",
  "city",
  "state",
  "zip",
  "zipCode",
  "zip_code",
  "postalCode",
  "postal_code",
  "country",
  "ipAddress",
  "ip_address",
  "ip",
  "userAgent",
  "user_agent",
]);

// Fields that are safe to log (allowlist)
const SAFE_FIELDS = new Set([
  "id",
  "userId",
  "submissionId",
  "reviewId",
  "promptId",
  "action",
  "status",
  "role",
  "weekOf",
  "weekNumber",
  "year",
  "createdAt",
  "updatedAt",
  "deletedAt",
  "publishedAt",
  "aiConfidence",
  "isAiGenerated",
  "version",
  "isActive",
  "count",
  "reason",
  "notes",
  "metadata",
  "resourceType",
  "resourceId",
]);

/**
 * Hash a string using simple hash (for IDs that need to be tracked but not revealed)
 */
export function hashString(str: string): string {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = ((hash << 5) - hash + char) | 0;
  }
  return `HASH_${Math.abs(hash).toString(16)}`;
}

/**
 * Mask email addresses
 */
export function maskEmail(email: string): string {
  if (!email || !EMAIL_REGEX.test(email)) {
    return email;
  }

  const [localPart, domain] = email.split("@");
  const maskedLocal = localPart.charAt(0) + "***";
  const domainParts = domain.split(".");
  const maskedDomain = domainParts[0].charAt(0) + "***." + domainParts[domainParts.length - 1];

  return `${maskedLocal}@${maskedDomain}`;
}

/**
 * Mask string value based on content type
 */
export function maskStringValue(value: string): string {
  if (!value) return value;

  // Check if it looks like an email
  if (EMAIL_REGEX.test(value)) {
    return maskEmail(value);
  }

  // Check if it looks like a phone number
  if (PHONE_REGEX.test(value)) {
    return "[PHONE_MASKED]";
  }

  // Check if it looks like an SSN
  if (SSN_REGEX.test(value)) {
    return "[SSN_MASKED]";
  }

  // Check if it looks like a credit card
  if (CREDIT_CARD_REGEX.test(value)) {
    return "[CARD_MASKED]";
  }

  // Check if it's a UUID (hash it for tracking)
  if (UUID_REGEX.test(value)) {
    return hashString(value);
  }

  // For other strings, check if they contain embedded emails
  if (EMAIL_REGEX.test(value)) {
    return value.replace(EMAIL_REGEX, "[EMAIL_MASKED]");
  }

  return value;
}

/**
 * Recursively mask PII in an object
 */
export function maskPII(data: PIIData): PIIData {
  if (!data || typeof data !== "object") {
    return data;
  }

  const masked: PIIData = {};

  for (const [key, value] of Object.entries(data)) {
    // Check if field is in allowlist
    if (SAFE_FIELDS.has(key)) {
      masked[key] = value;
      continue;
    }

    // Check if field should be masked
    if (SENSITIVE_FIELDS.has(key)) {
      if (typeof value === "string") {
        // For IDs that might be in sensitive fields, hash them
        if (key.toLowerCase().includes("id")) {
          masked[key] = hashString(value);
        } else {
          masked[key] = maskStringValue(value);
        }
      } else {
        masked[key] = "[MASKED]";
      }
      continue;
    }

    // Recursively process nested objects
    if (value && typeof value === "object" && !Array.isArray(value)) {
      masked[key] = maskPII(value as PIIData);
      continue;
    }

    // Process arrays
    if (Array.isArray(value)) {
      masked[key] = value.map((item) => {
        if (typeof item === "string") {
          return maskStringValue(item);
        }
        if (typeof item === "object") {
          return maskPII(item as PIIData);
        }
        return item;
      });
      continue;
    }

    // Process string values
    if (typeof value === "string") {
      masked[key] = maskStringValue(value);
      continue;
    }

    // Pass through other types
    masked[key] = value;
  }

  return masked;
}

/**
 * Check if data might contain PII
 */
export function mightContainPII(data: PIIData): boolean {
  if (!data || typeof data !== "object") {
    return false;
  }

  for (const [key, value] of Object.entries(data)) {
    // Check field name
    if (SENSITIVE_FIELDS.has(key)) {
      return true;
    }

    // Check string values
    if (typeof value === "string") {
      if (
        EMAIL_REGEX.test(value) ||
        PHONE_REGEX.test(value) ||
        SSN_REGEX.test(value)
      ) {
        return true;
      }
    }

    // Recursively check nested objects
    if (value && typeof value === "object") {
      if (mightContainPII(value as PIIData)) {
        return true;
      }
    }
  }

  return false;
}

/**
 * Sanitize text for safe logging
 */
export function sanitizeForLog(text: string): string {
  if (!text) return text;

  return text
    .replace(EMAIL_REGEX, "[EMAIL]")
    .replace(PHONE_REGEX, "[PHONE]")
    .replace(SSN_REGEX, "[SSN]")
    .replace(CREDIT_CARD_REGEX, "[CARD]")
    .slice(0, 1000); // Limit length
}
