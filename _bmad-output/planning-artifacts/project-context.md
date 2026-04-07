---
project_name: 'EPABusinessPlatform'
user_name: 'Jake'
date: '2026-02-18'
sections_completed: ['technology_stack', 'implementation_rules', 'patterns', 'anti_patterns']
---

# Project Context for AI Agents

_This file contains critical rules and patterns that AI agents must follow when implementing code in this project. Focus on unobvious details that agents might otherwise miss._

---

## Technology Stack & Versions

### Core Framework
- **Next.js**: 14+ with App Router (Server Components default)
- **React**: 18+ (Server/Client components pattern)
- **TypeScript**: 5.x with strict mode enabled
- **Node.js**: 18+ (LTS)

### Styling & UI
- **Tailwind CSS**: 3.4+
- **Shadcn/UI**: Latest (components via CLI)
- **CSS Variables**: For theming (EPA brand colors)
- **Framer Motion**: For Apple-inspired animations

### Database & ORM
- **PostgreSQL**: 15+ with PG Vector extension
- **Prisma**: 5.x (ORM and migrations)
- **pgvector**: For text embeddings (AI RAG)

### Authentication
- **NextAuth.js**: 5.x (beta)
- **Provider**: Azure AD B2C (EPA MAX)
- **Strategy**: JWT with session

### Microsoft Integration
- **Teams Bot Framework**: v4
- **MSAL Node**: For Graph API auth
- **Microsoft Graph API**: v1.0
- **Adaptive Cards**: v1.5

### AI Integration
- **Internal EPA AI Service**: HTTP REST API
- **No external AI services**: No OpenAI, Claude, etc.

### Testing
- **Vitest**: Unit/integration testing
- **React Testing Library**: Component testing
- **Playwright**: E2E testing

### Deployment
- **Cloud.gov**: PaaS (platform-as-a-service)
- **Containerized**: Docker-based deployment
- **FedRAMP**: Authorized environment

---

## Critical Implementation Rules

### Component Architecture

**ALWAYS use Server Components by default:**
```typescript
// ✅ GOOD - Server Component (default)
export default async function DashboardPage() {
  const submissions = await getSubmissions(); // Direct DB call
  return <DashboardGrid submissions={submissions} />;
}

// ❌ BAD - Unnecessary Client Component
'use client' // Only add when needed!
export default function DashboardPage() {
  const [data, setData] = useState(); // Don't do this for initial data
}
```

**Mark Client Components ONLY when necessary:**
```typescript
'use client' // Required for:
// - useState, useEffect, useContext
// - Event handlers (onClick, onSubmit)
// - Browser APIs (localStorage, window)
// - Framer Motion animations
```

### Data Fetching Pattern

**Server Components fetch directly:**
```typescript
// In Server Component
import { prisma } from '@/lib/db';

async function getSubmissions() {
  return await prisma.warSubmissions.findMany({
    where: { weekOf: getCurrentWeek() }
  });
}
```

**Client Components use React Query:**
```typescript
'use client';
import { useSubmissions } from '@/hooks/useSubmissions';

function SubmissionList() {
  const { data, isLoading } = useSubmissions(); // React Query hook
  // ...
}
```

### API Route Structure

**Next.js App Router pattern:**
```typescript
// app/api/submissions/route.ts
import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';

const submissionSchema = z.object({
  rawText: z.string().min(10),
  weekOf: z.string().date(),
});

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const validated = submissionSchema.parse(body);
    
    const submission = await createSubmission(validated);
    
    return NextResponse.json({ data: submission }, { status: 201 });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Validation failed', details: error.errors },
        { status: 400 }
      );
    }
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

### Database Access

**Always use Prisma client from lib/db:**
```typescript
import { prisma } from '@/lib/db';

// Singleton pattern ensures connection pooling
export const prisma = globalForPrisma.prisma ?? new PrismaClient();
```

**Include audit logging for all mutations:**
```typescript
// Every create/update/delete must log
await prisma.auditLog.create({
  data: {
    action: 'SUBMISSION_CREATED',
    userId: session.user.id,
    resourceId: submission.id,
    metadata: { weekOf: submission.weekOf }
  }
});
```

### Authentication Checks

**Middleware for route protection:**
```typescript
// middleware.ts
export { default } from 'next-auth/middleware';

