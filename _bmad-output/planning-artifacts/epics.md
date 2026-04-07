# EPABusinessPlatform - Epics & User Stories

**Project:** EPA Business Platform - Weekly Activity Report (WAR) Modernization  
**Date:** 2026-02-19  
**Status:** Initial Sprint Planning

---

## Epic 1: Foundation & Authentication

**Objective:** Establish the core application infrastructure, database schema, and EPA MAX authentication integration.

**Business Value:** Provides secure access to the WAR system and establishes the technical foundation for all subsequent features.

### Story 1.1: Project Initialization & Database Setup

**As a** developer  
**I want** to initialize the Next.js project with shadcn/ui and configure PostgreSQL with Prisma  
**So that** we have a solid technical foundation for development

**Acceptance Criteria:**
- [ ] Next.js 14 project initialized with TypeScript and Tailwind CSS
- [ ] shadcn/ui configured with 11+ base components
- [ ] Prisma schema defined with all models (User, Submission, Review, etc.)
- [ ] PostgreSQL database connection configured
- [ ] Initial migration created and applied
- [ ] Project structure follows architecture document

**Technical Notes:**
- Use `npx shadcn@latest init` for project setup
- Prisma schema must include pgvector extension for AI embeddings
- Follow naming conventions from project-context.md

### Story 1.2: EPA MAX Authentication Integration

**As a** WAR contributor  
**I want** to sign in using my EPA MAX credentials  
**So that** I can securely access the system with my existing account

**Acceptance Criteria:**
- [ ] NextAuth configured with Azure AD B2C provider
- [ ] Login page with EPA MAX button implemented
- [ ] JWT session strategy implemented
- [ ] Role-based access control (4 roles) configured
- [ ] Protected routes middleware implemented
- [ ] Sign-out functionality works correctly

**Technical Notes:**
- Use `@auth/prisma-adapter` for session storage
- Roles: CONTRIBUTOR, AGGREGATOR, PROGRAM_OVERSEER, ADMINISTRATOR
- Middleware protects `/dashboard`, `/review`, `/approve`, `/admin` routes

### Story 1.3: Core Layout & Navigation

**As a** WAR contributor  
**I want** a consistent navigation and layout across the application  
**So that** I can easily navigate between different sections

**Acceptance Criteria:**
- [ ] Root layout with EPA branding implemented
- [ ] Navigation component with role-based menu items
- [ ] Responsive sidebar/header navigation
- [ ] User menu with profile and sign-out options
- [ ] Loading states for all pages
- [ ] Error boundaries implemented

**Technical Notes:**
- Use Server Components for layout where possible
- Navigation must show different items based on user role
- Include EPA logo and colors

---

## Epic 2: WAR Submission Flow

**Objective:** Enable contributors to submit weekly activity reports via web interface with AI-powered terse conversion.

**Business Value:** Streamlines the WAR submission process and reduces manual editing through AI assistance.

### Story 2.1: WAR Submission Form

**As a** WAR contributor  
**I want** to submit my weekly activity report through a web form  
**So that** I can provide my updates without using email

**Acceptance Criteria:**
- [ ] Submission form with week selector implemented
- [ ] Large textarea for raw text input (verbose format)
- [ ] Form validation (minimum 10 characters)
- [ ] Submit button with loading state
- [ ] Success/error feedback after submission
- [ ] Submission saved to database with SUBMITTED status

**Technical Notes:**
- Use react-hook-form with Zod validation
- Server Action for form submission
- Include audit logging

### Story 2.2: AI Terse Conversion Integration

**As a** WAR contributor  
**I want** my verbose status update automatically converted to terse format  
**So that** I don't have to write two versions

**Acceptance Criteria:**
- [ ] AI service abstraction layer created
- [ ] Real-time conversion via Server Action
- [ ] Side-by-side raw vs. terse comparison view
- [ ] Confidence score displayed for AI output
- [ ] Manual override option if AI conversion is incorrect
- [ ] Fallback to manual entry if AI service unavailable

**Technical Notes:**
- Call internal EPA AI service (NOT external APIs)
- Implement timeout (5 seconds) and retry logic
- Cache conversion results

### Story 2.3: Submission Confirmation & History

