# Story 2.2: AI Terse Conversion Integration

Status: ready-for-dev
Created: 2026-02-19
Epic: WAR Submission Flow (Epic 2)
Depends On: Story 2.1 (WAR Submission Form)

---

## Story

As a WAR contributor,  
I want my verbose status update automatically converted to terse format,  
so that I don't have to write two versions.

---

## Acceptance Criteria

- [ ] **AC1:** AI service abstraction layer created
- [ ] **AC2:** Real-time conversion via Server Action
- [ ] **AC3:** Side-by-side raw vs. terse comparison view
- [ ] **AC4:** Confidence score displayed for AI output
- [ ] **AC5:** Manual override option if AI conversion is incorrect
- [ ] **AC6:** Fallback to manual entry if AI service unavailable

---

## Tasks / Subtasks

### Task 1: Create AI Service Abstraction Layer (AC: #1)
- [ ] **1.1** Create `src/lib/ai/service.ts`:
  - `convertToTerse(rawText: string, options?: ConvertOptions): Promise<TerseResult>`
  - Abstract internal EPA AI service HTTP client
  - Handle authentication (API key from env)
  - Request/response type definitions
- [ ] **1.2** Define types in `src/lib/ai/types.ts`:
  ```typescript
  export interface ConvertOptions {
    promptTemplateId?: string;
    timeout?: number;
  }
  
  export interface TerseResult {
    terseText: string;
    confidence: number; // 0-1
    processingTime: number; // ms
    modelVersion: string;
  }
  
  export interface AIError {
    code: string;
    message: string;
    retryable: boolean;
  }
  ```
- [ ] **1.3** Create `src/lib/ai/prompts.ts`:
  - Default prompt template for terse conversion
  - Prompt versioning support
  - Example:
    ```typescript
    export const DEFAULT_PROMPT = `
      Convert the following verbose weekly activity report to a terse format.
      Terse format rules:
      - Use abbreviations (e.g., "mtg" for meeting)
      - Remove articles (a, an, the)
      - Use action verbs only
      - One line per major activity
      - Maximum 5 bullet points
      
      Input:
      {rawText}
      
      Output (terse format only):
    `;
    ```
- [ ] **1.4** Create `src/lib/ai/cache.ts`:
  - In-memory LRU cache for conversion results
  - Cache key: hash of rawText + prompt version
  - TTL: 1 hour
  - Max entries: 100

### Task 2: Build AI Conversion Server Action (AC: #2)
- [ ] **2.1** Create `src/app/actions/ai-convert.ts`:
  - "use server" directive
  - `convertToTerseAction(rawText: string): Promise<ConvertResult>`
- [ ] **2.2** Implement with timeout and retry:
  ```typescript
  export async function convertToTerseAction(rawText: string) {
    // Check cache first
    const cached = getCachedResult(rawText);
    if (cached) return { success: true, ...cached };
    
    // Call AI service with timeout
    try {
      const result = await Promise.race([
        callAIService(rawText),
        new Promise((_, reject) => 
          setTimeout(() => reject(new Error("Timeout")), 5000)
        ),
      ]);
      
      // Cache result
      cacheResult(rawText, result);
      
      return { success: true, ...result };
    } catch (error) {
      // Retry logic (max 2 retries)
      if (isRetryable(error) && retries < 2) {
        retries++;
        await delay(1000 * retries); // Exponential backoff
        return convertToTerseAction(rawText);
      }
      
      return { 
        success: false, 
        error: formatAIError(error),
        fallback: true 
      };
    }
  }
  ```
- [ ] **2.3** Add rate limiting:
  - Max 10 conversions per user per minute
  - Store rate limit in Redis/memory
- [ ] **2.4** Handle error cases:
  - Service unavailable (503)
  - Timeout (504)
  - Invalid input (400)
  - Rate limit exceeded (429)

### Task 3: Create Side-by-Side Comparison UI (AC: #3)
- [ ] **3.1** Create `src/components/features/submit/AIPreview.tsx`:
  - "use client" directive
  - Split-pane or stacked layout
  - Left: Raw text (read-only, highlighted)
  - Right: Terse preview (with edit option)
