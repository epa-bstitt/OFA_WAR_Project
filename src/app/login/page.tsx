"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { getProviders, signIn } from "next-auth/react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { siteConfig } from "@/config/site";
import { Loader2, User, Users, Shield, Crown } from "lucide-react";

type DemoRole = "contributor" | "aggregator" | "overseer" | "admin";

const demoRoles: { id: DemoRole; name: string; description: string; icon: typeof User }[] = [
  {
    id: "contributor",
    name: "Contributor",
    description: "Submit WARs",
    icon: User,
  },
  {
    id: "aggregator",
    name: "Aggregator",
    description: "Review & Edit",
    icon: Users,
  },
  {
    id: "overseer",
    name: "Program Overseer",
    description: "Approve & Publish",
    icon: Shield,
  },
  {
    id: "admin",
    name: "Administrator",
    description: "Full Access",
    icon: Crown,
  },
];

// Cookie helper
function setCookie(name: string, value: string, days: number = 7) {
  const expires = new Date(Date.now() + days * 864e5).toUTCString();
  document.cookie = `${name}=${encodeURIComponent(value)}; expires=${expires}; path=/; SameSite=Lax`;
}

export default function LoginPage() {
  const router = useRouter();
  const [isLoading, setIsLoading] = useState<DemoRole | null>(null);
  const [isLoginGovLoading, setIsLoginGovLoading] = useState(false);
  const [isLoginGovAvailable, setIsLoginGovAvailable] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Auto-enable mock mode on page load for demo
  useEffect(() => {
    setCookie("admin-mock-mode", "true");

    void getProviders().then((providers) => {
      setIsLoginGovAvailable(Boolean(providers?.logingov));
    });
  }, []);

  const handleLoginGovSignIn = async () => {
    setError(null);
    setIsLoginGovLoading(true);

    try {
      await signIn("logingov", { callbackUrl: "/dashboard" });
    } catch (err) {
      console.error("Login.gov sign-in error:", err);
      setError("Unable to start Login.gov sign-in. Please try again.");
      setIsLoginGovLoading(false);
    }
  };

  const handleDemoLogin = async (role: DemoRole) => {
    setIsLoading(role);
    setError(null);

    const destination =
      role === "overseer" ? "/approve" : role === "aggregator" ? "/review" : "/dashboard";

    try {
      setCookie("admin-mock-mode", "true");
      setCookie("admin-mock-role", role);

      router.push(destination);
      router.refresh();
    } catch (err) {
      console.error("Demo login error:", err);
      setError("An error occurred during login.");
    } finally {
      setIsLoading(null);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-50 px-4 py-8">
      <Card className="w-full max-w-md">
        <CardHeader className="space-y-1 text-center">
          <CardTitle className="text-2xl font-bold">{siteConfig.name}</CardTitle>
          <CardDescription>
            Weekly Activity Report Management System
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {isLoginGovAvailable && (
            <div className="space-y-2">
              <Button
                className="w-full"
                size="lg"
                disabled={isLoading !== null || isLoginGovLoading}
                onClick={handleLoginGovSignIn}
              >
                {isLoginGovLoading ? <Loader2 className="h-4 w-4 animate-spin" /> : "Sign in with Login.gov"}
              </Button>
            </div>
          )}

          {/* EPA MAX Login */}
          <div className="space-y-2">
            <p className="text-sm text-muted-foreground text-center">
              Demo login bypasses external authentication for local testing
            </p>
            <Button 
              className="w-full" 
              size="lg"
              disabled={isLoading !== null || isLoginGovLoading}
              onClick={() => handleDemoLogin("contributor")}
            >
              Continue to Dashboard
            </Button>
          </div>

          {/* Divider */}
          <div className="relative">
            <div className="absolute inset-0 flex items-center">
              <span className="w-full border-t" />
            </div>
            <div className="relative flex justify-center text-xs uppercase">
              <span className="bg-white px-2 text-muted-foreground">
                Or demo login
              </span>
            </div>
          </div>

          {/* Demo Login Buttons */}
          <div className="grid grid-cols-2 gap-2">
            {demoRoles.map((role) => {
              const Icon = role.icon;
              const isLoadingThis = isLoading === role.id;

              return (
                <Button
                  key={role.id}
                  variant="outline"
                  onClick={() => handleDemoLogin(role.id)}
                  disabled={isLoading !== null || isLoginGovLoading}
                  className="flex flex-col items-center h-auto py-3 px-2"
                >
                  {isLoadingThis ? (
                    <Loader2 className="h-5 w-5 animate-spin mb-1" />
                  ) : (
                    <Icon className="h-5 w-5 mb-1" />
                  )}
                  <span className="text-sm font-medium">{role.name}</span>
                  <Badge variant="secondary" className="mt-1 text-[10px]">
                    {role.description}
                  </Badge>
                </Button>
              );
            })}
          </div>

          {error && (
            <p className="text-sm text-red-600 text-center">{error}</p>
          )}

          <p className="text-xs text-muted-foreground text-center">
            Use Login.gov in production and demo mode for non-production testing
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
