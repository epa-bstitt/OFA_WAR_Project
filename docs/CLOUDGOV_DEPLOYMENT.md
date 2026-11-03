# Cloud.gov Deployment Guide

## Overview
This guide covers deploying the EPA Business Platform to Cloud.gov, including migrating from a local Docker PostgreSQL instance to Cloud.gov's managed PostgreSQL service.

## Prerequisites

1. **Cloud.gov Account**: Ensure you have access to your agency's Cloud.gov organization and space
2. **CF CLI**: Install the Cloud Foundry CLI (cf CLI)
   ```bash
   # macOS
   brew install cloudfoundry/tap/cf-cli@8

   # Windows
   winget install cloudfoundry.cli
   ```
3. **Docker** (for local development and migration)

## Step 1: Login to Cloud.gov

```bash
cf login -a api.fr.cloud.gov --sso
```

Follow the prompts to authenticate with your PIV/CAC card or credentials.

## Step 2: Create Services

### 2.1 Create PostgreSQL Database

```bash
# Create a medium PostgreSQL service (adjust plan as needed)
cf create-service aws-rds medium-psql epa-db -c '{"engine_version": "15", "storage_encrypted": true}'

# Wait for service creation (can take 10-20 minutes)
cf services

# Get service credentials once ready
cf service-key epa-db credentials-key
cf create-service-key epa-db credentials-key
cf service-key epa-db credentials-key
```

### 2.2 Create User-Provided Service for Secrets

```bash
# Create a user-provided service for application secrets
cf create-user-provided-service epa-secrets -p '{
  "DATABASE_URL": "postgresql://username:password@host:5432/dbname",
  "NEXTAUTH_SECRET": "your-nextauth-secret",
  "AZURE_AD_B2C_CLIENT_ID": "your-client-id",
  "AZURE_AD_B2C_CLIENT_SECRET": "your-client-secret",
  "AZURE_AD_B2C_TENANT_NAME": "your-tenant",
  "SESSION_MAX_AGE": "28800"
}'
```

## Step 3: Prepare Application for Deployment

### 3.1 Update manifest.yml

Create/update `manifest.yml` in your project root:

```yaml
---
applications:
  - name: epa-business-platform
    buildpacks:
      - https://github.com/cloudfoundry/nodejs-buildpack
      - https://github.com/cloudfoundry/binary-buildpack
    stack: cflinuxfs4
    memory: 2G
    disk_quota: 1G
    instances: 2
    env:
      NODE_ENV: production
      NEXT_TELEMETRY_DISABLED: 1
      NPM_CONFIG_PRODUCTION: true
    services:
      - epa-db
      - epa-secrets
    routes:
      - route: epa-business-platform.app.cloud.gov
    health-check-type: port
    health-check-http-endpoint: /api/health
```

### 3.2 Update next.config.mjs for Cloud.gov

Ensure your `next.config.mjs` has output set to standalone:

```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  // ... other config
}

module.exports = nextConfig
```

### 3.3 Create Build Scripts

Create `buildpack-run.sh`:

```bash
#!/bin/bash
set -e

echo "Building EPA Business Platform..."

# Install dependencies
npm ci

# Generate Prisma client
npx prisma generate

# Build Next.js application
npm run build

echo "Build complete!"
```

Make it executable:
```bash
chmod +x buildpack-run.sh
```

## Step 4: Database Migration from SQLite to Cloud.gov

The migration reads `prisma/dev-db.sqlite`, validates its relationships, applies the
Prisma PostgreSQL baseline, copies all models in dependency order, and verifies row
counts and SHA-256 hashes. Binding credentials remain in the conduit-provided
`VCAP_SERVICES` environment and are not written to disk.

### 4.1 Back Up and Validate SQLite

Create an external backup before running any source repair. Then generate both Prisma
clients and run the source preflight:

```powershell
Copy-Item prisma\dev-db.sqlite ..\dev-db-before-postgres.sqlite
npm run db:generate
npm run db:generate:sqlite
node scripts\migrate-sqlite-to-postgres.mjs --inventory-only
```

If preflight reports the known duplicate orphaned Daycom rows, run the guarded repair
and repeat inventory. The repair aborts unless exactly ten orphaned rows match ten
valid rows field-for-field.

```powershell
npm run db:repair:orphaned-daycom
node scripts\migrate-sqlite-to-postgres.mjs --inventory-only
```

### 4.2 Apply and Verify the Migration

The `epa-db` service uses the `aws-rds` broker, which is not supported by the
Cloud Foundry conduit plugin. Do not use conduit to access this database. For
schema-only deployments, the GitHub Actions workflow stages a temporary no-route
task app, binds it to `epa-db`, runs `prisma migrate deploy`, waits for the task to
succeed, and only then deploys the public app. This path does not copy data from the
local SQLite database.

For a full SQLite-to-PostgreSQL data transfer, use a separately reviewed and backed
up migration operation. Do not replace or import production data as part of a normal
application deployment.

```powershell
# Confirm the managed database service is ready before deploying.
cf8 service epa-db
```

## Step 5: Deploy Application

### Automatic deployments from GitHub

The workflow in `.github/workflows/deploy-cloudgov.yml` builds and deploys the existing `epa-business-platform` app on each push to `main`. It can also be started manually from the GitHub Actions tab. In the GitHub repository, create a `production` environment and add these environment secrets:

