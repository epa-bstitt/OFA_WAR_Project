# EPA Business Platform

A secure, cloud-based platform for managing Weekly Activity Reports (WARs) with AI-powered terse conversion, multi-stage review workflows, Microsoft Teams integration, and comprehensive audit logging.

## Overview

The EPA Business Platform streamlines the process of submitting, reviewing, and publishing Weekly Activity Reports. It features:

- **AI-Powered Conversion**: Automatically converts verbose text to EPA-compliant terse format
- **Multi-Stage Workflow**: CONTRIBUTOR → AGGREGATOR → PROGRAM_OVERSEER → ADMINISTRATOR
- **Microsoft Teams Integration**: Bot for WAR submission and status notifications
- **OneNote Publishing**: Automated publication of approved WARs
- **Audit Logging**: Complete compliance tracking with PII masking
- **EPA MAX Authentication**: Secure Azure AD B2C integration

## Tech Stack

- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript 5
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: NextAuth.js v5 with Azure AD B2C
- **Styling**: Tailwind CSS + shadcn/ui
- **AI Integration**: Internal EPA AI service
- **Microsoft Integration**: Graph API + Bot Framework

## Quick Start

### Prerequisites

- Node.js 18+
- PostgreSQL 14+
- npm or yarn

### Installation

1. Clone the repository
2. Copy environment variables:
   ```bash
   cp .env.example .env.local
   ```
3. Install dependencies:
   ```bash
   npm install
   ```
4. Set up the database:
   ```bash
   npx prisma migrate dev
   npx prisma generate
   ```
5. Run the development server:
   ```bash
   npm run dev
   ```

### Environment Variables

See `.env.example` for all required variables. Key configurations:

- `DATABASE_URL`: PostgreSQL connection string
- `NEXTAUTH_SECRET`: Random string for session encryption
- `AZURE_AD_B2C_*`: EPA MAX authentication settings
- `MS_GRAPH_*`: Microsoft Graph API credentials
- `BOT_APP_*`: Teams bot credentials

## Architecture

### Directory Structure

```
src/
├── app/                    # Next.js App Router
│   ├── (dashboard)/        # Protected dashboard routes
│   ├── actions/            # Server actions
│   └── api/                # API routes
├── components/
│   ├── features/           # Feature-specific components
│   ├── shared/             # Reusable UI components
│   └── ui/                 # shadcn/ui components
├── lib/
│   ├── audit/              # Audit logging system
│   ├── teams/              # Teams bot integration
│   ├── graph/              # Microsoft Graph API
│   └── ai/                 # AI service integration
├── config/                 # Configuration files
└── types/                  # TypeScript types
```

### Key Features

#### 1. WAR Submission (Epic 2)
- Rich text input with AI conversion
- Confidence scoring
- Draft saving

#### 2. Review Workflow (Epic 3)
- Side-by-side editor
- Raw/terse comparison
- Batch review capabilities

#### 3. Approval System (Epic 4)
- Program Overseer dashboard
- Batch approval/rejection
- OneNote publication

#### 4. Teams Integration (Epic 5)
- `/war` command for submission
- Status notifications
- Adaptive Cards UI

#### 5. Compliance & Audit (Epic 6)
- Immutable audit logs
- PII masking
- 7-year retention
- Admin user management

## Role Hierarchy

```
ADMINISTRATOR (4)
    ↓
PROGRAM_OVERSEER (3)
    ↓
AGGREGATOR (2)
    ↓
CONTRIBUTOR (1)
```

Each role inherits permissions from lower levels.

## Development

### Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run lint` - Run ESLint
- `npm run db:migrate` - Run database migrations
- `npm run db:studio` - Open Prisma Studio

### Adding New Features

1. Create server actions in `src/app/actions/`
2. Build UI components in `src/components/features/`
3. Add routes in `src/app/(dashboard)/`
4. Update navigation in `src/config/navigation.ts`

## Deployment

### Production Build

```bash
npm run build
```

### Database Migration

```bash
npx prisma migrate deploy
```

### Environment Setup

Ensure all production environment variables are set:
- Database connection
- Azure AD B2C credentials
- Microsoft Graph API credentials
- Teams bot credentials

## Security

- All data encrypted in transit (HTTPS/TLS)
- Row-level security via role-based access
- PII masking in audit logs
- 8-hour session timeout
- Secure cookie handling

## Compliance

- **Audit Logging**: All actions logged with 7-year retention
- **PII Protection**: Automatic masking of sensitive data
- **Access Control**: Role-based permissions
- **Data Retention**: Configurable policies per data type

## API Integration

### Microsoft Graph

Used for OneNote publication:
- Authentication via MSAL
- Token caching and refresh
- Retry logic with exponential backoff

### Teams Bot

Bot Framework v4 integration:
- Command handling (`/war`, `/war status`)
- Adaptive Cards for UI
- Proactive notifications

## Troubleshooting

### Common Issues

1. **Build fails with auth errors**: Check `NEXTAUTH_SECRET` and `NEXTAUTH_URL`
2. **Database connection fails**: Verify `DATABASE_URL` format
3. **Teams bot not responding**: Check `BOT_APP_ID` and `BOT_APP_PASSWORD`
4. **AI conversion fails**: Verify `AI_SERVICE_URL` and `AI_SERVICE_API_KEY`

### Debug Mode

Enable detailed logging:
```env
LOG_LEVEL=debug
```

## Contributing

1. Follow the existing code style
2. Add types for all functions
3. Include audit logging for sensitive operations
4. Test with all user roles
5. Update documentation

## License

Internal EPA Use Only

## Support

For issues or questions, contact the development team or create an issue in the project repository.
