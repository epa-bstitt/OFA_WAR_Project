# Story 6.1: Audit Logging System

Status: ready-for-dev
Created: 2026-02-19
Epic: Compliance & Audit (Epic 6)
Depends On: Story 1.1 (Project Initialization & Database Setup)

---

## Story

As an Administrator,  
I want to see a complete audit trail of all system actions,  
so that I can ensure compliance and investigate issues.

---

## Acceptance Criteria

- [ ] **AC1:** Audit middleware logs all user actions
- [ ] **AC2:** Immutable audit log storage
- [ ] **AC3:** View audit logs by user, date, or action type
- [ ] **AC4:** Export audit logs (CSV, JSON)
- [ ] **AC5:** 7-year retention policy enforcement
- [ ] **AC6:** PII masking in logs (no emails, names)

---

## Tasks / Subtasks

### Task 1: Create Audit Middleware (AC: #1)
- [ ] **1.1** Create `src/lib/audit/middleware.ts`:
  - Intercept all API requests
  - Extract user, action, resource, timestamp
  - Log to database
- [ ] **1.2** Create `src/lib/audit/logger.ts`:
  - `logAuditEvent(event)` - Core logging function
  - Type-safe event definitions
  - Async logging (don't block)
- [ ] **1.3** Add to middleware chain:
  - Apply after auth middleware
  - Capture all authenticated requests
  - Skip health checks, static assets
- [ ] **1.4** Define audit events:
  - USER_SIGNIN, USER_SIGNOUT
  - SUBMISSION_CREATED, SUBMISSION_UPDATED, SUBMISSION_DELETED
  - SUBMISSION_APPROVED, SUBMISSION_REJECTED, SUBMISSION_PUBLISHED
  - REVIEW_CREATED, REVIEW_UPDATED
  - PROMPT_CREATED, PROMPT_UPDATED
  - NOTIFICATION_SENT

### Task 2: Implement Audit Database Storage (AC: #2)
- [ ] **2.1** Create AuditLog model (from Story 1.1):
  ```prisma
  model AuditLog {
    id          String   @id @default(cuid())
    action      String   // Action type
    userId      String   // Who performed action
    resourceId  String?  // What was affected
    resourceType String? // Type of resource
    details     Json?    // Additional context
    ipAddress   String?  // IP (optional)
    userAgent   String?  // Browser info
    timestamp   DateTime @default(now())
    
    user User @relation(fields: [userId], references: [id])
    
    @@index([userId, timestamp])
    @@index([action, timestamp])
    @@index([resourceId])
  }
  ```
- [ ] **2.2** Make logs immutable:
  - No update/delete operations
  - Append-only
  - Tamper-evident (hash chain optional)
- [ ] **2.3** Add to all Server Actions:
  - Log at start and end
  - Log success and failure
  - Include relevant IDs
- [ ] **2.4** Handle PII masking:
  - Don't log email addresses
  - Don't log names
  - Use userId only
  - Sanitize details JSON

### Task 3: Create Audit Log Viewer (AC: #3)
- [ ] **3.1** Create `src/app/(dashboard)/admin/audit/page.tsx`:
  - Route protected to ADMINISTRATOR only
  - Page title: "Audit Log"
  - Professional, serious design
- [ ] **3.2** Create `src/components/features/audit/AuditLogViewer.tsx`:
  - Table view of audit entries
  - Columns: Timestamp, User, Action, Resource, Details
  - Pagination (50 per page)
- [ ] **3.3** Add filtering:
  - Filter by user (dropdown)
  - Filter by action type
  - Filter by date range
  - Filter by resource ID
- [ ] **3.4** Add search:
  - Full-text search in details
  - Search by resource ID
  - Search by action
- [ ] **3.5** Create detail view:
  - Expandable rows
  - Show full JSON details
  - Pretty-print formatting

### Task 4: Build Export Functionality (AC: #4)
- [ ] **4.1** Create `exportAuditLogs` Server Action:
  - Accept filters
  - Generate CSV format
  - Generate JSON format
- [ ] **4.2** CSV export:
  - Headers: timestamp, userId, action, resourceId, details
  - ISO date format
  - Escaped values
- [ ] **4.3** JSON export:
  - Array of log objects
  - Pretty-printed
  - Date strings
- [ ] **4.4** Add download:
  - Stream large exports
  - Progress indicator for large datasets
  - Email download link (optional)

### Task 5: Implement Retention Policy (AC: #5)
- [ ] **5.1** Create retention job:
  - Daily/weekly scheduled task
  - Identify logs >7 years old
  - Archive or delete
- [ ] **5.2** Create `src/lib/audit/retention.ts`:
  - `enforceRetentionPolicy()` function
  - Query old logs
  - Archive to cold storage (optional)
  - Delete from database
- [ ] **5.3** Configure retention settings:
  - 7 years default
  - Configurable via env
  - Different retention for different action types (optional)
- [ ] **5.4** Log retention actions:
  - Log when logs are deleted
  - Who ran retention job
  - Count deleted
- [ ] **5.5** Add manual retention trigger:
  - Admin can run retention job
  - Preview what will be deleted
  - Confirmation required

### Task 6: Ensure PII Masking (AC: #6)
- [ ] **6.1** Create `src/lib/audit/pii.ts`:
  - `maskPII(data)` function
  - Remove email patterns
  - Remove name fields
  - Hash sensitive IDs
- [ ] **6.2** Apply masking:
  - Before saving to database
  - In details JSON
  - In user agent strings
- [ ] **6.3** Create allowlist:
  - Fields that are safe to log
  - Explicitly define what's logged
  - Everything else masked
- [ ] **6.4** Audit PII compliance:
  - Regular scan for PII in logs
  - Alert if found
  - Remediation process

### Task 7: Create Audit Dashboard (Supporting all ACs)
- [ ] **7.1** Create stats cards:
  - Total events today
  - Events by type (pie chart)
  - Events by user (top 10)
  - Failed actions count
- [ ] **7.2** Add trend analysis:
  - Events over time (line chart)
  - Anomaly detection (optional)
  - Alert on unusual activity
- [ ] **7.3** Create suspicious activity report:
  - Multiple failed logins
  - Unusual access patterns
  - Privilege escalation attempts

### Task 8: Add Compliance Features (Supporting all ACs)
- [ ] **8.1** Create compliance report:
  - PDF report generation
  - Period summary
  - Event counts
  - Sign-off page
- [ ] **8.2** Add tamper detection:
  - Hash chain verification
  - Report if chain broken
  - Digital signatures (optional)
- [ ] **8.3** Access logging:
  - Log who views audit logs
  - Self-referential logging
  - Admin access audit

---

## Dev Notes

### Architecture Compliance

**Middleware Pattern:**
```typescript
// src/middleware.ts chain
export default async function middleware(req) {
  // 1. Auth
  const session = await getSession(req);
  
  // 2. Audit
  await logRequest(req, session);
  
  // 3. Next
  return NextResponse.next();
}
```

**Immutable Logging:**
```typescript
// Never update or delete
await prisma.auditLog.create({ data: event });
// No update or delete operations!
```

### Previous Story Intelligence

**From Story 1.1:**
- AuditLog model in schema
- Database ready

**Key Integration Points:**
- All Server Actions need audit calls
- Middleware needs audit wrapper
- Auth events need special handling

---

## Project Structure Notes

### Files to Create

```
src/
├── lib/
│   └── audit/
│       ├── middleware.ts
│       ├── logger.ts
│       ├── pii.ts
│       └── retention.ts
├── app/
│   └── (dashboard)/
│       └── admin/
│           └── audit/
│               └── page.tsx
├── components/
│   └── features/
│       └── audit/
│           ├── AuditLogViewer.tsx
│           ├── AuditFilters.tsx
│           └── AuditStats.tsx
└── app/
    └── actions/
        └── audit.ts
```

---

## Story Completion Checklist

**Definition of Done:**
- [ ] All ACs completed and verified
- [ ] Middleware logging all requests
- [ ] Audit logs immutable and queryable
- [ ] Filtering by user, date, action working
- [ ] Export to CSV/JSON functional
- [ ] Retention policy enforced
- [ ] PII masked in all logs
- [ ] Ready for Story 6.2: System Administration

**Next Story Dependencies:**
- Story 6.2 requires: Audit logs for admin actions
