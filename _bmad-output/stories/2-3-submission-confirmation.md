# Story 2.3: Submission Confirmation & History

Status: ready-for-dev
Created: 2026-02-19
Epic: WAR Submission Flow (Epic 2)
Depends On: Story 2.2 (AI Terse Conversion Integration)

---

## Story

As a WAR contributor,  
I want to see my submission history and confirmation after submitting,  
so that I can track my past submissions.

---

## Acceptance Criteria

- [ ] **AC1:** Submission confirmation page with summary
- [ ] **AC2:** Personal submission history list
- [ ] **AC3:** Filter by status (submitted, approved, published)
- [ ] **AC4:** View detailed submission with raw and terse versions
- [ ] **AC5:** Edit submission before review stage
- [ ] **AC6:** Delete draft submissions

---

## Tasks / Subtasks

### Task 1: Create Submission Confirmation Page (AC: #1)
- [ ] **1.1** Create `src/app/(dashboard)/submit/success/page.tsx`:
  - Display success message with checkmark icon
  - Show submission summary:
    - Week of (date range)
    - Submission ID
    - Status (SUBMITTED with badge)
    - AI-generated flag (if applicable)
  - Show preview of submitted text (collapsed/expandable)
- [ ] **1.2** Add action buttons:
  - "Submit Another WAR" → Navigate to submit form (reset state)
  - "View My Submissions" → Navigate to submissions list
  - "Go to Dashboard" → Navigate to dashboard
- [ ] **1.3** Add next steps information:
  - "Your submission will be reviewed by Jake"
  - "You'll be notified when it's approved"
  - Link to submission status help

### Task 2: Build My Submissions List Page (AC: #2)
- [ ] **2.1** Create `src/app/(dashboard)/submissions/page.tsx`:
  - Page title: "My Submissions"
  - Use PageHeader and ContentCard
  - Empty state: "No submissions yet"
- [ ] **2.2** Create `src/components/features/submissions/SubmissionList.tsx`:
  - Table or card list view
  - Columns: Week, Status, Submitted Date, Actions
  - Sort by most recent first
  - Pagination (10 items per page)
- [ ] **2.3** Create `src/components/features/submissions/SubmissionCard.tsx`:
  - Individual submission card for mobile
  - Status badge color-coded
  - Expandable for details
- [ ] **2.4** Fetch submissions via Server Action:
  - `getMySubmissions(): Promise<Submission[]>`
  - Filter by current user ID from session
  - Include related data (reviews if any)

### Task 3: Implement Status Filtering (AC: #3)
- [ ] **3.1** Create `src/components/features/submissions/StatusFilter.tsx`:
  - shadcn Select component
  - Options: All, Submitted, In Review, Approved, Rejected, Published
  - Default: "All"
- [ ] **3.2** Add query parameter support:
  - `/submissions?status=SUBMITTED`
  - Persist filter on page refresh
- [ ] **3.3** Update Server Action with filter:
  - `getMySubmissions(status?: SubmissionStatus)`
  - Apply WHERE clause if status provided
- [ ] **3.4** Show filter results count:
  - "Showing 5 of 12 submissions"
  - Clear filter button

### Task 4: Create Submission Detail View (AC: #4)
- [ ] **4.1** Create `src/app/(dashboard)/submissions/[id]/page.tsx`:
  - Dynamic route for submission detail
  - Fetch submission by ID
  - 404 if not found or not owned by user
