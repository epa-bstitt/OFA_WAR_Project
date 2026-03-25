---
stepsCompleted: [step-01-init, step-02-discovery]
inputDocuments: ['c:/Users/Buyer/Documents/CascadeProjects/EPABusinessPlatform/_bmad-output/planning-artifacts/product-brief-EPABusinessPlatform-2026-02-09.md']
workflowType: 'prd'
documentCounts:
  productBriefs: 1
  research: 0
  brainstorming: 0
  projectDocs: 0
classification:
  projectType: 'Web application with AI integration (Next.js + Teams Bot + Graph API)'
  domain: 'Federal government IT project management and status reporting'
  complexity: 'Medium-High'
  projectContext: 'Greenfield'
---

# Product Requirements Document - EPABusinessPlatform

**Author:** Jake
**Date:** 2026-02-18
**Status:** Draft
**Version:** 1.0

---

## 1. Overview

### 1.1 Purpose
This document defines the functional and technical requirements for the EPABusinessPlatform Weekly Activity Report (WAR) Modernization system. It replaces a manual OneNote-based process with an AI-powered, automated solution that reduces administrative burden while maintaining backward compatibility with existing workflows.

### 1.2 Scope
**In Scope:**
- Teams-native submission via intelligent bot with `/war` commands
- AI-powered terse conversion of verbose updates
- Web-based review workflows for Jake (Aggregator) and Will (Program Overseer)
- Automated notification system (email + Teams) with multi-stage reminders
- Microsoft Graph API integration for OneNote output
- PostgreSQL database with PG Vector for RAG capabilities and markdown storage
- Historical OneNote import and analysis
- Admin dashboard for usage and compliance metrics

**Out of Scope (Phase 2/3):**
- AI "Bullshit Detector" for stall detection
- Resource load balancing
- Voice-to-text submission
- Mobile native applications
- Cross-team dependency mapping

### 1.3 Definitions and Acronyms
| Term | Definition |
|------|------------|
| WAR | Weekly Activity Report |
| AI TC | AI Terse Converter |
| RAG | Retrieval Augmented Generation |
| PG Vector | PostgreSQL extension for vector similarity search |
| Graph API | Microsoft Graph API for Office 365 integration |
| Adaptive Card | Microsoft's interactive message format for Teams |

---

## 2. Functional Requirements

### 2.1 User Management

#### 2.1.1 User Registration and Import
| ID | Requirement | Priority |
|----|-------------|----------|
| UM-001 | System shall support bulk import of users via CSV/Excel with fields: Name, Email, Section, Role | P0 |
| UM-002 | System shall integrate with Cloud.gov SSO for authentication | P0 |
| UM-003 | System shall support 3 user roles: Contributor, Aggregator (Jake), Overseer (Will) | P0 |
| UM-004 | System shall store user profiles with notification preferences | P1 |

#### 2.1.2 Role-Based Access Control
| ID | Requirement | Priority |
|----|-------------|----------|
| RBAC-001 | Contributors can only submit and view their own updates | P0 |
| RBAC-002 | Aggregator (Jake) can view all submissions, edit terse conversions, manage prompts | P0 |
| RBAC-003 | Overseer (Will) can view all submissions, perform final review, approve to OneNote | P0 |
| RBAC-004 | Admin role can access dashboard, manage users, view metrics | P1 |

### 2.2 Submission System

#### 2.2.1 Teams Bot Integration
| ID | Requirement | Priority |
|----|-------------|----------|
| TS-001 | Bot shall respond to `/war` slash command in Teams | P0 |
| TS-002 | Bot shall present adaptive card with pre-populated template from previous submission | P0 |
| TS-003 | Bot shall support free-text input with AI-assisted formatting suggestions | P0 |
| TS-004 | Bot shall allow submitter to review AI terse conversion before final submission | P0 |
| TS-005 | Bot shall confirm receipt with timestamp and submission ID | P0 |
| TS-006 | Bot shall support draft mode (save without submitting) | P1 |

