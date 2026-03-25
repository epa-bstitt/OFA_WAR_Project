---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
inputDocuments: [
  'c:/Users/Buyer/Documents/CascadeProjects/EPABusinessPlatform/_bmad-output/planning-artifacts/product-brief-EPABusinessPlatform-2026-02-09.md',
  'c:/Users/Buyer/Documents/CascadeProjects/EPABusinessPlatform/_bmad-output/planning-artifacts/prd.md'
]
---

# UX Design Specification - EPABusinessPlatform

**Author:** Jake
**Date:** 2026-02-18

---

<!-- UX design content will be appended sequentially through collaborative workflow steps -->

## Executive Summary

### Project Vision

EPABusinessPlatform is a Weekly Activity Report (WAR) Modernization system designed to replace a manual, time-intensive OneNote-based process consuming 30 hours/week of ITSB leadership time. The solution combines a Next.js web application with AI-powered terse conversion, Microsoft Teams bot integration, and seamless Microsoft Graph API connectivity to automate status reporting while maintaining backward compatibility with existing senior management workflows.

**Core UX Value Proposition:** Transform "herding cats" into "one-click clarity" - giving Jake his 15 hours/week back, Will his executive insights, and Contributors a frictionless submission experience that actually saves them time.

### Target Users

**Primary Users:**

1. **Contributors (19 Team Members)** - Federal employees across Contracts Management (10) and Service & Project Management (9) sections
   - **Tech Profile:** Moderate technical comfort, heavy Microsoft 365 users
   - **Primary Device:** Desktop/laptop with Teams open all day
   - **Pain Point:** Manual copy-paste from unwieldy OneNote, remembering to submit, formatting anxiety
   - **Success Metric:** Submit in < 2 minutes without leaving Teams workflow

2. **Aggregator (Jake)** - IT Specialist, Service and Project Management Section
   - **Tech Profile:** Technical power user, currently building this system
   - **Primary Device:** Desktop with multiple monitors
   - **Pain Point:** Spending ~15 hrs/week chasing 19 people via calls/texts, manual formatting cleanup
   - **Success Metric:** Dashboard shows status at a glance, zero manual chasing

3. **Program Overseer (Will)** - Program Manager reviewing ITSB portfolio
   - **Tech Profile:** Executive-level technical comfort
   - **Primary Device:** Desktop, tablet for mobile review
   - **Pain Point:** Inconsistent formatting requiring manual cleanup, no historical visibility
   - **Success Metric:** AI flags issues proactively, 10-minute review workflow

**Secondary Users:**

4. **Senior Management** - Executive leadership consuming OneNote output
   - **Tech Profile:** Minimal change tolerance
   - **Primary Device:** Desktop, familiar with current OneNote format
   - **Pain Point:** None (must see zero change)
   - **Success Metric:** Continue existing workflow, see cleaner more consistent content

### Key Design Challenges

1. **Multi-Modal Interaction Consistency**
   - Teams bot adaptive cards must feel equivalent to web interface
   - Same AI terse conversion, same submission flow, same confirmation patterns
   - Challenge: Teams has constrained UI capabilities vs. web flexibility

2. **AI Trust and Transparency**
   - Users must see AI conversions before finalizing (no black box)
   - Jake needs control over AI prompts (customization without breaking)
   - Challenge: Balance AI assistance with user control

3. **3-Stage Review Workflow Complexity**
   - Contributor submits → Jake edits terse → Will final reviews → OneNote
   - Each stage needs clear status visibility and handoff cues
   - Challenge: Make complex workflow feel simple and obvious

4. **Federal Government Constraints**
   - Cloud.gov hosting (no arbitrary external services)
   - WCAG 2.1 AA accessibility compliance
   - Security-first design (SSO, encryption, audit logging)
   - Challenge: Innovative UX within rigid constraints

5. **Invisible Integration**
   - Senior management must see zero change to OneNote experience
   - Graph API integration must be 100% reliable (no partial updates)
   - Challenge: Magic that never breaks

### Design Opportunities

1. **AI-Assisted Confidence**
   - Real-time terse preview as user types builds trust in AI
   - Side-by-side raw vs. terse comparison eliminates uncertainty
   - Opportunity: Make AI feel like a helpful colleague, not a replacement

