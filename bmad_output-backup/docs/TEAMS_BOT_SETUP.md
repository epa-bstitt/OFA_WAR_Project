# Microsoft Teams Bot Setup Guide

## Overview
This guide provides step-by-step instructions for setting up the Microsoft Teams Bot integration for the EPA Business Platform. The bot allows users to submit Weekly Activity Reports (WARs) directly through Microsoft Teams.

## Prerequisites

1. **Microsoft 365 Account** with admin privileges
2. **Azure AD Application** registration access
3. **Teams Administrator** role in your Microsoft 365 tenant
4. **Bot Framework** account (dev.botframework.com)

## Step 1: Register Azure AD Application

### 1.1 Create App Registration

1. Navigate to [Azure Portal](https://portal.azure.com)
2. Go to **Azure Active Directory** > **App registrations** > **New registration**
3. Configure:
   - **Name**: `EPA Business Platform Bot`
   - **Supported account types**: Accounts in this organizational directory only
   - **Redirect URI**: Leave blank for now
4. Click **Register**

### 1.2 Configure Authentication

1. In your app registration, go to **Authentication** > **Add a platform**
2. Select **Web**
3. Add redirect URIs:
   ```
   https://your-domain.com/api/auth/callback/azure-ad
   https://your-domain.com/api/webhooks/teams
   ```
4. Enable **Access tokens** and **ID tokens**
5. Click **Configure**

### 1.3 Generate Client Secret

1. Go to **Certificates & secrets** > **New client secret**
2. Description: `Bot Framework Secret`
3. Expires: **24 months** (or as per your security policy)
4. Click **Add**
5. **Copy the secret value immediately** - it won't be shown again

### 1.4 Configure API Permissions

1. Go to **API permissions** > **Add a permission**
2. Select **Microsoft Graph** > **Delegated permissions**
3. Add these permissions:
   - `openid`
   - `profile`
   - `email`
   - `User.Read`
   - `ChannelMessage.Send`
   - `Chat.ReadWrite`
   - `TeamsActivity.Send`
4. Click **Grant admin consent** for your tenant

### 1.5 Expose an API (For Bot Framework)

1. Go to **Expose an API** > **Add a scope**
2. Application ID URI: `api://botid-<your-bot-id>`
3. Add scope:
   - Scope name: `access_as_user`
   - Who can consent: Admins and users
   - Admin consent display name: `Access EPA Business Platform Bot`
   - Admin consent description: `Allows the bot to access user information`

## Step 2: Create Bot in Bot Framework

### 2.1 Register Bot

1. Navigate to [Bot Framework Portal](https://dev.botframework.com/bots/new)
2. Sign in with your Microsoft account
3. Click **Create a bot**
4. Configure:
   - **Display name**: `EPA WAR Bot`
   - **Handle**: `epa-war-bot` (must be unique)
   - **Long description**: `Weekly Activity Report submission bot for EPA teams`
5. Click **Create**

### 2.2 Configure Bot Channels

1. In the Bot Framework portal, go to your bot
2. Click **Channels** > **Microsoft Teams**
3. Click **Save** (accept terms of service)
4. The channel will be configured automatically

### 2.3 Get Bot Credentials

1. Go to **Settings**
2. Under **Microsoft App ID**, copy the App ID
3. Click **Manage** next to **Microsoft App password**
4. This redirects to Azure AD - generate a new client secret if needed

## Step 3: Configure Environment Variables

Add these variables to your `.env.local` and Cloud.gov secrets:

```bash
# Teams Bot Configuration
TEAMS_BOT_APP_ID=your-bot-app-id
TEAMS_BOT_APP_PASSWORD=your-bot-app-secret
TEAMS_CHANNEL_ID=your-default-channel-id  # Optional

# Azure AD Configuration (from Step 1)
AZURE_AD_B2C_CLIENT_ID=your-azure-app-id
AZURE_AD_B2C_CLIENT_SECRET=your-azure-client-secret
AZURE_AD_B2C_TENANT_NAME=your-tenant-name
AZURE_AD_B2C_PRIMARY_USER_FLOW=B2C_1_signupsignin1
```

## Step 4: Set Up Teams App Manifest

### 4.1 Create App Manifest

Create `manifest.json`:

```json
{
  "$schema": "https://developer.microsoft.com/json-schemas/teams/v1.12/MicrosoftTeams.schema.json",
  "manifestVersion": "1.12",
  "version": "1.0.0",
  "id": "{{BOT_APP_ID}}",
  "packageName": "gov.epa.warbot",
  "developer": {
    "name": "EPA Business Platform",
    "websiteUrl": "https://epa.gov",
    "privacyUrl": "https://epa.gov/privacy",
    "termsOfUseUrl": "https://epa.gov/terms"
  },
  "icons": {
    "color": "color.png",
    "outline": "outline.png"
  },
  "name": {
    "short": "WAR Bot",
    "full": "EPA Weekly Activity Report Bot"
  },
  "description": {
    "short": "Submit weekly activity reports via Teams",
    "full": "The EPA Weekly Activity Report Bot allows team members to submit their weekly activity reports directly through Microsoft Teams. Reports are automatically processed and integrated with the EPA Business Platform."
  },
  "bots": [
    {
      "botId": "{{BOT_APP_ID}}",
      "scopes": ["personal", "team", "groupchat"],
      "supportsFiles": false,
      "isNotificationOnly": false,
      "supportsCalling": false,
      "supportsVideo": false
    }
  ],
  "permissions": ["identity", "messageTeamMembers"],
  "validDomains": [
    "{{DOMAIN}}",
    "token.botframework.com"
  ],
  "webApplicationInfo": {
    "id": "{{AZURE_APP_ID}}",
    "resource": "api://{{DOMAIN}}/{{AZURE_APP_ID}}"
  }
}
```

### 4.2 Create Icons

Create two PNG icons:
- `color.png` - 192x192 pixels (full color)
- `outline.png` - 32x32 pixels (transparent background, white outline)

### 4.3 Package App

```bash
# Create zip file containing manifest.json and icons
zip teams-app.zip manifest.json color.png outline.png
```

## Step 5: Install Bot in Teams

### 5.1 Upload to Teams (Developer Mode)

1. In Microsoft Teams, click **Apps** in the bottom left
2. Click **Manage your apps** > **Upload an app** > **Upload custom app**
3. Select your `teams-app.zip` file
4. Click **Add** to install for yourself

### 5.2 Install for Organization (Production)

1. Go to [Teams Admin Center](https://admin.teams.microsoft.com)
2. Navigate to **Teams apps** > **Manage apps**
3. Click **Upload** and select your `teams-app.zip`
4. Configure app policies to make it available to users

## Step 6: Configure Webhook Endpoint

### 6.1 Verify Webhook URL

Your application must expose this webhook endpoint:

```
POST /api/webhooks/teams
```

This endpoint is handled by `src/app/api/webhooks/teams/route.ts`

### 6.2 Register Webhook in Bot Framework

1. Go to [Bot Framework Portal](https://dev.botframework.com)
2. Select your bot
3. Click **Settings**
4. Under **Messaging endpoint**, enter:
   ```
   https://your-domain.com/api/webhooks/teams
   ```
5. Click **Save**

## Step 7: Test Bot Integration

### 7.1 Direct Message Test

1. In Teams, find your bot under **Apps**
2. Click on the bot and select **Chat**
3. Send message: `help`
4. Bot should respond with available commands

### 7.2 Channel Test

1. Create a test team/channel
2. Add the bot to the channel
3. @mention the bot: `@WAR Bot help`
4. Verify bot responds in channel

### 7.3 Submit Test Report

1. Send: `submit war`
2. Follow the prompts to submit a test WAR
3. Verify the report appears in the EPA Business Platform

## Bot Commands

The bot supports these commands:

| Command | Description | Example |
|---------|-------------|---------|
| `help` | Show available commands | `help` |
| `submit war` | Start WAR submission | `submit war` |
| `my submissions` | List recent submissions | `my submissions` |
| `status` | Check submission status | `status` |
| `reminder on` | Enable weekly reminders | `reminder on` |
| `reminder off` | Disable weekly reminders | `reminder off` |

## Troubleshooting

### Bot Not Responding

1. Check application logs:
   ```bash
   cf logs epa-business-platform --recent
   ```

2. Verify webhook endpoint is accessible:
   ```bash
   curl -X POST https://your-domain.com/api/webhooks/teams \
     -H "Content-Type: application/json" \
     -d '{"test": "message"}'
   ```

3. Check Bot Framework channel health:
   - Go to [Bot Framework Portal](https://dev.botframework.com)
   - Select your bot > **Channels**
   - Look for any errors

### Authentication Issues

1. Verify Azure AD app has correct permissions
2. Check that admin consent is granted
3. Confirm client secret hasn't expired
4. Verify environment variables are set correctly

### Message Delivery Failures

1. Check Teams channel permissions
2. Verify bot is added to the channel
3. Review conversation state in database
4. Check for rate limiting (429 errors)

## Security Considerations

### Bot Security

1. **Validate JWT Tokens**: All requests include validation tokens
2. **HTTPS Only**: Ensure all endpoints use HTTPS
3. **Secret Rotation**: Rotate client secrets every 90 days
4. **Scope Limitations**: Only request necessary permissions

### Data Handling

1. **PII Protection**: Don't log or store user messages containing PII
2. **Conversation History**: Store minimal conversation context
3. **Encryption**: All data encrypted in transit and at rest
4. **Access Controls**: Restrict bot to authorized users only

## Maintenance

### Regular Tasks

- **Monitor**: Review bot logs weekly
- **Update**: Keep Bot Framework SDK updated
- **Rotate Secrets**: Every 90 days
- **Test**: Verify bot functionality monthly

### Updating the Bot

1. Update manifest version when adding features
2. Re-upload to Teams Admin Center
3. Notify users of new capabilities

## Support

For issues:
1. Check application logs
2. Review Bot Framework health status
3. Contact EPA IT Support
4. Reference this guide for configuration details

## References

- [Microsoft Teams Bot Documentation](https://docs.microsoft.com/en-us/microsoftteams/platform/bots/what-are-bots)
- [Bot Framework SDK](https://docs.microsoft.com/en-us/azure/bot-service/index-bf-sdk)
- [Teams App Manifest Schema](https://docs.microsoft.com/en-us/microsoftteams/platform/resources/schema/manifest-schema)
- [Azure AD Bot Registration](https://docs.microsoft.com/en-us/azure/bot-service/bot-service-resources-bot-framework-faq)
