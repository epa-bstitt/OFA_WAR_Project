# Story 1.2: EPA MAX Authentication Integration

Status: ready-for-dev
Created: 2026-02-19
Epic: Foundation & Authentication (Epic 1)
Depends On: Story 1.1 (Project Initialization)

---

## Story

As a WAR contributor,  
I want to sign in using my EPA MAX credentials,  
so that I can securely access the system with my existing account.

---

## Acceptance Criteria

- [ ] **AC1:** NextAuth configured with Azure AD B2C provider
- [ ] **AC2:** Login page with EPA MAX button implemented
- [ ] **AC3:** JWT session strategy implemented
- [ ] **AC4:** Role-based access control (4 roles) configured
- [ ] **AC5:** Protected routes middleware implemented
- [ ] **AC6:** Sign-out functionality works correctly

---

## Tasks / Subtasks

### Task 1: Configure NextAuth with Azure AD B2C (AC: #1, #3)
- [ ] **1.1** Install NextAuth v5 beta: `npm install next-auth@beta`
- [ ] **1.2** Install Prisma adapter: `npm install @auth/prisma-adapter`
- [ ] **1.3** Create `src/lib/auth.ts` with NextAuth configuration:
  - Azure AD B2C provider configuration
  - Tenant name, client ID, client secret
  - Primary user flow (B2C_1_signupsignin1)
  - JWT session strategy (8 hour max age)
  - Prisma adapter for session storage
  - Custom profile mapping for Azure AD claims
- [ ] **1.4** Configure NextAuth callbacks:
  - `jwt` callback to add role and azureAdId to token
  - `session` callback to expose user data to client
  - `signIn` event to log to audit trail
- [ ] **1.5** Create type declarations in `src/types/next-auth.d.ts`:
  - Extend Session interface with custom user fields
  - Extend JWT interface with role claim
  - Extend User interface with azureAdId

### Task 2: Create Authentication API Route (AC: #1)
- [ ] **2.1** Create `src/app/api/auth/[...nextauth]/route.ts`:
  - Import authOptions from `@/lib/auth`
  - Export GET and POST handlers
- [ ] **2.2** Verify endpoint responds correctly at `/api/auth/*`
- [ ] **2.3** Test sign-in flow manually with EPA MAX credentials

### Task 3: Build Login Page (AC: #2)
- [ ] **3.1** Enhance existing `src/app/login/page.tsx`:
  - Add EPA branding and logo
  - Implement sign-in button linking to `/api/auth/signin/azure-ad-b2c`
  - Add loading state during authentication
  - Add error handling display
  - Style with shadcn Card, Button components
- [ ] **3.2** Add error page at `src/app/auth/error/page.tsx`:
  - Display authentication errors
  - Provide retry button
  - Link back to login
- [ ] **3.3** Create loading state component for authentication redirects

### Task 4: Implement Role-Based Access Control (AC: #4)
- [ ] **4.1** Define role hierarchy in `src/lib/auth.ts`:
  ```typescript
  const ROLE_HIERARCHY = {
    ADMINISTRATOR: 4,
    PROGRAM_OVERSEER: 3,
    AGGREGATOR: 2,
    CONTRIBUTOR: 1,
  };
  ```
- [ ] **4.2** Create helper functions:
  - `hasRequiredRole(userRole, requiredRoles[])` - exact role match
  - `hasMinimumRole(userRole, minimumRole)` - hierarchy check
- [ ] **4.3** Configure custom sign-in page in NextAuth options:
  ```typescript
  pages: {
    signIn: "/login",
    error: "/auth/error",
  }
  ```
- [ ] **4.4** Map Azure AD custom claim (`extension_role`) to user role
- [ ] **4.5** Document role assignment process (Azure AD B2C portal)

### Task 5: Configure Route Protection Middleware (AC: #5)
- [ ] **5.1** Update existing `src/middleware.ts`:
  - Import NextAuth middleware
  - Configure matcher for protected routes:
    ```typescript
    export const config = {
      matcher: [
        "/dashboard/:path*",
        "/review/:path*",
        "/approve/:path*",
        "/admin/:path*",
        "/submit/:path*",
        "/api/submissions/:path*",
        "/api/review/:path*",
        "/api/approve/:path*",
        "/api/admin/:path*",
      ],
    };
    ```
- [ ] **5.2** Add public route exclusions:
  - `/api/auth/*` - Authentication endpoints
  - `/login` - Login page
  - `/_next/static/*` - Static assets
  - `/favicon.ico`, `/public/*` - Public files
- [ ] **5.3** Test middleware redirects unauthenticated users to login
- [ ] **5.4** Verify authenticated users can access protected routes

### Task 6: Implement Sign-Out Functionality (AC: #6)
- [ ] **6.1** Add sign-out button to navigation component (Story 1.3)
- [ ] **6.2** Create sign-out Server Action at `src/app/actions/auth.ts`:
  - Import `signOut` from `next-auth/react`
  - Clear session cookies
  - Log sign-out to audit trail
