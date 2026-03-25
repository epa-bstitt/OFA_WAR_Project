# Story 3.1: Review Dashboard (Jake's View)

Status: ready-for-dev
Created: 2026-02-19
Epic: Review Workflow (Aggregator) (Epic 3)
Depends On: Story 2.3 (Submission Confirmation & History)

---

## Story

As an Aggregator (Jake),  
I want to see all pending submissions that need my review,  
so that I can efficiently process WAR submissions.

---

## Acceptance Criteria

- [ ] **AC1:** Dashboard showing submissions in SUBMITTED status
- [ ] **AC2:** Filter by contributor, week, or status
- [ ] **AC3:** Quick stats (pending, reviewed today, total)
- [ ] **AC4:** Priority indicators for overdue submissions
- [ ] **AC5:** Bulk selection for batch operations
- [ ] **AC6:** Real-time updates when new submissions arrive

---

## Tasks / Subtasks

### Task 1: Create Review Dashboard Page (AC: #1)
- [ ] **1.1** Create `src/app/(dashboard)/review/page.tsx`:
  - Route protected to AGGREGATOR role and above
  - Page title: "Review Queue"
  - Use PageHeader with description
- [ ] **1.2** Create `src/components/features/review/ReviewDashboard.tsx`:
  - Main dashboard container
  - Stats cards at top
  - Submission list below
  - Responsive grid layout
- [ ] **1.3** Fetch submissions needing review:
  - Create `getPendingSubmissions()` Server Action
  - Query: `status = SUBMITTED`
  - Include: user info, submission data, dates
  - Order by: submittedAt (oldest first)
- [ ] **1.4** Handle empty state:
  - "No submissions pending review"
  - Icon and encouraging message
  - "Check back later"

### Task 2: Build Submission Queue List (AC: #1)
- [ ] **2.1** Create `src/components/features/review/ReviewQueue.tsx`:
  - Table view for desktop
  - Card view for mobile
  - Sortable columns
- [ ] **2.2** Table columns:
  - Checkbox (for bulk select)
  - Contributor (name/email)
  - Week Of (date)
  - Submitted Date (relative time)
  - Status (badge)
  - Priority (overdue indicator)
  - Actions (Review button)
- [ ] **2.3** Add pagination:
  - 20 items per page
  - Page navigation
  - Items count display
- [ ] **2.4** Add loading skeleton:
  - While fetching submissions
  - Table row skeletons

### Task 3: Implement Filtering (AC: #2)
- [ ] **3.1** Create `src/components/features/review/ReviewFilters.tsx`:
  - Filter by contributor (dropdown with search)
  - Filter by week (week selector)
  - Filter by submission date range
- [ ] **3.2** Add search bar:
  - Search contributor name/email
  - Debounced input (300ms)
  - Clear search button
- [ ] **3.3** Create Server Action with filters:
  - `getPendingSubmissions(filters: FilterOptions)`
  - Dynamic WHERE clause based on filters
  - Full-text search on contributor name
- [ ] **3.4** Persist filters in URL:
  - Query parameters: `?contributor=john&week=2024-W03`
  - Shareable filtered views

### Task 4: Create Stats Cards (AC: #3)
- [ ] **4.1** Create `src/components/features/review/ReviewStats.tsx`:
  - 4 stat cards in grid
  - Use shadcn Card component
- [ ] **4.2** Stats to display:
  - **Pending**: Count of SUBMITTED submissions
  - **Reviewed Today**: Count reviewed by Jake today
  - **Overdue**: Count >7 days old
  - **Total This Week**: All submissions this week
- [ ] **4.3** Calculate stats:
  - Create `getReviewStats()` Server Action
  - Aggregate queries for efficiency
  - Cache for 5 minutes (optional)
- [ ] **4.4** Visual indicators:
  - Trend icons (up/down arrows)
  - Color coding (red for overdue)
  - Progress bars (optional)