#### 2.2.2 Web Submission (Alternative)
| ID | Requirement | Priority |
|----|-------------|----------|
| WS-001 | Web interface shall provide same submission capabilities as Teams bot | P1 |
| WS-002 | Web form shall support rich text editing with markdown preview | P1 |
| WS-003 | Web submission shall integrate with same AI terse conversion pipeline | P1 |

#### 2.2.3 AI Terse Conversion
| ID | Requirement | Priority |
|----|-------------|----------|
| AI-001 | System shall convert verbose submissions to executive-ready terse format | P0 |
| AI-002 | AI shall preserve key information: accomplishments, blockers, risks, resources | P0 |
| AI-003 | AI shall support markdown table formatting preservation | P0 |
| AI-004 | System shall store both raw submission and AI-converted version | P0 |
| AI-005 | Jake (Aggregator) shall be able to edit AI terse conversions for accuracy | P0 |
| AI-006 | Jake shall be able to modify the AI prompt controlling terse formatting | P1 |
| AI-007 | System shall maintain version history of prompt changes | P2 |

### 2.3 Review Workflows

#### 2.3.1 Aggregator Dashboard (Jake)
| ID | Requirement | Priority |
|----|-------------|----------|
| AD-001 | Dashboard shall display submission status for all 19 contributors | P0 |
| AD-002 | Dashboard shall show real-time counts: submitted, pending, overdue | P0 |
| AD-003 | Dashboard shall allow filtering by section (Contracts vs Service/Project) | P1 |
| AD-004 | Dashboard shall provide one-click access to edit any submission | P0 |
| AD-005 | Dashboard shall display AI terse conversion with edit capability | P0 |
| AD-006 | Dashboard shall support batch operations (approve multiple submissions) | P1 |

#### 2.3.2 Overseer Review (Will)
| ID | Requirement | Priority |
|----|-------------|----------|
| OR-001 | Interface shall display submissions in date-range filterable view (default: 2 weeks) | P0 |
| OR-002 | Interface shall show AI-converted terse format with option to view raw | P0 |
| OR-003 | Will shall be able to edit any submission before final approval | P0 |
| OR-004 | Interface shall support custom search and filtering by project, person, date | P0 |
| OR-005 | System shall support "approve all" for batch processing | P1 |
| OR-006 | Interface shall show submission timeline/history per project | P1 |

### 2.4 Notification System

#### 2.4.1 Reminder Schedule
| ID | Requirement | Priority |
|----|-------------|----------|
| NS-001 | System shall send notifications at: 2 days, 1 day, 1 hour, 5 minutes before deadline | P0 |
| NS-002 | System shall send overdue notification immediately after deadline passes | P0 |
| NS-003 | Notifications shall be delivered via both email and Teams bot DM | P0 |
| NS-004 | System shall escalate to @mention in Teams channel after 2 overdue notifications | P1 |
| NS-005 | Users shall be able to configure notification preferences | P2 |

#### 2.4.2 Notification Content
| ID | Requirement | Priority |
|----|-------------|----------|
| NC-001 | Notifications shall include direct link to submission form (Teams or web) | P0 |
| NC-002 | Notifications shall show countdown to deadline | P1 |
| NC-003 | Overdue notifications shall include list of missing items from previous submission | P1 |

### 2.5 OneNote Integration

#### 2.5.1 Microsoft Graph API Integration
| ID | Requirement | Priority |
|----|-------------|----------|
| GR-001 | System shall authenticate with Microsoft Graph API using service principal | P0 |
| GR-002 | System shall prepend formatted updates to existing OneNote section | P0 |
| GR-003 | Output format shall match existing OneNote structure (bulleted terse format) | P0 |
| GR-004 | System shall maintain date ordering (newest first) | P0 |
| GR-005 | Integration shall handle authentication token refresh automatically | P0 |
| GR-006 | System shall log all Graph API operations for troubleshooting | P1 |

