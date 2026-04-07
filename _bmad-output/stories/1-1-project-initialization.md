# Story 1.1: Project Initialization & Database Setup

Status: ready-for-dev
Created: 2026-02-19
Epic: Foundation & Authentication (Epic 1)

---

## Story

As a developer,  
I want to initialize the Next.js project with shadcn/ui and configure PostgreSQL with Prisma,  
so that we have a solid technical foundation for development.

---

## Acceptance Criteria

- [ ] **AC1:** Next.js 14 project initialized with TypeScript and Tailwind CSS
- [ ] **AC2:** shadcn/ui configured with 11+ base components
- [ ] **AC3:** Prisma schema defined with all models (User, Submission, Review, etc.)
- [ ] **AC4:** PostgreSQL database connection configured
- [ ] **AC5:** Initial migration created and applied
- [ ] **AC6:** Project structure follows architecture document

---

## Tasks / Subtasks

### Task 1: Verify Next.js Project Setup (AC: #1)
- [ ] **1.1** Confirm Next.js 14+ is installed with App Router
- [ ] **1.2** Verify TypeScript strict mode is enabled in tsconfig.json
- [ ] **1.3** Confirm Tailwind CSS 3.4+ is configured
- [ ] **1.4** Verify project builds without errors (`npm run build`)

### Task 2: Configure shadcn/ui Components (AC: #2)
- [ ] **2.1** Verify shadcn/ui is initialized with `components.json`
- [ ] **2.2** Ensure all 11 base components are installed:
  - Button, Card, Input, Textarea, Label
  - Badge, Skeleton, Avatar, Separator
  - Dialog, DropdownMenu
- [ ] **2.3** Verify `cn()` utility is available in `src/lib/utils.ts`
- [ ] **2.4** Confirm CSS variables are configured in `globals.css`

