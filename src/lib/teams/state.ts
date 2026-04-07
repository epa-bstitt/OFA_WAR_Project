/**
 * Conversation state management for Teams bot
 */

export interface WarSubmissionState {
  userId: string;
  teamsUserId: string;
  conversationId: string;
  step: "idle" | "awaiting_input" | "awaiting_confirmation" | "completed" | "error";
  weekOf?: string;
  rawText?: string;
  terseText?: string;
  aiConfidence?: number;
  submissionId?: string;
  errorMessage?: string;
  lastActivity: Date;
}

// In-memory state storage (use Redis in production)
const conversationStates = new Map<string, WarSubmissionState>();

// Timeout after 30 minutes of inactivity
const INACTIVITY_TIMEOUT = 30 * 60 * 1000;

/**
 * Get or create state for a conversation
 */
export function getState(conversationId: string, teamsUserId: string): WarSubmissionState {
  const existing = conversationStates.get(conversationId);
  
  if (existing && existing.teamsUserId === teamsUserId) {
    // Update last activity
    existing.lastActivity = new Date();
    return existing;
  }
  
  // Create new state
  const newState: WarSubmissionState = {
    userId: "", // Will be set when user is authenticated
    teamsUserId,
    conversationId,
    step: "idle",
    lastActivity: new Date(),
  };
  
  conversationStates.set(conversationId, newState);
  return newState;
}

/**
 * Update state for a conversation
 */
export function updateState(
  conversationId: string,
  updates: Partial<WarSubmissionState>
): WarSubmissionState | null {
  const existing = conversationStates.get(conversationId);
  
  if (!existing) {
    return null;
  }
  
  const updated = {
    ...existing,
    ...updates,
    lastActivity: new Date(),
  };
  
  conversationStates.set(conversationId, updated);
  return updated;
}

/**
 * Clear state for a conversation
 */
export function clearState(conversationId: string): void {
  conversationStates.delete(conversationId);
}

/**
 * Check if user has active submission
 */
export function hasActiveSubmission(conversationId: string): boolean {
  const state = conversationStates.get(conversationId);
  
  if (!state) {
    return false;
  }
  
  // Check for timeout
  const now = new Date();
  if (now.getTime() - state.lastActivity.getTime() > INACTIVITY_TIMEOUT) {
    conversationStates.delete(conversationId);
    return false;
  }
  
  return state.step !== "idle" && state.step !== "completed" && state.step !== "error";
}

/**
 * Get active submission state
 */
export function getActiveSubmission(conversationId: string): WarSubmissionState | null {
  if (!hasActiveSubmission(conversationId)) {
    return null;
  }
  
  return conversationStates.get(conversationId) || null;
}

/**
 * Clean up old states (call periodically)
 */
export function cleanupOldStates(): number {
  const now = new Date();
  let cleaned = 0;
  
  const entries = Array.from(conversationStates.entries());
  for (const [id, state] of entries) {
    if (now.getTime() - state.lastActivity.getTime() > INACTIVITY_TIMEOUT) {
      conversationStates.delete(id);
      cleaned++;
    }
  }
  
  return cleaned;
}

/**
 * Get all active states for a user
 */
export function getUserStates(teamsUserId: string): WarSubmissionState[] {
  const states: WarSubmissionState[] = [];
  
  const allStates = Array.from(conversationStates.values());
  for (const state of allStates) {
    if (state.teamsUserId === teamsUserId) {
      states.push(state);
    }
  }
  
  return states;
}

/**
 * Cancel all active submissions for a user
 */
export function cancelUserSubmissions(teamsUserId: string): number {
  let cancelled = 0;
  
  const entries = Array.from(conversationStates.entries());
  for (const [id, state] of entries) {
    if (state.teamsUserId === teamsUserId && hasActiveSubmission(id)) {
      conversationStates.delete(id);
      cancelled++;
    }
  }
  
  return cancelled;
}