#### 2.5.2 Historical Import
| ID | Requirement | Priority |
|----|-------------|----------|
| HI-001 | System shall import entire existing OneNote document via Graph API | P1 |
| HI-002 | System shall parse and break apart entries by submission week | P1 |
| HI-003 | System shall associate historical entries with users where possible | P1 |
| HI-004 | System shall generate project recommendations based on historical patterns | P2 |

### 2.6 Admin Dashboard

#### 2.6.1 Usage Metrics
| ID | Requirement | Priority |
|----|-------------|----------|
| AM-001 | Dashboard shall display submission rates over time (weekly/bi-weekly trends) | P1 |
| AM-002 | Dashboard shall show average submission time per user | P1 |
| AM-003 | Dashboard shall track AI terse conversion usage rates | P1 |
| AM-004 | Dashboard shall display system uptime and API response times | P1 |

#### 2.6.2 Compliance Metrics
| ID | Requirement | Priority |
|----|-------------|----------|
| CM-001 | Dashboard shall show noncompliance metrics: overdue submissions, missing updates | P1 |
| CM-002 | Dashboard shall identify chronic late submitters | P1 |
| CM-003 | Dashboard shall track time-to-submit trends | P2 |
| CM-004 | System shall generate compliance reports exportable to CSV/PDF | P2 |

---

## 3. Technical Requirements

### 3.1 Platform and Infrastructure

| ID | Requirement | Priority |
|----|-------------|----------|
| TI-001 | Application shall be built on Next.js 14+ with App Router | P0 |
| TI-002 | UI shall use Tailwind CSS for styling with ShadCN UI component library | P0 |
| TI-003 | Application shall be hosted on Cloud.gov (Federal PaaS) | P0 |
| TI-004 | Application shall support horizontal scaling via Cloud Foundry instances | P1 |
| TI-005 | All static assets shall be served via CDN where possible | P2 |

### 3.2 Database Requirements

| ID | Requirement | Priority |
|----|-------------|----------|
| DB-001 | Database shall be PostgreSQL 15+ hosted on Cloud.gov | P0 |
| DB-002 | Database shall have PG Vector extension enabled for text embeddings | P0 |
| DB-003 | Schema shall support: users, submissions (raw + terse), projects, notifications, audit logs | P0 |
| DB-004 | Markdown content shall be stored as native PostgreSQL text with proper indexing | P0 |
| DB-005 | Database shall support full-text search via PostgreSQL tsvector | P1 |
| DB-006 | All data shall be encrypted at rest (Cloud.gov RDS encryption) | P0 |
| DB-007 | Database connections shall use SSL/TLS encryption | P0 |

### 3.3 AI and LLM Integration

| ID | Requirement | Priority |
|----|-------------|----------|
| AI-008 | AI terse conversion shall use cloud-based LLM API (Azure OpenAI or equivalent) | P0 |
| AI-009 | System shall implement RAG pattern using PG Vector for context-aware conversions | P1 |
| AI-010 | AI prompts shall be configurable and versioned | P1 |
| AI-011 | System shall implement rate limiting and token usage tracking | P1 |
| AI-012 | AI responses shall be cached where appropriate to reduce costs | P2 |

### 3.4 Security Requirements

| ID | Requirement | Priority |
|----|-------------|----------|
| SEC-001 | All authentication shall use Cloud.gov SSO (UAA) integration | P0 |
| SEC-002 | Session management shall use secure, httpOnly cookies | P0 |
| SEC-003 | All API endpoints shall require authentication | P0 |
| SEC-004 | Role-based access control shall be enforced at API layer | P0 |
| SEC-005 | All data in transit shall use TLS 1.3 | P0 |
| SEC-006 | API shall implement rate limiting to prevent abuse | P1 |
| SEC-007 | System shall log all authentication and authorization events | P1 |
| SEC-008 | Secrets (API keys, DB credentials) shall be stored in Cloud.gov environment variables | P0 |