**As a** WAR contributor  
**I want** to see my submission history and confirmation after submitting  
**So that** I can track my past submissions

**Acceptance Criteria:**
- [ ] Submission confirmation page with summary
- [ ] Personal submission history list
- [ ] Filter by status (submitted, approved, published)
- [ ] View detailed submission with raw and terse versions
- [ ] Edit submission before review stage
- [ ] Delete draft submissions

**Technical Notes:**
- Dashboard shows user's submissions
- Edit only allowed before IN_REVIEW status
- Soft delete with audit log

---

## Epic 3: Review Workflow (Aggregator)

**Objective:** Enable Jake (Aggregator) to review and edit AI-generated terse conversions before approval.

**Business Value:** Ensures quality control and accuracy of terse reports before publication.

### Story 3.1: Review Dashboard (Jake's View)

**As an** Aggregator (Jake)  
**I want** to see all pending submissions that need my review  
**So that** I can efficiently process WAR submissions

**Acceptance Criteria:**
- [ ] Dashboard showing submissions in SUBMITTED status
- [ ] Filter by contributor, week, or status
- [ ] Quick stats (pending, reviewed today, total)
- [ ] Priority indicators for overdue submissions
- [ ] Bulk selection for batch operations
- [ ] Real-time updates when new submissions arrive

**Technical Notes:**
- Only accessible to AGGREGATOR and above roles
- Use React Query for data fetching with polling
- Optimistic updates for status changes

### Story 3.2: Side-by-Side Review Interface

**As an** Aggregator (Jake)  
**I want** to compare raw and terse versions side-by-side  
**So that** I can efficiently review and edit the terse conversion

**Acceptance Criteria:**
- [ ] Split-pane view with raw text (left) and terse (right)
- [ ] Inline editing of terse version
- [ ] Highlight differences between raw and terse
- [ ] AI confidence indicator
- [ ] Quick approve/reject buttons
- [ ] Add edit reason/comment

**Technical Notes:**
- Use textarea for editing with auto-save
- Track edit history
- Diff highlighting for changes

### Story 3.3: Prompt Template Management

**As an** Aggregator (Jake)  
**I want** to customize the AI prompt templates  
**So that** I can improve the quality of terse conversions

**Acceptance Criteria:**
- [ ] Prompt template CRUD interface
- [ ] Version history for prompts
- [ ] A/B testing capability (compare prompt versions)
- [ ] Set active prompt template
- [ ] Preview prompt with sample text
- [ ] Only accessible to AGGREGATOR role

**Technical Notes:**
- Store prompts in database with versioning
- Allow rollback to previous versions
- Test prompts before activating

---

## Epic 4: Approval Workflow (Program Overseer)

**Objective:** Enable Will (Program Overseer) to review, approve, and batch-publish WARs to OneNote.

**Business Value:** Centralized approval process ensures oversight before public publication.

### Story 4.1: Approval Dashboard (Will's View)

**As a** Program Overseer (Will)  
**I want** to see all approved submissions ready for final review  
**So that** I can oversee the WAR publication process

**Acceptance Criteria:**
- [ ] Dashboard showing IN_REVIEW submissions
- [ ] Aggregator's edit history visible
- [ ] Filter by week, contributor, or aggregator
- [ ] Weekly summary view
- [ ] Export to CSV/Excel option
- [ ] Statistics and metrics dashboard

**Technical Notes:**
- Only accessible to PROGRAM_OVERSEER and ADMINISTRATOR
- Show complete audit trail
- Aggregate by week for batch operations

### Story 4.2: Batch Approval & Rejection

**As a** Program Overseer (Will)  
**I want** to approve or reject multiple submissions at once  
**So that** I can efficiently process weekly reports

**Acceptance Criteria:**
- [ ] Multi-select submissions with checkboxes
- [ ] Batch approve action with confirmation
- [ ] Batch reject with reason input
- [ ] Status changes to APPROVED or REJECTED
- [ ] Notifications sent to contributors on rejection
- [ ] Undo option within 5 minutes

**Technical Notes:**
- Transactional batch updates
- Send Teams notifications for rejections
- Soft-delete/undo capability

### Story 4.3: OneNote Publication