### Task 3: Set Up Prisma Database Schema (AC: #3, #4)
- [ ] **3.1** Install Prisma dependencies: `npm install @prisma/client prisma`
- [ ] **3.2** Create `prisma/schema.prisma` with all models:
  - User (with Azure AD integration, 4 roles)
  - Submission (WAR data with raw/terse text)
  - Review (Jake's edits with history)
  - WorkflowState (status tracking)
  - PromptTemplate (AI prompt versioning)
  - AuditLog (compliance logging)
  - Notification (user alerts)
  - ConversationState (Teams bot)
- [ ] **3.3** Configure PostgreSQL datasource with pgvector extension
- [ ] **3.4** Create `src/lib/db.ts` with Prisma client singleton

### Task 4: Initialize Database (AC: #5)
- [ ] **4.1** Create `.env.local` from `.env.example`
- [ ] **4.2** Configure `DATABASE_URL` with PostgreSQL connection string
- [ ] **4.3** Run `npx prisma migrate dev --name init`
- [ ] **4.4** Run `npx prisma generate` to generate client types
- [ ] **4.5** Verify database tables are created

### Task 5: Validate Project Structure (AC: #6)
- [ ] **5.1** Confirm directory structure matches architecture:
  ```
  src/
  ├── app/
  │   ├── api/auth/[...nextauth]/
  │   ├── dashboard/
  │   ├── login/
  │   └── layout.tsx
  ├── components/
  │   ├── ui/ (shadcn components)
  │   ├── features/ (empty, ready for implementation)
  │   └── shared/ (empty, ready for implementation)
  ├── lib/
  │   ├── ai/ (empty)
  │   ├── audit/ (empty)
  │   ├── db.ts (Prisma client)
  │   ├── graph/ (empty)
  │   ├── teams/ (empty)
  │   └── utils.ts (cn utility)
  ├── hooks/ (empty)
  ├── types/ (empty)
  └── config/
      └── site.ts
  ```
- [ ] **5.2** Verify `.github/workflows/` directory exists for CI/CD
- [ ] **5.3** Confirm `prisma/migrations/` directory exists
- [ ] **5.4** Verify test directories exist:
  - `tests/unit/`
  - `tests/integration/`
  - `tests/e2e/`

### Task 6: Install Additional Dependencies (Supporting all ACs)
- [ ] **6.1** Install NextAuth v5 beta: `npm install next-auth@beta`
- [ ] **6.2** Install Prisma adapter: `npm install @auth/prisma-adapter`
- [ ] **6.3** Install form handling: `npm install react-hook-form zod @hookform/resolvers`
- [ ] **6.4** Install data fetching: `npm install @tanstack/react-query`
- [ ] **6.5** Install Microsoft SDKs (for future stories):
  - `npm install @azure/msal-node`
  - `npm install botbuilder`

### Task 7: Create Configuration Files
- [ ] **7.1** Update `.env.example` with all required variables:
  - DATABASE_URL
  - NEXTAUTH_URL, NEXTAUTH_SECRET
  - AZURE_AD_B2C_* (EPA MAX config)
  - MS_GRAPH_* (OneNote integration)
  - AI_SERVICE_* (internal EPA AI)
  - BOT_* (Teams bot)
- [ ] **7.2** Create `src/config/site.ts` with site configuration
- [ ] **7.3** Verify `next.config.js` has proper output settings

---

## Dev Notes

### Architecture Compliance

**Technology Stack Requirements:**
- Next.js 14+ with App Router (Server Components default)
- TypeScript 5.x with strict mode
- Tailwind CSS 3.4+ with shadcn/ui components
- PostgreSQL 15+ with PG Vector extension
- Prisma 5.x for ORM

**Critical Patterns:**
1. **Server Components by default** - Only mark "use client" when needed for interactivity
2. **Prisma singleton pattern** - Use `src/lib/db.ts` for database access
3. **Feature-based organization** - Components in `src/components/features/<domain>/`
4. **Environment variables** - All secrets in `.env.local`, never commit to git

### Project Structure Alignment

**Source Tree Components to Touch:**
```
prisma/
├── schema.prisma          # NEW - Define all models
└── migrations/            # EXISTING - Migration files go here

src/
├── lib/
│   └── db.ts              # NEW - Prisma client singleton
└── config/
    └── site.ts            # NEW - Site configuration

.env.example               # UPDATE - Add all required env vars
.env.local                 # NEW - Local environment (gitignored)
```

### Testing Standards

**Required Tests for this Story:**
1. **Database Connection Test** - Verify Prisma can connect to PostgreSQL
2. **Migration Test** - Run `npx prisma migrate deploy` successfully
3. **Build Test** - `npm run build` completes without errors
4. **shadcn Components Test** - Verify all 11 components render without errors

**No E2E tests required** for this story (infrastructure only)

### Known Considerations

**pgvector Extension:**
- PostgreSQL must have pgvector extension enabled for AI embeddings
- Cloud.gov managed PostgreSQL supports this extension
- Include in schema: `datasource db { provider = "postgresql" }`

**Azure AD B2C Setup:**
- EPA MAX uses Azure AD B2C for authentication
- Requires tenant name, client ID, client secret
- JWT session strategy for stateless auth

**NextAuth v5 Beta:**
- Using beta version for App Router compatibility
- May have breaking changes - monitor for updates

---

## Project Structure Notes

### Alignment with Unified Project Structure

✅ **Compliant:**
- `src/components/ui/` - shadcn components (correct)
- `src/components/features/` - Feature components (correct)
- `src/lib/` - Utility functions and service abstractions (correct)
- `prisma/` - Database schema and migrations (correct)
- `tests/` - Unit, integration, E2E test directories (correct)

### Detected Conflicts or Variances

**None** - Project structure already matches architecture document.

**One Note:** `node_modules` is currently empty in listing but this is expected after fresh initialization. Dependencies will be installed during Task 6.

---

## References

### Source Documents

| Document | Location | Relevant Section |
|----------|----------|------------------|
| **Epics** | `_bmad-output/planning-artifacts/epics.md` | Epic 1, Story 1.1 (lines 15-33) |
| **Architecture** | `_bmad-output/planning-artifacts/architecture.md` | Project Structure (lines 453-559), Core Architectural Decisions (lines 213-342) |
| **Project Context** | `_bmad-output/planning-artifacts/project-context.md` | Technology Stack, Critical Implementation Rules, Naming Conventions |
| **PRD** | `_bmad-output/planning-artifacts/prd.md` | Data Model, Technical Constraints |

### Technical References

| Technology | Version | Documentation |
|------------|---------|---------------|
| Next.js | 14.2.35 | https://nextjs.org/docs |
| NextAuth | 5.0.0-beta | https://authjs.dev/getting-started/installation |
| Prisma | 5.x | https://www.prisma.io/docs |
| shadcn/ui | Latest | https://ui.shadcn.com/docs |
| Tailwind CSS | 3.4+ | https://tailwindcss.com/docs |

### Database Schema Reference

**User Model:**
- `id`: String @id @default(cuid())
- `email`: String @unique
- `name`: String?
- `azureAdId`: String @unique
- `role`: Role enum (CONTRIBUTOR, AGGREGATOR, PROGRAM_OVERSEER, ADMINISTRATOR)
- `isActive`: Boolean @default(true)

**Submission Model:**
- `id`: String @id
- `userId`: String (relation to User)
- `weekOf`: DateTime
- `rawText`: String
- `terseVersion`: String?
- `status`: SubmissionStatus enum
- `isAiGenerated`: Boolean

See `prisma/schema.prisma` for complete schema.

---

## Dev Agent Record

### Agent Model Used

Create Story Agent - Comprehensive story context generation with architecture analysis

### Debug Log References

- Project initialized: `npx shadcn@latest init --yes --template next --base-color slate`
- Components added: button, card, input, textarea, label, badge, skeleton, avatar, separator, dialog, dropdown-menu
- Structure created: All directories per architecture document

### Completion Notes List

**Before Starting Implementation:**
1. Run `npm install` to install all dependencies (project currently has empty node_modules)
2. Copy `.env.example` to `.env.local` and configure PostgreSQL connection
3. Ensure PostgreSQL 15+ is running locally or use Cloud.gov managed service
4. Have Azure AD B2C credentials ready for NextAuth configuration (Story 1.2)

**Common Issues to Watch:**
- pgvector extension must be enabled in PostgreSQL
- NextAuth v5 beta may have breaking changes - check docs if issues arise
- Prisma generate must run after schema changes

### File List

**Files to Create:**
- `prisma/schema.prisma` - Database schema
- `src/lib/db.ts` - Prisma client
- `src/config/site.ts` - Site config
- `.env.local` - Environment variables (from template)

**Files to Update:**
- `.env.example` - Add all required variables
- `package.json` - Add dependencies

**Files Already Existing:**
- `src/components/ui/*.tsx` - 11 shadcn components
- `src/lib/utils.ts` - cn utility
- `src/app/layout.tsx` - Root layout
- `src/app/page.tsx` - Home page
- `src/app/globals.css` - Global styles
- `tailwind.config.ts` - Tailwind config
- `components.json` - shadcn config

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Database migrations applied successfully
- [ ] `npm run build` completes without errors
- [ ] All 11 shadcn components render correctly
- [ ] Project structure matches architecture document
- [ ] `.env.example` documents all required environment variables
- [ ] No secrets committed to git
- [ ] Ready for Story 1.2: EPA MAX Authentication Integration

**Next Story Dependencies:**
- Story 1.2 requires: Database schema (User model), NextAuth dependency
- All subsequent stories require: Database tables created by this story's migrations
