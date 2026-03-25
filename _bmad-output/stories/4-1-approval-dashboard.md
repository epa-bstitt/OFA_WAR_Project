# Story 4.1: Approval Dashboard (Will's View)

Status: ready-for-dev
Created: 2026-02-19
Epic: Approval Workflow (Program Overseer) (Epic 4)
Depends On: Story 3.2 (Side-by-Side Review Interface)

---

## Story

As a Program Overseer (Will),  
I want to see all approved submissions ready for final review,  
so that I can oversee the WAR publication process.

---

## Acceptance Criteria

- [ ] **AC1:** Dashboard showing IN_REVIEW submissions
- [ ] **AC2:** Aggregator's edit history visible
- [ ] **AC3:** Filter by week, contributor, or aggregator
- [ ] **AC4:** Weekly summary view
- [ ] **AC5:** Export to CSV/Excel option
- [ ] **AC6:** Statistics and metrics dashboard

---

## Tasks / Subtasks

### Task 1: Create Approval Dashboard Page (AC: #1)
- [ ] **1.1** Create `src/app/(dashboard)/approve/page.tsx`:
  - Route protected to PROGRAM_OVERSEER and ADMINISTRATOR
  - Page title: "Approve WARs"
  - Description: "Review and approve submissions for publication"
- [ ] **1.2** Create `src/components/features/approve/ApprovalDashboard.tsx`:
  - Main container with stats, filters, and list
  - Use CardGrid for stats
  - Table for submissions
- [ ] **1.3** Fetch IN_REVIEW submissions:
  - Create `getInReviewSubmissions()` Server Action
  - Include: contributor, week, raw text, terse version, reviewer info
  - Order by: review date (oldest first)
- [ ] **1.4** Handle empty states:
  - "No submissions awaiting approval"
  - Show completed count "You've approved 42 WARs this week"

### Task 2: Show Aggregator Edit History (AC: #2)
- [ ] **2.1** Create `src/components/features/approve/EditHistory.tsx`:
  - Show all edits made by Jake
  - Original AI output vs Final terse version
  - Edit timestamps
- [ ] **2.2** Display inline in table:
  - "Edited" badge if Jake made changes
  - Expandable row showing before/after
- [ ] **2.3** Calculate edit metrics:
  - Number of edits
  - Character change count
  - AI confidence vs final quality
- [ ] **2.4** Show reviewer notes:
  - Comments from Jake's review
  - Reason for edits

### Task 3: Implement Advanced Filtering (AC: #3)
- [ ] **3.1** Create `src/components/features/approve/ApprovalFilters.tsx`:
  - Filter by week (multi-select)
  - Filter by contributor (searchable dropdown)
  - Filter by aggregator (who reviewed it)
  - Filter by date reviewed
- [ ] **3.2** Add search functionality:
  - Search in contributor name
  - Search in submission text
  - Full-text search
- [ ] **3.3** Save filter presets:
  - "This week's submissions"
  - "My reviews"
  - "High confidence only"
- [ ] **3.4** Apply filters to Server Action:
  - Dynamic query building
  - Pagination with filtered counts

### Task 4: Create Weekly Summary View (AC: #4)
- [ ] **4.1** Create `src/components/features/approve/WeeklySummary.tsx`:
  - Group submissions by week
  - Week selector at top
  - Summary cards for selected week
- [ ] **4.2** Show week statistics:
  - Total submissions this week
  - Approved count
  - Pending count
  - Rejected count
- [ ] **4.3** Add team activity:
  - Who submitted this week
  - Who reviewed this week
  - Coverage percentage
- [ ] **4.4** Add weekly report preview:
  - How it will look in OneNote
  - Export preview

### Task 5: Build Export Functionality (AC: #5)
- [ ] **5.1** Create CSV export:
  - `exportToCSV(submissions)` Server Action
  - Columns: Week, Contributor, Raw, Terse, Status, Reviewer
  - Download via browser
- [ ] **5.2** Create Excel export:
  - Use xlsx library
  - Formatted with headers
  - Multiple sheets (summary + detail)
- [ ] **5.3** Add PDF export (optional):
  - Formatted report
  - EPA branding
  - Table of contents
- [ ] **5.4** Create export dialog:
  - Select date range
  - Select status filter
  - Choose format (CSV/Excel)
  - Preview before download

### Task 6: Create Metrics Dashboard (AC: #6)
- [ ] **6.1** Create `src/components/features/approve/MetricsPanel.tsx`:
  - Charts and graphs
  - Time period selector
- [ ] **6.2** Key metrics:
  - Submissions per week (trend)
  - Review time (avg time from submit to approve)
  - AI confidence trend
  - Editor intervention rate (how often Jake edits)
- [ ] **6.3** Create charts:
  - Line chart: Submissions over time
  - Bar chart: Contributors this month
  - Pie chart: Status distribution
- [ ] **6.4** Export metrics:
  - Screenshot charts
  - Raw data export

### Task 7: Add Batch Operations (Supporting all ACs)
- [ ] **7.1** Add checkboxes to table:
  - Select multiple submissions
  - Select all on page
  - Shift-click range select
- [ ] **7.2** Create batch actions:
  - "Approve Selected" button
  - "Reject Selected" button
  - Confirmation dialog with count
- [ ] **7.3** Bulk approve Server Action:
  - Transactional update
  - Update all selected to APPROVED
  - Log each in audit trail

### Task 8: Create Submission Detail View (Supporting all ACs)
- [ ] **8.1** Create detail page at `src/app/(dashboard)/approve/[id]/page.tsx`:
  - Full submission view
  - Complete edit history
  - Audit trail
- [ ] **8.2** Add quick actions:
  - Approve/Reject buttons
  - View in context (next/prev navigation)
  - Jump to edit review

---

## Dev Notes

### Architecture Compliance

**Role Protection:**
```typescript
if (!hasRequiredRole(session.user.role, ["PROGRAM_OVERSEER", "ADMINISTRATOR"])) {
  redirect("/unauthorized");
}
```

**Data Aggregation:**
- Use Prisma groupBy for stats
- Efficient queries with select/include
- Cache expensive aggregations

### Previous Story Intelligence

**From Story 3.2:**
- Submissions have IN_REVIEW status
- Review records with edit history
- Audit logging in place

**Key Integration Points:**
- Reuse filtering patterns from Story 3.1
- Extend submission data with review info
- Link to batch approval (Story 4.2)

---

## Project Structure Notes

### Files to Create

```
src/
├── app/
│   └── (dashboard)/
│       └── approve/
│           ├── page.tsx
│           └── [id]/
│               └── page.tsx
├── components/
│   └── features/
│       └── approve/
│           ├── ApprovalDashboard.tsx
│           ├── EditHistory.tsx
│           ├── ApprovalFilters.tsx
│           ├── WeeklySummary.tsx
│           └── MetricsPanel.tsx
└── app/
    └── actions/
        └── approve.ts
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Dashboard shows IN_REVIEW submissions
- [ ] Edit history visible
- [ ] Filtering by week, contributor, aggregator works
- [ ] Weekly summary view functional
- [ ] Export to CSV/Excel working
- [ ] Metrics dashboard with charts
- [ ] Ready for Story 4.2: Batch Approval & Rejection

**Next Story Dependencies:**
- Story 4.2 requires: Approval dashboard with batch operations