export const config = {
  matcher: ['/dashboard/:path*', '/review/:path*', '/api/:path*']
};
```

**Server-side role checking:**
```typescript
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

async function checkRole(requiredRole: string) {
  const session = await getServerSession(authOptions);
  if (!session || session.user.role !== requiredRole) {
    throw new Error('Unauthorized');
  }
  return session;
}
```

### Error Handling Standards

**Consistent API error format:**
```typescript
{
  error: string,           // Human-readable message
  code: string,            // Machine-readable code (e.g., 'AUTH_REQUIRED')
  details?: Record<string, string[]>  // Validation errors
}
```

**Always wrap external calls:**
```typescript
try {
  const result = await graphClient.api('/me/onenote/pages').post(content);
} catch (error) {
  // Log to audit system
  await auditLogger.logError('GRAPH_API_FAILED', error);
  
  // Retry with exponential backoff (max 3 retries)
  return await retryWithBackoff(() => publishToOneNote(content));
}
```

### AI Integration Pattern

**Never call external AI services directly:**
```typescript
// ✅ GOOD - Use internal EPA service
import { aiService } from '@/lib/ai/service';

const terseVersion = await aiService.convertToTerse(rawText, {
  promptTemplate: currentPrompt,
  timeout: 5000 // 5 second timeout
});

// ❌ BAD - Never do this
import OpenAI from 'openai'; // FORBIDDEN
```

**Always provide fallback:**
```typescript
async function getTerseVersion(rawText: string) {
  try {
    return await aiService.convertToTerse(rawText);
  } catch (error) {
    // Return raw text with warning flag
    return { text: rawText, isFallback: true, warning: 'AI unavailable' };
  }
}
```

### Microsoft Graph API

**Always use retry logic:**
```typescript
import { retryWithBackoff } from '@/lib/graph/retry';

const result = await retryWithBackoff(
  () => graphClient.api('/me/onenote/pages').post(content),
  { maxRetries: 3, backoffMs: 1000 }
);
```

**Idempotent operations only:**
```typescript
// Use idempotency key to prevent duplicates
const idempotencyKey = `publish-${submissionId}-${weekOf}`;
```

### Naming Conventions

**Files:**
- Components: `PascalCase.tsx` (`SubmissionCard.tsx`)
- Hooks: `camelCase.ts` with `use` prefix (`useAuth.ts`)
- Utils: `camelCase.ts` (`formatDate.ts`)
- API routes: `kebab-case/route.ts` (`submit-war/route.ts`)

**Database:**
- Tables: `snake_case` plural (`war_submissions`)
- Columns: `snake_case` (`created_at`)
- Enums: `SCREAMING_SNAKE_CASE` (`SubmissionStatus.PENDING`)

**TypeScript:**
- Interfaces: `PascalCase` (`Submission`)
- Types: `PascalCase` with `Type` suffix (`SubmissionType`)
- Constants: `SCREAMING_SNAKE_CASE` (`MAX_RETRY_ATTEMPTS`)

### Code Organization

**Feature-based structure:**
```
components/
├── ui/                    # shadcn components (auto-generated)
├── features/
│   ├── dashboard/         # Dashboard-specific components
│   │   ├── SubmissionCard.tsx
│   │   ├── DashboardGrid.tsx
│   │   └── index.ts       # Barrel export
│   ├── review/            # Review workflow components
│   └── submit/            # Submission form components
└── shared/                # Cross-cutting components
    ├── Navigation.tsx
    └── Loading.tsx
```

**Lib organization:**
```
lib/
├── ai/                    # AI service abstraction
├── graph/                 # Microsoft Graph API
├── teams/                 # Teams bot integration
├── audit/                 # Compliance logging
├── db.ts                  # Prisma client
├── auth.ts                # NextAuth config
└── utils.ts               # Utility functions (cn, formatters)
```

---

## Patterns to Follow

### Form Handling

**Use react-hook-form + Zod:**
```typescript
'use client';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const submissionSchema = z.object({
  rawText: z.string().min(10, 'Minimum 10 characters'),
  weekOf: z.string().date()
});

type SubmissionForm = z.infer<typeof submissionSchema>;

