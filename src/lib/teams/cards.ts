/**
 * Adaptive Card templates for Teams bot
 */

export interface WarSubmissionData {
  weekOf: string;
  rawText: string;
}

export interface WarConfirmationData {
  terseText: string;
  editedTerseVersion?: string;
  accept: boolean;
}

/**
 * Get week options for the current and previous weeks
 */
export function getWeekOptions(): Array<{ title: string; value: string }> {
  const options = [];
  const now = new Date();
  
  // Current week and previous 3 weeks
  for (let i = 0; i < 4; i++) {
    const date = new Date(now.getTime() - i * 7 * 24 * 60 * 60 * 1000);
    const year = date.getFullYear();
    const weekNumber = getWeekNumber(date);
    const weekStart = getWeekStart(date);
    const weekLabel = weekStart.toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
    });
    
    options.push({
      title: `${year}-W${weekNumber.toString().padStart(2, "0")} (${weekLabel})`,
      value: `${year}-W${weekNumber}`,
    });
  }
  
  return options;
}

/**
 * WAR submission card - initial input
 */
export function createWarSubmissionCard(): unknown {
  const weekOptions = getWeekOptions();
  
  return {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "Submit Weekly Activity Report",
        weight: "Bolder",
        size: "Medium",
      },
      {
        type: "TextBlock",
        text: "Select the week and enter your verbose status update.",
        wrap: true,
        isSubtle: true,
      },
      {
        type: "Input.ChoiceSet",
        id: "weekOf",
        label: "Week of",
        isRequired: true,
        choices: weekOptions.map((opt) => ({
          title: opt.title,
          value: opt.value,
        })),
        value: weekOptions[0]?.value,
      },
      {
        type: "Input.Text",
        id: "rawText",
        label: "Your status update (verbose format)",
        placeholder: "e.g., This week I worked on...\n\nNext week I plan to...",
        isMultiline: true,
        maxLength: 2000,
        isRequired: true,
      },
    ],
    actions: [
      {
        type: "Action.Submit",
        title: "Convert to Terse",
        data: {
          action: "convert",
        },
      },
    ],
  };
}

/**
 * WAR confirmation card - after AI conversion
 */
export function createWarConfirmationCard(
  originalText: string,
  terseText: string,
  confidence: number
): unknown {
  const confidencePercent = Math.round(confidence * 100);
  const confidenceColor = confidence > 0.8 ? "Good" : confidence > 0.6 ? "Warning" : "Attention";
  
  return {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "Review AI Conversion",
        weight: "Bolder",
        size: "Medium",
      },
      {
        type: "TextBlock",
        text: `AI Confidence: ${confidencePercent}%`,
        color: confidenceColor,
        weight: "Bolder",
      },
      {
        type: "Container",
        style: "emphasis",
        items: [
          {
            type: "TextBlock",
            text: "AI Generated Terse Version:",
            weight: "Bolder",
          },
          {
            type: "TextBlock",
            text: terseText,
            wrap: true,
          },
        ],
      },
      {
        type: "Container",
        style: "accent",
        items: [
          {
            type: "TextBlock",
            text: "Original Text (click to expand):",
            weight: "Bolder",
          },
          {
            type: "TextBlock",
            text: originalText,
            wrap: true,
            isVisible: false,
            id: "originalText",
          },
        ],
        selectAction: {
          type: "Action.ToggleVisibility",
          targetElements: ["originalText"],
        },
      },
      {
        type: "Input.Text",
        id: "editedTerseVersion",
        label: "Edit terse version (optional)",
        placeholder: "Make edits to the AI-generated text if needed...",
        isMultiline: true,
        maxLength: 500,
        value: terseText,
      },
    ],
    actions: [
      {
        type: "Action.Submit",
        title: "✓ Submit WAR",
        style: "positive",
        data: {
          action: "submit",
          terseText,
          confidence,
        },
      },
      {
        type: "Action.Submit",
        title: "🔄 Regenerate",
        style: "default",
        data: {
          action: "regenerate",
          originalText,
        },
      },
      {
        type: "Action.Submit",
        title: "✕ Cancel",
        style: "destructive",
        data: {
          action: "cancel",
        },
      },
    ],
  };
}

