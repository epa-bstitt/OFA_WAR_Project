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

### Option 4: cloud.gov (Cloud Foundry)

#### Prerequisites
- Cloud Foundry CLI (cf8.exe)
- cloud.gov account and org/space access
- manifest.yml in project root (see below)

#### 1. Prepare manifest.yml
A sample manifest.yml is provided in the project root. Edit the `route` to match your cloud.gov subdomain:

```yaml
---
applications:
  - name: ofa-war-project
    memory: 512M
    instances: 1
    buildpacks:
      - nodejs_buildpack
    command: npm run start
    env:
      NODE_ENV: production
    routes:
      - route: ofa-war-project.YOUR-SUBDOMAIN-HERE.app.cloud.gov
```

#### 2. Build and Deploy

```bash
# Install dependencies and build
npm install
npx prisma generate
npm run build

# Log in to cloud.gov
cf login -a https://api.fr.cloud.gov --sso

# Target your org and space
cf target -o YOUR_ORG -s YOUR_SPACE

# Deploy
cf push
```

#### 3. Troubleshooting
- If you see `Failed due to Can not find manifest file!`, ensure `manifest.yml` is in the project root.
- Check buildpack logs with `cf logs ofa-war-project --recent` for errors.
- Make sure all environment variables are set in the manifest or via `cf set-env`.

#### 4. Environment Variables
- You can set sensitive variables with `cf set-env ofa-war-project VAR_NAME value` and restage:
  ```bash
  cf set-env ofa-war-project NEXTAUTH_SECRET your-secret
  cf restage ofa-war-project
  ```

#### 5. Database
- Use a managed PostgreSQL service (AWS RDS, Azure, etc.) and set `DATABASE_URL` accordingly.
- cloud.gov supports service bindings for databases if provisioned through the marketplace.

---