- [ ] **4.2** Create `src/components/features/submissions/SubmissionDetail.tsx`:
  - Full submission view with tabs or sections:
    - Overview (week, status, dates)
    - Raw Text (full content)
    - Terse Version (full content)
    - Review History (if available)
    - Audit Trail (user's actions only)
- [ ] **4.3** Add status timeline:
  - Visual timeline of submission lifecycle
  - Dates for each status change
  - Current status highlighted
- [ ] **4.4** Add print/export option:
  - Print-friendly layout
  - Export to PDF (optional)

### Task 5: Implement Edit Functionality (AC: #5)
- [ ] **5.1** Add edit button to submission list/card:
  - Only show for SUBMITTED status
  - Hide for IN_REVIEW, APPROVED, REJECTED, PUBLISHED
  - Tooltip: "Cannot edit after review begins"
- [ ] **5.2** Create edit page at `src/app/(dashboard)/submissions/[id]/edit/page.tsx`:
  - Pre-fill form with existing data
  - Reuse SubmissionForm component with edit mode
  - Update submit button to "Save Changes"
- [ ] **5.3** Create `updateSubmission` Server Action:
  - Validate user owns the submission
  - Validate status is still SUBMITTED
  - Update rawText, terseVersion, weekOf
  - Reset updatedAt timestamp
  - Log audit event: SUBMISSION_UPDATED
- [ ] **5.4** Handle edit conflicts:
  - Check if status changed since page load
  - Show error if now IN_REVIEW
  - Prevent overwriting aggregator's work

### Task 6: Add Delete Functionality (AC: #6)
- [ ] **6.1** Add delete button to submission list/card:
  - Only for SUBMITTED or REJECTED status
  - Soft delete (mark as deleted, don't hard delete)
- [ ] **6.2** Create confirmation dialog:
  - shadcn AlertDialog
  - "Are you sure? This action cannot be undone."
  - Show submission preview in dialog
- [ ] **6.3** Create `deleteSubmission` Server Action:
  - Validate ownership
  - Validate status allows deletion
  - Soft delete: set `deletedAt` timestamp
  - Log audit event: SUBMISSION_DELETED
- [ ] **6.4** Update queries to exclude deleted:
  - Add `where: { deletedAt: null }` to all queries
  - Show "Deleted" filter option for admins

### Task 7: Create Dashboard Widget (Supporting all ACs)
- [ ] **7.1** Create `src/components/features/dashboard/RecentSubmissions.tsx`:
  - Show last 5 submissions on dashboard
  - Quick status overview
  - "View All" link to submissions page
- [ ] **7.2** Create `src/components/features/dashboard/SubmissionStats.tsx`:
  - Stats cards:
    - Total submissions this year
    - Pending review count
    - Approved count
    - Published count
- [ ] **7.3** Integrate into dashboard page:
  - Use CardGrid from Story 1.3
  - Responsive layout

### Task 8: Add Notifications/Alerts (Supporting all ACs)
- [ ] **8.1** Create `src/components/shared/StatusAlert.tsx`:
  - Alert for submissions needing attention
  - Overdue submissions (submitted >7 days ago, not reviewed)
  - Rejected submissions (with reason)
- [ ] **8.2** Show alerts on dashboard:
  - Top of page alert banner
  - Dismissible
  - Link to relevant submission

---

## Dev Notes

### Architecture Compliance

**Data Fetching Pattern:**
- Server Components fetch via Server Actions
- Use React Query for client-side caching (optional)
- Optimistic updates for delete/edit

**Permission Pattern:**
```typescript
// Always verify ownership
const submission = await prisma.submission.findFirst({
  where: { 
    id, 
    userId: session.user.id,
    deletedAt: null 
  }
});
if (!submission) throw new Error("Not found or access denied");
```

### Status Workflow

```
SUBMITTED → IN_REVIEW → APPROVED → PUBLISHED
     ↓         ↓          ↓
  [EDIT]   [DELETE]   [DELETE if REJECTED]
```

**Edit Rules:**
- Can edit only when SUBMITTED
- Cannot edit after IN_REVIEW (Jake is working on it)
- Cannot edit APPROVED or PUBLISHED (already processed)

**Delete Rules:**
- Soft delete only (never hard delete for audit)
- Can delete SUBMITTED or REJECTED
- Cannot delete IN_REVIEW, APPROVED, PUBLISHED

### Previous Story Intelligence

**From Story 2.2:**
- Submissions have terse versions
- AI-generated flag exists
- Form components reusable for edit mode

**Key Integration Points:**
- Reuse SubmissionForm for edit
- Reuse StatusBadge from navigation
- Leverage existing Server Action patterns

---

## Project Structure Notes

### Files to Create/Update

**New Files:**
```
src/
├── app/
│   └── (dashboard)/
│       ├── submissions/
│       │   ├── page.tsx
│       │   ├── [id]/
│       │   │   ├── page.tsx
│       │   │   └── edit/
│       │   │       └── page.tsx
│       │   └── success/
│       │       └── page.tsx
│       └── dashboard/
│           └── page.tsx (update)
├── components/
│   └── features/
│       ├── submissions/
│       │   ├── SubmissionList.tsx
│       │   ├── SubmissionCard.tsx
│       │   ├── SubmissionDetail.tsx
│       │   └── StatusFilter.tsx
│       └── dashboard/
│           ├── RecentSubmissions.tsx
│           └── SubmissionStats.tsx
└── app/
    └── actions/
        └── submissions.ts (update)
```

---

## Dev Agent Record

### Previous Story Intelligence

**From Story 2.2:**
- Submission form with AI integration
- Server Actions pattern established
- Submissions stored in database

### File List

**Files to Create:**
- `src/app/(dashboard)/submissions/page.tsx`
- `src/app/(dashboard)/submissions/[id]/page.tsx`
- `src/app/(dashboard)/submissions/[id]/edit/page.tsx`
- `src/components/features/submissions/SubmissionList.tsx`
- `src/components/features/submissions/SubmissionCard.tsx`
- `src/components/features/submissions/SubmissionDetail.tsx`
- `src/components/features/submissions/StatusFilter.tsx`

**Files to Update:**
- `src/app/(dashboard)/dashboard/page.tsx` - Add widgets
- `src/app/actions/submissions.ts` - Add update/delete

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Confirmation page shows submission summary
- [ ] My Submissions list displays all user submissions
- [ ] Status filtering works correctly
- [ ] Detail view shows raw and terse versions
- [ ] Edit works only for SUBMITTED status
- [ ] Delete soft-deletes submission
- [ ] Dashboard shows recent submissions and stats
- [ ] Ready for Story 3.1: Review Dashboard (Jake's View)

**Next Story Dependencies:**
- Story 3.1 requires: Submissions exist in SUBMITTED status
- Story 3.2 requires: Review model and submission detail view
