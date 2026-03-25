# Story 5.1: Teams Bot Setup & Commands

Status: ready-for-dev
Created: 2026-02-19
Epic: Microsoft Teams Integration (Epic 5)
Depends On: Story 1.2 (EPA MAX Authentication Integration)

---

## Story

As a WAR contributor,  
I want to submit my WAR through Teams using a bot command,  
so that I don't need to switch to a web browser.

---

## Acceptance Criteria

- [ ] **AC1:** Bot Framework v4 bot registered and configured
- [ ] **AC2:** `/war` command recognized
- [ ] **AC3:** Adaptive Card for text input displayed
- [ ] **AC4:** AI conversion via bot
- [ ] **AC5:** Submission confirmation in Teams
- [ ] **AC6:** Error handling for bot failures

---

## Tasks / Subtasks

### Task 1: Set Up Bot Framework (AC: #1)
- [ ] **1.1** Install Bot Framework: `npm install botbuilder`
- [ ] **1.2** Create `src/lib/teams/bot.ts`:
  - Bot adapter configuration
  - MicrosoftAppCredentials setup
  - Error handling middleware
- [ ] **1.3** Configure environment variables:
  ```
  BOT_APP_ID=""
  BOT_APP_PASSWORD=""
  BOT_CHANNEL_REGISTRATION=""
  ```
- [ ] **1.4** Register bot in Azure:
  - Azure Bot resource
  - Microsoft Teams channel enabled
  - Messaging endpoint configured

### Task 2: Create Webhook Endpoint (AC: #1)
- [ ] **2.1** Create `src/app/api/webhooks/teams/route.ts`:
  - POST handler for bot messages
  - Adapter processActivity
  - Route to appropriate handler
- [ ] **2.2** Implement message handler:
  - Parse Teams activity
  - Identify command vs conversation
  - Extract user context
- [ ] **2.3** Add authentication:
  - Verify bot token
  - Validate request from Microsoft
- [ ] **2.4** Add error handling:
  - Log errors
  - Return 200 to Teams (prevent retries)
  - Graceful degradation

### Task 3: Implement `/war` Command (AC: #2)
- [ ] **3.1** Register command in Azure:
  - Bot command manifest
  - `/war` - Submit Weekly Activity Report
- [ ] **3.2** Create command handler:
  ```typescript
  if (context.activity.text?.startsWith('/war')) {
    await handleWarCommand(context);
  }
  ```
- [ ] **3.3** Validate user:
  - Extract Teams user ID
  - Map to EPA MAX user (if possible)
  - Check authorization
- [ ] **3.4** Handle command in DM vs channel:
  - Prefer DM for privacy
  - Respond in channel if mentioned

### Task 4: Build Adaptive Card Interface (AC: #3)
- [ ] **4.1** Create `src/lib/teams/cards.ts`:
  - Adaptive Card JSON templates
  - Week selector dropdown
  - Multi-line text input for WAR
  - Submit button
- [ ] **4.2** Design WAR submission card:
  ```json
  {
    "type": "AdaptiveCard",
    "body": [
      {
        "type": "TextBlock",
        "text": "Submit Weekly Activity Report"
      },
      {
        "type": "Input.ChoiceSet",
        "id": "weekOf",
        "label": "Week of"
      },
      {
        "type": "Input.Text",
        "id": "rawText",
        "label": "Your status update (verbose format)",
        "isMultiline": true
      }
    ],
    "actions": [
      {
        "type": "Action.Submit",
        "title": "Submit WAR"
      }
    ]
  }
  ```
- [ ] **4.3** Handle card submission:
  - Parse adaptive card response
  - Extract week and text values
  - Validate input
- [ ] **4.4** Add card refresh:
  - Update card after AI conversion
  - Show terse version
  - Confirm before final submit

### Task 5: Integrate AI Conversion (AC: #4)
- [ ] **5.1** Call AI service from bot:
  - Reuse `convertToTerse()` from web
  - Same timeout and retry logic
  - Cache results
- [ ] **5.2** Show AI conversion card:
  - Original text (collapsed)
  - Terse version (expanded)
  - Edit button
  - Confidence score
- [ ] **5.3** Handle manual edit:
  - Text input for manual terse
  - Use AI button to regenerate
- [ ] **5.4** Store AI metadata:
  - Same as web submission
  - Track isAiGenerated flag

### Task 6: Create Submission Flow (AC: #5, #6)
- [ ] **6.1** Create submission via bot:
  - Call `submitWAR` Server Action
  - Pass Teams user context
  - Store Teams conversation ID
- [ ] **6.2** Show confirmation card:
  - Success message
  - Submission ID
  - Week confirmed
  - Link to web dashboard (optional)
- [ ] **6.3** Handle errors:
  - Validation errors → Show inline
  - Service errors → Friendly message + retry
  - Auth errors → "Please sign in on the web first"
- [ ] **6.4** Add retry option:
  - "Try again" button on error
  - Preserve input values
  - Clear error state

### Task 7: Store Conversation State (Supporting all ACs)
- [ ] **7.1** Create `src/lib/teams/state.ts`:
  - Conversation state storage
  - User state (current submission)
  - In-memory or Redis
- [ ] **7.2** Track active submissions:
  - Multi-step conversation flow
  - User can have multiple in-progress
  - Timeout after 30 minutes of inactivity
- [ ] **7.3** Handle conversation restart:
  - Welcome message on first contact
  - Help command (`/war help`)
  - Current status command

### Task 8: Add Help & Commands (Supporting all ACs)
- [ ] **8.1** Create `/war help` command:
  - Show usage instructions
  - Example verbose format
  - Link to web app
- [ ] **8.2** Create `/war status` command:
  - Show user's pending submissions
  - Recent submission status
- [ ] **8.3** Create `/war cancel` command:
  - Cancel in-progress submission
  - Clear conversation state

---

## Dev Notes

### Architecture Compliance

**Bot Service Pattern:**
```typescript
// Webhook endpoint
export async function POST(req: Request) {
  const body = await req.json();
  
  await adapter.processActivity(body, async (context) => {
    if (context.activity.type === ActivityTypes.Message) {
      await handleMessage(context);
    }
  });
  
  return new Response('', { status: 200 });
}
```

**Teams Activity Types:**
- `message` - User sends text
- `invoke` - Adaptive card submit
- `conversationUpdate` - User joins/leaves

### Previous Story Intelligence

**From Story 2.2:**
- AI conversion service exists
- Can reuse for Teams
- Same prompt templates

**Key Integration Points:**
- Reuse AI service abstraction
- Reuse submission validation
- Reuse database models

---

## Project Structure Notes

### Files to Create

```
src/
├── lib/
│   └── teams/
│       ├── bot.ts
│       ├── cards.ts
│       ├── state.ts
│       └── commands.ts
├── app/
│   └── api/
│       └── webhooks/
│           └── teams/
│               └── route.ts
└── app/
    └── actions/
        └── submissions.ts (update for Teams)
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Bot Framework configured
- [ ] Webhook endpoint receiving messages
- [ ] `/war` command responding
- [ ] Adaptive Card displaying correctly
- [ ] AI conversion working in Teams
- [ ] Submission confirmation sent
- [ ] Error handling graceful
- [ ] Ready for Story 5.2: Teams Notifications

**Next Story Dependencies:**
- Story 5.2 requires: Bot able to send proactive messages
