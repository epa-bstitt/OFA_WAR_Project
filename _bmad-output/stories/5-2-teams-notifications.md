# Story 5.2: Teams Notifications

Status: ready-for-dev
Created: 2026-02-19
Epic: Microsoft Teams Integration (Epic 5)
Depends On: Story 5.1 (Teams Bot Setup & Commands)

---

## Story

As a WAR contributor,  
I want to receive Teams notifications about my submission status,  
so that I'm informed of progress without checking email.

---

## Acceptance Criteria

- [ ] **AC1:** Notification on submission received
- [ ] **AC2:** Notification when approved/rejected
- [ ] **AC3:** Notification when published to OneNote
- [ ] **AC4:** @mentions for urgent items
- [ ] **AC5:** Notification preferences (opt-out option)
- [ ] **AC6:** Digest mode (daily summary option)

---

## Tasks / Subtasks

### Task 1: Create Notification Service (AC: #1, #2, #3)
- [ ] **1.1** Create `src/lib/teams/notifications.ts`:
  - `sendNotification(userId, message)` - Core send function
  - `sendSubmissionReceived(user, submission)`
  - `sendSubmissionApproved(user, submission)`
  - `sendSubmissionRejected(user, submission, reason)`
  - `sendSubmissionPublished(user, submission, oneNoteUrl)`
- [ ] **1.2** Store Teams conversation references:
  - User ID → Conversation ID mapping
  - Store in User model or separate table
  - Update when user interacts with bot
- [ ] **1.3** Create notification cards:
  - Adaptive Cards for each notification type
  - Consistent EPA branding
  - Action buttons (View Details, Go to Dashboard)
- [ ] **1.4** Handle proactive messaging:
  - Use Bot Framework proactive messaging
  - Continue conversation from stored reference
  - Handle errors gracefully

### Task 2: Trigger Notifications from Workflow (AC: #1, #2, #3)
- [ ] **2.1** Add to `submitWAR` Server Action:
  - After successful submission
  - Queue notification async
  - Don't block submission response
- [ ] **2.2** Add to `approveSubmission` Server Action:
  - After approval
  - Send approval notification
  - Include approver name
- [ ] **2.3** Add to `rejectSubmission` Server Action:
  - After rejection
  - Include rejection reason
  - Offer resubmission guidance
- [ ] **2.4** Add to `publishToOneNote` Server Action:
  - After publication
  - Include OneNote link
  - Congratulatory message
- [ ] **2.5** Use background processing:
  - Don't await notification send
  - Queue for retry on failure
  - Log all notification attempts

### Task 3: Build Notification Cards (AC: #1, #2, #3)
- [ ] **3.1** Create received card:
  - Title: "WAR Submitted Successfully"
  - Week of [Date]
  - Submission ID
  - "You'll be notified when reviewed"
  - Link to view on web
- [ ] **3.2** Create approved card:
  - Title: "WAR Approved"
  - Green checkmark icon
  - Week of [Date]
  - Approved by [Name]
  - Next step: "Will publish to OneNote soon"
- [ ] **3.3** Create rejected card:
  - Title: "WAR Needs Revision"
  - Red warning icon
  - Week of [Date]
  - Rejection reason
  - "Edit and resubmit" button
  - Link to edit on web
- [ ] **3.4** Create published card:
  - Title: "WAR Published to OneNote"
  - Celebration icon
  - Week of [Date]
  - "View in OneNote" button
  - Link to page

### Task 4: Implement @Mentions (AC: #4)
- [ ] **4.1** Add urgent mention logic:
  - Rejected submissions → @mention user
  - Overdue items (>7 days in review) → @mention
  - Critical system issues → @mention all admins
- [ ] **4.2** Create mention format:
  - Teams mention: `<at>${userName}</at>`
  - Include in card text
- [ ] **4.3** Add priority levels:
  - High: @mention + card
  - Normal: Card only
  - Low: Digest only

