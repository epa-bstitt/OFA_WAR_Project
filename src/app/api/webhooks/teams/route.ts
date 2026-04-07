import { NextRequest, NextResponse } from "next/server";
import { ActivityTypes } from "botbuilder";
import { getBotAdapter, isBotConfigured } from "@/lib/teams/bot";
import { handleMessage } from "@/lib/teams/commands";

/**
 * Teams bot webhook endpoint
 * POST /api/webhooks/teams
 */
export async function POST(request: NextRequest): Promise<NextResponse> {
  try {
    // Check if bot is configured
    if (!isBotConfigured()) {
      console.error("Bot not configured");
      return NextResponse.json(
        { error: "Bot not configured" },
        { status: 503 }
      );
    }

    // Parse the incoming activity
    const body = await request.json();

    // Get the bot adapter
    const adapter = getBotAdapter();

    // Process the activity
    await adapter.processActivity(body, async (context) => {
      const activity = context.activity;

      // Log activity for debugging
      if (process.env.NODE_ENV === "development") {
        console.log("Teams activity received:", {
          type: activity.type,
          text: activity.text,
          from: activity.from?.id,
          conversation: activity.conversation?.id,
        });
      }

      // Handle different activity types
      switch (activity.type) {
        case ActivityTypes.Message:
          await handleMessage(context);
          break;

        case ActivityTypes.ConversationUpdate:
          // Handle conversation updates (user added/removed)
          await handleConversationUpdate(context);
          break;

        case ActivityTypes.Invoke:
          // Handle adaptive card invokes
          await handleMessage(context);
          break;

        default:
          // Ignore other activity types
          console.log(`Unhandled activity type: ${activity.type}`);
      }
    });

    // Always return 200 to Teams to prevent retries
    return NextResponse.json({ success: true }, { status: 200 });
  } catch (error) {
    console.error("Error processing Teams webhook:", error);

    // Always return 200 to prevent Teams from retrying
    // The error is logged for debugging
    return NextResponse.json({ success: true }, { status: 200 });
  }
}

/**
 * Handle conversation update events
 */
async function handleConversationUpdate(context: unknown): Promise<void> {
  const turnContext = context as {
    activity: {
      membersAdded?: Array<{ id: string; name?: string }>;
      membersRemoved?: Array<{ id: string; name?: string }>;
      recipient?: { id: string };
    };
    sendActivity: (activity: unknown) => Promise<void>;
  };

  const { activity } = turnContext;

  // Handle members added
  if (activity.membersAdded && activity.membersAdded.length > 0) {
    for (const member of activity.membersAdded) {
      // Skip the bot itself
      if (member.id === activity.recipient?.id) {
        continue;
      }

      // Send welcome message
      await turnContext.sendActivity({
        type: ActivityTypes.Message,
        text: `Welcome! I'm the EPA WAR Bot. Type \`/war\` to submit a Weekly Activity Report, or \`/war help\` for more options.`,
      });
    }
  }
}

/**
 * Verify bot endpoint is accessible
 * GET /api/webhooks/teams
 */
export async function GET(): Promise<NextResponse> {
  return NextResponse.json({
    status: "Teams bot webhook endpoint",
    configured: isBotConfigured(),
    timestamp: new Date().toISOString(),
  });
}
