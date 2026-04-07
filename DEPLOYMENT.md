# Deployment Guide

This guide covers the deployment process for the EPA Business Platform.

## Prerequisites

### System Requirements

- Node.js 18.x or higher
- PostgreSQL 14.x or higher
- npm 9.x or higher
- Git
Jake

### Required Accounts & Services

1. **Azure AD B2C** - For EPA MAX authentication
2. **Microsoft Graph API** - For OneNote integration
3. **Microsoft Bot Framework** - For Teams bot (optional)
4. **PostgreSQL Database** - Can be cloud-hosted (AWS RDS, Azure Database, etc.)
5. **Hosting Platform** - Vercel, AWS, Azure, or self-hosted

## Environment Setup

### 1. Database Setup

#### Local Development
```bash
# Install PostgreSQL locally or use Docker
docker run -d \
  --name epa-postgres \
  -e POSTGRES_USER=epauser \
  -e POSTGRES_PASSWORD=yourpassword \
  -e POSTGRES_DB=epabusinessplatform \
  -p 5432:5432 \
  postgres:14
```

#### Production
Use a managed PostgreSQL service:
- **AWS RDS for PostgreSQL**
- **Azure Database for PostgreSQL**
- **Google Cloud SQL for PostgreSQL**

### 2. Environment Variables

Copy `.env.example` to `.env.local` and fill in all required values:

```bash
cp .env.example .env.local
```

#### Critical Variables

| Variable | Description | Source |
|----------|-------------|--------|
| `DATABASE_URL` | PostgreSQL connection string | Database provider |
| `NEXTAUTH_SECRET` | Random 32+ character string | Generate with `openssl rand -base64 32` |
| `NEXTAUTH_URL` | Your app URL | Deployment platform |
| `AZURE_AD_B2C_TENANT_NAME` | Azure AD B2C tenant | Azure Portal |
| `AZURE_AD_B2C_CLIENT_ID` | Application client ID | Azure Portal |
| `AZURE_AD_B2C_CLIENT_SECRET` | Application secret | Azure Portal |

#### Microsoft Graph API (for OneNote)

1. Register application in Azure AD
2. Add Microsoft Graph API permissions:
   - `Notes.ReadWrite`
   - `User.Read`
3. Create client secret
4. Copy values to environment variables

#### Teams Bot (Optional)

1. Register bot in Azure Bot Service
2. Enable Microsoft Teams channel
3. Copy App ID and Password to environment variables

## Build Process

### Local Build Test

```bash
# Install dependencies
npm install

# Generate Prisma client
npx prisma generate

# Build application
npm run build

# Verify build output
ls -la .next/
```

### Production Build

```bash
# Set production environment
export NODE_ENV=production

# Install production dependencies
npm ci --only=production

# Build
npm run build
```

## Deployment Options

### Option 1: Vercel (Recommended)

1. **Install Vercel CLI**
   ```bash
   npm i -g vercel
   ```

2. **Login to Vercel**
   ```bash
   vercel login
   ```

3. **Deploy**
   ```bash
   vercel --prod
   ```

4. **Environment Variables**
   - Add all variables in Vercel Dashboard
   - Or use `vercel env add VARIABLE_NAME`

5. **Database Connection**
   - Ensure database allows connections from Vercel IPs
   - Or use connection pooling (PgBouncer)

### Option 2: AWS (ECS/Fargate)

1. **Create ECS Cluster**
   ```bash
   aws ecs create-cluster --cluster-name epa-platform
   ```

2. **Build Docker Image**
   ```dockerfile
   # Dockerfile
   FROM node:18-alpine
   WORKDIR /app
   COPY package*.json ./
   RUN npm ci --only=production
   COPY . .
   RUN npm run build
   EXPOSE 3000
   CMD ["npm", "start"]
   ```

3. **Push to ECR**
   ```bash
   aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_URL
   docker build -t epa-platform .
   docker tag epa-platform:latest $ECR_URL/epa-platform:latest
   docker push $ECR_URL/epa-platform:latest
   ```

4. **Create ECS Service**
   - Use Fargate for serverless containers
   - Configure auto-scaling
   - Set environment variables

### Option 3: Self-Hosted (Linux Server)

1. **Server Requirements**
   - Ubuntu 22.04 LTS or similar
   - 2+ CPU cores
   - 4GB+ RAM
   - 20GB+ storage

2. **Install Node.js**
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

3. **Install PM2**
   ```bash
   sudo npm install -g pm2
   ```

4. **Deploy Application**
   ```bash
   # Clone repository
git clone <repository-url> /var/www/epa-platform
   cd /var/www/epa-platform

   # Install dependencies
   npm ci --only=production

   # Build
   npm run build

   # Start with PM2
   pm2 start npm --name "epa-platform" -- start
   pm2 save
   pm2 startup
   ```