- [ ] **3.2** Enhance existing `SubmissionForm.tsx`:
  - Add "Preview Conversion" button
  - Toggle between single textarea and side-by-side view
  - Animate transition between views
- [ ] **3.3** Implement responsive layout:
  - Desktop: Horizontal split (50/50)
  - Mobile: Vertical stack (raw on top, terse below)
- [ ] **3.4** Add visual indicators:
  - Raw text panel: "Original" label
  - Terse panel: "AI Converted" label with sparkles icon
  - Sync scroll (optional feature)

### Task 4: Display Confidence Score (AC: #4)
- [ ] **4.1** Create `src/components/features/submit/ConfidenceBadge.tsx`:
  - Display confidence as percentage (e.g., "87% confidence")
  - Color coding:
    - Green (≥80%): High confidence
    - Yellow (60-79%): Medium confidence
    - Red (<60%): Low confidence - recommend review
- [ ] **4.2** Add tooltip explaining confidence:
  - "Based on pattern matching and semantic analysis"
  - Link to documentation about AI conversion
- [ ] **4.3** Show processing time:
  - "Converted in 1.2s" (small text below confidence)
- [ ] **4.4** Add refresh/regenerate button:
  - Re-run conversion with same raw text
  - Useful if first result wasn't satisfactory

### Task 5: Implement Manual Override (AC: #5)
- [ ] **5.1** Make terse preview editable:
  - Convert terse display to textarea
  - Enable when user clicks "Edit"
  - Save edits to form state
- [ ] **5.2** Add "Use AI Version" / "Use My Version" toggle:
  - Default: AI version selected
  - User can switch to manual input
  - Visual indication of which is active
- [ ] **5.3** Track isAiGenerated flag:
  - Set to `true` if using AI version (even if edited)
  - Set to `false` if user completely replaced with manual entry
  - Store in form state and submission record
- [ ] **5.4** Add warning for low confidence:
  - If confidence <70%, show alert: "Please review AI conversion carefully"
  - Highlight potentially problematic sections

### Task 6: Create Service Unavailable Fallback (AC: #6)
- [ ] **6.1** Detect AI service failures:
  - 503 Service Unavailable
  - Timeout after 5 seconds + 2 retries
  - Network errors
- [ ] **6.2** Show user-friendly message:
  - "AI conversion temporarily unavailable"
  - "Please enter terse version manually or try again later"
  - Option to "Retry" or "Enter Manually"
- [ ] **6.3** Enable manual terse entry:
  - Show textarea for manual terse input
  - Same validation as raw text (10-5000 chars)
  - Pre-fill with empty or placeholder text
- [ ] **6.4** Log service failures:
  - Track AI service uptime
  - Alert administrators if service down >5 minutes

### Task 7: Integrate with Submission Form (Supporting all ACs)
- [ ] **7.1** Update `SubmissionForm.tsx`:
  - Add state for terse conversion:
    ```typescript
    interface ConversionState {
      status: 'idle' | 'converting' | 'success' | 'error';
      result?: TerseResult;
      error?: string;
      useManual: boolean;
      manualText: string;
    }
    ```
- [ ] **7.2** Add conversion trigger:
  - "Preview Conversion" button below raw textarea
  - Debounced auto-convert after typing stops (optional)
  - Loading state during conversion
- [ ] **7.3** Update submission payload:
  - Include `terseVersion` (AI or manual)
  - Include `isAiGenerated` flag
  - Include `aiConfidence` if AI-generated
- [ ] **7.4** Enhance submit Server Action:
  - Accept terse version from form
  - Validate terse text (min 10 chars)
  - Store AI metadata in submission record

### Task 8: Add Real-Time Updates (Supporting AC: #2)
- [ ] **8.1** Implement optimistic UI:
  - Show loading spinner immediately on convert click
  - Don't wait for server response to show animation
- [ ] **8.2** Add cancel conversion:
  - AbortController for fetch timeout
  - "Cancel" button during conversion
  - Return to raw-only view
