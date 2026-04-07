/**
 * Audit Logger - Core logging functionality for compliance
 * All audit events are immutable and append-only
 */

import { prisma } from "@/lib/db";
import { maskPII, type PIIData } from "./pii";

// Audit event types
export type AuditAction =
  | "USER_SIGNIN"
  | "USER_SIGNOUT"
  | "USER_ROLE_CHANGED"
  | "USER_DISABLED"
  | "USER_ENABLED"
  | "SUBMISSION_CREATED"
  | "SUBMISSION_UPDATED"
  | "SUBMISSION_DELETED"
  | "SUBMISSION_APPROVED"
  | "SUBMISSION_REJECTED"
  | "SUBMISSION_PUBLISHED"
  | "REVIEW_CREATED"
  | "REVIEW_UPDATED"
  | "PROMPT_CREATED"
  | "PROMPT_UPDATED"
  | "PROMPT_DELETED"
  | "PROMPT_ACTIVATED"
  | "BATCH_APPROVED"
  | "BATCH_REJECTED"
  | "NOTIFICATION_SENT"
  | "NOTIFICATION_FAILED"
  | "AUDIT_LOG_VIEWED"
  | "DATA_EXPORTED"
  | "RETENTION_ENFORCED";

// Resource types
export type ResourceType =
  | "user"
  | "submission"
  | "review"
  | "prompt"
  | "notification"
  | "export"
  | "audit"
  | "system";

// Audit event interface
export interface AuditEvent {
  action: AuditAction;
  userId: string | null;
  resourceType: ResourceType;
  resourceId?: string;
  metadata?: Record<string, unknown>;
  ipAddress?: string;
  userAgent?: string;
}

/**
 * Log an audit event
 * This is the ONLY way to create audit log entries
 * Updates and deletes are NOT allowed - logs are immutable
 */
export async function logAuditEvent(event: AuditEvent): Promise<void> {
  try {
    // Mask PII in metadata
    const sanitizedMetadata = event.metadata
      ? maskPII(event.metadata as PIIData)
      : null;

    // Sanitize user agent (may contain PII)
    const sanitizedUserAgent = event.userAgent
      ? sanitizeUserAgent(event.userAgent)
      : null;

    // Create audit log entry
    await prisma.auditLog.create({
      data: {
        action: event.action,
        userId: event.userId,
        resourceType: event.resourceType,
        resourceId: event.resourceId,
        metadata: sanitizedMetadata,
        ipAddress: event.ipAddress,
        userAgent: sanitizedUserAgent,
        // createdAt is auto-set by Prisma
      },
    });

    // Log to console in development
    if (process.env.NODE_ENV === "development") {
      console.log(`[AUDIT] ${event.action}`, {
        userId: event.userId,
        resourceType: event.resourceType,
        resourceId: event.resourceId,
      });
    }
  } catch (error) {
    // Log errors but don't throw - audit logging should never block operations
    console.error("Failed to create audit log:", error);
  }
}

/**
 * Batch log multiple audit events
 * Useful for batch operations
 */
export async function logAuditEvents(events: AuditEvent[]): Promise<void> {
  try {
    const sanitizedEvents = events.map((event) => ({
      action: event.action,
      userId: event.userId,
      resourceType: event.resourceType,
      resourceId: event.resourceId,
      metadata: event.metadata ? maskPII(event.metadata as PIIData) : null,
      ipAddress: event.ipAddress,
      userAgent: event.userAgent ? sanitizeUserAgent(event.userAgent) : null,
    }));

    await prisma.auditLog.createMany({
      data: sanitizedEvents,
    });
  } catch (error) {
    console.error("Failed to create batch audit logs:", error);
  }
}

/**
 * Log authentication events
 */
export async function logAuthEvent(
  action: "USER_SIGNIN" | "USER_SIGNOUT",
  userId: string,
  ipAddress?: string,
  userAgent?: string
): Promise<void> {
  await logAuditEvent({
    action,
    userId,
    resourceType: "user",
    resourceId: userId,
    ipAddress,
    userAgent,
  });
}

/**
 * Log submission events
 */
export async function logSubmissionEvent(
  action: "SUBMISSION_CREATED" | "SUBMISSION_UPDATED" | "SUBMISSION_DELETED",
  userId: string,
  submissionId: string,
  metadata?: { weekOf?: string; status?: string }
): Promise<void> {
  await logAuditEvent({
    action,
    userId,
    resourceType: "submission",
    resourceId: submissionId,
    metadata,
  });
}

/**
 * Log workflow events
 */
export async function logWorkflowEvent(
  action: "SUBMISSION_APPROVED" | "SUBMISSION_REJECTED" | "SUBMISSION_PUBLISHED",
  userId: string,
  submissionId: string,
  metadata?: { approverName?: string; rejectionReason?: string; oneNoteUrl?: string }
): Promise<void> {
  await logAuditEvent({
    action,
    userId,
    resourceType: "submission",
    resourceId: submissionId,
    metadata,
  });
}

/**
 * Log admin events
 */
export async function logAdminEvent(
  action: "AUDIT_LOG_VIEWED" | "DATA_EXPORTED" | "RETENTION_ENFORCED",
  userId: string,
  metadata?: Record<string, unknown>
): Promise<void> {
  await logAuditEvent({
    action,
    userId,
    resourceType: "system",
    metadata,
  });
}

/**
 * Sanitize user agent string to remove PII
 */
function sanitizeUserAgent(userAgent: string): string {
  // Truncate to reasonable length
  const truncated = userAgent.slice(0, 500);

  // Remove potential PII patterns
  return truncated
    .replace(/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/gi, "[UUID]") // UUIDs
    .replace(/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/g, "[EMAIL]"); // Email addresses
}

/**
 * Create a helper to log from server actions
 * Extracts common data like IP and user agent from headers
 */
export function createAuditLogger(
  headers: Headers,
  userId: string | null
) {
  const ipAddress = headers.get("x-forwarded-for") ||
    headers.get("x-real-ip") ||
    "unknown";
  const userAgent = headers.get("user-agent") || undefined;

  return {
    log: (action: AuditAction, resourceType: ResourceType, resourceId?: string, metadata?: Record<string, unknown>) =>
      logAuditEvent({
        action,
        userId,
        resourceType,
        resourceId,
        metadata,
        ipAddress: ipAddress || undefined,
        userAgent,
      }),
  };
}
