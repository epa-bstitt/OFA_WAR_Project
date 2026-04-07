# Story 3.2: Side-by-Side Review Interface

Status: ready-for-dev
Created: 2026-02-19
Epic: Review Workflow (Aggregator) (Epic 3)
Depends On: Story 3.1 (Review Dashboard)

---

## Story

As an Aggregator (Jake),  
I want to compare raw and terse versions side-by-side,  
so that I can efficiently review and edit the terse conversion.

---

## Acceptance Criteria

- [ ] **AC1:** Split-pane view with raw text (left) and terse (right)
- [ ] **AC2:** Inline editing of terse version
- [ ] **AC3:** Highlight differences between raw and terse
- [ ] **AC4:** AI confidence indicator
- [ ] **AC5:** Quick approve/reject buttons
- [ ] **AC6:** Add edit reason/comment

---

## Tasks / Subtasks

### Task 1: Create Review Detail Page (AC: #1)
- [ ] **1.1** Create `src/app/(dashboard)/review/[id]/page.tsx`:
  - Dynamic route for individual review
  - Fetch submission by ID
  - Verify submission is in SUBMITTED status
- [ ] **1.2** Create `src/components/features/review/ReviewPanel.tsx`:
  - Main review container
  - Header with contributor info, week, dates
  - Split-pane layout
  - Action footer
- [ ] **1.3** Create `src/components/features/review/SplitPane.tsx`:
  - Resizable split pane (optional)
  - Left panel: Raw text (read-only)
  - Right panel: Terse text (editable)
  - Responsive: Stack on mobile, side-by-side on desktop

### Task 2: Build Raw Text Panel (AC: #1)
- [ ] **2.1** Create `src/components/features/review/RawPanel.tsx`:
  - Read-only display of original submission
  - Formatted text with line breaks preserved
  - Highlight key sections (auto-detect)
- [ ] **2.2** Add contributor context:
  - Show contributor name
  - Show submission date
  - Show week of
- [ ] **2.3** Add expand/collapse:
  - Collapse if very long
  - "Show full text" button

### Task 3: Build Terse Edit Panel (AC: #2)
- [ ] **3.1** Create `src/components/features/review/TerseEditor.tsx`:
  - Editable textarea
  - Pre-filled with AI-generated terse version
  - Auto-resize as user types
- [ ] **3.2** Add formatting toolbar:
  - Bold, italic (optional)
  - Bullet list formatting
  - Clear formatting button
- [ ] **3.3** Implement auto-save:
  - Debounced save (3 seconds)
  - Save indicator ("Saved" / "Saving...")
  - Draft saved to localStorage (backup)
- [ ] **3.4** Add character counter:
  - Show current length
  - Warn if too long (>1000 chars)

### Task 4: Implement Diff Highlighting (AC: #3)
- [ ] **4.1** Create `src/components/features/review/DiffView.tsx`:
  - Compare raw vs terse
  - Highlight changed sections
  - Use diff library (diff-match-patch)
- [ ] **4.2** Add toggle:
  - "Show Diff" / "Hide Diff"
  - Default: Off (clean view)
- [ ] **4.3** Color coding:
  - Green: Added in terse
  - Red: Removed from raw
  - Yellow: Modified

### Task 5: Add AI Confidence Display (AC: #4)
- [ ] **5.1** Show confidence badge:
  - Reuse ConfidenceBadge from Story 2.2
  - Display AI confidence score
  - Color-coded (green/yellow/red)
- [ ] **5.2** Add AI details:
  - Model version used
  - Processing time
  - Is AI-generated flag
- [ ] **5.3** Show prompt info:
  - Which prompt template was used
  - Link to prompt management (Story 3.3)

### Task 6: Create Review Actions (AC: #5)
- [ ] **6.1** Add action buttons:
  - **Approve**: Green button, marks as IN_REVIEW
  - **Reject**: Red button, returns to contributor
  - **Skip**: Gray button, go to next submission
- [ ] **6.2** Create approve Server Action:
  - `approveSubmission(id, terseText, comment?)`
  - Update submission status to IN_REVIEW
  - Update terseVersion with edited text
  - Create Review record
  - Log audit event
- [ ] **6.3** Create reject Server Action:
  - `rejectSubmission(id, reason)`
  - Update status to REJECTED
  - Store rejection reason
  - Notify contributor (placeholder)
- [ ] **6.4** Add keyboard shortcuts:
  - `Cmd/Ctrl + Enter`: Approve
  - `Esc`: Cancel/back
  - `→`: Skip to next

### Task 7: Add Edit Comments (AC: #6)
- [ ] **7.1** Create comment input:
  - Textarea for edit notes
  - Optional but encouraged
  - Placeholder: "What changes did you make and why?"
- [ ] **7.2** Store comment:
  - Save to Review record
  - Show in audit trail
  - Visible to other aggregators
- [ ] **7.3** Add comment templates:
  - Quick-select common reasons:
    - "Fixed abbreviations"
    - "Added missing detail"
    - "Corrected formatting"

### Task 8: Navigation Between Submissions (Supporting all ACs)
- [ ] **8.1** Add prev/next navigation:
  - Top of page: "Submission 5 of 12"
  - Previous/Next buttons
  - Maintain review queue order
- [ ] **8.2** Handle navigation state:
  - Remember position in queue
  - Return to queue after approve/reject
  - Preserve filters
- [ ] **8.3** Add submission summary:
  - Mini stats in sidebar
  - Total pending
  - Your reviewed today

---

## Dev Notes

### Architecture Compliance

**State Management:**
- Local state for textarea edits
- Server Actions for persistence
- Optimistic updates for navigation

**Auto-Save Pattern:**
```typescript
useEffect(() => {
  const timer = setTimeout(() => {
    saveDraft(submissionId, terseText);
  }, 3000);
  return () => clearTimeout(timer);
}, [terseText]);
```

### Previous Story Intelligence

**From Story 3.1:**
- Review queue exists
- Submission data available
- AGGREGATOR role checks in place

**From Story 2.2:**
- Confidence badge component
- AI conversion patterns
- Side-by-side layout inspiration

---

## Project Structure Notes

### Files to Create

```
src/
├── app/
│   └── (dashboard)/
│       └── review/
│           └── [id]/
│               └── page.tsx
├── components/
│   └── features/
│       └── review/
│           ├── ReviewPanel.tsx
│           ├── SplitPane.tsx
│           ├── RawPanel.tsx
│           ├── TerseEditor.tsx
│           ├── DiffView.tsx
│           └── ReviewActions.tsx
└── app/
    └── actions/
        └── review.ts (update)
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Split-pane view with raw and terse
- [ ] Terse version editable inline
- [ ] Diff highlighting available
- [ ] Confidence score displayed
- [ ] Approve/reject/skip buttons working
- [ ] Edit comments stored
- [ ] Navigation between submissions
- [ ] Ready for Story 3.3: Prompt Template Management

**Next Story Dependencies:**
- Story 3.3 requires: Review interface with prompt info link