- [ ] **8.3** Handle streaming (if supported):
  - If AI service supports SSE/WebSocket
  - Show progressive output
  - Otherwise use standard request/response

### Task 9: Create Help & Guidance (Supporting all ACs)
- [ ] **9.1** Add info tooltip about AI conversion:
  - "What is terse format?"
  - Example comparison (verbose vs terse)
  - Link to style guide
- [ ] **9.2** Create help panel:
  - "Tips for better AI conversion"
  - "Common abbreviations used"
  - "Review checklist before submitting"
- [ ] **9.3** Add first-time user modal:
  - Explain AI conversion feature
  - Show example
  - "Don't show again" checkbox

---

## Dev Notes

### Architecture Compliance

**AI Service Pattern (per Architecture):**
- Abstract AI service in `src/lib/ai/` folder
- Server Action for conversion (stateless)
- Internal EPA service only (NO external APIs like OpenAI)
- HTTP client with timeout and retry

**Service Boundaries:**
```
Client Component (SubmissionForm)
  ↓ calls
Server Action (convertToTerseAction)
  ↓ calls
AI Service (src/lib/ai/service.ts)
  ↓ HTTP POST
Internal EPA AI Service
```

### AI Service Configuration

**Environment Variables:**
```
AI_SERVICE_URL="https://internal-epa-ai.gov/api/v1/convert"
AI_SERVICE_API_KEY="your-api-key"
AI_SERVICE_TIMEOUT_MS="5000"
AI_SERVICE_MAX_RETRIES="2"
```

**Request Format:**
```json
{
  "text": "verbose status update text...",
  "options": {
    "format": "terse",
    "maxLength": 500,
    "style": "epa-war"
  }
}
```

**Response Format:**
```json
{
  "terseText": "- Comp Q4 emissions analysis\n- Attended stakeholder mtg\n- Reviewed 15 permits",
  "confidence": 0.87,
  "processingTimeMs": 1200,
  "modelVersion": "epa-convert-v1.2"
}
```

### Caching Strategy

**Cache Implementation:**
- LRU cache with max 100 entries
- TTL: 1 hour
- Key: `sha256(rawText + promptVersion)`
- Value: `TerseResult`
- Eviction: LRU when max size reached

**Benefits:**
- Faster repeated conversions
- Reduce load on AI service
- Better user experience

### Previous Story Intelligence

**From Story 2.1 (WAR Submission Form):**
- Form structure exists with react-hook-form
- Week selector and raw textarea implemented
- Submission Server Action available
- Validation with Zod established
- Audit logging pattern in place

**Key Integration Points:**
- Enhance existing `SubmissionForm.tsx`
- Reuse existing validation patterns
- Call existing submit Server Action with new fields
- Use established shadcn components

### Testing Approach

**Unit Tests:**
- Test AI service client (mock HTTP calls)
- Test caching logic
- Test confidence badge color logic

**Integration Tests:**
- Test Server Action with mocked AI service
- Test form state management with conversion

**E2E Tests:**
- Full conversion flow:
  1. Enter raw text
  2. Click "Preview Conversion"
  3. Verify side-by-side view
  4. Check confidence score
  5. Edit terse version
  6. Submit with AI-generated flag

### Error Handling Matrix

| Error Type | User Message | Action |
|------------|--------------|--------|
| Service unavailable | "AI conversion temporarily unavailable" | Show manual entry |
| Timeout | "Conversion timed out" | Retry button |
| Rate limit | "Too many requests" | Wait message |
| Invalid input | "Input too short/long" | Validation error |
| Network error | "Connection lost" | Retry button |

---

## Project Structure Notes

### Alignment with Unified Project Structure

✅ **Compliant:**
- `src/lib/ai/` - Service abstraction (correct)
- `src/app/actions/` - Server Actions (correct)
- `src/components/features/submit/` - Feature components (correct)

### Files to Create/Update

