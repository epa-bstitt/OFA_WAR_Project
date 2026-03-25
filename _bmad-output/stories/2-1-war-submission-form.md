# Story 2.1: WAR Submission Form

Status: ready-for-dev
Created: 2026-02-19
Epic: WAR Submission Flow (Epic 2)
Depends On: Story 1.3 (Core Layout & Navigation)

---

## Story

As a WAR contributor,  
I want to submit my weekly activity report through a web form,  
so that I can provide my updates without using email.

---

## Acceptance Criteria

- [ ] **AC1:** Submission form with week selector implemented
- [ ] **AC2:** Large textarea for raw text input (verbose format)
- [ ] **AC3:** Form validation (minimum 10 characters)
- [ ] **AC4:** Submit button with loading state
- [ ] **AC5:** Success/error feedback after submission
- [ ] **AC6:** Submission saved to database with SUBMITTED status

---

## Tasks / Subtasks

### Task 1: Create Submission Page Structure (AC: #1)
- [ ] **1.1** Create route group `src/app/(dashboard)/submit/`:
  - `src/app/(dashboard)/submit/page.tsx` - Main submission page
  - `src/app/(dashboard)/submit/layout.tsx` - Submit-specific layout (optional)
- [ ] **1.2** Create `src/components/features/submit/SubmissionForm.tsx`:
  - Main form component
  - "use client" directive (react-hook-form needs client)
  - Integrate with shadcn Form, Input, Textarea, Button components
- [ ] **1.3** Set up form container with EPA branding:
  - PageHeader with title: "Submit Weekly Activity Report"
  - Breadcrumb: Dashboard > Submit WAR
  - ContentCard wrapper for form

### Task 2: Implement Week Selector (AC: #1)
- [ ] **2.1** Create `src/components/features/submit/WeekSelector.tsx`:
  - Week of year selector (ISO week format)
  - Default to current week
  - Show week range (Monday - Sunday dates)
  - Validation: Cannot select future weeks
  - Validation: Cannot select weeks more than 1 week past
- [ ] **2.2** Add week helper utilities in `src/lib/date-utils.ts`:
  - `getCurrentWeek()` - Returns current ISO week
  - `getWeekRange(weekNumber, year)` - Returns Monday-Sunday dates
  - `isWeekValid(weekNumber)` - Validates week is not future or too old
- [ ] **2.3** Use shadcn Select or Popover component for week picker
- [ ] **2.4** Display selected week dates below selector

### Task 3: Build Raw Text Input (AC: #2)
- [ ] **3.1** Create `src/components/features/submit/RawTextInput.tsx`:
  - Large textarea for verbose status update
  - Minimum height: 300px
  - Placeholder with example verbose format:
    ```
    Week of January 15-19, 2024
    
    This week I worked on the following activities:
    - Completed data analysis for Q4 emissions report
    - Attended stakeholder meeting on Tuesday
    - Reviewed 15 permit applications
    
    Next week plans:
    - Begin writing final report
    - Coordinate with regional office
    ```
- [ ] **3.2** Add character counter display
- [ ] **3.3** Add formatting hints/help text
- [ ] **3.4** Auto-resize or fixed height with scroll

### Task 4: Implement Form Validation (AC: #3)
- [ ] **4.1** Create Zod schema in `src/lib/validation/submission.ts`:
  ```typescript
  export const submissionSchema = z.object({
    weekOf: z.date()
      .refine(date => !isFutureWeek(date), "Cannot select future weeks")
      .refine(date => !isTooOld(date), "Week is too old to submit"),
    rawText: z.string()
      .min(10, "Status update must be at least 10 characters")
      .max(5000, "Status update cannot exceed 5000 characters"),
  });
  
  export type SubmissionInput = z.infer<typeof submissionSchema>;
  ```
- [ ] **4.2** Integrate react-hook-form with Zod resolver:
  ```typescript
  const form = useForm<SubmissionInput>({
    resolver: zodResolver(submissionSchema),
    defaultValues: {
      weekOf: new Date(),
      rawText: "",
    },
  });
  ```
