import { CardFactory, TurnContext } from "botbuilder";
import { prisma } from "@/lib/db";
import { getBotAdapter } from "./bot";
import type { ConversationReference } from "botbuilder";

// In-memory store for conversation references (use Redis in production)
const conversationReferences = new Map<string, ConversationReference>();

// Notification types
export type NotificationType = 
  | "SUBMISSION_RECEIVED"
  | "SUBMISSION_APPROVED"
  | "SUBMISSION_REJECTED"
  | "SUBMISSION_PUBLISHED";

interface NotificationPayload {
  userId: string;
  type: NotificationType;
  submissionId: string;
  weekOf?: string;
  approverName?: string;
  rejectionReason?: string;
  oneNoteUrl?: string;
}

/**
 * Store conversation reference when user interacts with bot
 */
export async function storeConversationReference(
  userId: string,
  reference: ConversationReference
): Promise<void> {
  conversationReferences.set(userId, reference);
  
  // Also store in database for persistence
  await prisma.user.update({
    where: { id: userId },
    data: {
      teamsConversationId: reference.conversation.id,
      teamsConversationReference: JSON.stringify(reference),
    },
  });
}

/**
 * Get conversation reference for user
 */
export async function getConversationReference(
  userId: string
): Promise<ConversationReference | null> {
  // Check in-memory cache first
  const cached = conversationReferences.get(userId);
  if (cached) {
    return cached;
  }
  
  // Fetch from database
  const user = await prisma.user.findUnique({
    where: { id: userId },
    select: { teamsConversationReference: true },
  });
  
  if (user?.teamsConversationReference) {
    try {
      const reference = JSON.parse(user.teamsConversationReference) as ConversationReference;
      conversationReferences.set(userId, reference);
      return reference;
    } catch {
      return null;
    }
  }
  
  return null;
}

/**
 * Check if user has Teams notifications enabled
 */
export async function hasTeamsNotificationsEnabled(userId: string): Promise<boolean> {
  const user = await prisma.user.findUnique({
    where: { id: userId },
    select: { 
      teamsNotificationsEnabled: true,
      teamsConversationReference: true,
    },
  });
  
  return user?.teamsNotificationsEnabled === true && !!user?.teamsConversationReference;
}

/**
 * Send notification to user via Teams
 */
export async function sendTeamsNotification(
  userId: string,
  card: unknown
): Promise<{ success: boolean; error?: string }> {
  try {
    // Check if notifications are enabled
    const enabled = await hasTeamsNotificationsEnabled(userId);
    if (!enabled) {
      return { success: false, error: "Notifications not enabled for user" };
    }
    
    // Get conversation reference
    const reference = await getConversationReference(userId);
    if (!reference) {
      return { success: false, error: "No conversation reference found" };
    }
    
    // Get bot adapter
    const adapter = getBotAdapter();
    
    // Send proactive message
    await adapter.continueConversation(reference, async (context: TurnContext) => {
      await context.sendActivity({
        attachments: [CardFactory.adaptiveCard(card)],
      });
    });
    
    // Log successful notification
    await logNotification(userId, "SENT", card);
    
    return { success: true };
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : "Unknown error";
    console.error(`Failed to send Teams notification to ${userId}:`, errorMessage);
    
    // Log failed notification
    await logNotification(userId, "FAILED", card, errorMessage);
    
    return { success: false, error: errorMessage };
  }
}

/**
 * Log notification attempt
 */
async function logNotification(
  userId: string,
  status: "SENT" | "FAILED" | "SKIPPED",
  card: unknown,
  error?: string
): Promise<void> {
  try {
    await prisma.notification.create({
      data: {
        userId,
        type: "TEAMS",
        status,
        content: JSON.stringify(card),
        error,
      },
    });
  } catch (err) {
    console.error("Failed to log notification:", err);
  }
}

/**
 * Send submission received notification
 */
