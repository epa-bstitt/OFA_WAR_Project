import { BotFrameworkAdapter, TurnContext, ActivityTypes } from "botbuilder";

// Bot Framework adapter configuration
const adapter = new BotFrameworkAdapter({
  appId: process.env.BOT_APP_ID,
  appPassword: process.env.BOT_APP_PASSWORD,
});

// Error handling middleware
adapter.onTurnError = async (context: TurnContext, error: Error) => {
  console.error("Bot error:", error);
  
  // Send error message to user
  await context.sendActivity({
    type: ActivityTypes.Message,
    text: "Sorry, something went wrong. Please try again or contact support.",
  });
};

/**
 * Get the configured Bot Framework adapter
 */
export function getBotAdapter(): BotFrameworkAdapter {
  if (!process.env.BOT_APP_ID || !process.env.BOT_APP_PASSWORD) {
    throw new Error("Bot credentials not configured");
  }
  return adapter;
}

/**
 * Check if bot is configured
 */
export function isBotConfigured(): boolean {
  return !!(
    process.env.BOT_APP_ID &&
    process.env.BOT_APP_PASSWORD
  );
}

export { adapter };
export type { TurnContext, ActivityTypes };