- [ ] **4.3** Display inline validation errors:
  - Week selector error message
  - Textarea error message below input
  - Use shadcn FormMessage component
- [ ] **4.4** Prevent form submission if validation fails
- [ ] **4.5** Add client-side validation on blur

### Task 5: Create Submit Server Action (AC: #4, #6)
- [ ] **5.1** Create `src/app/actions/submissions.ts`:
  - "use server" directive
  - Import `createSubmission` function
- [ ] **5.2** Implement `submitWAR` Server Action:
  ```typescript
  export async function submitWAR(data: SubmissionInput) {
    // Validate user is authenticated
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      throw new Error("Authentication required");
    }
    
    // Server-side validation
    const validated = submissionSchema.parse(data);
    
    // Create submission record
    const submission = await prisma.submission.create({
      data: {
        id: generateId(),
        userId: session.user.id,
        weekOf: validated.weekOf,
        rawText: validated.rawText,
        status: "SUBMITTED",
        isAiGenerated: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });
    
    // Log to audit trail
    await logAuditEvent({
      action: "SUBMISSION_CREATED",
      userId: session.user.id,
      resourceId: submission.id,
      details: { weekOf: validated.weekOf },
    });
    
    return { success: true, submissionId: submission.id };
  }
  ```
- [ ] **5.3** Handle errors gracefully:
  - Database errors
  - Validation errors
  - Authentication errors
- [ ] **5.4** Return typed response for client handling

### Task 6: Build Submit Button with Loading State (AC: #4)
- [ ] **6.1** Add submit button to form:
  - shadcn Button component
  - Variant: primary (EPA blue)
  - Size: lg
  - Full width on mobile
- [ ] **6.2** Implement loading state:
  - Use `form.formState.isSubmitting` from react-hook-form
  - Show spinner icon during submission
  - Disable button while submitting
  - Button text: "Submit WAR" → "Submitting..."
- [ ] **6.3** Add cancel button (optional):
  - Navigate back to dashboard
  - Confirm if form is dirty

### Task 7: Create Success Feedback (AC: #5)
- [ ] **7.1** Create `src/components/features/submit/SubmissionSuccess.tsx`:
  - Success message card
  - Checkmark icon
  - Summary of submission (week, preview of text)
- [ ] **7.2** Implement redirect to confirmation page:
  - `src/app/(dashboard)/submit/success/page.tsx`
  - Or show inline success state in form
- [ ] **7.3** Add action buttons after success:
  - "Submit Another WAR" → Reset form
  - "View My Submissions" → Navigate to submissions list
  - "Go to Dashboard" → Navigate to dashboard
- [ ] **7.4** Show toast notification on success (optional)

### Task 8: Create Error Feedback (AC: #5)
- [ ] **8.1** Create `src/components/features/submit/SubmissionError.tsx`:
  - Error alert component
  - Error icon
  - User-friendly error message
  - Technical details in expandable section (dev mode)
- [ ] **8.2** Handle different error types:
  - Validation errors (display inline)
  - Authentication errors (redirect to login)
  - Database errors ("Failed to save submission. Please try again.")
  - Network errors ("Connection lost. Please check your internet and try again.")
- [ ] **8.3** Implement retry mechanism:
  - "Try Again" button
  - Preserve form data
  - Re-submit with same values
- [ ] **8.4** Log errors to console/monitoring

### Task 9: Add Audit Logging (Supporting all ACs)
- [ ] **9.1** Extend Server Action to log events:
  - SUBMISSION_CREATED - When submission is saved
  - SUBMISSION_CREATE_FAILED - When submission fails
- [ ] **9.2** Store in AuditLog table:
  - Action type
  - User ID
  - Resource ID (submission ID)
  - Timestamp
  - IP address (from headers)
  - User agent
- [ ] **9.3** Ensure no PII in audit logs (just user ID, not email/name)