2. **Friction Elimination**
   - Pre-populated templates from previous submission (no blank page)
   - One-click submit from Teams (no context switching)
   - Auto-save drafts (never lose work)
   - Opportunity: Submission feels faster than current OneNote process

3. **Dashboard Clarity**
   - Card-based layout for Jake to scan 19 contributors at a glance
   - Color-coded status (submitted/pending/overdue) with counts
   - Inline editing without page navigation
   - Opportunity: Replace "herding cats" anxiety with calm control

4. **Seamless Handoffs**
   - Clear visual cues showing submission progress through workflow stages
   - One-click approval with batch processing for Will
   - Automatic OneNote publication with confirmation
   - Opportunity: Each handoff feels effortless and reliable

5. **Smart Notifications**
   - Contextual reminders that feel helpful, not nagging
   - Progressive escalation (gentle → firm) based on user history
   - Direct action links in every notification
   - Opportunity: Users feel supported, not harassed

### Animation & Motion Design Philosophy

**Design Aesthetic: Apple.com Inspired**

The interface will employ sophisticated, purposeful animations that guide attention and create a premium feel without overwhelming the user. Motion should feel natural, physics-based, and meaningful.

**Page Transitions:**
- Smooth fade transitions between dashboard views (200-300ms ease-out)
- Staggered content reveal on page load (elements fade in sequentially 50ms apart)
- Slide transitions for mobile navigation drawers (spring physics, not linear)
- Cross-fade between raw and terse content views in the review interface

**Issue Highlighting & Micro-interactions:**
- **Overdue submissions:** Subtle pulse animation on status badges (scale 1.0 → 1.05 → 1.0, 2s loop)
- **AI conversion complete:** Success checkmark draws itself (SVG stroke animation)
- **New notifications:** Gentle slide-in from right with slight bounce at end
- **Form validation errors:** Shake animation on invalid fields (translateX -5px → 5px → 0, 300ms)
- **Loading states:** Skeleton screens with shimmer effect, not spinners

**Hover & Focus States:**
- Cards lift with soft shadow on hover (translateY -2px, shadow expansion)
- Buttons have magnetic cursor attraction effect (subtle, 5px range)
- Interactive elements show scale feedback on click (0.98 scale, 100ms)
- Focus rings animate in with a "draw" effect rather than instant appearance

**Data Visualization:**
- Count-up animations for metrics (numbers animate from 0 to final value)
- Progress bars fill with easing (cubic-bezier, not linear)
- Status changes transition color smoothly (300ms color interpolation)

**Performance Requirements:**
- All animations use CSS transforms (GPU-accelerated, no layout thrashing)
- Support `prefers-reduced-motion` media query for accessibility
- Animations must complete within 300ms for interactions, 500ms for page transitions
- No animation should block user input or delay critical functionality

---

## 2. Core User Experience

### 2.1 Defining Experience

**The Core Interaction: "Submit, Review, Approve"**

The defining experience of EPABusinessPlatform is the seamless three-stage workflow: Contributors submit via Teams or web, Jake reviews and edits AI terse conversions, Will performs final approval and publishes to OneNote.

**User Description:** *"I just type my update in Teams, the AI makes it executive-ready, and it magically appears in OneNote for management. No copy-paste, no formatting, no chasing people."*

### 2.2 User Mental Model

**How Users Currently Think:**
- Contributors see WAR as a tedious obligation with formatting anxiety
- Jake sees it as a time-consuming coordination nightmare ("herding cats")
- Will sees it as inconsistent content requiring manual cleanup

**How We Want Users to Think:**
- Contributors: "This is easier than the old way - the AI helps me write better"
- Jake: "I can see everything at a glance and only touch what needs it"
- Will: "I review polished content, approve, and it just works"

### 2.3 Success Criteria

**Core Experience Success Indicators:**

1. **Contributor Success:** Submit in < 2 minutes from Teams without context switching
2. **Jake Success:** Dashboard review takes < 10 minutes for all 19 contributors
3. **Will Success:** Batch approval workflow completes in < 5 minutes
4. **End-to-End Success:** Raw submission → OneNote publication < 30 minutes

