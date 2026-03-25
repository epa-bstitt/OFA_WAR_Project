# Story 4.3: OneNote Publication

Status: ready-for-dev
Created: 2026-02-19
Epic: Approval Workflow (Program Overseer) (Epic 4)
Depends On: Story 4.2 (Batch Approval & Rejection)

---

## Story

As a Program Overseer (Will),  
I want to publish approved WARs to the Program OneNote,  
so that leadership can access the consolidated reports.

---

## Acceptance Criteria

- [ ] **AC1:** Microsoft Graph API integration for OneNote
- [ ] **AC2:** Batch publish to specific OneNote section
- [ ] **AC3:** Formatted output (terse versions only)
- [ ] **AC4:** Publication confirmation with page links
- [ ] **AC5:** Retry logic for failed publications
- [ ] **AC6:** Status changes to PUBLISHED after success

---

## Tasks / Subtasks

### Task 1: Set Up Microsoft Graph Client (AC: #1)
- [ ] **1.1** Install MSAL Node: `npm install @azure/msal-node`
- [ ] **1.2** Create `src/lib/graph/client.ts`:
  - MSAL Node configuration
  - Client credentials flow (app-only)
  - Token caching
  - Error handling
- [ ] **1.3** Configure environment variables:
  ```
  MS_GRAPH_CLIENT_ID=""
  MS_GRAPH_CLIENT_SECRET=""
  MS_GRAPH_TENANT_ID=""
  MS_GRAPH_ONENOTE_SECTION_ID=""
  ```
- [ ] **1.4** Create token acquisition:
  - Get access token for Graph API
  - Cache token until expiry
  - Auto-refresh before expiration

### Task 2: Create OneNote Service (AC: #1, #2)
- [ ] **2.1** Create `src/lib/graph/onenote.ts`:
  - `createPage(title, content, sectionId)` - Create OneNote page
  - `getSection(sectionId)` - Get section details
  - `listPages(sectionId)` - List existing pages
- [ ] **2.2** Implement HTML formatting:
  - Convert terse WARs to OneNote HTML
  - EPA branding header
  - Table format for weekly summary
  - Proper OneNote markup
- [ ] **2.3** Create publication batch:
  - Group WARs by week
  - Create single page per week (or multiple if large)
  - Section header with week dates
- [ ] **2.4** Add idempotency:
  - Check if page already exists
  - Update vs create logic
  - Prevent duplicates

### Task 3: Build Publication Interface (AC: #2, #3)
- [ ] **3.1** Create `src/app/(dashboard)/publish/page.tsx`:
  - Route protected to PROGRAM_OVERSEER and ADMINISTRATOR
  - Show APPROVED submissions ready to publish
  - Week selector for batch
- [ ] **3.2** Create `src/components/features/publish/PublishPanel.tsx`:
  - List of approved submissions
  - Preview of formatted output
  - Publish button
- [ ] **3.3** Add formatting preview:
  - "Preview in OneNote" modal
  - Show how it will look
  - HTML preview
- [ ] **3.4** Add section selection:
  - Dropdown of available OneNote sections
  - Default to configured section
  - Remember last selection

### Task 4: Implement Batch Publication (AC: #2, #6)
- [ ] **4.1** Create `publishToOneNote` Server Action:
  ```typescript
  export async function publishToOneNote(
    submissionIds: string[],
    sectionId: string
  ) {
    // Validate all are APPROVED
    // Group by week
    // Create OneNote pages
    // Update submission status to PUBLISHED
    // Return page URLs
  }
  ```
- [ ] **4.2** Format content for OneNote:
  - Header: "Weekly Activity Reports - Week of [Date]"
  - Contributor name and terse version
  - Footer with publication date
- [ ] **4.3** Update submission status:
  - Set to PUBLISHED
  - Store OneNote page URL
  - Store publication timestamp
- [ ] **4.4** Log publication:
  - Audit trail entry
  - Include OneNote page URL
  - Who published

### Task 5: Add Publication Confirmation (AC: #4)
- [ ] **5.1** Create success modal:
  - "Published successfully!"
  - List of created pages
  - Links to OneNote pages