5. **Configure Nginx**
   ```nginx
   server {
       listen 80;
       server_name your-domain.gov;
       return 301 https://$server_name$request_uri;
   }

   server {
       listen 443 ssl http2;
       server_name your-domain.gov;

       ssl_certificate /path/to/cert.pem;
       ssl_certificate_key /path/to/key.pem;

       location / {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

## Database Migrations

### Initial Setup

```bash
# Run migrations
npx prisma migrate deploy

# Seed initial data (if applicable)
npx prisma db seed
```

### Subsequent Deployments

```bash
# Check migration status
npx prisma migrate status

# Deploy pending migrations
npx prisma migrate deploy
```

## Post-Deployment Checklist

### Verification Steps

1. **Application Health**
   - [ ] Homepage loads without errors
   - [ ] Login page accessible
   - [ ] Authentication working
   - [ ] Database connection stable

2. **Feature Verification**
   - [ ] WAR submission form works
   - [ ] AI conversion functional
   - [ ] Review workflow accessible
   - [ ] Approval dashboard loads
   - [ ] Admin panel accessible (for admins)

3. **Integration Tests**
   - [ ] Teams bot responding (if enabled)
   - [ ] OneNote publishing works
   - [ ] Email notifications sending

4. **Security Checks**
   - [ ] HTTPS enforced
   - [ ] Security headers present
   - [ ] Environment variables secured
   - [ ] Database connections encrypted

### Monitoring Setup

1. **Application Monitoring**
   - Install APM tool (Datadog, New Relic, etc.)
   - Configure error tracking (Sentry)
   - Set up log aggregation

2. **Database Monitoring**
   - Enable query performance monitoring
   - Set up connection pool monitoring
   - Configure backup alerts

3. **Uptime Monitoring**
   - Set up health check endpoints
   - Configure uptime alerts
   - Establish SLA monitoring

## Rollback Procedure

If deployment fails:

1. **Immediate Rollback**
   ```bash
   # Using PM2
   pm2 stop epa-platform
   pm2 start epa-platform-old

   # Using Docker
   docker stop epa-platform-new
   docker start epa-platform-old
   ```

2. **Database Rollback**
   ```bash
   # If migrations failed
   npx prisma migrate resolve --rolled-back <migration-name>

   # Restore from backup (if needed)
   pg_restore --clean --if-exists --dbname=epabusinessplatform backup.sql
   ```

## Troubleshooting

### Common Issues

#### Build Failures

```bash
# Clear Next.js cache
rm -rf .next

# Rebuild
npm run build
```

#### Database Connection Issues

```bash
# Test connection
npx prisma db pull

# Check connection string format
# Should be: postgresql://user:pass@host:port/db?schema=public
```

#### Authentication Issues

- Verify `NEXTAUTH_SECRET` is set
- Check `NEXTAUTH_URL` matches deployment URL
- Ensure Azure AD B2C redirect URLs configured

#### Memory Issues

```bash
# Increase Node.js memory limit
export NODE_OPTIONS="--max-old-space-size=4096"
npm run build
```

## Performance Optimization

### Database

1. **Enable Connection Pooling**
   ```env
   DATABASE_URL="postgresql://user:pass@host:port/db?connection_limit=20&pool_timeout=30"
   ```

2. **Add Indexes** (if needed)
   ```sql
   CREATE INDEX CONCURRENTLY idx_submissions_status ON submissions(status);
   ```

### Application

1. **Enable CDN for static assets**
2. **Configure caching headers**
3. **Use Next.js Image optimization**
4. **Enable gzip compression**

## Security Hardening

### Network Security

1. **Firewall Rules**
   - Allow only HTTPS (443)
   - Restrict database access to app servers
   - Block unused ports

2. **DDoS Protection**
   - Enable Cloudflare or AWS Shield
   - Configure rate limiting

### Application Security

1. **Security Headers**
   ```javascript
   // next.config.js
   async headers() {
     return [
       {
         source: '/:path*',
         headers: [
           { key: 'X-DNS-Prefetch-Control', value: 'on' },
           { key: 'Strict-Transport-Security', value: 'max-age=63072000' },
           { key: 'X-Frame-Options', value: 'SAMEORIGIN' },
           { key: 'X-Content-Type-Options', value: 'nosniff' },
         ],
       },
     ];
   }
   ```

2. **Content Security Policy**
   - Define strict CSP headers
   - Whitelist allowed domains

3. **Regular Updates**
   - Keep dependencies updated
   - Apply security patches promptly
   - Monitor vulnerability databases

## Maintenance

### Regular Tasks

- **Daily**: Check error logs, monitor performance
- **Weekly**: Review security alerts, update dependencies
- **Monthly**: Database optimization, backup verification
- **Quarterly**: Security audit, penetration testing

### Backup Strategy

1. **Database Backups**
   - Automated daily backups
   - Point-in-time recovery enabled
   - Cross-region replication

2. **Application Backups**
   - Source code in version control
   - Environment variables documented
   - Infrastructure as code (Terraform/CloudFormation)

## Support Contacts

- **Technical Issues**: Development team
- **Infrastructure**: DevOps team
- **Security**: Security team
- **Business Users**: EPA help desk

---

**Last Updated**: February 2026
**Version**: 1.0
