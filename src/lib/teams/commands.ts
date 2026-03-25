import { TurnContext, ActivityTypes } from "botbuilder";
import {
  createWarSubmissionCard,
  createWarConfirmationCard,
  createSuccessCard,
  createErrorCard,
  createHelpCard,
  createStatusCard,
  type WarSubmissionData,
  type WarConfirmationData,
} from "./cards";
import {
  getState,
  updateState,
  clearState,
  hasActiveSubmission,
  cancelUserSubmissions,
  type WarSubmissionState,
} from "./state";

// Import AI conversion and submission actions
// These will be imported when implementing full functionality
// import { convertToTerse } from "@/lib/ai/conversion";
// import { submitWAR } from "@/app/actions/submissions";

/**
 * Handle incoming Teams message
 */
export async function handleMessage(context: TurnContext): Promise<void> {
  const activity = context.activity;
  const text = activity.text?.trim().toLowerCase() || "";
  const conversationId = activity.conversation.id;
  const teamsUserId = activity.from.id;
  
  // Get or create state
  const state = getState(conversationId, teamsUserId);
  
  // Check for commands
  if (text.startsWith("/war ")) {
    const command = text.slice(5).trim();
    
    if (command === "help") {
      await handleHelp(context);
    } else if (command === "status") {
      await handleStatus(context, state);
    } else if (command === "cancel") {
      await handleCancel(context, conversationId, teamsUserId);
    } else {
      // Unknown subcommand, show help
      await handleHelp(context);
    }
    return;
  }
  
  if (text === "/war") {
    // Start new WAR submission
    if (hasActiveSubmission(conversationId)) {
      await context.sendActivity({
        type: ActivityTypes.Message,
        text: "You already have an active submission. Type `/war cancel` to start fresh.",
      });
      return;
    }
    
    await handleNewSubmission(context, conversationId, teamsUserId);
    return;
  }
  
  // Check for adaptive card submit
  if (activity.value && typeof activity.value === "object") {
    const action = (activity.value as Record<string, unknown>).action as string;
    
    switch (action) {
      case "convert":
        await handleConvert(context, activity.value as WarSubmissionData, state);
        break;
      case "submit":
        await handleSubmit(context, activity.value as WarConfirmationData, state);
        break;
      case "regenerate":
        await handleRegenerate(context, activity.value as Record<string, string>, state);
        break;
      case "cancel":
        await handleCancel(context, conversationId, teamsUserId);
        break;
      case "retry":
        await handleNewSubmission(context, conversationId, teamsUserId);
        break;
      case "new_submission":
        await handleNewSubmission(context, conversationId, teamsUserId);
        break;
      default:
        // Unknown action
        await context.sendActivity({
          type: ActivityTypes.Message,
          text: "I didn't understand that action. Type `/war help` for assistance.",
        });
    }
    return;
  }
  
  // Default response for unrecognized messages
  await context.sendActivity({
    type: ActivityTypes.Message,
    text: "Hi! I'm the EPA WAR Bot. Type `/war` to submit a Weekly Activity Report, or `/war help` for more options.",
  });
}

/**
 * Handle /war help command
 */
async function handleHelp(context: TurnContext): Promise<void> {
  const card = createHelpCard();
  await context.sendActivity({
    type: ActivityTypes.Message,
    attachments: [
      {
        contentType: "application/vnd.microsoft.card.adaptive",
        content: card,
      },
    ],
  });
}

/**
 * Handle /war status command
 */
async function handleStatus(
  context: TurnContext,
  state: WarSubmissionState
): Promise<void> {
  // Mock data - in production, fetch from database
  const pendingCount = state.step !== "idle" && state.step !== "completed" ? 1 : 0;
  const approvedCount = 0;
  const recentSubmissions: Array<{ week: string; status: string }> = [];
  
  if (state.weekOf) {
    recentSubmissions.push({
      week: state.weekOf,
      status: state.step === "completed" ? "Submitted" : "In Progress",
    });
  }
  
  const card = createStatusCard(pendingCount, approvedCount, recentSubmissions);
  await context.sendActivity({
    type: ActivityTypes.Message,
    attachments: [
      {
        contentType: "application/vnd.microsoft.card.adaptive",
        content: card,
      },
    ],
  });
}

/**
 * Handle /war cancel command
 */
async function handleCancel(
  context: TurnContext,
  conversationId: string,
  teamsUserId: string
): Promise<void> {
  const cancelled = cancelUserSubmissions(teamsUserId);
  clearState(conversationId);
  
  await context.sendActivity({
    type: ActivityTypes.Message,
    text: cancelled > 0
      ? `Cancelled ${cancelled} active submission(s). You can start fresh with \`/war\`.`
      : "No active submissions to cancel.",
  });
}

/**
 * Handle new WAR submission
 */
