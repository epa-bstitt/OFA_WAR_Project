# Story 6.2: System Administration

Status: ready-for-dev
Created: 2026-02-19
Epic: Compliance & Audit (Epic 6)
Depends On: Story 6.1 (Audit Logging System)

---

## Story

As an Administrator,  
I want to manage users and system configuration,  
so that I can maintain the system.

---

## Acceptance Criteria

- [ ] **AC1:** User management interface (view, disable, change roles)
- [ ] **AC2:** System settings configuration
- [ ] **AC3:** Feature flags management
- [ ] **AC4:** Database health monitoring
- [ ] **AC5:** Export all data for backup
- [ ] **AC6:** Impersonation capability for support

---

## Tasks / Subtasks

### Task 1: Create Admin Dashboard (AC: #1)
- [ ] **1.1** Create `src/app/(dashboard)/admin/page.tsx`:
  - Route protected to ADMINISTRATOR role only
  - Admin dashboard overview
  - Quick stats and links
- [ ] **1.2** Create `src/components/features/admin/AdminDashboard.tsx`:
  - System health indicators
  - User counts by role
  - Recent activity summary
  - Navigation to admin sections
- [ ] **1.3** Add admin navigation:
  - Users, Audit Log, Settings, System
  - Only visible to ADMINISTRATOR
- [ ] **1.4** Add security warnings:
  - "Admin access - actions are logged"
  - Session timeout warning

### Task 2: Build User Management (AC: #1)
- [ ] **2.1** Create `src/app/(dashboard)/admin/users/page.tsx`:
  - User list view
  - Search and filter
- [ ] **2.2** Create `src/components/features/admin/UserManager.tsx`:
  - Table of all users
  - Columns: Name, Email, Role, Status, Last Active, Actions
  - Sortable columns
- [ ] **2.3** Implement user actions:
  - View user details
  - Edit user role (dropdown: CONTRIBUTOR, AGGREGATOR, PROGRAM_OVERSEER, ADMINISTRATOR)
  - Disable/enable user account
  - View user's submissions
- [ ] **2.4** Create `updateUserRole` Server Action:
  - Validate admin permissions
  - Update user role
  - Log to audit trail (action: USER_ROLE_CHANGED)
  - Notify user of role change (optional)
- [ ] **2.5** Create `disableUser`/`enableUser` Server Actions:
  - Soft disable (set isActive = false)
  - Prevent login when disabled
  - Log action in audit
  - Show reason for disable
- [ ] **2.6** Add bulk actions:
  - Select multiple users
  - Bulk disable/enable
  - Bulk role change (with confirmation)

### Task 3: Create System Settings (AC: #2)
- [ ] **3.1** Create `src/app/(dashboard)/admin/settings/page.tsx`:
  - System configuration panel
  - Organized by category
- [ ] **3.2** Create `src/components/features/admin/SystemSettings.tsx`:
  - Form sections for each setting category
  - Save/reset buttons
- [ ] **3.3** Implement settings categories:
  - **AI Service**: Timeout, max retries, endpoint URL
  - **Notifications**: Default preferences, digest schedule
  - **OneNote**: Default section ID, section name
  - **Teams**: Bot settings, notification defaults
  - **Security**: Session timeout, password policy (if applicable)
  - **Retention**: Audit log retention, data retention
- [ ] **3.4** Create `updateSystemSettings` Server Action:
  - Validate admin role
  - Update settings in database or env
  - Log changes to audit
  - Apply immediately (no restart needed)
- [ ] **3.5** Add settings validation:
  - Validate URLs
  - Validate numeric ranges
  - Test connections (optional)

### Task 4: Implement Feature Flags (AC: #3)
- [ ] **4.1** Create FeatureFlag model:
  ```prisma
  model FeatureFlag {
    id          String   @id @default(cuid())
    key         String   @unique
    name        String
    description String?
    enabled     Boolean  @default(false)
    rolloutPercent Int   @default(0) // 0-100
    createdAt   DateTime @default(now())
    updatedAt   DateTime @updatedAt
  }
  ```
- [ ] **4.2** Create `src/lib/feature-flags.ts`:
  - `isFeatureEnabled(key, userId?)` - Check if enabled
  - Support percentage rollouts
  - Cache flags
- [ ] **4.3** Create feature flags admin:
  - `src/app/(dashboard)/admin/features/page.tsx`
  - List all feature flags
  - Toggle on/off
  - Adjust rollout percentage
  - Description and purpose
- [ ] **4.4** Implement usage:
  - Wrap features in `isFeatureEnabled()` checks
  - Examples:
    - `FEATURE_TEAMS_BOT`
    - `FEATURE_AI_CONVERSION`
    - `FEATURE_DIGEST_MODE`
- [ ] **4.5** Add feature flag analytics:
  - Track usage per feature
  - Success rates
  - Performance impact