**New Files:**
```
src/
├── lib/
│   └── ai/
│       ├── service.ts
│       ├── types.ts
│       ├── prompts.ts
│       └── cache.ts
├── app/
│   └── actions/
│       └── ai-convert.ts
├── components/
│   └── features/
│       └── submit/
│           ├── AIPreview.tsx
│           ├── ConfidenceBadge.tsx
│           └── ... (update existing)
```

**Update Existing:**
- `src/components/features/submit/SubmissionForm.tsx` - Add AI integration
- `src/components/features/submit/RawTextInput.tsx` - Add convert button
- `src/app/actions/submissions.ts` - Accept terse fields
- `src/lib/validation/submission.ts` - Add terse validation

---

## References

### Source Documents

| Document | Location | Relevant Section |
|----------|----------|------------------|
| **Epics** | `_bmad-output/planning-artifacts/epics.md` | Epic 2, Story 2.2 (lines 99-117) |
| **Architecture** | `_bmad-output/planning-artifacts/architecture.md` | Service Boundaries (lines 576-579), AI Processing |
| **Project Context** | `_bmad-output/planning-artifacts/project-context.md` | Service patterns, error handling |
| **Previous Story** | `_bmad-output/stories/2-1-war-submission-form.md` | Form structure, validation, Server Actions |

### Technical References

| Technology | Documentation |
|------------|---------------|
| AbortController | https://developer.mozilla.org/en-US/docs/Web/API/AbortController |
| Promise.race | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/race |
| LRU Cache | https://github.com/isaacs/node-lru-cache |
| shadcn Alert | https://ui.shadcn.com/docs/components/alert |

---

## Dev Agent Record

### Agent Model Used

Create Story Agent - Story context generation with AI service integration patterns

### Previous Story Intelligence

**From Story 2.1:**
- Form exists with react-hook-form
- Week selector working
- Raw textarea implemented
- Submit Server Action ready
- Validation with Zod established

**Key Integration Points:**
- Add conversion state to existing form state
- Reuse form submission flow
- Enhance existing UI with side-by-side view
- Leverage existing validation patterns

### Completion Notes List

**Before Starting Implementation:**
1. Verify Story 2.1 is complete (form structure ready)
2. Obtain internal EPA AI service documentation
3. Get API endpoint and authentication details
4. Confirm AI service supports the conversion endpoint

**Common Issues to Watch:**
- AI service latency: Always implement timeout
- Rate limiting: Implement client-side throttling
- Caching: Don't cache failed requests
- Error handling: Distinguish retryable vs non-retryable errors
- Form state: Ensure terse version is included in submission

### File List

**Files to Create:**
- `src/lib/ai/service.ts` - AI service HTTP client
- `src/lib/ai/types.ts` - TypeScript interfaces
- `src/lib/ai/prompts.ts` - Default prompt templates
- `src/lib/ai/cache.ts` - LRU cache implementation
- `src/app/actions/ai-convert.ts` - Conversion Server Action
- `src/components/features/submit/AIPreview.tsx` - Side-by-side preview
- `src/components/features/submit/ConfidenceBadge.tsx` - Confidence display

**Files to Update:**
- `src/components/features/submit/SubmissionForm.tsx` - Add conversion flow
- `src/app/actions/submissions.ts` - Add terse fields to submission
- `src/lib/validation/submission.ts` - Add terse validation

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] AI service abstraction layer created with timeout/retry
- [ ] Conversion Server Action working with caching
- [ ] Side-by-side raw vs terse view implemented
- [ ] Confidence score displayed with color coding
- [ ] Manual override/edit functionality working
- [ ] Fallback to manual entry when AI unavailable
- [ ] Form includes terse version in submission
- [ ] E2E test: Full conversion flow works end-to-end
- [ ] Ready for Story 2.3: Submission Confirmation & History

**Next Story Dependencies:**
- Story 2.3 requires: Submissions with terse versions exist in database
- Story 3.1 requires: AI conversion working for Jake to review

**Integration Points:**
- Story 2.1 provides form foundation
- Story 3.2 will reuse AIPreview component for review interface
- Story 3.3 will manage prompt templates used here