### Task 10: Create Form Help & Guidance (Supporting all ACs)
- [ ] **10.1** Add help panel/sidebar:
  - Example verbose format
  - Tips for writing good status updates
  - Link to style guide (if exists)
- [ ] **10.2** Add character counter with visual indicator:
  - Shows "X characters" below textarea
  - Turns yellow at 4000 chars
  - Turns red at 4800 chars
  - Blocks at 5000 chars
- [ ] **10.3** Add info tooltip for week selector:
  - Explains week format
  - Shows deadline policy

---

## Dev Notes

### Architecture Compliance

**Form Pattern (per Architecture):**
- Client Component for form interactivity ("use client")
- react-hook-form for state management
- Zod for validation
- Server Action for submission
- shadcn/ui for UI components

**Server Action Pattern:**
```typescript
"use server";

export async function submitWAR(data: SubmissionInput) {
  // 1. Check auth
  // 2. Validate input
  // 3. Perform action
  // 4. Log audit
  // 5. Return result
}
```

### Database Schema Integration

**Submission Model (from Story 1.1):**
```prisma
model Submission {
  id            String   @id @default(cuid())
  userId        String
  weekOf        DateTime
  rawText       String   @db.Text
  terseVersion  String?  @db.Text
  status        SubmissionStatus @default(SUBMITTED)
  isAiGenerated Boolean  @default(false)
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  
  user User @relation(fields: [userId], references: [id])
  reviews Review[]
  auditLogs AuditLog[]
}
```

### Form Validation Rules

**Week Validation:**
- Cannot select future weeks
- Cannot select weeks older than 1 week past (grace period)
- Must be valid ISO week number (1-53)

**Text Validation:**
- Minimum: 10 characters (prevents empty submissions)
- Maximum: 5000 characters (prevents abuse)
- No HTML/script tags (sanitized)

### UX Patterns

**Progressive Enhancement:**
1. Form loads with defaults
2. User fills in week and text
3. Validation happens on blur/submit
4. Submit button shows loading
5. Success/error feedback shown
6. User can navigate elsewhere

**Error Handling:**
- Inline validation errors (immediate feedback)
- Form-level errors (submission failures)
- Network error recovery (retry button)

### Previous Story Intelligence

**From Story 1.3 (Layout & Navigation):**
- PageHeader component available
- ContentCard component available
- AppShell provides consistent layout
- Navigation includes "Submit WAR" link
- EPA branding already applied

**From Story 1.2 (Authentication):**
- `useSession()` hook available
- `getServerSession()` for Server Actions
- User ID available from session

**Key Integration Points:**
- Use existing layout components
- Use existing validation patterns
- Follow existing Server Action pattern

### Testing Approach

**Unit Tests:**
- Test Zod validation schema
- Test week date utilities
- Test form component rendering

**Integration Tests:**
- Test Server Action with mock data
- Test database insertion
- Test audit logging

**E2E Tests:**
- Full submission flow:
  1. Navigate to submit page
  2. Select week
  3. Enter text
  4. Submit
  5. Verify success message
  6. Verify database record created

---

## Project Structure Notes

### Alignment with Unified Project Structure

✅ **Compliant:**
- `src/components/features/submit/` - Feature-specific components (correct)
- `src/app/(dashboard)/submit/` - Route group (correct)
- `src/app/actions/` - Server Actions (correct)
- `src/lib/validation/` - Validation schemas (correct)

### Files to Create/Update

**New Files:**
```
src/
├── app/
│   ├── (dashboard)/
│   │   └── submit/
│   │       ├── page.tsx
│   │       └── success/
│   │           └── page.tsx
│   └── actions/
│       └── submissions.ts
├── components/
│   └── features/
│       └── submit/
│           ├── SubmissionForm.tsx
│           ├── WeekSelector.tsx
│           ├── RawTextInput.tsx
│           ├── SubmissionSuccess.tsx
│           └── SubmissionError.tsx
├── lib/
│   ├── validation/
│   │   └── submission.ts
│   └── date-utils.ts
```