### Task 5: Add Database Health Monitoring (AC: #4)
- [ ] **5.1** Create `src/lib/db/health.ts`:
  - `checkDatabaseHealth()` function
  - Connection pool status
  - Query performance metrics
  - Table size statistics
- [ ] **5.2** Create health check endpoint:
  - `src/app/api/health/db/route.ts`
  - Return health status JSON
  - Include in monitoring
- [ ] **5.3** Create admin database panel:
  - `src/app/(dashboard)/admin/database/page.tsx`
  - Connection stats
  - Table sizes
  - Index health
  - Slow query log (if available)
- [ ] **5.4** Add alerts:
  - Connection pool near limit
  - Slow queries detected
  - Database size growing fast
- [ ] **5.5** Add maintenance tools:
  - Vacuum/analyze (if needed)
  - Clear caches
  - Refresh materialized views (if any)

### Task 6: Build Data Export (AC: #5)
- [ ] **6.1** Create `src/app/(dashboard)/admin/export/page.tsx`:
  - Data export interface
  - Select what to export
- [ ] **6.2** Implement export options:
  - Users (CSV/JSON)
  - Submissions (CSV/JSON)
  - Reviews (CSV/JSON)
  - Audit Logs (CSV/JSON)
  - Full database dump (JSON)
- [ ] **6.3** Create `exportData` Server Action:
  - Accept entity type and format
  - Stream large exports
  - Sanitize sensitive data
  - Include relationships
- [ ] **6.4** Add date range filtering:
  - Export submissions from date range
  - Export audit logs for period
  - Useful for compliance reports
- [ ] **6.5** Schedule automated backups:
  - Weekly full export
  - Store in secure location
  - Log backup completion

### Task 7: Implement Impersonation (AC: #6)
- [ ] **7.1** Create `src/app/actions/admin/impersonate.ts`:
  - `startImpersonation(targetUserId)` Server Action
  - Validate admin role
  - Store original admin session
  - Create impersonated session
- [ ] **7.2** Create impersonation UI:
  - "Impersonate User" button in user list
  - Confirmation dialog
  - Warning banner during impersonation
- [ ] **7.3** Add impersonation indicator:
  - Top banner: "You are impersonating [User Name]"
  - "Exit Impersonation" button
  - All actions logged as impersonated
- [ ] **7.4** Handle impersonation in audit:
  - Log action: IMPERSONATION_STARTED
  - Log all impersonated actions with original admin ID
  - Clear audit trail for accountability
- [ ] **7.5** Add safety limits:
  - Max impersonation time (1 hour)
  - Auto-logout after timeout
  - Cannot impersonate other admins

### Task 8: Create Admin Security Features (Supporting all ACs)
- [ ] **8.1** Log all admin actions:
  - Every admin page view
  - Every admin action
  - Separate ADMIN_AUDIT level
- [ ] **8.2** Add admin session timeout:
  - Shorter timeout for admin sessions (15 min idle)
  - Re-authentication required for sensitive actions
- [ ] **8.3** Create admin activity report:
  - What each admin did
  - When they did it
  - Failed admin actions
- [ ] **8.4** Add two-person rule (optional):
  - Sensitive actions require second admin approval
  - Role changes, system settings

---

## Dev Notes

### Architecture Compliance

**Role Enforcement:**
```typescript
if (session.user.role !== "ADMINISTRATOR") {
  throw new Error("Admin access required");
}
```

**Audit Pattern:**
```typescript
// Log every admin action
await logAuditEvent({
  action: "ADMIN_USER_ROLE_CHANGED",
  userId: session.user.id,
  resourceId: targetUserId,
  details: { oldRole, newRole },
});
```

### Previous Story Intelligence

**From Story 6.1:**
- Audit logging working
- Can view admin actions in audit log

**Key Integration Points:**
- All admin actions must be audited
- Use audit log for admin activity report
- User management updates user records

---

## Project Structure Notes

### Files to Create

```
src/
├── app/
│   └── (dashboard)/
│       └── admin/
│           ├── page.tsx
│           ├── users/
│           │   └── page.tsx
│           ├── settings/
│           │   └── page.tsx
│           ├── features/
│           │   └── page.tsx
│           ├── database/
│           │   └── page.tsx
│           └── export/
│               └── page.tsx
├── components/
│   └── features/
│       └── admin/
│           ├── AdminDashboard.tsx
│           ├── UserManager.tsx
│           ├── SystemSettings.tsx
│           ├── FeatureFlags.tsx
│           └── DatabaseHealth.tsx
├── lib/
│   ├── feature-flags.ts
│   └── db/
│       └── health.ts
└── app/
    └── actions/
        └── admin/
            ├── users.ts
            ├── settings.ts
            └── impersonate.ts
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] User management (view, edit role, disable) working
- [ ] System settings configurable
- [ ] Feature flags functional
- [ ] Database health monitoring
- [ ] Data export working
- [ ] Impersonation with safety controls
- [ ] All admin actions logged
- [ ] Ready for full system launch

**Epic 6 Complete!**