### Task 5: Add Priority Indicators (AC: #4)
- [ ] **5.1** Calculate submission age:
  - Days since submission
  - Overdue threshold: >7 days
- [ ] **5.2** Create priority badges:
  - **Urgent**: >14 days (red)
  - **High**: 7-14 days (orange)
  - **Normal**: <7 days (green)
- [ ] **5.3** Add visual indicators:
  - Priority column in table
  - Sort by priority option
  - Alert icon for urgent items
- [ ] **5.4** Add overdue alert banner:
  - If any overdue submissions exist
  - "You have X overdue submissions requiring attention"
  - Link to filtered overdue view

### Task 6: Implement Bulk Selection (AC: #5)
- [ ] **6.1** Add checkboxes to table:
  - Header checkbox (select all on page)
  - Row checkboxes (individual select)
  - Select all/none functionality
- [ ] **6.2** Create bulk actions bar:
  - Appears when items selected
  - Shows count: "3 submissions selected"
  - Actions: "Mark as Reviewed" (placeholder for future)
- [ ] **6.3** Add shift+click range selection:
  - Select range of submissions
  - Common spreadsheet behavior
- [ ] **6.4** Persist selection across pagination:
  - Remember selected IDs
  - Clear on page refresh

### Task 7: Add Real-Time Updates (AC: #6)
- [ ] **7.1** Set up React Query with polling:
  - Polling interval: 30 seconds
  - Background refetch
  - Stale time: 1 minute
- [ ] **7.2** Show new submission indicator:
  - "New submission arrived" toast
  - Highlight new rows briefly
  - Play subtle sound (optional, muted by default)
- [ ] **7.3** Handle auto-refresh:
  - Update stats on new data
  - Maintain scroll position
  - Preserve filters
- [ ] **7.4** Add manual refresh button:
  - Refresh icon in header
  - Last updated timestamp
  - Loading state during refresh

### Task 8: Create Quick Review Actions (Supporting all ACs)
- [ ] **8.1** Add "Quick Review" button:
  - Inline approve (for high-confidence AI)
  - Skip to next submission
- [ ] **8.2** Add keyboard shortcuts:
  - `Enter` or `Space`: Open review
  - `→` or `↓`: Next submission
  - `←` or `↑`: Previous submission
- [ ] **8.3** Add review progress:
  - Progress bar: "15 of 32 reviewed"
  - Daily goal setting (optional)

---

## Dev Notes

### Architecture Compliance

**Role-Based Access:**
```typescript
// Middleware + Server Action check
if (!hasMinimumRole(session.user.role, "AGGREGATOR")) {
  throw new Error("Insufficient permissions");
}
```

**Data Fetching:**
- Use React Query for real-time updates
- Server Action for initial fetch
- Optimistic updates for actions

### Previous Story Intelligence

**From Story 2.3:**
- Submission list component patterns
- Status filtering logic
- Server Action patterns

**Key Integration Points:**
- Reuse table/card components
- Extend filtering for review needs
- Link to review detail page (Story 3.2)

---

## Project Structure Notes

### Files to Create

```
src/
├── app/
│   └── (dashboard)/
│       └── review/
│           └── page.tsx
├── components/
│   └── features/
│       └── review/
│           ├── ReviewDashboard.tsx
│           ├── ReviewQueue.tsx
│           ├── ReviewStats.tsx
│           ├── ReviewFilters.tsx
│           └── PriorityBadge.tsx
└── app/
    └── actions/
        └── review.ts
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Dashboard shows pending submissions
- [ ] Filtering by contributor, week, status works
- [ ] Stats cards display correct counts
- [ ] Overdue items clearly marked
- [ ] Bulk selection working
- [ ] Real-time updates every 30 seconds
- [ ] E2E test: Review queue loads and filters correctly
- [ ] Ready for Story 3.2: Side-by-Side Review Interface

**Next Story Dependencies:**
- Story 3.2 requires: Review queue with "Review" button linking to detail view