export async function sendSubmissionReceived(
  userId: string,
  submissionId: string,
  weekOf: string
): Promise<void> {
  const card = {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "✓ WAR Submitted Successfully",
        weight: "Bolder",
        size: "Medium",
        color: "Good",
      },
      {
        type: "FactSet",
        facts: [
          { title: "Week:", value: weekOf },
          { title: "ID:", value: submissionId },
        ],
      },
      {
        type: "TextBlock",
        text: "Your submission is now pending review. You'll be notified when it's processed.",
        wrap: true,
      },
    ],
    actions: [
      {
        type: "Action.OpenUrl",
        title: "View on Web",
        url: `${process.env.NEXTAUTH_URL}/submissions/${submissionId}`,
      },
    ],
  };
  
  // Don't await - fire and forget
  sendTeamsNotification(userId, card).catch(console.error);
}

/**
 * Send submission approved notification
 */
export async function sendSubmissionApproved(
  userId: string,
  submissionId: string,
  weekOf: string,
  approverName: string
): Promise<void> {
  const card = {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "✓ WAR Approved",
        weight: "Bolder",
        size: "Medium",
        color: "Good",
      },
      {
        type: "FactSet",
        facts: [
          { title: "Week:", value: weekOf },
          { title: "Approved by:", value: approverName },
        ],
      },
      {
        type: "TextBlock",
        text: "Your submission has been approved and will be published to OneNote soon.",
        wrap: true,
      },
    ],
    actions: [
      {
        type: "Action.OpenUrl",
        title: "View Details",
        url: `${process.env.NEXTAUTH_URL}/submissions/${submissionId}`,
      },
    ],
  };
  
  sendTeamsNotification(userId, card).catch(console.error);
}

/**
 * Send submission rejected notification
 */
export async function sendSubmissionRejected(
  userId: string,
  submissionId: string,
  weekOf: string,
  reason: string
): Promise<void> {
  const card = {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "⚠ WAR Needs Revision",
        weight: "Bolder",
        size: "Medium",
        color: "Attention",
      },
      {
        type: "FactSet",
        facts: [
          { title: "Week:", value: weekOf },
        ],
      },
      {
        type: "TextBlock",
        text: "Rejection Reason:",
        weight: "Bolder",
      },
      {
        type: "TextBlock",
        text: reason,
        wrap: true,
      },
      {
        type: "TextBlock",
        text: "Please edit and resubmit your WAR.",
        wrap: true,
      },
    ],
    actions: [
      {
        type: "Action.OpenUrl",
        title: "Edit WAR",
        url: `${process.env.NEXTAUTH_URL}/submissions/${submissionId}/edit`,
      },
    ],
  };
  
  sendTeamsNotification(userId, card).catch(console.error);
}

/**
 * Send submission published notification
 */
export async function sendSubmissionPublished(
  userId: string,
  submissionId: string,
  weekOf: string,
  oneNoteUrl?: string
): Promise<void> {
  const actions: unknown[] = [
    {
      type: "Action.OpenUrl",
      title: "View on Web",
      url: `${process.env.NEXTAUTH_URL}/submissions/${submissionId}`,
    },
  ];
  
  if (oneNoteUrl) {
    actions.unshift({
      type: "Action.OpenUrl",
      title: "View in OneNote",
      url: oneNoteUrl,
    });
  }
  
  const card = {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "🎉 WAR Published to OneNote",
        weight: "Bolder",
        size: "Medium",
        color: "Good",
      },
      {
        type: "FactSet",
        facts: [
          { title: "Week:", value: weekOf },
        ],
      },
      {
        type: "TextBlock",
        text: "Your submission has been published and is now available in OneNote.",
        wrap: true,
      },
    ],
    actions,
  };
  
  sendTeamsNotification(userId, card).catch(console.error);
}

/**
 * Send urgent mention notification
 */
export async function sendUrgentMention(
  userId: string,
  message: string
): Promise<void> {
  const card = {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "🔔 Urgent: Action Required",
        weight: "Bolder",
        size: "Medium",
        color: "Attention",
      },
      {
        type: "TextBlock",
        text: message,
        wrap: true,
      },
    ],
    actions: [
      {
        type: "Action.OpenUrl",
        title: "Go to Dashboard",
        url: `${process.env.NEXTAUTH_URL}/dashboard`,
      },
    ],
  };
  
  sendTeamsNotification(userId, card).catch(console.error);
}

/**
 * Queue notification for async processing
 */
export function queueNotification(
  fn: () => Promise<void>
): void {
  // Fire and forget - don't block the main flow
  fn().catch((error) => {
    console.error("Queued notification failed:", error);
  });
}
