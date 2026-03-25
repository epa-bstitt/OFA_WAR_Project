"use client";

import { useState } from "react";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { 
  CheckCircle, 
  Circle, 
  ChevronRight, 
  ChevronLeft, 
  Bot, 
  Cloud,
  FileJson,
  Shield,
  AlertTriangle,
  ExternalLink,
  Copy,
  Check
} from "lucide-react";
import Link from "next/link";
import { toast } from "sonner";

interface WizardStep {
  id: string;
  title: string;
  description: string;
  completed: boolean;
}

interface WizardConfig {
  appName: string;
  botId: string;
  botPassword: string;
  tenantId: string;
  messagingEndpoint: string;
  ngrokUrl: string;
  azurePortalUrl: string;
  botFrameworkUrl: string;
}

const initialSteps: WizardStep[] = [
  { id: "prerequisites", title: "Prerequisites", description: "Install required tools", completed: false },
  { id: "azure-app", title: "Azure App Registration", description: "Register in Azure AD", completed: false },
  { id: "bot-registration", title: "Bot Registration", description: "Create bot in Bot Framework", completed: false },
  { id: "teams-channel", title: "Teams Channel", description: "Enable Teams channel", completed: false },
  { id: "manifest", title: "App Manifest", description: "Create Teams app package", completed: false },
  { id: "environment", title: "Environment", description: "Configure environment variables", completed: false },
  { id: "deployment", title: "Deployment", description: "Deploy and test bot", completed: false },
];

const defaultConfig: WizardConfig = {
  appName: "EPA WAR Bot",
  botId: "",
  botPassword: "",
  tenantId: "",
  messagingEndpoint: "https://your-domain.com/api/webhooks/teams",
  ngrokUrl: "https://your-ngrok-url.ngrok.io",
  azurePortalUrl: "https://portal.azure.com",
  botFrameworkUrl: "https://dev.botframework.com",
};

