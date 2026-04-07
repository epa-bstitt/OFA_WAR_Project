"use client";

import { useState, useEffect } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import { 
  Brain, 
  Database, 
  Cloud, 
  Bot, 
  Shield, 
  Save, 
  RefreshCw,
  Check,
  X,
  AlertTriangle,
  Server,
  Cpu
} from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { SystemSettings, defaultSystemSettings } from "@/lib/admin/mock-data";
import { testDatabaseConnection, type DatabaseConnectionResult } from "@/app/actions/admin/database";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

interface ConnectionStatus {
  ai: boolean;
  database: boolean;
  microsoft: boolean;
  teams: boolean;
}

export function SettingsManager() {
  const [settings, setSettings] = useState<SystemSettings>(defaultSystemSettings);
  const [isLoading, setIsLoading] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  const [connectionStatus, setConnectionStatus] = useState<ConnectionStatus>({
    ai: false,
    database: false,
    microsoft: false,
    teams: false,
  });
  const [lastSaved, setLastSaved] = useState<Date | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [dbTestResult, setDbTestResult] = useState<DatabaseConnectionResult | null>(null);
  const [isDbTesting, setIsDbTesting] = useState(false);

  useEffect(() => {
    loadSettings();
    checkConnections();
  }, []);

  const loadSettings = async () => {
    try {
      const response = await fetch("/api/admin/settings");
      if (response.ok) {
        const data = await response.json();
        setSettings(data.settings);
      }
    } catch (err) {
      console.error("Failed to load settings:", err);
    }
  };

  const checkConnections = async () => {
    setIsLoading(true);
    try {
      // Send current settings in request body so backend can test with them
      const response = await fetch("/api/admin/settings/test-connections", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(settings),
      });
      if (response.ok) {
        const data = await response.json();
        setConnectionStatus(data.status);
      }
    } catch (err) {
      console.error("Failed to check connections:", err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleTestDatabase = async () => {
    setIsDbTesting(true);
    setDbTestResult(null);
    try {
      const result = await testDatabaseConnection();
      setDbTestResult(result);
    } catch (err) {
      console.error("Database test failed:", err);
      setDbTestResult({
        success: false,
        message: "Failed to test database connection",
        error: "Unknown error occurred",
      });
    } finally {
      setIsDbTesting(false);
    }
  };

  const handleSave = async () => {
    setIsSaving(true);
    setError(null);
    setSuccess(null);

    try {
      const response = await fetch("/api/admin/settings", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(settings),
      });

      if (response.ok) {
        setLastSaved(new Date());
        setSuccess("Settings saved successfully");
      } else {
        const error = await response.text();
        setError(error || "Failed to save settings");
      }
    } catch (err) {
      setError("Network error while saving settings");
    } finally {
      setIsSaving(false);
    }
  };

  const updateSetting = (section: keyof SystemSettings, field: string, value: string | number | boolean) => {
    setSettings(prev => ({
      ...prev,
      [section]: {
        ...prev[section],
        [field]: value,
      },
    }));
  };

  const ConnectionBadge = ({ connected }: { connected: boolean }) => (
    <Badge variant={connected ? "default" : "destructive"} className="ml-2">
      {connected ? (
        <><Check className="h-3 w-3 mr-1" /> Connected</>
      ) : (
        <><X className="h-3 w-3 mr-1" /> Disconnected</>
      )}
    </Badge>
  );

  return (
    <div className="space-y-6">
      {/* Status Alert */}
      {error && (
        <Alert variant="destructive">
          <AlertTriangle className="h-4 w-4" />
          <AlertTitle>Error</AlertTitle>
          <AlertDescription>{error}</AlertDescription>
        </Alert>
      )}

      {success && (
        <Alert className="bg-green-50 border-green-200">
          <Check className="h-4 w-4 text-green-600" />
          <AlertTitle className="text-green-800">Success</AlertTitle>
          <AlertDescription className="text-green-700">{success}</AlertDescription>
        </Alert>
      )}

      {/* Save Bar */}
      <div className="flex items-center justify-between bg-muted p-4 rounded-lg">
        <div>
          <h3 className="font-medium">System Configuration</h3>
          {lastSaved && (
            <p className="text-sm text-muted-foreground">
              Last saved: {lastSaved.toLocaleString()}
            </p>
          )}
        </div>
        <div className="flex gap-2">
          <Button 
            variant="outline" 
            onClick={checkConnections}
            disabled={isLoading}
          >
            <RefreshCw className={`h-4 w-4 mr-2 ${isLoading ? 'animate-spin' : ''}`} />
            Test Connections
          </Button>
          <Button 
            onClick={handleSave}
            disabled={isSaving}
          >
            <Save className="h-4 w-4 mr-2" />
            {isSaving ? "Saving..." : "Save Changes"}
          </Button>
        </div>
      </div>

      <Tabs defaultValue="ai" className="space-y-4">
        <TabsList className="grid w-full grid-cols-6">
          <TabsTrigger value="ai">
            <Brain className="h-4 w-4 mr-2" />
            AI Service
          </TabsTrigger>
          <TabsTrigger value="database">
            <Database className="h-4 w-4 mr-2" />
            Database
          </TabsTrigger>
          <TabsTrigger value="microsoft">
            <Cloud className="h-4 w-4 mr-2" />
            Microsoft
          </TabsTrigger>
          <TabsTrigger value="teams">
            <Bot className="h-4 w-4 mr-2" />
            Teams Bot
          </TabsTrigger>
          <TabsTrigger value="ngrok">
            <Cloud className="h-4 w-4 mr-2" />
            Ngrok
          </TabsTrigger>
          <TabsTrigger value="security">
            <Shield className="h-4 w-4 mr-2" />
            Security
          </TabsTrigger>
        </TabsList>

        {/* AI Settings */}
        <TabsContent value="ai">
          <Card>
            <CardHeader>
              <div className="flex items-center justify-between">
                <div>
                  <CardTitle>AI Service Configuration</CardTitle>
                  <CardDescription>
                    Configure the internal EPA AI service for text conversion
                  </CardDescription>
                </div>
                <ConnectionBadge connected={connectionStatus.ai} />
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between">
                <Label htmlFor="ai-enabled">Enable AI Conversion</Label>
                <Switch
                  id="ai-enabled"
                  checked={settings.ai.enabled}
                  onCheckedChange={(checked) => updateSetting("ai", "enabled", checked)}
                />
              </div>

              <Separator />

              <div className="grid gap-2">
                <Label htmlFor="ai-model" className="flex items-center gap-2">
                  <Cpu className="h-4 w-4" />
                  LLM Model
                </Label>
                <Select
                  value={settings.ai.model}
                  onValueChange={(value) => updateSetting("ai", "model", value)}
                >
                  <SelectTrigger id="ai-model">
                    <SelectValue placeholder="Select a model" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="gpt-4o">GPT-4o (Best quality)</SelectItem>
                    <SelectItem value="gpt-4o-mini">GPT-4o Mini (Balanced)</SelectItem>
                    <SelectItem value="gpt-4">GPT-4 (Legacy)</SelectItem>
                    <SelectItem value="gpt-3.5-turbo">GPT-3.5 Turbo (Fastest)</SelectItem>
                    <SelectItem value="claude-3-sonnet">Claude 3 Sonnet</SelectItem>
                    <SelectItem value="claude-3-haiku">Claude 3 Haiku</SelectItem>
                    <SelectItem value="llama-3.1-70b">Llama 3.1 70B</SelectItem>
                    <SelectItem value="llama-3.1-8b">Llama 3.1 8B</SelectItem>
                  </SelectContent>
                </Select>
                <p className="text-sm text-muted-foreground">
                  Select the AI model to use for text conversion. GPT-4o Mini is recommended for most use cases.
                </p>
              </div>

              <Separator />

              <div className="grid gap-2">
                <Label htmlFor="ai-url">Service URL</Label>
                <Input
                  id="ai-url"
                  value={settings.ai.serviceUrl}
                  onChange={(e) => updateSetting("ai", "serviceUrl", e.target.value)}
                  placeholder="https://ai-service.epa.gov/api"
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="ai-key">API Key</Label>
                <Input
                  id="ai-key"
                  type="password"
                  value={settings.ai.apiKey}
                  onChange={(e) => updateSetting("ai", "apiKey", e.target.value)}
                  placeholder="Enter API key"
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="ai-timeout">Timeout (ms)</Label>
                <Input
                  id="ai-timeout"
                  type="number"
                  value={settings.ai.timeout}
                  onChange={(e) => updateSetting("ai", "timeout", parseInt(e.target.value))}
                  placeholder="5000"
                />
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Database Settings */}
        <TabsContent value="database">
          <Card>
            <CardHeader>
              <div className="flex items-center justify-between">
                <div>
                  <CardTitle>Database Configuration</CardTitle>
                  <CardDescription>
                    PostgreSQL database connection settings
                  </CardDescription>
                </div>
                <ConnectionBadge connected={connectionStatus.database} />
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <Alert variant="destructive">
                <AlertTriangle className="h-4 w-4" />
                <AlertTitle>Security Warning</AlertTitle>
                <AlertDescription>
                  Database credentials are sensitive. Changes require application restart.
                </AlertDescription>
              </Alert>

              {/* Database Connection Test */}
              <div className="border rounded-lg p-4 space-y-4">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <Server className="h-5 w-5" />
                    <h4 className="font-medium">Connection Test</h4>
                  </div>
                  <Button
                    variant="outline"
                    onClick={handleTestDatabase}
                    disabled={isDbTesting}
                  >
                    <RefreshCw className={`h-4 w-4 mr-2 ${isDbTesting ? 'animate-spin' : ''}`} />
                    {isDbTesting ? "Testing..." : "Test Connection"}
                  </Button>
                </div>

                {dbTestResult && (
                  <div className={`p-4 rounded-lg ${dbTestResult.success ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'}`}>
                    <div className="flex items-start gap-2">
                      {dbTestResult.success ? (
                        <Check className="h-5 w-5 text-green-600 mt-0.5" />
                      ) : (
                        <X className="h-5 w-5 text-red-600 mt-0.5" />
                      )}
                      <div>
                        <p className={`font-medium ${dbTestResult.success ? 'text-green-800' : 'text-red-800'}`}>
                          {dbTestResult.message}
                        </p>
                        {dbTestResult.details && (
                          <div className="mt-2 text-sm text-slate-600 space-y-1">
                            <p><strong>Database:</strong> {dbTestResult.details.database}</p>
                            <p><strong>Version:</strong> {dbTestResult.details.version}</p>
                            <p><strong>Tables:</strong> {dbTestResult.details.tableCount}</p>
                            <p><strong>pgvector Extension:</strong> {dbTestResult.details.vectorExtension ? '✓ Installed' : '✗ Not installed'}</p>
                          </div>
                        )}
                        {dbTestResult.error && (
                          <p className="mt-2 text-sm text-red-600">
                            Error: {dbTestResult.error}
                          </p>
                        )}
                      </div>
                    </div>
                  </div>
                )}
              </div>

              <Separator />

              <div className="grid gap-2">
                <Label htmlFor="db-connection">Connection String</Label>
                <Input
                  id="db-connection"
                  type="password"
                  value={settings.database.connectionString}
                  onChange={(e) => updateSetting("database", "connectionString", e.target.value)}
                  placeholder="postgresql://user:pass@host:5432/db"
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="db-pool">Connection Pool Size</Label>
                <Input
                  id="db-pool"
                  type="number"
                  value={settings.database.poolSize}
                  onChange={(e) => updateSetting("database", "poolSize", parseInt(e.target.value))}
                  placeholder="20"
                />
              </div>
              <div className="flex items-center justify-between">
                <Label htmlFor="db-ssl">Enable SSL</Label>
                <Switch
                  id="db-ssl"
                  checked={settings.database.sslEnabled}
                  onCheckedChange={(checked) => updateSetting("database", "sslEnabled", checked)}
                />
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Microsoft Graph Settings */}
        <TabsContent value="microsoft">
          <Card>
            <CardHeader>
              <div className="flex items-center justify-between">
                <div>
                  <CardTitle>Microsoft Graph API</CardTitle>
                  <CardDescription>
                    OneNote integration and Microsoft services
                  </CardDescription>
                </div>
                <ConnectionBadge connected={connectionStatus.microsoft} />
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between">
                <Label htmlFor="ms-enabled">Enable Microsoft Integration</Label>
                <Switch
                  id="ms-enabled"
                  checked={settings.microsoft.enabled}
                  onCheckedChange={(checked) => updateSetting("microsoft", "enabled", checked)}
                />
              </div>
              <Separator />
              <div className="grid gap-2">
                <Label htmlFor="ms-client-id">Client ID</Label>
                <Input
                  id="ms-client-id"
                  value={settings.microsoft.graphClientId}
                  onChange={(e) => updateSetting("microsoft", "graphClientId", e.target.value)}
                  placeholder="Enter Azure AD application client ID"
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="ms-client-secret">Client Secret</Label>
                <Input
                  id="ms-client-secret"
                  type="password"
                  value={settings.microsoft.graphClientSecret}
                  onChange={(e) => updateSetting("microsoft", "graphClientSecret", e.target.value)}
                  placeholder="Enter client secret"
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="ms-tenant">Tenant ID</Label>
                <Input
                  id="ms-tenant"
                  value={settings.microsoft.tenantId}
                  onChange={(e) => updateSetting("microsoft", "tenantId", e.target.value)}
                  placeholder="Enter Azure AD tenant ID"
                />
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Teams Bot Settings */}
        <TabsContent value="teams">
          <Card>
            <CardHeader>
              <div className="flex items-center justify-between">
                <div>
                  <CardTitle>Teams Bot Configuration</CardTitle>
                  <CardDescription>
                    Microsoft Teams bot integration settings
                  </CardDescription>
                </div>
                <ConnectionBadge connected={connectionStatus.teams} />
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between">
                <Label htmlFor="teams-enabled">Enable Teams Bot</Label>
                <Switch
                  id="teams-enabled"
                  checked={settings.teams.enabled}
                  onCheckedChange={(checked) => updateSetting("teams", "enabled", checked)}
                />
              </div>
              <Separator />
              <div className="grid gap-2">
                <Label htmlFor="teams-app-id">Bot App ID</Label>
                <Input
                  id="teams-app-id"
                  value={settings.teams.botAppId}
                  onChange={(e) => updateSetting("teams", "botAppId", e.target.value)}
                  placeholder="Enter bot application ID"
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="teams-password">Bot App Password</Label>
                <Input
                  id="teams-password"
                  type="password"
                  value={settings.teams.botAppPassword}
                  onChange={(e) => updateSetting("teams", "botAppPassword", e.target.value)}
                  placeholder="Enter bot application password"
                />
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Ngrok Settings */}
        <TabsContent value="ngrok">
          <Card>
            <CardHeader>
              <div className="flex items-center justify-between">
                <div>
                  <CardTitle>Ngrok Configuration</CardTitle>
                  <CardDescription>
                    Secure tunnel configuration for local development and webhook testing
                  </CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <Alert>
                <AlertTriangle className="h-4 w-4" />
                <AlertTitle>Development Only</AlertTitle>
                <AlertDescription>
                  Ngrok is for local development only. Do not enable in production.
                </AlertDescription>
              </Alert>

              <div className="flex items-center justify-between">
                <Label htmlFor="ngrok-enabled">Enable Ngrok</Label>
                <Switch
                  id="ngrok-enabled"
                  checked={settings.ngrok?.enabled ?? false}
                  onCheckedChange={(checked) => updateSetting("ngrok", "enabled", checked)}
                />
              </div>

              <Separator />

              <div className="grid gap-2">
                <Label htmlFor="ngrok-authtoken">Auth Token</Label>
                <Input
                  id="ngrok-authtoken"
                  type="password"
                  value={settings.ngrok?.authtoken ?? ""}
                  onChange={(e) => updateSetting("ngrok", "authtoken", e.target.value)}
                  placeholder="Your ngrok authtoken"
                />
              </div>

              <div className="grid gap-2">
                <Label htmlFor="ngrok-apikey">API Key (Optional)</Label>
                <Input
                  id="ngrok-apikey"
                  type="password"
                  value={settings.ngrok?.apiKey ?? ""}
                  onChange={(e) => updateSetting("ngrok", "apiKey", e.target.value)}
                  placeholder="For OpenAPI-compatible ngrok management"
                />
              </div>

              <div className="grid gap-2">
                <Label htmlFor="ngrok-region">Region</Label>
                <Input
                  id="ngrok-region"
                  value={settings.ngrok?.region ?? "us"}
                  onChange={(e) => updateSetting("ngrok", "region", e.target.value)}
                  placeholder="us, eu, ap, au, sa, jp, in"
                />
              </div>

              <div className="grid gap-2">
                <Label htmlFor="ngrok-subdomain">Subdomain (Paid Plans)</Label>
                <Input
                  id="ngrok-subdomain"
                  value={settings.ngrok?.subdomain ?? ""}
                  onChange={(e) => updateSetting("ngrok", "subdomain", e.target.value)}
                  placeholder="your-app"
                />
              </div>

              <div className="grid gap-2">
                <Label htmlFor="ngrok-domain">Custom Domain (Paid Plans)</Label>
                <Input
                  id="ngrok-domain"
                  value={settings.ngrok?.domain ?? ""}
                  onChange={(e) => updateSetting("ngrok", "domain", e.target.value)}
                  placeholder="your-domain.ngrok.io"
                />
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Security Settings */}
        <TabsContent value="security">
          <Card>
            <CardHeader>
              <CardTitle>Security Settings</CardTitle>
              <CardDescription>
                Authentication and security configuration
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid gap-2">
                <Label htmlFor="session-max-age">Session Max Age (seconds)</Label>
                <Input
                  id="session-max-age"
                  type="number"
                  value={settings.security.sessionMaxAge}
                  onChange={(e) => updateSetting("security", "sessionMaxAge", parseInt(e.target.value))}
                  placeholder="28800 (8 hours)"
                />
                <p className="text-sm text-muted-foreground">
                  Default: 28800 seconds (8 hours)
                </p>
              </div>
              <div className="grid gap-2">
                <Label htmlFor="max-attempts">Max Login Attempts</Label>
                <Input
                  id="max-attempts"
                  type="number"
                  value={settings.security.maxLoginAttempts}
                  onChange={(e) => updateSetting("security", "maxLoginAttempts", parseInt(e.target.value))}
                  placeholder="5"
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="lockout-duration">Lockout Duration (minutes)</Label>
                <Input
                  id="lockout-duration"
                  type="number"
                  value={settings.security.lockoutDuration}
                  onChange={(e) => updateSetting("security", "lockoutDuration", parseInt(e.target.value))}
                  placeholder="30"
                />
              </div>
              <Separator />
              <div className="grid gap-2">
                <Label htmlFor="audit-retention">Audit Log Retention (days)</Label>
                <Input
                  id="audit-retention"
                  type="number"
                  value={settings.audit.retentionDays}
                  onChange={(e) => updateSetting("audit", "retentionDays", parseInt(e.target.value))}
                  placeholder="2555 (7 years)"
                />
                <p className="text-sm text-muted-foreground">
                  Federal compliance: 2555 days (7 years)
                </p>
              </div>
              <div className="flex items-center justify-between">
                <Label htmlFor="pii-masking">PII Masking</Label>
                <Switch
                  id="pii-masking"
                  checked={settings.audit.piiMasking}
                  onCheckedChange={(checked) => updateSetting("audit", "piiMasking", checked)}
                />
              </div>
              <div className="flex items-center justify-between">
                <Label htmlFor="detailed-logging">Detailed Audit Logging</Label>
                <Switch
                  id="detailed-logging"
                  checked={settings.audit.detailedLogging}
                  onCheckedChange={(checked) => updateSetting("audit", "detailedLogging", checked)}
                />
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