- [ ] **5.2** Add copy links functionality:
  - Copy OneNote URLs to clipboard
  - "Share these links with your team"
- [ ] **5.3** Show publication summary:
  - Count published
  - Week covered
  - OneNote section
  - Timestamp
- [ ] **5.4** Add "View in OneNote" button:
  - Opens OneNote web app
  - Deep link to section/page

### Task 6: Implement Retry Logic (AC: #5)
- [ ] **6.1** Add retry mechanism:
  - Exponential backoff (1s, 2s, 4s)
  - Max 3 retries
  - Log each attempt
- [ ] **6.2** Handle specific errors:
  - 429 Rate Limit → Wait and retry
  - 503 Service Unavailable → Retry
  - 401/403 Auth → Refresh token, retry
  - 400 Bad Request → Don't retry, log error
- [ ] **6.3** Create failure handling:
  - If retry exhausted, mark as failed
  - Show error to user
  - Allow manual retry
- [ ] **6.4** Add partial success handling:
  - If some pages fail, show which succeeded
  - Option to retry failed only

### Task 7: Create Publication History (Supporting all ACs)
- [ ] **7.1** Create `src/app/(dashboard)/publish/history/page.tsx`:
  - List all past publications
  - Filter by date, week, status
- [ ] **7.2** Show publication details:
  - What was published
  - When
  - OneNote links
  - Success/failure status
- [ ] **7.3** Add republish option:
  - "Update in OneNote" for published submissions
  - Sync changes to existing page

### Task 8: Add Pre-Publication Validation (Supporting all ACs)
- [ ] **8.1** Validate before publish:
  - All selected are APPROVED
  - No duplicates
  - Required fields present
- [ ] **8.2** Show warnings:
  - "3 submissions are missing terse versions"
  - "Some submissions have low AI confidence"
- [ ] **8.3** Require confirmation:
  - Final check dialog
  - Summary of what will be published

---

## Dev Notes

### Architecture Compliance

**Graph API Pattern:**
```typescript
// Service boundary
const graphClient = new Client.initWithMiddleware({
  authProvider: msalAuthProvider,
});

// Retry with backoff
const publishWithRetry = async (content, attempt = 1) => {
  try {
    return await createPage(content);
  } catch (error) {
    if (attempt < 3 && isRetryable(error)) {
      await delay(1000 * Math.pow(2, attempt));
      return publishWithRetry(content, attempt + 1);
    }
    throw error;
  }
};
```

**OneNote HTML Format:**
```html
<!DOCTYPE html>
<html>
<head>
  <title>WAR Week of [Date]</title>
</head>
<body>
  <h1>EPA Weekly Activity Reports</h1>
  <h2>Week of January 15-19, 2024</h2>
  <p><b>Contributor Name:</b> Terse status update...</p>
</body>
</html>
```

### Previous Story Intelligence

**From Story 4.2:**
- APPROVED submissions exist
- Batch operations working
- Notification system available

**Key Integration Points:**
- Reuse batch selection from approval dashboard
- Use notification system for success/failure
- Link from approval dashboard to publish

---

## Project Structure Notes

### Files to Create

```
src/
├── lib/
│   └── graph/
│       ├── client.ts
│       ├── onenote.ts
│       └── retry.ts
├── app/
│   └── (dashboard)/
│       └── publish/
│           ├── page.tsx
│           └── history/
│               └── page.tsx
├── components/
│   └── features/
│       └── publish/
│           ├── PublishPanel.tsx
│           ├── PublishPreview.tsx
│           └── PublicationHistory.tsx
└── app/
    └── actions/
        └── publish.ts
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Microsoft Graph client configured
- [ ] OneNote service creating pages
- [ ] Batch publish functional
- [ ] Proper HTML formatting
- [ ] Publication confirmation with links
- [ ] Retry logic working (exponential backoff)
- [ ] Status changes to PUBLISHED
- [ ] Ready for Epic 5: Microsoft Teams Integration

**Next Story Dependencies:**
- Story 5.2 requires: PUBLISHED status for notifications