export function TeamsBotWizard() {
  const [currentStep, setCurrentStep] = useState(0);
  const [steps, setSteps] = useState(initialSteps);
  const [config, setConfig] = useState(defaultConfig);
  const [showPreview, setShowPreview] = useState(false);
  const [copiedField, setCopiedField] = useState<string | null>(null);

  const updateStep = (index: number, completed: boolean) => {
    const newSteps = [...steps];
    newSteps[index].completed = completed;
    setSteps(newSteps);
  };

  const copyToClipboard = (text: string, field: string) => {
    navigator.clipboard.writeText(text);
    setCopiedField(field);
    toast.success(`Copied ${field} to clipboard`);
    setTimeout(() => setCopiedField(null), 2000);
  };

  const nextStep = () => {
    if (currentStep < steps.length - 1) {
      updateStep(currentStep, true);
      setCurrentStep(currentStep + 1);
    }
  };

  const prevStep = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
    }
  };

  const StepIndicator = () => (
    <div className="flex items-center justify-center gap-2 mb-6">
      {steps.map((step, index) => (
        <div key={step.id} className="flex items-center">
          <div
            className={`flex items-center justify-center w-8 h-8 rounded-full text-sm font-medium ${
              index === currentStep
                ? "bg-blue-600 text-white"
                : step.completed
                ? "bg-green-600 text-white"
                : "bg-gray-200 text-gray-600"
            }`}
          >
            {step.completed ? <CheckCircle className="w-4 h-4" /> : index + 1}
          </div>
          {index < steps.length - 1 && (
            <div
              className={`w-8 h-0.5 ${
                step.completed ? "bg-green-600" : "bg-gray-200"
              }`}
            />
          )}
        </div>
      ))}
    </div>
  );

  const renderPrerequisites = () => (
    <div className="space-y-4">
      <Alert>
        <AlertTriangle className="h-4 w-4" />
        <AlertTitle>Required Tools</AlertTitle>
        <AlertDescription>
          Before starting, ensure you have these tools installed:
        </AlertDescription>
      </Alert>

      <div className="space-y-3">
        {[
          { name: "Node.js 18+", url: "https://nodejs.org", desc: "JavaScript runtime" },
          { name: "Ngrok", url: "https://ngrok.com", desc: "Secure tunnel for local development" },
          { name: "Visual Studio Code", url: "https://code.visualstudio.com", desc: "Recommended IDE" },
          { name: "Microsoft 365 Account", url: "", desc: "With admin permissions" },
        ].map((tool) => (
          <div key={tool.name} className="flex items-center justify-between p-3 border rounded-lg">
            <div>
              <p className="font-medium">{tool.name}</p>
              <p className="text-sm text-muted-foreground">{tool.desc}</p>
            </div>
            {tool.url && (
              <Link href={tool.url} target="_blank" rel="noopener noreferrer">
                <Button variant="outline" size="sm">
                  <ExternalLink className="w-4 h-4 mr-2" />
                  Download
                </Button>
              </Link>
            )}
          </div>
        ))}
      </div>

      <div className="bg-blue-50 p-4 rounded-lg">
        <h4 className="font-medium text-blue-900 mb-2">Quick Install Commands</h4>
        <pre className="text-sm bg-white p-2 rounded border">
{`# Install Node.js (Windows via chocolatey)
choco install nodejs

# Install Ngrok
choco install ngrok

# Or download manually from the links above`}
        </pre>
      </div>
    </div>
  );

  const renderAzureApp = () => (
    <div className="space-y-4">
      <Alert>
        <Shield className="h-4 w-4" />
        <AlertTitle>Azure App Registration</AlertTitle>
        <AlertDescription>
          Register your bot as an Azure AD application for authentication.
        </AlertDescription>
      </Alert>

      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h4 className="font-medium">Step 1: Create App Registration</h4>
          <Link href="https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade" target="_blank">
            <Button variant="outline" size="sm">
              <ExternalLink className="w-4 h-4 mr-2" />
              Open Azure Portal
            </Button>
          </Link>
        </div>

        <ol className="list-decimal list-inside space-y-2 text-sm">
          <li>Navigate to <strong>Azure Active Directory</strong> &gt; <strong>App registrations</strong></li>
          <li>Click <strong>New registration</strong></li>
          <li>
            Set the following values:
            <ul className="list-disc list-inside ml-6 mt-1 space-y-1">
              <li><strong>Name:</strong> 
                <Input 
                  value={config.appName} 
                  onChange={(e) => setConfig({...config, appName: e.target.value})}
                  className="w-48 inline-block ml-2"
                />
              </li>
              <li><strong>Supported account types:</strong> Accounts in this organizational directory only</li>
              <li><strong>Redirect URI:</strong> Leave blank for now</li>
            </ul>
          </li>
          <li>Click <strong>Register</strong></li>
        </ol>

        <Separator />

        <h4 className="font-medium">Step 2: Collect Application Details</h4>
        <div className="space-y-3">
          <div>
            <Label>Application (client) ID</Label>
            <div className="flex gap-2">
              <Input 
                value={config.botId}
                onChange={(e) => setConfig({...config, botId: e.target.value})}
                placeholder="Paste from Azure Portal Overview page"
              />
              {config.botId && (
                <Button 
                  variant="outline" 
                  size="icon"
                  onClick={() => copyToClipboard(config.botId, "Client ID")}
                >
                  {copiedField === "Client ID" ? <Check className="w-4 h-4" /> : <Copy className="w-4 h-4" />}
                </Button>
              )}
            </div>
          </div>

          <div>
            <Label>Directory (tenant) ID</Label>
            <div className="flex gap-2">
              <Input 
                value={config.tenantId}
                onChange={(e) => setConfig({...config, tenantId: e.target.value})}
                placeholder="Paste from Azure Portal Overview page"
              />
            </div>
          </div>
        </div>

        <Separator />

        <h4 className="font-medium">Step 3: Add API Permissions</h4>
        <ol className="list-decimal list-inside space-y-1 text-sm">
          <li>Go to <strong>API permissions</strong> in your app registration</li>
          <li>Click <strong>Add a permission</strong></li>
          <li>Select <strong>Microsoft Graph</strong> &gt; <strong>Delegated permissions</strong></li>
          <li>Add: <code>User.Read</code> (should be enabled by default)</li>
          <li>Click <strong>Grant admin consent</strong> for your organization</li>
        </ol>
      </div>
    </div>
  );

  const renderBotRegistration = () => (
    <div className="space-y-4">
      <Alert>
        <Bot className="h-4 w-4" />
        <AlertTitle>Bot Framework Registration</AlertTitle>
        <AlertDescription>
          Register your bot with the Microsoft Bot Framework.
        </AlertDescription>
      </Alert>

      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h4 className="font-medium">Create Bot in Bot Framework</h4>
          <Link href="https://dev.botframework.com/bots/new" target="_blank">
            <Button variant="outline" size="sm">
              <ExternalLink className="w-4 h-4 mr-2" />
              Open Bot Framework
            </Button>
          </Link>
        </div>

        <ol className="list-decimal list-inside space-y-2 text-sm">
          <li>Sign in with your Microsoft account</li>
          <li>Click <strong>Create a bot</strong></li>
          <li>Fill in the registration form:
            <ul className="list-disc list-inside ml-6 mt-1 space-y-1">
              <li><strong>Display name:</strong> EPA WAR Bot</li>
              <li><strong>Handle:</strong> epa-war-bot (must be unique)</li>
              <li><strong>Long description:</strong> Weekly Activity Report submission bot</li>
            </ul>
          </li>
          <li>Use your Azure AD App ID from previous step</li>
        </ol>

        <Separator />

        <h4 className="font-medium">Configure Messaging Endpoint</h4>
        <div className="space-y-3">
          <div>
            <Label>Messaging Endpoint URL</Label>
            <div className="flex gap-2">
              <Input 
                value={config.messagingEndpoint}
                onChange={(e) => setConfig({...config, messagingEndpoint: e.target.value})}
                placeholder="https://your-domain.com/api/webhooks/teams"
              />
              <Button 
                variant="outline" 
                size="icon"
                onClick={() => copyToClipboard(config.messagingEndpoint, "Messaging Endpoint")}
              >
                {copiedField === "Messaging Endpoint" ? <Check className="w-4 h-4" /> : <Copy className="w-4 h-4" />}
              </Button>
            </div>
            <p className="text-sm text-muted-foreground mt-1">
              For local development: <code>{config.ngrokUrl}/api/webhooks/teams</code>
            </p>
          </div>

          <div className="bg-yellow-50 p-3 rounded-lg border border-yellow-200">
            <h5 className="font-medium text-yellow-800">For Local Development</h5>
            <p className="text-sm text-yellow-700">
              Start ngrok first to get your tunnel URL, then update this endpoint.
            </p>
            <pre className="text-xs bg-white p-2 rounded mt-2">
              ngrok http 3000
            </pre>
          </div>
        </div>
      </div>
    </div>
  );

  const renderTeamsChannel = () => (
    <div className="space-y-4">
      <Alert>
        <Cloud className="h-4 w-4" />
        <AlertTitle>Enable Teams Channel</AlertTitle>
        <AlertDescription>
          Connect your bot to Microsoft Teams.
        </AlertDescription>
      </Alert>

      <div className="space-y-4">
        <h4 className="font-medium">Configure Teams Channel</h4>
        <ol className="list-decimal list-inside space-y-2 text-sm">
          <li>In Bot Framework Portal, go to your bot</li>
          <li>Click <strong>Channels</strong> &gt; <strong>Microsoft Teams</strong></li>
          <li>Accept the Terms of Service</li>
          <li>The channel will be configured automatically</li>
          <li>Click <strong>Done</strong></li>
        </ol>

        <Separator />

        <h4 className="font-medium">Get Bot Credentials</h4>
        <div className="space-y-3">
          <div>
            <Label>Microsoft App ID</Label>
            <Input value={config.botId || "(from Azure Portal)"} readOnly />
          </div>

          <div>
            <Label>Client Secret (App Password)</Label>
            <div className="flex gap-2">
              <Input 
                type="password"
                value={config.botPassword}
                onChange={(e) => setConfig({...config, botPassword: e.target.value})}
                placeholder="Generated in Azure AD Certificates & secrets"
              />
            </div>
            <p className="text-sm text-muted-foreground mt-1">
              Go to Azure Portal &gt; Your App &gt; Certificates & secrets &gt; New client secret
            </p>
          </div>
        </div>

        <div className="bg-green-50 p-3 rounded-lg border border-green-200">
          <h5 className="font-medium text-green-800">Channel Status</h5>
          <p className="text-sm text-green-700">
            Once enabled, your bot can receive messages from Teams. The connection status
            will show in the Bot Framework portal.
          </p>
        </div>
      </div>
    </div>
  );

  const renderManifest = () => (
    <div className="space-y-4">
      <Alert>
        <FileJson className="h-4 w-4" />
        <AlertTitle>Teams App Manifest</AlertTitle>
        <AlertDescription>
          Create the app package for Microsoft Teams.
        </AlertDescription>
      </Alert>

      <div className="space-y-4">
        <h4 className="font-medium">Generate App Manifest</h4>
        
        <div className="bg-slate-100 p-4 rounded-lg">
          <div className="flex justify-between items-center mb-2">
            <span className="text-sm font-medium">manifest.json</span>
            <Button 
              variant="outline" 
              size="sm"
              onClick={() => copyToClipboard(JSON.stringify({
                "$schema": "https://developer.microsoft.com/json-schemas/teams/v1.12/MicrosoftTeams.schema.json",
                "manifestVersion": "1.12",
                "version": "1.0.0",
                "id": config.botId,
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
                  "full": "The EPA Weekly Activity Report Bot allows team members to submit their weekly activity reports directly through Microsoft Teams."
                },
                "bots": [{
                  "botId": config.botId,
                  "scopes": ["personal", "team", "groupchat"],
                  "supportsFiles": false,
                  "isNotificationOnly": false
                }],
                "permissions": ["identity", "messageTeamMembers"],
                "validDomains": ["token.botframework.com"]
              }, null, 2), "Manifest JSON")}
            >
              {copiedField === "Manifest JSON" ? <Check className="w-4 h-4 mr-2" /> : <Copy className="w-4 h-4 mr-2" />}
              Copy JSON
            </Button>
          </div>
          <pre className="text-xs overflow-auto max-h-48 bg-white p-2 rounded">
{JSON.stringify({
  "$schema": "https://developer.microsoft.com/json-schemas/teams/v1.12/MicrosoftTeams.schema.json",
  "manifestVersion": "1.12",
  "version": "1.0.0",
  "id": config.botId || "{{BOT_ID}}",
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
    "full": "The EPA Weekly Activity Report Bot allows team members to submit their weekly activity reports directly through Microsoft Teams."
  },
  "bots": [{
    "botId": config.botId || "{{BOT_ID}}",
    "scopes": ["personal", "team", "groupchat"],
    "supportsFiles": false,
    "isNotificationOnly": false
  }],
  "permissions": ["identity", "messageTeamMembers"],
  "validDomains": ["token.botframework.com"]
}, null, 2)}
          </pre>
        </div>

        <h4 className="font-medium">Create App Package</h4>
        <ol className="list-decimal list-inside space-y-2 text-sm">
          <li>Create a folder for your app files</li>
          <li>Save the manifest.json above to that folder</li>
          <li>Create two icon files:
            <ul className="list-disc list-inside ml-6 mt-1">
              <li><strong>color.png</strong> - 192x192 pixels (full color)</li>
              <li><strong>outline.png</strong> - 32x32 pixels (white outline, transparent background)</li>
            </ul>
          </li>
          <li>Select all files and compress into a ZIP file named <code>teams-app.zip</code></li>
        </ol>
      </div>
    </div>
  );

  const renderEnvironment = () => (
    <div className="space-y-4">
      <Alert>
        <FileJson className="h-4 w-4" />
        <AlertTitle>Environment Configuration</AlertTitle>
        <AlertDescription>
          Add these environment variables to your application.
        </AlertDescription>
      </Alert>

      <div className="bg-slate-100 p-4 rounded-lg">
        <div className="flex justify-between items-center mb-2">
          <span className="text-sm font-medium">.env.local</span>
          <Button 
            variant="outline" 
            size="sm"
            onClick={() => copyToClipboard(
              `# Teams Bot Configuration
TEAMS_BOT_APP_ID=${config.botId}
TEAMS_BOT_APP_PASSWORD=${config.botPassword}
TEAMS_CHANNEL_ID=your-channel-id

# Azure AD Configuration
AZURE_AD_B2C_CLIENT_ID=${config.botId}
AZURE_AD_B2C_CLIENT_SECRET=${config.botPassword}
AZURE_AD_B2C_TENANT_NAME=your-tenant
AZURE_AD_B2C_PRIMARY_USER_FLOW=B2C_1_signupsignin1`, 
              "Environment Variables"
            )}
          >
            {copiedField === "Environment Variables" ? <Check className="w-4 h-4 mr-2" /> : <Copy className="w-4 h-4 mr-2" />}
            Copy All
          </Button>
        </div>
        <pre className="text-sm bg-white p-3 rounded overflow-auto">
{`# Teams Bot Configuration
TEAMS_BOT_APP_ID=${config.botId || "your-bot-app-id"}
TEAMS_BOT_APP_PASSWORD=${config.botPassword || "your-bot-app-secret"}
TEAMS_CHANNEL_ID=your-channel-id

# Azure AD Configuration
AZURE_AD_B2C_CLIENT_ID=${config.botId || "your-azure-app-id"}
AZURE_AD_B2C_CLIENT_SECRET=${config.botPassword || "your-azure-client-secret"}
AZURE_AD_B2C_TENANT_NAME=your-tenant
AZURE_AD_B2C_PRIMARY_USER_FLOW=B2C_1_signupsignin1`}
        </pre>
      </div>

      <div className="space-y-3">
        <h4 className="font-medium">Configuration Steps</h4>
        <ol className="list-decimal list-inside space-y-2 text-sm">
          <li>Create or edit <code>.env.local</code> in your project root</li>
          <li>Paste the environment variables above</li>
          <li>Replace placeholder values with actual values</li>
          <li>Restart your development server</li>
        </ol>
      </div>

      <div className="bg-yellow-50 p-3 rounded-lg border border-yellow-200">
        <h5 className="font-medium text-yellow-800">Security Note</h5>
        <p className="text-sm text-yellow-700">
          Never commit <code>.env.local</code> to version control. It should be listed in <code>.gitignore</code>.
        </p>
      </div>
    </div>
  );

  const renderDeployment = () => (
    <div className="space-y-4">
      <Alert>
        <Cloud className="h-4 w-4" />
        <AlertTitle>Deploy and Test</AlertTitle>
        <AlertDescription>
          Install your bot in Teams and verify it works.
        </AlertDescription>
      </Alert>

      <div className="space-y-4">
        <h4 className="font-medium">Install in Teams (Developer Mode)</h4>
        <ol className="list-decimal list-inside space-y-2 text-sm">
          <li>Open Microsoft Teams</li>
          <li>Click <strong>Apps</strong> in the bottom left</li>
          <li>Click <strong>Manage your apps</strong> &gt; <strong>Upload an app</strong></li>
          <li>Select your <code>teams-app.zip</code> file</li>
          <li>Click <strong>Add</strong> to install the bot</li>
        </ol>

        <Separator />

        <h4 className="font-medium">Test the Bot</h4>
        <div className="space-y-2">
          <p className="text-sm">Send these test messages:</p>
          <div className="grid grid-cols-2 gap-2">
            {["help", "submit war", "my submissions", "status"].map((cmd) => (
              <Button 
                key={cmd} 
                variant="outline" 
                size="sm"
                onClick={() => copyToClipboard(cmd, `command-${cmd}`)}
              >
                {copiedField === `command-${cmd}` ? <Check className="w-4 h-4 mr-2" /> : <Copy className="w-4 h-4 mr-2" />}
                {cmd}
              </Button>
            ))}
          </div>
        </div>

        <Separator />

        <h4 className="font-medium">Production Deployment</h4>
        <ol className="list-decimal list-inside space-y-2 text-sm">
          <li>Upload to <strong>Teams Admin Center</strong> (teams.microsoft.com)</li>
          <li>Navigate to <strong>Teams apps</strong> &gt; <strong>Manage apps</strong></li>
          <li>Click <strong>Upload</strong> and select your app package</li>
          <li>Configure app policies for your organization</li>
        </ol>

        <div className="bg-green-50 p-3 rounded-lg border border-green-200">
          <h5 className="font-medium text-green-800">You're All Set!</h5>
          <p className="text-sm text-green-700">
            Your Teams bot should now be fully configured and ready to accept WAR submissions.
          </p>
        </div>
      </div>
    </div>
  );

  const stepContent = [
    renderPrerequisites,
    renderAzureApp,
    renderBotRegistration,
    renderTeamsChannel,
    renderManifest,
    renderEnvironment,
    renderDeployment,
  ];

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <div className="flex items-center gap-3">
            <Bot className="h-8 w-8 text-blue-600" />
            <div>
              <CardTitle>Teams Bot Deployment Wizard</CardTitle>
              <CardDescription>
                Step-by-step guide to deploy your EPA WAR Bot to Microsoft Teams
              </CardDescription>
            </div>
          </div>
        </CardHeader>

        <CardContent>
          <StepIndicator />

          <div className="mt-6">
            <h3 className="text-lg font-semibold mb-4">
              Step {currentStep + 1}: {steps[currentStep].title}
            </h3>
            <p className="text-sm text-muted-foreground mb-6">
              {steps[currentStep].description}
            </p>

            {stepContent[currentStep]()}
          </div>
        </CardContent>

        <CardFooter className="flex justify-between">
          <Button
            variant="outline"
            onClick={prevStep}
            disabled={currentStep === 0}
          >
            <ChevronLeft className="w-4 h-4 mr-2" />
            Previous
          </Button>

          <div className="flex gap-2">
            {currentStep === steps.length - 1 ? (
              <Button onClick={() => window.location.reload()}>
                <CheckCircle className="w-4 h-4 mr-2" />
                Start Over
              </Button>
            ) : (
              <Button onClick={nextStep}>
                Next
                <ChevronRight className="w-4 h-4 ml-2" />
              </Button>
            )}
          </div>
        </CardFooter>
      </Card>

      {/* Progress Summary */}
      <Card>
        <CardHeader>
          <CardTitle className="text-sm">Setup Progress</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            {steps.map((step, index) => (
              <div 
                key={step.id} 
                className={`flex items-center justify-between p-2 rounded ${
                  index === currentStep ? 'bg-blue-50 border border-blue-200' : ''
                }`}
              >
                <div className="flex items-center gap-2">
                  {step.completed ? (
                    <CheckCircle className="w-4 h-4 text-green-600" />
                  ) : index === currentStep ? (
                    <Circle className="w-4 h-4 text-blue-600" />
                  ) : (
                    <Circle className="w-4 h-4 text-gray-300" />
                  )}
                  <span className={step.completed ? 'text-green-700' : index === currentStep ? 'text-blue-700 font-medium' : 'text-gray-500'}>
                    {step.title}
                  </span>
                </div>
                {step.completed && (
                  <Badge variant="secondary" className="text-xs">Completed</Badge>
                )}
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Quick Reference */}
      <Card>
        <CardHeader>
          <CardTitle className="text-sm">Quick Reference</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 gap-4 text-sm">
            <div>
              <p className="font-medium text-muted-foreground">Azure Portal</p>
              <Link href="https://portal.azure.com" target="_blank" className="text-blue-600 hover:underline">
                portal.azure.com
              </Link>
            </div>
            <div>
              <p className="font-medium text-muted-foreground">Bot Framework</p>
              <Link href="https://dev.botframework.com" target="_blank" className="text-blue-600 hover:underline">
                dev.botframework.com
              </Link>
            </div>
            <div>
              <p className="font-medium text-muted-foreground">Teams Admin</p>
              <Link href="https://admin.teams.microsoft.com" target="_blank" className="text-blue-600 hover:underline">
                admin.teams.microsoft.com
              </Link>
            </div>
            <div>
              <p className="font-medium text-muted-foreground">Ngrok Dashboard</p>
              <Link href="https://dashboard.ngrok.com" target="_blank" className="text-blue-600 hover:underline">
                dashboard.ngrok.com
              </Link>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