### 3.5 Performance Requirements

| ID | Requirement | Priority |
|----|-------------|----------|
| PERF-001 | Page load time shall be < 2 seconds for 95th percentile | P0 |
| PERF-002 | API response time shall be < 500ms for 95th percentile | P0 |
| PERF-003 | AI terse conversion shall complete within 5 seconds | P0 |
| PERF-004 | System shall support 50 concurrent users without degradation | P0 |
| PERF-005 | Database queries shall be optimized with proper indexing | P1 |
| PERF-006 | Static assets shall be cached with appropriate TTL | P1 |

### 3.6 Reliability and Availability

| ID | Requirement | Priority |
|----|-------------|----------|
| REL-001 | System shall maintain 99.5% uptime during business hours (8am-6pm ET) | P0 |
| REL-002 | Database shall have automated daily backups with 7-day retention | P0 |
| REL-003 | System shall implement health check endpoints for monitoring | P1 |
| REL-004 | Critical failures shall trigger alerts to admin team | P1 |
| REL-005 | System shall gracefully degrade if AI service is unavailable | P1 |

---

## 4. Integration Requirements

### 4.1 Microsoft Teams Integration

| ID | Requirement | Priority |
|----|-------------|----------|
| TEAMS-001 | Bot shall be registered with Microsoft Bot Framework | P0 |
| TEAMS-002 | Bot shall support proactive messaging (initiated by system) | P0 |
| TEAMS-003 | Bot shall handle adaptive card submissions and responses | P0 |
| TEAMS-004 | Bot shall support rich text formatting in messages | P1 |
| TEAMS-005 | System shall handle Teams-specific authentication (OAuth via Bot Framework) | P0 |

### 4.2 Microsoft Graph API Integration

| ID | Requirement | Priority |
|----|-------------|----------|
| GRAPH-001 | System shall implement OAuth 2.0 flow for Graph API authentication | P0 |
| GRAPH-002 | System shall use application permissions for OneNote write access | P0 |
| GRAPH-003 | Integration shall handle token expiration and refresh | P0 |
| GRAPH-004 | System shall implement retry logic with exponential backoff | P1 |
| GRAPH-005 | All Graph API errors shall be logged with actionable error messages | P1 |

### 4.3 Email Integration

| ID | Requirement | Priority |
|----|-------------|----------|
| EMAIL-001 | System shall integrate with EPA SMTP gateway for email notifications | P0 |
| EMAIL-002 | Email templates shall be HTML with plain text fallback | P1 |
| EMAIL-003 | System shall track email delivery status (sent, delivered, bounced) | P2 |

---

## 5. User Interface Requirements

### 5.1 General UI/UX

| ID | Requirement | Priority |
|----|-------------|----------|
| UI-001 | Interface shall be responsive (mobile, tablet, desktop) | P0 |
| UI-002 | All interactions shall have loading states and error handling | P0 |
| UI-003 | Interface shall support keyboard navigation for accessibility | P1 |
| UI-004 | Color contrast shall meet WCAG 2.1 AA standards | P1 |
| UI-005 | All user actions shall have confirmation feedback | P0 |

### 5.2 Contributor Interface

| ID | Requirement | Priority |
|----|-------------|----------|
| CI-001 | Submission form shall show previous week's content as reference | P0 |
| CI-002 | AI terse preview shall update in real-time as user types | P1 |
| CI-003 | Interface shall support "save draft" and "submit final" actions | P0 |
| CI-004 | Confirmation shall show what was submitted and what's next | P0 |

### 5.3 Reviewer Interfaces

| ID | Requirement | Priority |
|----|-------------|----------|
| RI-001 | Jake's dashboard shall use card-based layout for quick scanning | P0 |
| RI-002 | Will's review interface shall use split-pane (terse view + raw view) | P0 |
| RI-003 | Both interfaces shall support inline editing with auto-save | P1 |
| RI-004 | Date range picker shall default to last 2 weeks, allow custom ranges | P0 |

