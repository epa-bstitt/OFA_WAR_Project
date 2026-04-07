# Ngrok Setup Guide for Local Development

## Overview
Ngrok provides secure tunnels to localhost, enabling external services (like Microsoft Teams webhooks) to reach your local development environment. This guide covers setting up ngrok with OpenAPI-compatible authentication for the EPA Business Platform.

## Why Ngrok?

- **Webhook Testing**: Teams Bot and other webhooks need public HTTPS URLs
- **Mobile Testing**: Test on real devices against local development server
- **Share Work**: Share local development with teammates
- **Secure**: Encrypted tunnels with automatic HTTPS

## Prerequisites

1. **Ngrok Account**: Sign up at [ngrok.com](https://ngrok.com)
2. **Auth Token**: Get from ngrok dashboard
3. **API Key** (optional): For programmatic management

## Step 1: Install Ngrok

### Option A: Direct Download

```bash
# macOS
brew install ngrok

# Windows (via Chocolatey)
choco install ngrok

# Linux
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar xvzf ngrok-v3-stable-linux-amd64.tgz
sudo mv ngrok /usr/local/bin/
```

### Option B: Docker

```bash
docker run -it --rm -p 4040:4040 ngrok/ngrok:latest http host.docker.internal:3000
```

## Step 2: Configure Ngrok

### 2.1 Add Auth Token

```bash
ngrok config add-authtoken <YOUR_AUTHTOKEN>
```

### 2.2 Create Configuration File

Create `ngrok.yml` in your home directory (`~/.config/ngrok/ngrok.yml`):

```yaml
version: 2
authtoken: <YOUR_AUTHTOKEN>
region: us  # Choose: us, eu, ap, au, sa, jp, in

# Default tunnel (for general testing)
tunnels:
  epa-app:
    proto: http
    addr: 3000
    domain: your-custom-domain.ngrok-free.app  # Optional: use paid plan for custom domains
    schemes: [https]
    inspect: true
    
  # Teams webhook specific tunnel
  teams-webhook:
    proto: http
    addr: 3000
    domain: epa-teams-webhook.ngrok-free.app
    schemes: [https]
    inspect: false
    
  # Static domain for consistent testing
  static:
    proto: http
    addr: 3000
    hostname: your-epa-subdomain.ngrok.app  # Requires paid plan for static hostname
```

## Step 3: Start Ngrok Tunnel

### Basic Usage

```bash
# Start with default settings
ngrok http 3000

# Start with specific subdomain (requires paid plan)
ngrok http --subdomain=epa-dev 3000

# Start with configuration file tunnel
ngrok start epa-app

# Start multiple tunnels
ngrok start epa-app teams-webhook
```

### With Environment Variables

```bash
# Set auth token via environment
export NGROK_AUTHTOKEN=<your-token>
ngrok http 3000
```

## Step 4: Configure Application

### 4.1 Environment Variables

Add to `.env.local`:

```bash
# Ngrok Configuration
NGROK_ENABLED=true
NGROK_AUTHTOKEN=<your-ngrok-authtoken>
NGROK_API_KEY=<your-ngrok-api-key>  # Optional, for management API
NGROK_REGION=us
NGROK_SUBDOMAIN=epa-dev  # Optional
NGROK_DOMAIN=your-domain.ngrok.io  # Optional

# Webhook URLs (update these when ngrok starts)
TEAMS_WEBHOOK_URL=https://your-ngrok-url.ngrok.io/api/webhooks/teams
APP_PUBLIC_URL=https://your-ngrok-url.ngrok.io
```

### 4.2 Update Webhook Endpoints

When ngrok starts, it provides a public URL like:
```
https://abc123-def.ngrok-free.app
```

Update your webhook configurations:

**Microsoft Teams Bot:**
1. Go to [Bot Framework Portal](https://dev.botframework.com)
2. Update messaging endpoint to: `https://your-ngrok-url.ngrok.io/api/webhooks/teams`

**Login.gov (for testing):**
- Update redirect URIs in sandbox dashboard

**Azure AD B2C:**
- Add ngrok URL to allowed redirect URIs

## Step 5: Ngrok Management API (OpenAPI Compatible)

### 5.1 API Key Setup

1. Go to [ngrok Dashboard](https://dashboard.ngrok.com) > **API** > **New API Key**
2. Copy the API key
3. Add to environment: `NGROK_API_KEY=<key>`

### 5.2 Using Ngrok API

```bash
# List active tunnels
curl -H "Authorization: Bearer $NGROK_API_KEY" \
  https://api.ngrok.com/tunnels

# Get tunnel details
curl -H "Authorization: Bearer $NGROK_API_KEY" \
  https://api.ngrok.com/tunnels/<tunnel-id>

# List requests (requires paid plan)
curl -H "Authorization: Bearer $NGROK_API_KEY" \
  https://api.ngrok.com/tunnels/<tunnel-id>/requests
```

### 5.3 Programmatic Management

```typescript
// lib/ngrok/manager.ts
export class NgrokManager {
  private apiKey: string;
  private baseUrl = 'https://api.ngrok.com';

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  async listTunnels() {
    const response = await fetch(`${this.baseUrl}/tunnels`, {
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json',
      },
    });
    return response.json();
  }

  async getPublicUrl() {
    const { tunnels } = await this.listTunnels();
    const httpTunnel = tunnels.find((t: any) => t.public_url.startsWith('https'));
    return httpTunnel?.public_url;
  }
}
```

## Step 6: Automate Ngrok Integration

### 6.1 Start Script

Create `scripts/start-with-ngrok.js`:

```javascript
const { spawn } = require('child_process');
const ngrok = require('ngrok');
const fs = require('fs');

async function start() {
  // Start ngrok
  const url = await ngrok.connect({
    proto: 'http',
    addr: 3000,
    authtoken: process.env.NGROK_AUTHTOKEN,
    region: process.env.NGROK_REGION || 'us',
  });

  console.log(`Ngrok tunnel active: ${url}`);

  // Write URL to file for reference
  fs.writeFileSync('.ngrok-url', url);

  // Update environment
  process.env.NEXTAUTH_URL = url;
  process.env.TEAMS_WEBHOOK_URL = `${url}/api/webhooks/teams`;

  // Start Next.js
  const next = spawn('npm', ['run', 'dev'], {
    stdio: 'inherit',
    env: process.env,
  });

  // Cleanup on exit
  process.on('SIGINT', async () => {
    console.log('\nShutting down ngrok...');
    await ngrok.disconnect();
    await ngrok.kill();
    next.kill();
    process.exit(0);
  });
}

start();
```

### 6.2 npm Script

Add to `package.json`:

```json
{
  "scripts": {
    "dev:ngrok": "node scripts/start-with-ngrok.js",
    "ngrok:start": "ngrok http 3000 --region=us",
    "ngrok:stop": "pkill ngrok"
  }
}
```

## Step 7: Webhook Development Workflow

### 7.1 Typical Development Session

```bash
# Terminal 1: Start ngrok tunnel
npm run ngrok:start

# Note the HTTPS URL (e.g., https://abc123.ngrok-free.app)

# Terminal 2: Start development server
npm run dev

# Terminal 3: Monitor ngrok traffic
open http://localhost:4040  # ngrok web interface
```

### 7.2 Update Bot Framework

1. Copy ngrok HTTPS URL
2. Go to [Bot Framework Portal](https://dev.botframework.com)
3. Update messaging endpoint
4. Test bot in Teams

### 7.3 Webhook Debugging

Use ngrok's web interface at `http://localhost:4040`:
- View all requests
- Replay webhooks
- Inspect headers and body
- Generate curl commands

## Security Considerations

### 1. **Never Commit Credentials**

```bash
# Add to .gitignore
.ngrok-url
ngrok.yml
*.ngrok.io
```

### 2. **Rotate Auth Tokens**

```bash
# Reset authtoken if compromised
ngrok config add-authtoken <NEW_TOKEN>
```

### 3. **IP Restrictions** (Paid Plans)

```yaml
# ngrok.yml with IP allowlist
tunnels:
  secure:
    proto: http
    addr: 3000
    ip_restriction:
      allow:
        - 10.0.0.0/8  # EPA internal network
        - 127.0.0.1/32
```

### 4. **Request Validation**

Always validate webhook signatures in production:

```typescript
// Validate Teams webhook signature
export function validateTeamsSignature(
  body: string,
  signature: string,
  secret: string
): boolean {
  const hmac = crypto.createHmac('sha256', secret);
  hmac.update(body);
  const expected = hmac.digest('base64');
  return signature === expected;
}
```

## Troubleshooting

### Ngrok Won't Start

```bash
# Check if port is in use
lsof -i :3000

# Kill existing ngrok processes
pkill ngrok

# Verify authtoken
ngrok diagnose
```

### Connection Refused

```bash
# Ensure Next.js is running on port 3000
curl http://localhost:3000/api/health

# Check firewall
sudo ufw status
```

### Webhooks Not Received

1. Verify public URL is accessible:
   ```bash
   curl https://your-ngrok-url.ngrok.io/api/health
   ```

2. Check ngrok inspection interface:
   ```
   http://localhost:4040/inspect/http
   ```

3. Verify webhook URL is updated in external service

### Rate Limiting

Free plan limits:
- 40 connections/minute
- 3 tunnels
- Random URLs (change every restart)

Upgrade to paid plan for:
- Static domains
- Higher rate limits
- Custom branding

## Best Practices

### 1. **Consistent URLs** (Development Teams)

Use paid ngrok plan for static domains:
```yaml
# ngrok.yml
tunnels:
  epa-dev:
    proto: http
    addr: 3000
    hostname: epa-dev-team.ngrok.app  # Static
```

### 2. **Environment Management**

```bash
# .env.development (for local with ngrok)
NGROK_ENABLED=true
TEAMS_WEBHOOK_URL=https://epa-dev.ngrok.app/api/webhooks/teams

# .env.production (Cloud.gov)
TEAMS_WEBHOOK_URL=https://epa-business-platform.app.cloud.gov/api/webhooks/teams
```

### 3. **Team Coordination**

Share ngrok URLs via team chat:
```bash
# Post URL to Slack/Teams when starting
echo "Ngrok URL: $(cat .ngrok-url)" | pbcopy
```

## Advanced Configuration

### Multiple Ports

```yaml
# ngrok.yml
tunnels:
  app:
    proto: http
    addr: 3000
  api:
    proto: http
    addr: 8080
  websocket:
    proto: http
    addr: 8081
```

### TCP Tunnel (Database)

```bash
# For remote database access (development only)
ngrok tcp 5432
```

### OAuth (Paid Feature)

```yaml
# ngrok.yml with OAuth
tunnels:
  secure-app:
    proto: http
    addr: 3000
    oauth:
      provider: microsoft
      allow_domains:
        - epa.gov
```

## References

- [Ngrok Documentation](https://ngrok.com/docs)
- [Ngrok API Reference](https://ngrok.com/docs/api/)
- [Teams Webhook Guide](TEAMS_BOT_SETUP.md)
- [Azure AD B2C Setup](LOGINGOV_SETUP.md)

## Support

- Ngrok Issues: support@ngrok.com
- EPA IT Support: ITSC@epa.gov
- Application Team: [Your Team Contact]