function SubmissionForm() {
  const form = useForm<SubmissionForm>({
    resolver: zodResolver(submissionSchema),
    defaultValues: { rawText: '', weekOf: getCurrentWeek() }
  });
  
  async function onSubmit(data: SubmissionForm) {
    await createSubmission(data);
  }
  
  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        {/* Form fields */}
      </form>
    </Form>
  );
}
```

### Server Actions

**Use for form submissions:**
```typescript
// app/actions/submission.ts
'use server';

import { revalidatePath } from 'next/cache';

export async function createSubmission(formData: FormData) {
  const rawText = formData.get('rawText') as string;
  
  // Validate
  // Save to DB
  // Audit log
  
  revalidatePath('/dashboard');
  return { success: true };
}
```

### Loading States

**Use Next.js loading.tsx:**
```typescript
// app/dashboard/loading.tsx
import { Skeleton } from '@/components/ui/skeleton';

export default function Loading() {
  return (
    <div className="space-y-4">
      <Skeleton className="h-8 w-[250px]" />
      <Skeleton className="h-32" />
    </div>
  );
}
```

### Error Boundaries

**Use error.tsx for route errors:**
```typescript
// app/dashboard/error.tsx
'use client';

export default function Error({
  error,
  reset
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <div className="error-container">
      <h2>Something went wrong!</h2>
      <Button onClick={reset}>Try again</Button>
    </div>
  );
}
```

### Styling with Tailwind

**Use cn() utility for conditional classes:**
```typescript
import { cn } from '@/lib/utils';

function Button({ className, variant, ...props }) {
  return (
    <button
      className={cn(
        'inline-flex items-center justify-center rounded-md',
        variant === 'primary' && 'bg-primary text-white',
        variant === 'secondary' && 'bg-secondary',
        className // User overrides last
      )}
      {...props}
    />
  );
}
```

### Animation Standards

**Apple-inspired motion (per UX spec):**
```typescript
// Page transitions: 200-300ms ease-out
// Micro-interactions: 150ms ease-in-out
// Respect prefers-reduced-motion

import { motion } from 'framer-motion';

<motion.div
  initial={{ opacity: 0, y: 20 }}
  animate={{ opacity: 1, y: 0 }}
  transition={{ duration: 0.3, ease: [0.25, 0.1, 0.25, 1] }}
>
```

---

## Anti-Patterns to Avoid

### ❌ NEVER do these:

**1. Client-side data fetching for initial load:**
```typescript
// ❌ BAD
'use client';
function Page() {
  useEffect(() => {
    fetch('/api/data').then(r => r.json()); // Wrong!
  }, []);
}

// ✅ GOOD
// Server Component
async function Page() {
  const data = await getData(); // Direct call
}
```

**2. Direct external AI service calls:**
```typescript
// ❌ FORBIDDEN
import OpenAI from 'openai';
const openai = new OpenAI({ apiKey: process.env.OPENAI_KEY });

// ✅ GOOD
import { aiService } from '@/lib/ai/service';
const result = await aiService.convertToTerse(text);
```

**3. Missing audit logging:**
```typescript
// ❌ BAD
await prisma.submission.create({ data });

// ✅ GOOD
const submission = await prisma.submission.create({ data });
await auditLogger.log('SUBMISSION_CREATED', { userId, submissionId: submission.id });
```

**4. No error handling on external calls:**
```typescript
// ❌ BAD
const result = await graphClient.api('/onenote/pages').post(content);

// ✅ GOOD
try {
  const result = await retryWithBackoff(() => 
    graphClient.api('/onenote/pages').post(content)
  );
} catch (error) {
  await auditLogger.logError('ONE_NOTE_PUBLISH_FAILED', error);
  throw new PublishError('Failed to publish to OneNote', { cause: error });
}
```

**5. Prop drilling:**
```typescript
// ❌ BAD
<Parent user={user}>
  <Child user={user}>
    <GrandChild user={user} /> // Drilling!
  </Child>
</Parent>

// ✅ GOOD - Use composition or Context
<UserContext.Provider value={user}>
  <Parent />
</UserContext.Provider>
```

**6. Inconsistent error responses:**
```typescript
// ❌ BAD
return res.status(500).json({ message: 'It broke' });