### 2.4 Experience Mechanics

**Contributor Flow:**
```
Start → See Template → Type Update → AI Preview → Review & Edit → Submit → Confirmation → Done
```

**Jake Flow:**
```
Dashboard → Scan Cards → Click Card → Side-by-Side View → Edit Terse (if needed) → Approve → Batch Approve → Done
```

**Will Flow:**
```
Review Interface → Set Date Range → Filter/Sort → Review Content → Edit if Needed → Approve Single or Batch → OneNote Sync → Confirmation → Done
```

---

## 3. Desired Emotional Response

### 3.1 Primary Emotional Goals

**Core Emotion: Empowered Control**

Users should feel:
1. **Confident** - The system handles complexity, I just do my part
2. **Efficient** - This is faster and better than the old way
3. **In Control** - I can see status, edit as needed

### 3.2 Emotional Journey

| Stage | Contributor | Jake | Will |
|-------|-------------|------|------|
| **First Use** | Surprised by AI | Relieved by dashboard | Impressed by quality |
| **Core Action** | Satisfied | Productive | Efficient |
| **Success** | Confident | Accomplished | Complete |

### 3.3 Design Principles

1. **Always Provide Control** - Even when AI works, users can override
2. **Make Progress Visible** - Clear feedback and next steps
3. **Celebrate Efficiency** - Make time savings tangible
4. **Design for Skepticism** - Prove reliability to first-time users
5. **Maintain Transparency** - Show what's happening behind the scenes

---

## 4. UX Pattern Analysis & Inspiration

### 4.1 Inspiring Products

**Linear (linear.app)** - Clean card-based task display, keyboard shortcuts, inline editing
**Notion (notion.so)** - Slash commands, real-time collaboration, block-based editing
**Slack/Teams** - Conversational bot interactions, adaptive cards
**GitHub Projects** - Kanban workflow visualization, filter chips

### 4.2 Transferable Patterns

**Navigation:** Command palette (`/war` slash command), sidebar navigation, breadcrumbs
**Interaction:** Inline editing, split-pane views, progressive disclosure, smart defaults
**Visual:** Card-based layout, subtle status colors, typography hierarchy, generous whitespace

### 4.3 Anti-Patterns to Avoid

- Dashboard overload (too many metrics)
- Hidden actions (buried in menus)
- Modal hell (chains of dialogs)
- Notification spam
- AI black box (no visibility)

---

## 5. Design System Foundation

### 5.1 Design System Choice

**Selected: Shadcn/UI + Tailwind CSS**

**Rationale:**
- Built on Tailwind (matches Next.js technical stack)
- Radix UI primitives (accessible, keyboard-navigable)
- Themeable (easy EPA brand customization)
- Modern React patterns (Server/Client compatible)
- Cloud.gov compatible (self-hosted)

### 5.2 Implementation Roadmap

**Phase 1 - Foundation Components:** Button, Card, Input, Textarea, Dialog, Table, Badge, Alert
**Phase 2 - WAR-Specific:** SubmissionCard, ReviewPanel, StatusTimeline
**Phase 3 - Enhancement:** PromptEditor, MetricCard, NotificationToast

---

## 6. Visual Design Foundation

### 6.1 Color System

**Primary Palette:**
- Primary: #0F4C81 (EPA Blue)
- Success: #10B981 (Submitted/Approved)
- Warning: #F59E0B (Pending/Deadline)
- Error: #EF4444 (Overdue/Error)

**Neutral Palette:**
- Background: #FFFFFF
- Surface: #F8FAFC
- Text Primary: #1E293B
- Text Secondary: #64748B

### 6.2 Typography System

**Font Family:** Inter (Google Fonts)

**Type Scale:**
- H1: 32px/700 (Page titles)
- H2: 24px/600 (Section headers)
- H3: 20px/600 (Card titles)
- Body: 16px/400 (Paragraphs)
- Body Small: 14px/400 (Metadata)

### 6.3 Spacing & Layout

**Spacing Scale:** 4px base unit (4, 8, 12, 16, 24, 32, 48)
**Container:** Max-width 1440px, 24px padding
**Grid:** 12-column with 24px gutters
**Card Padding:** 16px-24px

---

## 7. User Journey Flows

