# Story 1.3: Core Layout & Navigation

Status: ready-for-dev
Created: 2026-02-19
Epic: Foundation & Authentication (Epic 1)
Depends On: Story 1.2 (EPA MAX Authentication Integration)

---

## Story

As a WAR contributor,  
I want a consistent navigation and layout across the application,  
so that I can easily navigate between different sections.

---

## Acceptance Criteria

- [ ] **AC1:** Root layout with EPA branding implemented
- [ ] **AC2:** Navigation component with role-based menu items
- [ ] **AC3:** Responsive sidebar/header navigation
- [ ] **AC4:** User menu with profile and sign-out options
- [ ] **AC5:** Loading states for all pages
- [ ] **AC6:** Error boundaries implemented

---

## Tasks / Subtasks

### Task 1: Enhance Root Layout with EPA Branding (AC: #1)
- [ ] **1.1** Update `src/app/layout.tsx`:
  - Add EPA logo (SVG or PNG) to header
  - Apply EPA color scheme (primary: #005ea2, secondary: #70e17b)
  - Set page title: "EPA Business Platform - Weekly Activity Reports"
  - Add EPA favicon
  - Include skip-to-content link for accessibility (WCAG 2.1 AA)
- [ ] **1.2** Create `src/components/shared/EPALogo.tsx`:
  - EPA logo SVG component
  - Configurable size prop (sm, md, lg)
  - Link to EPA.gov (opens in new tab)
- [ ] **1.3** Create `src/components/shared/Footer.tsx`:
  - EPA footer with links
  - Privacy policy, accessibility statement
  - Federal government notices
  - Copyright information
- [ ] **1.4** Update `globals.css` with EPA CSS variables:
  ```css
  :root {
    --epa-primary: #005ea2;
    --epa-secondary: #70e17b;
    --epa-dark: #1b1b1b;
    --epa-light: #f0f0f0;
    /* Map to shadcn variables */
    --primary: var(--epa-primary);
    --secondary: var(--epa-secondary);
  }
  ```

### Task 2: Create Navigation Component (AC: #2)
- [ ] **2.1** Create `src/components/shared/Navigation.tsx`:
  - Main navigation bar/header
  - "use client" directive (needs interactivity)
  - Use shadcn NavigationMenu or custom implementation
- [ ] **2.2** Define navigation items by role in `src/config/navigation.ts`:
  ```typescript
  export const NAV_ITEMS = {
    CONTRIBUTOR: [
      { label: "Dashboard", href: "/dashboard", icon: "LayoutDashboard" },
      { label: "Submit WAR", href: "/submit", icon: "FileText" },
      { label: "My Submissions", href: "/submissions", icon: "List" },
    ],
    AGGREGATOR: [
      { label: "Dashboard", href: "/dashboard", icon: "LayoutDashboard" },
      { label: "Review Queue", href: "/review", icon: "Inbox" },
      { label: "Prompts", href: "/prompts", icon: "Settings" },
    ],
    PROGRAM_OVERSEER: [
      { label: "Dashboard", href: "/dashboard", icon: "LayoutDashboard" },
      { label: "Approve", href: "/approve", icon: "CheckCircle" },
      { label: "Analytics", href: "/analytics", icon: "BarChart" },
    ],
    ADMINISTRATOR: [
      { label: "Dashboard", href: "/dashboard", icon: "LayoutDashboard" },
      { label: "Users", href: "/admin/users", icon: "Users" },
      { label: "Audit Log", href: "/admin/audit", icon: "FileSearch" },
      { label: "Settings", href: "/admin/settings", icon: "Settings" },
    ],
  };
  ```
- [ ] **2.3** Implement role-based filtering:
  - Read user role from `useSession()` hook
  - Filter navigation items based on role
  - Highlight active route
  - Show/hide items based on `hasMinimumRole()` checks

### Task 3: Build Responsive Sidebar/Header (AC: #3)
- [ ] **3.1** Create `src/components/shared/Sidebar.tsx`:
  - Desktop: Left sidebar (240px width)
  - Mobile: Sheet/drawer component (shadcn Sheet)
  - Collapsible sections
  - Sticky positioning on desktop
- [ ] **3.2** Create `src/components/shared/Header.tsx`:
  - Top header bar
  - EPA logo + app name
  - Mobile hamburger menu button
  - User menu trigger (avatar + name)
- [ ] **3.3** Create responsive layout wrapper:
  - `src/components/shared/AppShell.tsx`:
    ```typescript
    export function AppShell({ children }: { children: React.ReactNode }) {
      return (
        <div className="min-h-screen flex flex-col">
          <Header />
          <div className="flex-1 flex">
            <Sidebar className="hidden lg:block" />
            <main id="main-content" className="flex-1 p-6">
              {children}
            </main>
          </div>
          <Footer />
        </div>
      );
    }
    ```
- [ ] **3.4** Update `src/app/(dashboard)/layout.tsx`:
  - Wrap children with AppShell
  - Apply to all protected routes
- [ ] **3.5** Add mobile responsive breakpoints:
  - `sm:` (640px) - Mobile landscape
  - `md:` (768px) - Tablet
  - `lg:` (1024px) - Desktop sidebar appears
  - `xl:` (1280px) - Wide desktop

### Task 4: Create User Menu Component (AC: #4)
- [ ] **4.1** Create `src/components/shared/UserMenu.tsx`:
  - "use client" directive
  - shadcn DropdownMenu component
  - User avatar (from session or initials fallback)
  - User name and role display
- [ ] **4.2** Add menu items:
  - Profile link (placeholder for now)
  - Settings link (placeholder for now)
  - Separator
  - Sign out button (calls signOut from NextAuth)
- [ ] **4.3** Display role badge:
  - Color-coded badges per role:
    - CONTRIBUTOR: blue
    - AGGREGATOR: yellow
    - PROGRAM_OVERSEER: green
    - ADMINISTRATOR: red
  - Role name in user menu header
- [ ] **4.4** Handle loading state:
  - Show skeleton while session loads
  - Show fallback avatar if no image

### Task 5: Implement Loading States (AC: #5)
- [ ] **5.1** Create `src/app/loading.tsx` (root loading):
  - Full-page loading spinner
  - EPA branded loading state
- [ ] **5.2** Create `src/app/(dashboard)/loading.tsx`:
  - Dashboard skeleton layout
  - shadcn Skeleton components
- [ ] **5.3** Create `src/components/shared/Loading.tsx`:
  - Reusable loading component
  - Props: size, fullScreen, text
- [ ] **5.4** Create `src/components/shared/PageSkeleton.tsx`:
  - Page content skeleton
  - Header, content cards, action buttons
- [ ] **5.5** Add Suspense boundaries:
  - Wrap async data fetching in Suspense
  - Show loading.tsx fallback
  - Strategic placement for progressive loading

### Task 6: Create Error Boundaries (AC: #6)
- [ ] **6.1** Create `src/app/error.tsx` (root error boundary):
  - Generic error display
  - Retry button
  - Link to return home
- [ ] **6.2** Create `src/app/(dashboard)/error.tsx`:
  - Dashboard-specific error handling
  - Preserves navigation
  - Error details (dev mode only)
- [ ] **6.3** Create `src/components/shared/ErrorDisplay.tsx`:
  - Reusable error component
  - Props: title, message, retry?, error?
  - Log error to console/monitoring
- [ ] **6.4** Create `src/app/not-found.tsx`:
  - 404 page
  - EPA branding
  - Search suggestions
  - Link back to dashboard
- [ ] **6.5** Create `src/app/global-error.tsx`:
  - Root level error boundary
  - Handles uncaught errors
  - Full-page error display

### Task 7: Create Dashboard Layout Components (Supporting all ACs)
- [ ] **7.1** Create `src/components/shared/PageHeader.tsx`:
  - Page title and description
  - Breadcrumbs (optional)
  - Action buttons slot
- [ ] **7.2** Create `src/components/shared/CardGrid.tsx`:
  - Responsive grid layout for dashboard cards
  - Props: columns (1-4), gap, children
- [ ] **7.3** Create `src/components/shared/ContentCard.tsx`:
  - shadcn Card wrapper
  - Consistent styling
  - Header, content, footer slots

### Task 8: Add Accessibility Features (Supporting all ACs)
- [ ] **8.1** Add skip-to-content link:
  - First focusable element in layout
  - Jumps to `<main id="main-content">`
- [ ] **8.2** Ensure keyboard navigation:
  - All interactive elements focusable
  - Visible focus indicators
  - Logical tab order
- [ ] **8.3** Add ARIA labels:
  - Navigation landmarks
  - Button labels
  - Menu descriptions
- [ ] **8.4** Test color contrast:
  - EPA primary (#005ea2) on white: 7:1 ratio ✓
  - EPA secondary (#70e17b) on dark: 12:1 ratio ✓
- [ ] **8.5** Add screen reader announcements:
  - Route changes announced
  - Loading states announced
  - Error messages announced

---

## Dev Notes

### Architecture Compliance

**Component Pattern (per Architecture):**
- Server Components by default for layouts
- Client Components ("use client") only for:
  - Navigation (needs useSession, interactivity)
  - UserMenu (needs signOut, dropdown state)
  - Mobile menu toggle (needs useState)

**Layout Hierarchy:**
```
Root Layout (Server)
├── Header (Client - needs session)
├── Sidebar (Client - needs session, mobile toggle)
├── Main Content (Server/Client based on page)
└── Footer (Server)
```

### EPA Design System

**Colors:**
- Primary: `#005ea2` (EPA Blue)
- Secondary: `#70e17b` (EPA Green)
- Dark: `#1b1b1b`
- Light: `#f0f0f0`

**Typography:**
- Font: Inter (already configured)
- Hierarchy: h1, h2, h3 with EPA styling

**Logo:**
- Use EPA official logo SVG
- Link to https://www.epa.gov
- Alt text: "U.S. Environmental Protection Agency"

### Navigation Structure

**Role-Based Access:**
```typescript
// Navigation visibility logic
const visibleItems = NAV_ITEMS[role] || [];
const hasAccess = hasMinimumRole(userRole, requiredRole);
```

**Active State:**
- Use Next.js `usePathname()` hook
- Compare current path to nav item href
- Apply active styling (background, border)

### Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Default | < 640px | Stack, hamburger menu |
| sm | ≥ 640px | Stack, hamburger menu |
| md | ≥ 768px | Stack, hamburger menu |
| lg | ≥ 1024px | Sidebar + content |
| xl | ≥ 1280px | Wider sidebar |

### Error Handling Strategy

**Error Boundaries Hierarchy:**
1. `global-error.tsx` - Catches all uncaught errors
2. `error.tsx` (dashboard group) - Dashboard-specific
3. `error.tsx` (root) - Generic fallback
4. Component-level try/catch - Local handling

**Error Display:**
- User-friendly message (no stack traces in prod)
- Retry button when applicable
- Automatic error logging to console
- Optional: report to error tracking service

### Previous Story Intelligence

**From Story 1.2 (Authentication):**
- `useSession()` hook available from NextAuth
- User roles: CONTRIBUTOR, AGGREGATOR, PROGRAM_OVERSEER, ADMINISTRATOR
- `signOut()` function available
- Middleware already protecting routes

**Key Learnings to Apply:**
- Use Server Components for layout structure
- Client Components only when interactivity needed
- Session data available via `useSession()`
- EPA branding must be consistent across all pages

### Testing Approach

**Visual Regression:**
- Screenshot tests for layout at different breakpoints
- EPA color consistency check

**Accessibility Tests:**
- axe-core automated checks
- Keyboard navigation flow
- Screen reader announcements

**Responsive Tests:**
- Mobile (375px)
- Tablet (768px)
- Desktop (1440px)

---

## Project Structure Notes

### Alignment with Unified Project Structure

✅ **Compliant:**
- `src/components/shared/` - Shared components (correct)
- `src/config/` - Configuration files (correct)
- `src/app/(dashboard)/` - Route groups (correct)
- `src/app/loading.tsx` - Loading states (correct)
- `src/app/error.tsx` - Error boundaries (correct)

### Files to Create/Update

**New Files:**
```
src/
├── components/
│   └── shared/
│       ├── AppShell.tsx
│       ├── CardGrid.tsx
│       ├── ContentCard.tsx
│       ├── EPALogo.tsx
│       ├── ErrorDisplay.tsx
│       ├── Footer.tsx
│       ├── Header.tsx
│       ├── Loading.tsx
│       ├── Navigation.tsx
│       ├── PageHeader.tsx
│       ├── PageSkeleton.tsx
│       ├── Sidebar.tsx
│       └── UserMenu.tsx
├── config/
│   └── navigation.ts
├── app/
│   ├── (dashboard)/
│   │   ├── layout.tsx (update)
│   │   ├── loading.tsx (create)
│   │   └── error.tsx (create)
│   ├── not-found.tsx (create)
│   ├── global-error.tsx (create)
│   └── loading.tsx (create)
```

**Update Existing:**
- `src/app/layout.tsx` - Add EPA branding, footer
- `src/globals.css` - EPA CSS variables
- `src/config/site.ts` - Add navigation metadata

---

## References

### Source Documents

| Document | Location | Relevant Section |
|----------|----------|------------------|
| **Epics** | `_bmad-output/planning-artifacts/epics.md` | Epic 1, Story 1.3 (lines 53-71) |
| **Architecture** | `_bmad-output/planning-artifacts/architecture.md` | Project Structure (lines 489-542), Component Boundaries |
| **Project Context** | `_bmad-output/planning-artifacts/project-context.md` | Component Architecture, Styling with Tailwind |
| **UX Design Spec** | `_bmad-output/planning-artifacts/ux-design-specification.md` | Navigation patterns, responsive design |
| **Previous Story** | `_bmad-output/stories/1-2-epa-max-authentication.md` | useSession, role hierarchy, signOut |

### Technical References

| Technology | Documentation |
|------------|---------------|
| Next.js App Router | https://nextjs.org/docs/app/building-your-application/routing/route-groups |
| Next.js Loading UI | https://nextjs.org/docs/app/building-your-application/routing/loading-ui |
| Next.js Error Handling | https://nextjs.org/docs/app/building-your-application/routing/error-handling |
| shadcn Navigation Menu | https://ui.shadcn.com/docs/components/navigation-menu |
| shadcn Sheet | https://ui.shadcn.com/docs/components/sheet |
| shadcn Dropdown Menu | https://ui.shadcn.com/docs/components/dropdown-menu |
| shadcn Skeleton | https://ui.shadcn.com/docs/components/skeleton |

### EPA Design Resources

- EPA Web Design System: https://www.epa.gov/themes/epa_theme/pattern-lab/
- EPA Colors: https://www.epa.gov/themes/epa_theme/css/base/variables.css
- WCAG 2.1 AA Guidelines: https://www.w3.org/WAI/WCAG21/quickref/

---

## Dev Agent Record

### Agent Model Used

Create Story Agent - Story context generation with architecture and UX analysis

### Previous Story Intelligence

**From Story 1.2:**
- Authentication system is working
- `useSession()` hook provides user data and role
- `signOut()` function available for logout
- Role hierarchy established: CONTRIBUTOR < AGGREGATOR < PROGRAM_OVERSEER < ADMINISTRATOR

**Key Integration Points:**
- Navigation must use `useSession()` to get user role
- UserMenu will call `signOut()` from NextAuth
- Role-based nav filtering using `hasMinimumRole()` from auth-helpers

### Completion Notes List

**Before Starting Implementation:**
1. Ensure Story 1.2 is complete (authentication working)
2. Have EPA logo SVG ready (download from EPA website or create placeholder)
3. Test `useSession()` hook returns expected user data
4. Verify all 4 roles can be tested (may need mock users)

**Common Issues to Watch:**
- Server/Client boundary: Don't use `useSession()` in Server Components
- Hydration errors: Ensure loading states match final render
- Mobile menu: State must be managed carefully to avoid flicker
- Active route: `usePathname()` only works in Client Components

### File List

**Files to Create:**
- `src/components/shared/AppShell.tsx` - Main app layout wrapper
- `src/components/shared/Header.tsx` - Top navigation bar
- `src/components/shared/Sidebar.tsx` - Left navigation sidebar
- `src/components/shared/Footer.tsx` - EPA footer
- `src/components/shared/Navigation.tsx` - Navigation menu
- `src/components/shared/UserMenu.tsx` - User dropdown menu
- `src/components/shared/EPALogo.tsx` - EPA logo component
- `src/components/shared/Loading.tsx` - Reusable loading component
- `src/components/shared/PageSkeleton.tsx` - Page loading skeleton
- `src/components/shared/ErrorDisplay.tsx` - Error display component
- `src/components/shared/PageHeader.tsx` - Page header component
- `src/components/shared/CardGrid.tsx` - Dashboard grid layout
- `src/components/shared/ContentCard.tsx` - Card wrapper component
- `src/config/navigation.ts` - Navigation configuration
- `src/app/loading.tsx` - Root loading state
- `src/app/(dashboard)/loading.tsx` - Dashboard loading state
- `src/app/(dashboard)/error.tsx` - Dashboard error boundary
- `src/app/not-found.tsx` - 404 page
- `src/app/global-error.tsx` - Global error boundary

**Files to Update:**
- `src/app/layout.tsx` - Add EPA branding, footer, skip link
- `src/app/(dashboard)/layout.tsx` - Wrap with AppShell
- `src/globals.css` - Add EPA CSS variables
- `src/config/site.ts` - Add navigation metadata

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] EPA branding (logo, colors) applied throughout
- [ ] Navigation shows correct items for each of 4 roles
- [ ] Responsive layout working at all breakpoints (mobile, tablet, desktop)
- [ ] User menu shows avatar, name, role, and sign-out option
- [ ] Loading states implemented (page skeletons, spinners)
- [ ] Error boundaries catch and display errors gracefully
- [ ] 404 page created with EPA branding
- [ ] Accessibility: Skip link, keyboard navigation, ARIA labels
- [ ] Color contrast meets WCAG 2.1 AA (tested)
- [ ] E2E test: Navigation works on mobile (hamburger menu)
- [ ] E2E test: Role-based navigation shows/hides correctly
- [ ] Ready for Story 2.1: WAR Submission Form

**Next Story Dependencies:**
- Story 2.1 requires: Dashboard layout, navigation to submit page, form layout
- All future stories require: Consistent layout, navigation, loading states

**Integration Points:**
- Story 2.1 (Submission Form) will use ContentCard and PageHeader
- Story 3.1 (Review Dashboard) will use CardGrid for stats display
- All pages will use AppShell for consistent layout
- UserMenu integration with sign-out from Story 1.2