// ✅ GOOD
return NextResponse.json(
  { error: 'Failed to process submission', code: 'SUBMISSION_ERROR' },
  { status: 500 }
);
```

**7. Missing loading states:**
```typescript
// ❌ BAD
function Component() {
  const { data } = useQuery(...);
  return <div>{data.name}</div>; // Will crash on load
}

// ✅ GOOD
function Component() {
  const { data, isLoading } = useQuery(...);
  if (isLoading) return <Skeleton />;
  if (!data) return <ErrorMessage />;
  return <div>{data.name}</div>;
}
```

**8. Storing sensitive data client-side:**
```typescript
// ❌ BAD
localStorage.setItem('userToken', token); // Security risk!

// ✅ GOOD
// Keep tokens in HTTP-only cookies (handled by NextAuth)
// Store only UI preferences client-side
localStorage.setItem('sidebarCollapsed', 'true');
```

---

## Testing Requirements

### Unit Tests

**Every utility function needs tests:**
```typescript
// lib/utils.test.ts
import { describe, it, expect } from 'vitest';
import { formatDate } from './utils';

describe('formatDate', () => {
  it('formats ISO date to readable string', () => {
    expect(formatDate('2024-02-18')).toBe('Feb 18, 2024');
  });
});
```

### Component Tests

**Test user interactions:**
```typescript
// components/SubmissionCard.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';

describe('SubmissionCard', () => {
  it('shows submit button', () => {
    render(<SubmissionCard />);
    expect(screen.getByText('Submit')).toBeInTheDocument();
  });
  
  it('calls onSubmit when clicked', () => {
    const onSubmit = vi.fn();
    render(<SubmissionCard onSubmit={onSubmit} />);
    fireEvent.click(screen.getByText('Submit'));
    expect(onSubmit).toHaveBeenCalled();
  });
});
```

### E2E Tests

**Critical flows must have E2E coverage:**
```typescript
// tests/e2e/submission.spec.ts
import { test, expect } from '@playwright/test';

test('user can submit WAR', async ({ page }) => {
  await page.goto('/dashboard');
  await page.fill('[name="rawText"]', 'My weekly update...');
  await page.click('button[type="submit"]');
  await expect(page.locator('.success-message')).toBeVisible();
});
```

---

## Federal Compliance Notes

### Accessibility (WCAG 2.1 AA)

**Always include:**
- `aria-label` on icon-only buttons
- Keyboard navigation support
- Focus indicators visible
- Color contrast 4.5:1 minimum
- Screen reader announcements for dynamic content

### Security

**Required practices:**
- All user input validated (Zod schemas)
- SQL injection prevention (Prisma parameterized queries)
- XSS prevention (React auto-escapes, but verify dangerouslySetInnerHTML)
- CSRF tokens for state-changing operations
- Audit logging for all data mutations

### Data Handling

**Federal requirements:**
- No PII in logs (mask user emails, names)
- Data retention policies (configurable)
- Encryption at rest (Cloud.gov handles this)
- Encryption in transit (HTTPS only)

---

## Quick Reference

### Common Commands

```bash
# Add shadcn component
npx shadcn add button

# Run Prisma migration
npx prisma migrate dev --name add_submission_status

# Generate Prisma client
npx prisma generate

# Run tests
npm test              # Unit tests
npm run test:e2e      # E2E tests

# Type checking
npx tsc --noEmit

# Linting
npm run lint
```

### Environment Variables Required

```bash
# Database
DATABASE_URL="postgresql://..."

# NextAuth
NEXTAUTH_URL="https://..."
NEXTAUTH_SECRET="..."
AZURE_AD_B2C_TENANT_NAME="..."
AZURE_AD_B2C_CLIENT_ID="..."
AZURE_AD_B2C_CLIENT_SECRET="..."

# Microsoft Graph
MS_GRAPH_CLIENT_ID="..."
MS_GRAPH_CLIENT_SECRET="..."

# AI Service
AI_SERVICE_URL="..."
AI_SERVICE_API_KEY="..."

# Teams Bot
BOT_APP_ID="..."
BOT_APP_PASSWORD="..."
```

---

*This document is optimized for LLM context efficiency. AI agents should read this file before implementing any code in the EPABusinessPlatform project.*