### 7.1 Contributor Submission Journey

1. **Entry:** Teams `/war` command or web dashboard
2. **Template:** Pre-filled from previous submission
3. **Input:** Type raw update in textarea
4. **AI Preview:** Real-time terse conversion appears
5. **Review:** User sees side-by-side comparison
6. **Edit:** Optional editing of terse version
7. **Submit:** One-click submission
8. **Confirmation:** Success message with submission ID

### 7.2 Jake Review Journey

1. **Dashboard:** Card grid showing 19 contributors
2. **Filter:** By section (Contracts/Service) or status
3. **Review:** Click card opens split-pane view
4. **Edit:** Inline editing of AI terse if needed
5. **Approve:** Single or batch approval
6. **Confirm:** Status updates to "Approved"

### 7.3 Will Publication Journey

1. **Interface:** Date range selector (default 2 weeks)
2. **Filter:** By person, project, or search
3. **Review:** List view of approved submissions
4. **Edit:** Inline editing if needed
5. **Batch Approve:** Multi-select and confirm
6. **OneNote Sync:** Graph API publication
7. **Confirmation:** Success with OneNote link

---

## 8. Component Strategy

### 8.1 Foundation Components (Shadcn)

Button, Card, Input, Textarea, Select, Dialog, Sheet, Table, Badge, Alert, Tabs, Skeleton

### 8.2 Custom Components

**SubmissionCard** - Avatar, name, section, status badge, content preview, timestamp, actions
**ReviewPanel** - Split-pane (raw vs terse), inline editing, action buttons
**StatusTimeline** - Visual workflow stages (Submitted → Review → Approved → Published)
**PromptEditor** - AI prompt customization with version history
**MetricCard** - Title, metric, context, trend indicator

---

## 9. UX Consistency Patterns

### 9.1 Button Hierarchy

**Primary:** Submit, Approve, Save (EPA Blue, solid)
**Secondary:** Edit, View (outlined/ghost)
**Tertiary:** Cancel, Close (minimal, gray)
**Destructive:** Delete, Reject (red, requires confirmation)

### 9.2 Feedback Patterns

**Success:** Toast notification, green checkmark, auto-dismiss 3s
**Error:** Inline validation, red icon, actionable message
**Warning:** Yellow/amber, non-blocking alerts
**Loading:** Skeleton screens, spinners for buttons

### 9.3 Form Patterns

- Label above input (not inline)
- Validation on blur (not while typing)
- 16px between label and input
- 24px between form fields
- Primary submit button, cancel as text link

### 9.4 Navigation Patterns

- Role-based sidebar navigation
- Tabs for view switching (By Section, By Status)
- Filter chips for quick filtering
- Breadcrumbs for deep navigation

---

## 10. Responsive Design & Accessibility

### 10.1 Responsive Strategy

**Desktop (1024px+):** Full sidebar, multi-column, split-pane review, hover states
**Tablet (768-1023px):** Collapsible sidebar, tabbed review interface, touch targets
**Mobile (320-767px):** Bottom navigation, single column, full-screen panels

### 10.2 Breakpoints

- sm: 640px (mobile landscape)
- md: 768px (tablet)
- lg: 1024px (desktop)
- xl: 1280px (large desktop)

### 10.3 Accessibility (WCAG 2.1 AA)

**Visual:** 4.5:1 contrast ratio, color not sole indicator, text resizable
**Interaction:** Keyboard accessible, no traps, skip links, visible focus
**Screen Reader:** Semantic HTML, ARIA labels, alt text, live regions
**Motion:** Respect `prefers-reduced-motion`, no auto-play, no flashing

---

## 11. Summary

### 11.1 Key Decisions

| Decision | Choice |
|----------|--------|
| Design System | Shadcn/UI + Tailwind |
| Visual Aesthetic | Minimal Professional |
| Animation | Apple-inspired motion |
| Accessibility | WCAG 2.1 AA |

### 11.2 Success Metrics

- Contributor submission time < 2 minutes
- Jake review time < 10 minutes (19 contributors)
- Will approval workflow < 5 minutes
- User satisfaction > 4/5
- Zero accessibility violations

### 11.3 Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-18 | Jake | Initial UX specification |
