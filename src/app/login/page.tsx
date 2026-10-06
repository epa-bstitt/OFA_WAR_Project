"use client";

import { FormEvent, useEffect, useState } from "react";
import { getProviders, signIn } from "next-auth/react";
import { Loader2, LogIn } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { PasswordInput } from "@/components/shared/PasswordInput";
import { siteConfig } from "@/config/site";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isCredentialLoading, setIsCredentialLoading] = useState(false);
  const [loadingProvider, setLoadingProvider] = useState<string | null>(null);
  const [availableProviders, setAvailableProviders] = useState<string[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    void getProviders().then((providers) => {
      setAvailableProviders(Object.keys(providers ?? {}));
    });
  }, []);

  async function handleCredentialSignIn(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setError(null);
    setIsCredentialLoading(true);

    try {
      const result = await signIn("credentials", {
        email,
        password,
        redirect: false,
        callbackUrl: "/dashboard",
      });

      if (result?.error) {
        setError("The email or password is incorrect, or the account is unavailable.");
        return;
      }

      window.location.assign(result?.url ?? "/dashboard");
    } catch {
      setError("Unable to sign in. Please try again.");
    } finally {
      setIsCredentialLoading(false);
    }
  }

  async function handleSsoSignIn(provider: string) {
    setError(null);
    setLoadingProvider(provider);

    try {
      await signIn(provider, { callbackUrl: "/dashboard" });
    } catch {
      setError("Unable to start single sign-on. Please try again.");
      setLoadingProvider(null);
    }
  }

  const ssoProviders = availableProviders.filter((provider) =>
    ["logingov", "azure-ad-b2c"].includes(provider)
  );
  const isLoading = isCredentialLoading || loadingProvider !== null;

  return (
    <main id="main-content" className="min-h-screen flex items-center justify-center bg-slate-50 px-5 py-10">
      <Card className="w-full max-w-xl">
        <CardHeader className="space-y-2 px-8 pb-7 pt-9 text-center sm:px-12 sm:pt-11">
          <CardTitle asChild className="text-3xl font-bold sm:text-4xl">
            <h1>{siteConfig.name}</h1>
          </CardTitle>
          <CardDescription className="text-base">Weekly Activity Report Management System</CardDescription>
        </CardHeader>
        <CardContent className="space-y-7 px-8 pb-9 sm:px-12 sm:pb-11">
          <form className="space-y-6" onSubmit={handleCredentialSignIn}>
            <div className="space-y-2.5">
              <Label htmlFor="email" className="text-base">EPA email address</Label>
              <Input
                id="email"
                name="email"
                type="email"
                autoComplete="username"
                placeholder="lastname.firstname@epa.gov"
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                required
                disabled={isLoading}
                className="h-12 px-4 text-base md:text-base"
              />
            </div>
            <div className="space-y-2.5">
              <Label htmlFor="password" className="text-base">Password</Label>
              <PasswordInput
                id="password"
                name="password"
                autoComplete="current-password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                required
                disabled={isLoading}
                className="h-12 px-4 text-base md:text-base"
              />
            </div>
            <Button className="h-12 w-full text-base" size="lg" type="submit" disabled={isLoading}>
              {isCredentialLoading ? <Loader2 className="h-5 w-5 animate-spin" /> : <LogIn className="h-5 w-5" />}
              Sign in
            </Button>
          </form>

          {ssoProviders.length > 0 && (
            <>
              <div className="relative">
                <div className="absolute inset-0 flex items-center"><span className="w-full border-t" /></div>
                <div className="relative flex justify-center text-xs uppercase">
                  <span className="bg-white px-2 text-muted-foreground">Or use single sign-on</span>
                </div>
              </div>
              <div className="space-y-2">
                {ssoProviders.map((provider) => (
                  <Button key={provider} className="h-12 w-full text-base" variant="outline" size="lg" disabled={isLoading} onClick={() => handleSsoSignIn(provider)}>
                    {loadingProvider === provider && <Loader2 className="h-4 w-4 animate-spin" />}
                    Sign in with {provider === "logingov" ? "Login.gov" : "Azure AD"}
                  </Button>
                ))}
              </div>
            </>
          )}

          {error && <p role="alert" className="text-sm text-red-600 text-center">{error}</p>}
        </CardContent>
      </Card>
    </main>
  );
}