### Task 5: Create Notification Preferences (AC: #5)
- [ ] **5.1** Add to User model:
  - `teamsNotificationsEnabled: Boolean`
  - `notificationPreferences: Json`
  - `digestMode: Boolean`
- [ ] **5.2** Create settings page:
  - `src/app/(dashboard)/settings/notifications/page.tsx`
  - Toggle for Teams notifications
  - Opt-out option
- [ ] **5.3** Store preferences:
  - Update User record
  - Apply immediately
- [ ] **5.4** Respect opt-out:
  - Check before sending
  - Skip if disabled
  - Log opt-out in audit

### Task 6: Implement Digest Mode (AC: #6)
- [ ] **6.1** Create digest scheduler:
  - Daily at 9am (configurable)
  - Aggregate notifications
  - Create summary card
- [ ] **6.2** Build digest content:
  - "Your Daily WAR Summary"
  - List of updates (approved, rejected, published)
  - Count of each type
  - Action links
- [ ] **6.3** Create digest queue:
  - Store notifications if digest mode on
  - Flush at scheduled time
  - Clear queue after send
- [ ] **6.4** Add manual digest:
  - "Send me a summary now" button
  - On-demand digest generation

### Task 7: Handle Failed Notifications (Supporting all ACs)
- [ ] **7.1** Add retry logic:
  - Exponential backoff
  - Max 3 retries
  - Log failures
- [ ] **7.2** Handle user not found:
  - User removed from Teams
  - Update preferences to disabled
  - Alert admin
- [ ] **7.3** Handle bot not installed:
  - User hasn't added bot
  - Send email fallback (if configured)
  - Show warning in web app
- [ ] **7.4** Notification log:
  - Track all sends
  - Success/failure status
  - Retry count

### Task 8: Add Notification History (Supporting all ACs)
- [ ] **8.1** Create `src/app/(dashboard)/notifications/page.tsx`:
  - List of all notifications sent
  - Filter by type, date, status
  - Mark as read
- [ ] **8.2** Store notification history:
  - Notification table
  - User, type, content, timestamp, status
- [ ] **8.3** Show unread count:
  - Badge on navigation
  - Dashboard widget

---

## Dev Notes

### Architecture Compliance

**Proactive Messaging Pattern:**
```typescript
const conversationReference = await getConversationRef(userId);

await adapter.continueConversation(conversationReference, async (context) => {
  await context.sendActivity({
    attachments: [CardFactory.adaptiveCard(notificationCard)]
  });
});
```

**Async Notification Queue:**
```typescript
// Don't await in main flow
queueNotification(() => sendTeamsNotification(user, message));
```

### Previous Story Intelligence

**From Story 5.1:**
- Bot configured
- Can send proactive messages
- Conversation references stored

**Key Integration Points:**
- Trigger from workflow actions
- Use existing bot infrastructure
- Extend user preferences

---

## Project Structure Notes

### Files to Create/Update

**New Files:**
```
src/
├── lib/
│   └── teams/
│       └── notifications.ts
├── app/
│   └── (dashboard)/
│       ├── settings/
│       │   └── notifications/
│       │       └── page.tsx
│       └── notifications/
│           └── page.tsx
└── prisma/
    └── schema.prisma (update - add notification preferences)
```

**Update Existing:**
- `src/app/actions/submissions.ts` - Add notification triggers
- `src/app/actions/review.ts` - Add notification triggers
- `src/app/actions/approve.ts` - Add notification triggers
- `src/app/actions/publish.ts` - Add notification triggers

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Notifications sending on submission
- [ ] Approval/rejection notifications working
- [ ] Publication notifications with OneNote link
- [ ] @mentions for urgent items
- [ ] Notification preferences saved
- [ ] Digest mode functional
- [ ] Ready for Epic 6: Compliance & Audit

**Next Story Dependencies:**
- Story 6.1 requires: Notification logging for audit trail