---

## 6. Data Requirements

### 6.1 Data Models

**User Entity:**
- id (UUID)
- email (string, unique)
- name (string)
- section (string: "Contracts Management" | "Service & Project Management")
- role (enum: "contributor" | "aggregator" | "overseer" | "admin")
- notification_preferences (JSON)
- created_at, updated_at (timestamps)

**Submission Entity:**
- id (UUID)
- user_id (FK to users)
- submission_period (date range)
- raw_content (text, markdown)
- terse_content (text, markdown)
- ai_converted (boolean)
- status (enum: "draft" | "submitted" | "under_review" | "approved" | "published")
- submitted_at, reviewed_at, published_at (timestamps)
- review_notes (text)
- version (integer)

**Project Entity:**
- id (UUID)
- name (string)
- description (text)
- section (string)
- contributors (array of user IDs)
- created_at, updated_at (timestamps)

**Notification Log Entity:**
- id (UUID)
- user_id (FK)
- type (enum: "reminder" | "overdue" | "confirmation")
- channel (enum: "email" | "teams")
- scheduled_at, sent_at (timestamps)
- status (enum: "scheduled" | "sent" | "failed")

### 6.2 Data Retention

| ID | Requirement | Priority |
|----|-------------|----------|
| DR-001 | Submissions shall be retained for 7 years per federal records requirements | P0 |
| DR-002 | Audit logs shall be retained for 3 years | P0 |
| DR-003 | Notification logs shall be retained for 1 year | P1 |
| DR-004 | Soft deletes shall be used for all user-facing data | P1 |

---

## 7. Acceptance Criteria

### 7.1 MVP Release Criteria

The MVP shall be considered complete when:

1. **All P0 (Critical) requirements are implemented and tested**
2. **End-to-end workflow tested:**
   - Contributor submits via Teams bot
   - AI terse conversion completes successfully
   - Jake reviews and edits terse conversion
   - Will performs final review and approves
   - Content appears in OneNote via Graph API
3. **Notification system verified:**
   - All 5 reminder stages send correctly
   - Both email and Teams channels work
4. **Performance targets met:**
   - Page load < 2 seconds
   - API response < 500ms
   - AI conversion < 5 seconds
5. **Security requirements satisfied:**
   - Cloud.gov SSO integration working
   - Role-based access control enforced
   - All data encrypted in transit and at rest

### 7.2 User Acceptance Testing

| Scenario | Expected Result |
|----------|-----------------|
| New contributor submits first WAR via Teams | Submission successful, confirmation received, appears in dashboard |
| Jake edits AI terse conversion | Changes saved, version history maintained, approval workflow continues |
| Will approves batch of 10 submissions | All published to OneNote in correct format and order |
| System sends 2-day reminder | Notification received via both email and Teams |
| AI service temporarily unavailable | System falls back to raw submission with clear message to user |

### 7.3 Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Submission rate | > 95% | % of 19 contributors submitting on time |
| AI conversion usage | > 70% | % of submissions using AI terse feature |
| Time savings (Jake) | 75% reduction | Hours per week spent on WAR administration |
| User satisfaction | > 4/5 | Post-submission survey scores |
| System uptime | > 99.5% | Cloud.gov monitoring |

---

## 8. Appendices

### 8.1 References
- Product Brief: `product-brief-EPABusinessPlatform-2026-02-09.md`
- Brainstorming Session: `brainstorming-session-2026-02-09.md`
- Next.js Documentation: https://nextjs.org/docs
- Microsoft Graph API: https://docs.microsoft.com/en-us/graph/
- Cloud.gov Documentation: https://cloud.gov/docs/

### 8.2 Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-18 | Jake | Initial PRD based on Product Brief |
