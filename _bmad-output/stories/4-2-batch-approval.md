# Story 4.2: Batch Approval & Rejection

Status: ready-for-dev
Created: 2026-02-19
Epic: Approval Workflow (Program Overseer) (Epic 4)
Depends On: Story 4.1 (Approval Dashboard)

---

## Story

As a Program Overseer (Will),  
I want to approve or reject multiple submissions at once,  
so that I can efficiently process weekly reports.

---

## Acceptance Criteria

- [ ] **AC1:** Multi-select submissions with checkboxes
- [ ] **AC2:** Batch approve action with confirmation
- [ ] **AC3:** Batch reject with reason input
- [ ] **AC4:** Status changes to APPROVED or REJECTED
- [ ] **AC5:** Notifications sent to contributors on rejection
- [ ] **AC6:** Undo option within 5 minutes

---

## Tasks / Subtasks

### Task 1: Build Multi-Select Interface (AC: #1)
- [ ] **1.1** Enhance Approval Dashboard table:
  - Add checkbox column at left
  - Header checkbox selects all visible
  - Row checkboxes for individual select
- [ ] **1.2** Create selection state management:
  - Store selected submission IDs
  - Persist across pagination
  - "Select all matching filters" option
- [ ] **1.3** Add shift+click range selection:
  - Click first item
  - Shift+click last item
  - Selects range
- [ ] **1.4** Show selection summary:
  - Floating bar: "15 submissions selected"
  - "Clear selection" button
  - Selected count by status

### Task 2: Create Batch Approve Flow (AC: #2, #4)
- [ ] **2.1** Add "Approve Selected" button:
  - Enabled when selections exist
  - Primary button style (green)
  - Disabled during processing
- [ ] **2.2** Create confirmation dialog:
  - shadcn AlertDialog
  - "Approve 15 submissions?"
  - List of selected items (scrollable)
  - Final confirmation required
- [ ] **2.3** Create `batchApprove` Server Action:
  ```typescript
  export async function batchApprove(submissionIds: string[]) {
    // Validate all submissions are IN_REVIEW
    // Transactional update
    const result = await prisma.$transaction(
      submissionIds.map(id => 
        prisma.submission.update({
          where: { id, status: "IN_REVIEW" },
          data: { status: "APPROVED", approvedAt: new Date() }
        })
      )
    );
    
    // Log each approval
    for (const id of submissionIds) {
      await logAuditEvent({ action: "SUBMISSION_APPROVED", resourceId: id });
    }
    
    return { success: true, count: result.length };
  }
  ```
- [ ] **2.4** Handle partial failures:
  - If some fail, show which succeeded/failed
  - Retry option for failed items
  - Detailed error messages

### Task 3: Create Batch Reject Flow (AC: #3, #4, #5)
- [ ] **3.1** Add "Reject Selected" button:
  - Danger style (red)
  - Requires reason input
- [ ] **3.2** Create rejection dialog:
  - List submissions to reject
  - **Required**: Rejection reason textarea
  - Template reasons dropdown:
    - "Incomplete information"
    - "Incorrect formatting"
    - "Missing key details"
    - "Not appropriate for publication"
    - "Other (specify)"
- [ ] **3.3** Create `batchReject` Server Action:
  - Similar to batchApprove
  - Store rejection reason on each submission
  - Set status to REJECTED
- [ ] **3.4** Send notifications:
  - Queue Teams notifications (Story 5.2)
  - Email notification (if configured)
  - In-app notification (future)
- [ ] **3.5** Log rejections:
  - Audit trail with reason
  - Who rejected and when

### Task 4: Implement Undo Functionality (AC: #6)
- [ ] **4.1** Create undo system:
  - Store recent actions (last 5 minutes)
  - In-memory cache or Redis
- [ ] **4.2** Show undo toast:
  - "15 submissions approved"
  - "Undo" button in toast
  - 5-minute countdown
- [ ] **4.3** Create `undoAction` Server Action:
  - Revert status changes
  - Remove audit logs (or mark as undone)
  - Notify if already processed further
- [ ] **4.4** Handle undo expiration:
  - Disable undo after 5 minutes
  - Log attempt to undo expired action
  - Show "Undo expired" message

### Task 5: Add Progress Indicators (Supporting all ACs)
- [ ] **5.1** Create progress modal:
  - For large batches (>50)
  - Show progress bar
  - "Processing 23 of 150..."
- [ ] **5.2** Handle long operations:
  - Async processing for large batches
  - Background job (optional)
  - Notify when complete
- [ ] **5.3** Add success feedback:
  - Toast on completion
  - Summary: "Approved 150 submissions"
  - Auto-refresh list

### Task 6: Create Safety Features (Supporting all ACs)
- [ ] **6.1** Add validation:
  - Verify all selected are IN_REVIEW
  - Prevent approving already approved
  - Show error if selection invalid
- [ ] **6.2** Add confirmation for large batches:
  - Extra confirmation if >20 items
  - "Are you sure? This will affect 45 submissions."
- [ ] **6.3** Log all batch actions:
  - BATCH_APPROVED action in audit log
  - Include all affected submission IDs
  - Store who performed action

---

## Dev Notes

### Architecture Compliance

**Transactional Safety:**
```typescript
await prisma.$transaction(async (tx) => {
  for (const id of submissionIds) {
    await tx.submission.update({...});
    await tx.auditLog.create({...});
  }
});
```

**Undo Pattern:**
- Store action ID, timestamp, affected IDs
- Undo reverses each change
- 5-minute window from action time

### Previous Story Intelligence

**From Story 4.1:**
- Approval dashboard exists
- Multi-select checkboxes in place
- Selection state managed

**Key Integration Points:**
- Extend existing dashboard
- Add batch action buttons
- Hook into notification system (Story 5.2)

---

## Project Structure Notes

### Files to Create/Update

**Update Existing:**
- `src/app/(dashboard)/approve/page.tsx` - Add batch buttons
- `src/components/features/approve/ApprovalDashboard.tsx` - Add batch actions

**New Files:**
```
src/
├── components/
│   └── features/
│       └── approve/
│           ├── BatchActionBar.tsx
│           ├── BatchApproveDialog.tsx
│           ├── BatchRejectDialog.tsx
│           └── UndoToast.tsx
└── app/
    └── actions/
        └── batch-approve.ts
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Multi-select working with checkboxes
- [ ] Batch approve with confirmation
- [ ] Batch reject with reason
- [ ] Status changes applied correctly
- [ ] Notifications queued for rejections
- [ ] Undo working within 5 minutes
- [ ] Ready for Story 4.3: OneNote Publication

**Next Story Dependencies:**
- Story 4.3 requires: APPROVED submissions ready for publishing