/**
 * Success confirmation card
 */
export function createSuccessCard(submissionId: string, weekLabel: string): unknown {
  return {
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
        type: "TextBlock",
        text: `Week: ${weekLabel}`,
      },
      {
        type: "TextBlock",
        text: `Submission ID: ${submissionId}`,
        isSubtle: true,
        size: "Small",
      },
      {
        type: "TextBlock",
        text: "Your submission is now pending review. You'll be notified once it's processed.",
        wrap: true,
      },
    ],
    actions: [
      {
        type: "Action.Submit",
        title: "Submit Another WAR",
        data: {
          action: "new_submission",
        },
      },
    ],
  };
}

/**
 * Error card
 */
export function createErrorCard(errorMessage: string, canRetry: boolean = false): unknown {
  const card: Record<string, unknown> = {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "⚠ Submission Failed",
        weight: "Bolder",
        size: "Medium",
        color: "Attention",
      },
      {
        type: "TextBlock",
        text: errorMessage,
        wrap: true,
      },
    ],
  };

  if (canRetry) {
    card.actions = [
      {
        type: "Action.Submit",
        title: "Try Again",
        data: {
          action: "retry",
        },
      },
      {
        type: "Action.Submit",
        title: "Cancel",
        data: {
          action: "cancel",
        },
      },
    ];
  }

  return card;
}

/**
 * Help card
 */
export function createHelpCard(): unknown {
  return {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "📖 WAR Bot Help",
        weight: "Bolder",
        size: "Medium",
      },
      {
        type: "TextBlock",
        text: "Available Commands:",
        weight: "Bolder",
      },
      {
        type: "FactSet",
        facts: [
          {
            title: "/war",
            value: "Submit a new Weekly Activity Report",
          },
          {
            title: "/war status",
            value: "Check your submission status",
          },
          {
            title: "/war help",
            value: "Show this help message",
          },
          {
            title: "/war cancel",
            value: "Cancel current submission",
          },
        ],
      },
      {
        type: "TextBlock",
        text: "Tips for verbose format:",
        weight: "Bolder",
        spacing: "Medium",
      },
      {
        type: "TextBlock",
        text: "• This week I completed...\n• I also worked on...\n• Next week I plan to...\n• Blockers: none",
        wrap: true,
        isSubtle: true,
      },
      {
        type: "TextBlock",
        text: "Web Dashboard:",
        weight: "Bolder",
        spacing: "Medium",
      },
      {
        type: "TextBlock",
        text: process.env.NEXTAUTH_URL || "https://epa-business-platform.vercel.app",
        color: "Accent",
      },
    ],
  };
}

/**
 * Status card
 */
export function createStatusCard(
  pendingCount: number,
  approvedCount: number,
  recentSubmissions: Array<{ week: string; status: string }>
): unknown {
  return {
    type: "AdaptiveCard",
    version: "1.4",
    body: [
      {
        type: "TextBlock",
        text: "📊 Your WAR Status",
        weight: "Bolder",
        size: "Medium",
      },
      {
        type: "FactSet",
        facts: [
          {
            title: "Pending Review:",
            value: pendingCount.toString(),
          },
          {
            title: "Approved:",
            value: approvedCount.toString(),
          },
        ],
      },
      {
        type: "TextBlock",
        text: "Recent Submissions:",
        weight: "Bolder",
        spacing: "Medium",
      },
      ...recentSubmissions.map((sub) => ({
        type: "TextBlock",
        text: `• ${sub.week}: ${sub.status}`,
        size: "Small",
      })),
    ],
    actions: [
      {
        type: "Action.Submit",
        title: "Submit New WAR",
        data: {
          action: "new_submission",
        },
      },
    ],
  };
}

// Helper functions
function getWeekNumber(date: Date): number {
  const start = new Date(date.getFullYear(), 0, 1);
  const diff = date.getTime() - start.getTime();
  const oneWeek = 1000 * 60 * 60 * 24 * 7;
  return Math.floor(diff / oneWeek) + 1;
}

function getWeekStart(date: Date): Date {
  const day = date.getDay();
  const diff = date.getDate() - day + (day === 0 ? -6 : 1); // Adjust when day is Sunday
  return new Date(date.setDate(diff));
}