**Update Existing:**
- `src/config/navigation.ts` - Ensure "Submit WAR" link is configured

---

## References

### Source Documents

| Document | Location | Relevant Section |
|----------|----------|------------------|
| **Epics** | `_bmad-output/planning-artifacts/epics.md` | Epic 2, Story 2.1 (lines 80-98) |
| **Architecture** | `_bmad-output/planning-artifacts/architecture.md` | Component Boundaries, API Patterns |
| **Project Context** | `_bmad-output/planning-artifacts/project-context.md` | Forms & Validation patterns |
| **UX Design Spec** | `_bmad-output/planning-artifacts/ux-design-specification.md` | Form patterns, feedback states |
| **Previous Story** | `_bmad-output/stories/1-3-core-layout-navigation.md` | Layout components, PageHeader |

### Technical References

| Technology | Documentation |
|------------|---------------|
| react-hook-form | https://react-hook-form.com/get-started |
| Zod | https://zod.dev/
| @hookform/resolvers | https://github.com/react-hook-form/resolvers |
| shadcn Form | https://ui.shadcn.com/docs/components/form |
| shadcn Textarea | https://ui.shadcn.com/docs/components/textarea |
| shadcn Select | https://ui.shadcn.com/docs/components/select |
| Next.js Server Actions | https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations |

### Date Handling

**ISO Week Format:**
- Week starts on Monday
- Week 1 is the week with the first Thursday of the year
- Use `date-fns` or native `Intl` for calculations

---

## Dev Agent Record

### Agent Model Used

Create Story Agent - Story context generation with form and validation patterns

### Previous Story Intelligence

**From Story 1.3:**
- PageHeader, ContentCard components available
- EPA branding in place
- Navigation structure established
- Layout patterns defined

**From Story 1.2:**
- Authentication system working
- Server Actions pattern established
- Audit logging pattern available

**Key Integration Points:**
- Use PageHeader from shared components
- Wrap form in ContentCard
- Use existing validation patterns
- Follow Server Action structure from auth

### Completion Notes List

**Before Starting Implementation:**
1. Verify Story 1.3 is complete (layout components ready)
2. Verify database has Submission model
3. Review existing validation patterns in project
4. Have date utility library ready (date-fns recommended)

**Common Issues to Watch:**
- Week date calculations can be tricky - use tested library
- Textarea auto-resize vs fixed height - decide UX preference
- Form state persistence on error - use react-hook-form's persist
- Server Action error serialization - return plain objects

### File List

**Files to Create:**
- `src/app/(dashboard)/submit/page.tsx` - Main submission page
- `src/app/(dashboard)/submit/success/page.tsx` - Success page
- `src/app/actions/submissions.ts` - Server Action
- `src/components/features/submit/SubmissionForm.tsx` - Main form
- `src/components/features/submit/WeekSelector.tsx` - Week picker
- `src/components/features/submit/RawTextInput.tsx` - Text input
- `src/components/features/submit/SubmissionSuccess.tsx` - Success display
- `src/components/features/submit/SubmissionError.tsx` - Error display
- `src/lib/validation/submission.ts` - Zod schema
- `src/lib/date-utils.ts` - Date helpers

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Form renders correctly with EPA branding
- [ ] Week selector shows current week by default
- [ ] Textarea accepts verbose input (10-5000 chars)
- [ ] Validation shows inline errors
- [ ] Submit button shows loading state during submission
- [ ] Success page/message shown after submission
- [ ] Error handling with user-friendly messages
- [ ] Submission saved to database with SUBMITTED status
- [ ] Audit log entry created for each submission
- [ ] E2E test: Complete submission flow works
- [ ] Ready for Story 2.2: AI Terse Conversion Integration

**Next Story Dependencies:**
- Story 2.2 requires: Submission form exists, can add AI conversion
- Story 2.3 requires: Submission records exist in database

**Integration Points:**
- Story 2.2 will add AI preview alongside text input
- Story 2.3 will show submitted records in history
- Navigation already links to this page from Story 1.3