- `CF_USERNAME`: a dedicated cloud.gov deployer/service account with access to the `epa-prototyping` org and `admin-training` space.
- `CF_PASSWORD`: that account's password, stored only as a GitHub secret. Do not use an interactive SSO/passcode account for CI.

Until both secrets are configured, the workflow builds but cannot authenticate to deploy. The workflow pins Node.js 22 and CF CLI 8.19.0, runs focused tests, builds a Next.js standalone bundle, stages a temporary no-route task app with the current source, binds it to `epa-db`, and runs checked-in Prisma migrations through the bound `VCAP_SERVICES` credentials. It waits for the migration task to succeed before pushing the public app; migration failure prevents the app push. The temporary app is removed after the deployment job. This process does **not** transfer the local SQLite database, bootstrap users, or import data. The build sets `CI=false` for the Next.js step because this repository currently has unrelated strict TypeScript errors; this matches the existing production build behavior and should be removed after those errors are fixed. Configure environment protection rules if production changes need review before deployment.

### 5.1 Initial Deployment

For an initial manual deployment, use the same order as the GitHub workflow: stage a
temporary task app with the Prisma CLI installed, bind `epa-db`, run and verify
`prisma migrate deploy`, then push and start the public app. Do not run migrations
through conduit for this `aws-rds` service.

### 5.2 Blue-Green Deployment (Zero Downtime)

```bash
# Use autopilot plugin or cf bgd
cf install-plugin autopilot -r CF-Community

# Deploy with zero downtime
cf zero-downtime-push epa-business-platform -f manifest.yml
```

## Step 6: Post-Deployment Verification

### 6.1 Check Application Logs

```bash
# Stream logs
cf logs epa-business-platform

# Recent logs
cf logs epa-business-platform --recent
```

### 6.2 Verify Database Connection

Access the admin panel and use the "Test Database Connection" button in Settings.

### 6.3 Health Check

```bash
curl https://epa-business-platform.app.cloud.gov/api/health
```

## Step 7: Environment Variables Management

### Update Secrets

```bash
# Update user-provided service
cf update-user-provided-service epa-secrets -p '{
  "DATABASE_URL": "new-connection-string",
  "OTHER_SECRET": "new-value"
}'

# Restage application to pick up new env vars
cf restage epa-business-platform
```

### View Environment Variables

```bash
cf env epa-business-platform
```

## Step 8: Scaling

### Scale Instances

```bash
# Scale horizontally (more instances)
cf scale epa-business-platform -i 3

# Scale vertically (more memory)
cf scale epa-business-platform -m 4G
```

### Enable Autoscaling (if using Cloud.gov Autoscaler)

```bash
cf create-service autoscaler standard epa-autoscaler
cf bind-service epa-business-platform epa-autoscaler
cf configure-autoscaling epa-business-platform --min 2 --max 10 --cpu-threshold 70
```

## Troubleshooting

### Common Issues

1. **Database Connection Refused**
   - Verify DATABASE_URL format in secrets service
   - Check RDS security group allows connections from app space

2. **Build Fails**
   - Check buildpack logs: `cf logs epa-business-platform --recent`
   - Ensure `npm ci` works locally
   - Verify Node.js version compatibility

3. **Prisma Migration Errors**
  - Inspect the migration task output in the GitHub Actions run.
  - Confirm the temporary task app had an active binding to `epa-db`.

4. **Memory Issues**
   - Increase memory allocation: `cf scale epa-business-platform -m 4G`
   - Check for memory leaks in logs

### Useful Commands

```bash
# SSH into running container
cf ssh epa-business-platform

# Run one-off tasks
cf run-task epa-business-platform "npx prisma migrate status" --name check-migrations

# View service bindings
cf services

# View app events
cf events epa-business-platform

# Enable debug logging
 cf set-env epa-business-platform DEBUG '*'
 cf restage epa-business-platform
```

## Security Considerations

1. **Encrypted Storage**: Cloud.gov RDS uses encrypted storage by default
2. **HTTPS Only**: All traffic is automatically HTTPS
3. **Network Isolation**: Apps run in isolated containers
4. **PII Handling**: Use Cloud.gov's secure environment for PII data
5. **Audit Logging**: Enable Cloud.gov's audit logging for compliance

## Maintenance

### Regular Updates

1. **Update Buildpacks**: Automatic with each deployment
2. **Security Patches**: Monitor Cloud.gov notifications
3. **Database Maintenance**: Use Cloud.gov's supported RDS service controls for backups and maintenance. The conduit plugin cannot interpret this `aws-rds` service instance.

### Backup Strategy

1. **RDS Automated Backups**: Enabled by default (retention: 7 days)
2. **Manual Backups**: Create and verify a Cloud.gov-supported RDS snapshot before major data operations.

## Support

- Cloud.gov Support: cloud.gov/docs/help/
- EPA Internal Support: [Your Internal Team]
- Application Issues: Check logs and metrics in Cloud.gov dashboard

---

## Quick Reference Cheat Sheet

```bash
# Deployment and migration status
cf logs epa-business-platform --recent
cf tasks epa-business-platform

# Troubleshooting
cf logs epa-business-platform --recent
cf ssh epa-business-platform
cf run-task epa-business-platform "npm run db:status" --name debug
```