async function handleNewSubmission(
  context: TurnContext,
  conversationId: string,
  teamsUserId: string
): Promise<void> {
  // Reset state
  updateState(conversationId, {
    step: "awaiting_input",
    weekOf: undefined,
    rawText: undefined,
    terseText: undefined,
    aiConfidence: undefined,
    submissionId: undefined,
    errorMessage: undefined,
  });
  
  const card = createWarSubmissionCard();
  await context.sendActivity({
    type: ActivityTypes.Message,
    attachments: [
      {
        contentType: "application/vnd.microsoft.card.adaptive",
        content: card,
      },
    ],
  });
}

/**
 * Handle convert action (from adaptive card)
 */
async function handleConvert(
  context: TurnContext,
  data: WarSubmissionData,
  state: WarSubmissionState
): Promise<void> {
  try {
    // Update state
    updateState(state.conversationId, {
      step: "awaiting_confirmation",
      weekOf: data.weekOf,
      rawText: data.rawText,
    });
    
    // Mock AI conversion - in production, call convertToTerse
    // const result = await convertToTerse(data.rawText);
    // For now, mock result
    const mockResult = {
      success: true,
      terseText: mockConvertToTerse(data.rawText),
      confidence: 0.85,
    };
    
    if (!mockResult.success) {
      const errorCard = createErrorCard("AI conversion failed. Please try again.", true);
      await context.sendActivity({
        type: ActivityTypes.Message,
        attachments: [
          {
            contentType: "application/vnd.microsoft.card.adaptive",
            content: errorCard,
          },
        ],
      });
      return;
    }
    
    // Update state with converted text
    updateState(state.conversationId, {
      terseText: mockResult.terseText,
      aiConfidence: mockResult.confidence,
    });
    
    // Send confirmation card
    const confirmCard = createWarConfirmationCard(
      data.rawText,
      mockResult.terseText,
      mockResult.confidence
    );
    await context.sendActivity({
      type: ActivityTypes.Message,
      attachments: [
        {
          contentType: "application/vnd.microsoft.card.adaptive",
          content: confirmCard,
        },
      ],
    });
  } catch (error) {
    console.error("Error in handleConvert:", error);
    const errorCard = createErrorCard("Something went wrong. Please try again.", true);
    await context.sendActivity({
      type: ActivityTypes.Message,
      attachments: [
        {
          contentType: "application/vnd.microsoft.card.adaptive",
          content: errorCard,
        },
      ],
    });
  }
}

/**
 * Handle submit action (from adaptive card)
 */
async function handleSubmit(
  context: TurnContext,
  data: WarConfirmationData,
  state: WarSubmissionState
): Promise<void> {
  try {
    if (!state.weekOf || !state.rawText) {
      throw new Error("Missing submission data");
    }
    
    const finalTerseText = data.editedTerseVersion || data.terseText;
    
    // Mock submission - in production, call submitWAR server action
    // const result = await submitWAR({...});
    
    // Generate mock submission ID
    const submissionId = `TEAMS-${Date.now()}`;
    
    // Update state
    updateState(state.conversationId, {
      step: "completed",
      submissionId,
    });
    
    // Send success card
    const successCard = createSuccessCard(submissionId, state.weekOf);
    await context.sendActivity({
      type: ActivityTypes.Message,
      attachments: [
        {
          contentType: "application/vnd.microsoft.card.adaptive",
          content: successCard,
        },
      ],
    });
  } catch (error) {
    console.error("Error in handleSubmit:", error);
    const errorCard = createErrorCard(
      "Failed to submit WAR. Please try again or use the web app.",
      true
    );
    await context.sendActivity({
      type: ActivityTypes.Message,
      attachments: [
        {
          contentType: "application/vnd.microsoft.card.adaptive",
          content: errorCard,
        },
      ],
    });
  }
}

/**
 * Handle regenerate action (from adaptive card)
 */
async function handleRegenerate(
  context: TurnContext,
  data: Record<string, string>,
  state: WarSubmissionState
): Promise<void> {
  // For now, just show the input card again
  // In production, could use a different prompt or approach
  await handleNewSubmission(context, state.conversationId, state.teamsUserId);
}

/**
 * Mock AI conversion for development
 */
function mockConvertToTerse(rawText: string): string {
  // Simple mock that extracts key sentences
  const sentences = rawText
    .split(/[.!?]+/)
    .map((s) => s.trim())
    .filter((s) => s.length > 10);
  
  if (sentences.length === 0) {
    return "No activity reported.";
  }
  
  // Take first 2-3 sentences and abbreviate
  const keyPoints = sentences.slice(0, 3).map((s) => {
    // Remove filler words
    return s
      .replace(/\b(this week|i|we|have|been|working on)\b/gi, "")
      .trim();
  });
  
  return keyPoints.join("; ") + ".";
}