**As a** Program Overseer (Will)  
**I want** to publish approved WARs to the Program OneNote  
**So that** leadership can access the consolidated reports

**Acceptance Criteria:**
- [ ] Microsoft Graph API integration for OneNote
- [ ] Batch publish to specific OneNote section
- [ ] Formatted output (terse versions only)
- [ ] Publication confirmation with page links
- [ ] Retry logic for failed publications
- [ ] Status changes to PUBLISHED after success

**Technical Notes:**
- Use MSAL Node for Graph API auth
- Idempotent operations (prevent duplicates)
- Exponential backoff retry (max 3 retries)
- Log all publications to audit log

---

## Epic 5: Microsoft Teams Integration

**Objective:** Enable WAR submissions and notifications through Microsoft Teams.

**Business Value:** Meets users where they already work and provides seamless notification experience.

### Story 5.1: Teams Bot Setup & Commands

**As a** WAR contributor  
**I want** to submit my WAR through Teams using a bot command  
**So that** I don't need to switch to a web browser

**Acceptance Criteria:**
- [ ] Bot Framework v4 bot registered and configured
- [ ] `/war` command recognized
- [ ] Adaptive Card for text input displayed
- [ ] AI conversion via bot
- [ ] Submission confirmation in Teams
- [ ] Error handling for bot failures

**Technical Notes:**
- Bot Framework v4 with adaptive cards
- Webhook endpoint at `/api/webhooks/teams`
- Conversation state management

### Story 5.2: Teams Notifications

**As a** WAR contributor  
**I want** to receive Teams notifications about my submission status  
**So that** I'm informed of progress without checking email

**Acceptance Criteria:**
- [ ] Notification on submission received
- [ ] Notification when approved/rejected
- [ ] Notification when published to OneNote
- [ ] @mentions for urgent items
- [ ] Notification preferences (opt-out option)
- [ ] Digest mode (daily summary option)

**Technical Notes:**
- Proactive messaging via Bot Framework
- Store notification preferences per user
- Respect Teams notification settings

---

## Epic 6: Compliance & Audit

**Objective:** Ensure all actions are logged for federal compliance requirements.

**Business Value:** Satisfies EPA audit requirements and provides accountability.

### Story 6.1: Audit Logging System

**As an** Administrator  
**I want** to see a complete audit trail of all system actions  
**So that** I can ensure compliance and investigate issues

**Acceptance Criteria:**
- [ ] Audit middleware logs all user actions
- [ ] Immutable audit log storage
- [ ] View audit logs by user, date, or action type
- [ ] Export audit logs (CSV, JSON)
- [ ] 7-year retention policy enforcement
- [ ] PII masking in logs (no emails, names)

**Technical Notes:**
- Middleware intercepts all API calls
- Separate audit_log table
- Automated cleanup after retention period

### Story 6.2: System Administration

**As an** Administrator  
**I want** to manage users and system configuration  
**So that** I can maintain the system

**Acceptance Criteria:**
- [ ] User management interface (view, disable, change roles)
- [ ] System settings configuration
- [ ] Feature flags management
- [ ] Database health monitoring
- [ ] Export all data for backup
- [ ] Impersonation capability for support

**Technical Notes:**
- Only accessible to ADMINISTRATOR role
- Role changes require audit log
- Soft delete for users (never hard delete)

---

## Story Summary

| Epic | Stories | Total Points |
|------|---------|--------------|
| Epic 1: Foundation | 3 stories | ~13 points |
| Epic 2: Submission | 3 stories | ~13 points |
| Epic 3: Review | 3 stories | ~13 points |
| Epic 4: Approval | 3 stories | ~13 points |
| Epic 5: Teams | 2 stories | ~8 points |
| Epic 6: Compliance | 2 stories | ~8 points |
| **Total** | **16 stories** | **~68 points** |

---

## Development Sequence Recommendation

1. **Sprint 1:** Epic 1 (Foundation) - Essential infrastructure
2. **Sprint 2:** Epic 2 (Submission) - Core contributor functionality
3. **Sprint 3:** Epic 3 (Review) - Jake's workflow
4. **Sprint 4:** Epic 4 (Approval) - Will's workflow
5. **Sprint 5:** Epic 5 (Teams) + Epic 6 (Compliance) - Integrations & polish
