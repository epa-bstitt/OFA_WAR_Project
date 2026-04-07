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

## Step 4: Database Migration from Local Docker to Cloud.gov

### 4.1 Export Local Database

```bash
# Start local Docker PostgreSQL if not running
docker-compose up -d postgres

# Export local database
docker exec epa-postgres pg_dump -U epauser -d epadb --format=custom > epa_backup.dump

# Or export as SQL
docker exec epa-postgres pg_dump -U epauser -d epadb --inserts > epa_backup.sql
```

### 4.2 Prepare Cloud.gov Database

```bash
# SSH into the app container (after initial deployment)
cf ssh epa-business-platform

# Or use the conduit plugin for direct database access
cf install-plugin conduit -r CF-Community
cf conduit epa-db -- pg_restore --verbose --clean --no-acl --no-owner -h localhost -U user -d dbname < epa_backup.dump
```

### 4.3 Alternative: Manual Migration via pgAdmin

1. Get Cloud.gov database credentials:
   ```bash
   cf service-key epa-db credentials-key
   ```

2. Use pgAdmin or any PostgreSQL client to connect and restore the backup

## Step 5: Deploy Application

### 5.1 Initial Deployment

```bash
# Push application (without starting)
cf push --no-start

# Run database migrations
cf run-task epa-business-platform "npx prisma migrate deploy" --name migrate

# Start application
cf start epa-business-platform
```

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
   - Connect directly to database to diagnose: `cf conduit epa-db -- psql`
   - Check migration status: `npx prisma migrate status`

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
3. **Database Maintenance**: Use `cf conduit` for database maintenance tasks

### Backup Strategy

1. **RDS Automated Backups**: Enabled by default (retention: 7 days)
2. **Manual Backups**: Create before major deployments
   ```bash
   cf conduit epa-db -- pg_dump -Fc > backup-$(date +%Y%m%d).dump
   ```

## Support

- Cloud.gov Support: cloud.gov/docs/help/
- EPA Internal Support: [Your Internal Team]
- Application Issues: Check logs and metrics in Cloud.gov dashboard

---

## Quick Reference Cheat Sheet

```bash
# Full deployment workflow
cf login -a api.fr.cloud.gov --sso
cf target -o <org> -s <space>
cf push --no-start
cf run-task epa-business-platform "npx prisma migrate deploy" --name migrate
cf start epa-business-platform
cf logs epa-business-platform

# Database operations
cf conduit epa-db -- psql
cf conduit epa-db -- pg_dump -Fc > backup.dump
cf conduit epa-db -- pg_restore -d dbname < backup.dump

# Troubleshooting
cf logs epa-business-platform --recent
cf ssh epa-business-platform
cf run-task epa-business-platform "npm run db:status" --name debug
```