- [ ] **6.3** Handle sign-out redirect to `/login` page
- [ ] **6.4** Add confirmation dialog before sign-out
- [ ] **6.5** Test sign-out clears session and redirects correctly

### Task 7: Create Server-Side Auth Helpers (Supporting all ACs)
- [ ] **7.1** Create `src/lib/auth-helpers.ts`:
  - `getCurrentUser()` - Server-side user retrieval
  - `requireAuth()` - Ensure user is authenticated
  - `requireRole(role)` - Ensure user has specific role
  - `requireMinimumRole(role)` - Ensure user meets role hierarchy
- [ ] **7.2** Add error handling for unauthorized access (401/403)
- [ ] **7.3** Create reusable auth check components:
  - `<RequireAuth>` - Wrapper for protected content
  - `<RequireRole role={}>` - Role-based content gating

### Task 8: Add Audit Logging for Auth Events (Supporting all ACs)
- [ ] **8.1** Extend `src/lib/auth.ts` events:
  - `signIn` event - Log successful authentication
  - `signOut` event - Log sign-out
  - `createUser` event - Log new user registration
- [ ] **8.2** Store in `AuditLog` table:
  - Action type (USER_SIGNIN, USER_SIGNOUT, USER_REGISTERED)
  - User ID
  - Timestamp
  - IP address (if available)
  - User agent
- [ ] **8.3** Ensure PII masking (no emails in logs)

### Task 9: Create Environment Configuration (Supporting all ACs)
- [ ] **9.1** Add to `.env.example`:
  ```
  # NextAuth
  NEXTAUTH_URL="http://localhost:3000"
  NEXTAUTH_SECRET="generate-random-secret-min-32-chars"
  
  # Azure AD B2C (EPA MAX)
  AZURE_AD_B2C_TENANT_NAME="your-tenant-name"
  AZURE_AD_B2C_CLIENT_ID="your-app-registration-client-id"
  AZURE_AD_B2C_CLIENT_SECRET="your-client-secret"
  AZURE_AD_B2C_PRIMARY_USER_FLOW="B2C_1_signupsignin1"
  ```
- [ ] **9.2** Document how to generate `NEXTAUTH_SECRET`:
  ```bash
  openssl rand -base64 32
  ```
- [ ] **9.3** Add validation that all required env vars are present at startup

---

## Dev Notes

### Architecture Compliance

