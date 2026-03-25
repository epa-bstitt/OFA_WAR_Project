# Story 3.3: Prompt Template Management

Status: ready-for-dev
Created: 2026-02-19
Epic: Review Workflow (Aggregator) (Epic 3)
Depends On: Story 3.2 (Side-by-Side Review Interface)

---

## Story

As an Aggregator (Jake),  
I want to customize the AI prompt templates,  
so that I can improve the quality of terse conversions.

---

## Acceptance Criteria

- [ ] **AC1:** Prompt template CRUD interface
- [ ] **AC2:** Version history for prompts
- [ ] **AC3:** A/B testing capability (compare prompt versions)
- [ ] **AC4:** Set active prompt template
- [ ] **AC5:** Preview prompt with sample text
- [ ] **AC6:** Only accessible to AGGREGATOR role

---

## Tasks / Subtasks

### Task 1: Create Prompt Management Page (AC: #1, #6)
- [ ] **1.1** Create `src/app/(dashboard)/prompts/page.tsx`:
  - Route protected to AGGREGATOR role only
  - Page title: "AI Prompt Templates"
  - Description explaining purpose
- [ ] **1.2** Create `src/components/features/prompts/PromptManager.tsx`:
  - List view of all prompt templates
  - Active/Inactive status
  - Create, edit, delete actions
- [ ] **1.3** Build prompt list:
  - Table with columns: Name, Version, Active, Created, Actions
  - Sort by name or date
  - Search/filter by name
- [ ] **1.4** Add empty state:
  - "No prompt templates yet"
  - "Create your first template" button

### Task 2: Implement Prompt CRUD (AC: #1)
- [ ] **2.1** Create prompt creation:
  - Form with fields:
    - Name (required, unique)
    - Description (optional)
    - Prompt Text (required, textarea)
    - System Message (optional)
  - Validation: Name unique, prompt not empty
- [ ] **2.2** Create prompt editing:
  - Edit existing prompts
  - Show version number (read-only)
  - Track who last edited
- [ ] **2.3** Create prompt deletion:
  - Soft delete (mark inactive)
  - Cannot delete if actively used
  - Confirmation dialog
- [ ] **2.4** Create Server Actions:
  - `createPrompt(data)` - Create new prompt
  - `updatePrompt(id, data)` - Edit existing
  - `deletePrompt(id)` - Soft delete
  - `setActivePrompt(id)` - Mark as active

### Task 3: Build Version History (AC: #2)
- [ ] **3.1** Create `src/components/features/prompts/VersionHistory.tsx`:
  - Timeline of prompt versions
  - Show changes between versions
  - Who created/edited and when
- [ ] **3.2** Auto-version on edit:
  - Increment version number (semantic versioning)
  - Store previous versions in database
  - Never overwrite, always create new version
- [ ] **3.3** Add version restore:
  - "Restore this version" button
  - Creates new version from old one
  - Preserves history chain
- [ ] **3.4** Show version diff:
  - Compare two versions
  - Highlight changes
  - Side-by-side or inline diff

### Task 4: Implement A/B Testing (AC: #3)
- [ ] **4.1** Create test configuration:
  - Select 2 prompt versions to compare
  - Set test duration
  - Define success metric (confidence score average)
- [ ] **4.2** Run A/B test:
  - Randomly assign conversions to prompt A or B
  - Track results per prompt
  - Store test ID with conversion
- [ ] **4.3** Show test results:
  - Stats: conversions per prompt, avg confidence
  - Winner determination
  - Recommendation: "Prompt B performs 15% better"
- [ ] **4.4** End test and apply:
  - Set winning prompt as active
  - Archive test configuration
  - Log decision in audit trail

### Task 5: Set Active Template (AC: #4)
- [ ] **5.1** Add "Set Active" button:
  - Only one active prompt at a time
  - Show currently active prominently
  - Confirmation before switching
- [ ] **5.2** Update AI conversion:
  - `convertToTerse()` uses active prompt
  - Pass prompt ID to AI service
  - Store which prompt was used
- [ ] **5.3** Show active indicator:
  - Badge on active prompt in list
  - Banner: "This is the currently active prompt"
  - Last activated timestamp
- [ ] **5.4** Default fallback:
  - If no active prompt, use system default
  - Warn if no active prompt set

### Task 6: Create Preview Feature (AC: #5)
- [ ] **6.1** Create `src/components/features/prompts/PromptPreview.tsx`:
  - Side-by-side: Sample text → AI output
  - Test prompt without saving
- [ ] **6.2** Add sample inputs:
  - Pre-defined sample WAR texts
  - Or enter custom text
  - Multiple samples for comparison
- [ ] **6.3** Run preview conversion:
  - Call AI service with draft prompt
  - Show loading state
  - Display result with confidence
- [ ] **6.4** Compare prompts:
  - Run same sample through multiple prompts
  - Side-by-side comparison
  - Help choose best performing

### Task 7: Add Prompt Analytics (Supporting all ACs)
- [ ] **7.1** Track prompt performance:
  - Conversions per prompt
  - Average confidence per prompt
  - Edit frequency (how often Jake fixes it)
- [ ] **7.2** Show analytics dashboard:
  - Charts of prompt performance
  - Trend over time
  - Best/worst performing prompts
- [ ] **7.3** Export data:
  - CSV export of prompt performance
  - For external analysis

---

## Dev Notes

### Architecture Compliance

**Prompt Model (from Story 1.1):**
```prisma
model PromptTemplate {
  id          String   @id @default(cuid())
  name        String
  description String?
  promptText  String   @db.Text
  systemMsg   String?  @db.Text
  version     String   // e.g., "1.2.3"
  isActive    Boolean  @default(false)
  isDeleted   Boolean  @default(false)
  createdBy   String
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  
  @@index([isActive, isDeleted])
}
```

**Database Pattern:**
- Soft delete for prompts (never hard delete)
- Version history in separate table or JSON
- Only one `isActive = true` at a time

### Previous Story Intelligence

**From Story 3.2:**
- Review interface shows prompt info
- Link to this management page
- AI conversion uses active prompt

**Key Integration Points:**
- Link from review interface to here
- AI service uses active prompt ID
- Version history displayed in edit view

---

## Project Structure Notes

### Files to Create

```
src/
├── app/
│   └── (dashboard)/
│       └── prompts/
│           ├── page.tsx
│           └── [id]/
│               └── edit/
│                   └── page.tsx
├── components/
│   └── features/
│       └── prompts/
│           ├── PromptManager.tsx
│           ├── PromptForm.tsx
│           ├── VersionHistory.tsx
│           ├── PromptPreview.tsx
│           └── ABTestPanel.tsx
└── app/
    └── actions/
        └── prompts.ts
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Prompt CRUD interface working
- [ ] Version history tracked
- [ ] A/B testing functional
- [ ] Active template switching works
- [ ] Preview with sample text works
- [ ] Role restriction to AGGREGATOR enforced
- [ ] Ready for Epic 4: Approval Workflow

**Next Story Dependencies:**
- Story 4.x uses reviewed submissions