**Authentication Pattern (per Architecture Decision #3):**
- NextAuth.js v5 beta with Azure AD B2C provider
- JWT session strategy for stateless authentication
- Prisma adapter for session persistence
- Role-based access control with 4 defined roles

**Critical Implementation Rules:**
1. **Server Components fetch auth directly** - Use `getServerSession()` in Server Components
2. **Client Components use hooks** - Use `useSession()` hook in Client Components marked with "use client"
3. **Middleware for route protection** - All protected routes checked at edge
4. **Audit every auth event** - Sign-in, sign-out, role changes logged

### Role-Based Access Pattern

```typescript
// Server Component - Direct check
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";

async function Page() {
  const session = await getServerSession(authOptions);
  if (!session?.user || !hasRequiredRole(session.user.role, ["AGGREGATOR"])) {
    redirect("/unauthorized");
  }
  // ... render page
}

// Client Component - Hook check
"use client";
import { useSession } from "next-auth/react";

function Component() {
  const { data: session, status } = useSession();
  if (status === "loading") return <Skeleton />;
  if (!session || session.user.role !== "AGGREGATOR") return null;
  // ... render component
}
```

### Azure AD B2C Configuration

**Required Azure Portal Settings:**
1. App Registration created in Azure AD B2C tenant
2. Redirect URI configured: `http://localhost:3000/api/auth/callback/azure-ad-b2c`
3. Client secret generated and stored securely
4. Custom attribute `extension_role` added to user flow
5. User flow "B2C_1_signupsignin1" configured

**Claims to Request:**
- `oid` - Object ID (maps to azureAdId)
- `emails` - Email addresses
- `name` - Display name
- `extension_role` - Custom role claim

### Testing Approach

**Unit Tests:**
- Test `hasRequiredRole()` and `hasMinimumRole()` functions
- Test role hierarchy logic
- Test auth helper functions

**Integration Tests:**
- Test `/api/auth/signin` endpoint
- Test middleware redirects
- Test protected route access

**E2E Tests:**
- Full sign-in flow with test Azure AD credentials
- Sign-out flow
- Role-based navigation visibility

### Dependency on Previous Story

**Story 1.1 must be complete before starting:**
- Database schema must exist (User model)
- Prisma client must be configured
- Next.js project must be running
- `.env.local` must be configured

### Environment Variable Validation

Add this check to `src/lib/auth.ts`:
```typescript
const requiredEnvVars = [
  "AZURE_AD_B2C_TENANT_NAME",
  "AZURE_AD_B2C_CLIENT_ID",
  "AZURE_AD_B2C_CLIENT_SECRET",
];

for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    throw new Error(`Missing required environment variable: ${envVar}`);
  }
}
```

---

## Project Structure Notes

### Alignment with Unified Project Structure

✅ **Compliant:**
- `src/lib/auth.ts` - NextAuth configuration (correct)
- `src/middleware.ts` - Route protection (correct)
- `src/app/api/auth/[...nextauth]/` - Auth API route (correct)
- `src/types/next-auth.d.ts` - Type extensions (correct)

### Files to Create/Update

**New Files:**
- `src/types/next-auth.d.ts` - TypeScript declarations
- `src/app/auth/error/page.tsx` - Error page
- `src/lib/auth-helpers.ts` - Server helpers

**Update Existing:**
- `src/lib/auth.ts` - Complete NextAuth config (partially exists from Story 1.1)
- `src/middleware.ts` - Add route protection (partially exists)
- `src/app/login/page.tsx` - Add sign-in button (exists, needs enhancement)
- `.env.example` - Add auth variables

---

## References

### Source Documents

| Document | Location | Relevant Section |
|----------|----------|------------------|
| **Epics** | `_bmad-output/planning-artifacts/epics.md` | Epic 1, Story 1.2 (lines 34-52) |
| **Architecture** | `_bmad-output/planning-artifacts/architecture.md` | Decision 3: Authentication Architecture (lines 247-260) |
| **Project Context** | `_bmad-output/planning-artifacts/project-context.md` | Authentication & Authorization patterns |
| **PRD** | `_bmad-output/planning-artifacts/prd.md` | User roles, SSO requirements |
| **Previous Story** | `_bmad-output/stories/1-1-project-initialization.md` | Database schema, Prisma setup |

### Technical References

| Technology | Version | Documentation |
|------------|---------|---------------|
| NextAuth | 5.0.0-beta.25 | https://authjs.dev/getting-started/migrating-to-v5 |
| Azure AD B2C | v2.0 | https://docs.microsoft.com/en-us/azure/active-directory-b2c/ |
| Prisma Adapter | Latest | https://authjs.dev/reference/adapter/prisma |

### Azure AD B2C User Flow

**Required User Flow Configuration:**
```json
{
  "Id": "B2C_1_signupsignin1",
  "IdentityProviders": ["Local Account"],
  "Claims": ["email", "name", "oid", "extension_role"]
}
```

---

## Dev Agent Record

### Agent Model Used

Create Story Agent - Story context generation with architecture and previous story analysis

### Previous Story Intelligence

**From Story 1.1:**
- Prisma schema already defined with User model
- Database migrations should be applied
- Project structure is established
- Dependencies (NextAuth, Prisma adapter) should be installed

**Key Learnings to Apply:**
- Follow Server Component default pattern from project-context.md
- Use `getServerSession()` for auth checks in Server Components
- Always include audit logging for auth events
- Environment variables must be validated at startup

### Completion Notes List

**Before Starting Implementation:**
1. Verify Story 1.1 is complete (database ready, Prisma configured)
2. Obtain Azure AD B2C credentials from EPA IT team
3. Configure App Registration in Azure portal
4. Add redirect URIs for localhost and production
5. Test Azure AD connection before implementing UI

**Common Issues to Watch:**
- NextAuth v5 beta API may change - check for breaking changes
- Azure AD B2C user flow must include `extension_role` claim
- JWT secret must be at least 32 characters
- Middleware matcher syntax must be correct for Next.js 14

### File List

**Files to Create:**
- `src/types/next-auth.d.ts` - TypeScript type extensions
- `src/app/auth/error/page.tsx` - Auth error page
- `src/lib/auth-helpers.ts` - Server-side auth utilities

**Files to Update:**
- `src/lib/auth.ts` - Complete NextAuth configuration
- `src/middleware.ts` - Add route protection matcher
- `src/app/login/page.tsx` - Add sign-in button and styling
- `.env.example` - Add all Azure AD B2C variables

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] NextAuth configured with Azure AD B2C provider
- [ ] Login page with EPA MAX branding and sign-in button
- [ ] JWT session strategy working (8-hour expiry)
- [ ] All 4 roles (CONTRIBUTOR, AGGREGATOR, PROGRAM_OVERSEER, ADMINISTRATOR) functional
- [ ] Middleware protecting all required routes
- [ ] Sign-out functionality working with audit logging
- [ ] Server-side auth helpers created and tested
- [ ] Environment variables documented in `.env.example`
- [ ] E2E test: User can sign in with EPA MAX credentials
- [ ] E2E test: Unauthenticated users redirected to login
- [ ] E2E test: Role-based access working correctly
- [ ] Ready for Story 1.3: Core Layout & Navigation

**Next Story Dependencies:**
- Story 1.3 requires: Authentication working, `useSession()` hook available
- Story 2.1 requires: Role checks, auth middleware protecting submission routes

**Integration Points:**
- Navigation component will use `useSession()` for user menu
- Dashboard will use `getServerSession()` for data fetching
- All future API routes will check authentication via middleware
