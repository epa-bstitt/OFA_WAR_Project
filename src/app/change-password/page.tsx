"use client";

import { FormEvent, useState } from "react";
import { signOut } from "next-auth/react";
import { KeyRound, Loader2 } from "lucide-react";
import { changeOwnPassword } from "@/app/actions/auth/password";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { PasswordInput } from "@/components/shared/PasswordInput";

export default function ChangePasswordPage() {
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmation, setConfirmation] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setError(null);

    if (newPassword !== confirmation) {
      setError("The new passwords do not match.");
      return;
    }

    setIsLoading(true);
    const result = await changeOwnPassword(currentPassword, newPassword);

    if (!result.success) {
      setError(result.error);
      setIsLoading(false);
      return;
    }

    await signOut({ callbackUrl: "/login" });
  }

  return (
    <main id="main-content" className="min-h-screen flex items-center justify-center bg-slate-50 px-4 py-8">
      <Card className="w-full max-w-md">
        <CardHeader className="text-center">
          <CardTitle asChild><h1>Change temporary password</h1></CardTitle>
          <CardDescription>Choose a new password with at least 12 characters before continuing.</CardDescription>
        </CardHeader>
        <CardContent>
          <form className="space-y-4" onSubmit={handleSubmit}>
            <div className="space-y-2">
              <Label htmlFor="currentPassword">Temporary password</Label>
              <PasswordInput id="currentPassword" autoComplete="current-password" value={currentPassword} onChange={(event) => setCurrentPassword(event.target.value)} required disabled={isLoading} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="newPassword">New password</Label>
              <PasswordInput id="newPassword" autoComplete="new-password" minLength={12} value={newPassword} onChange={(event) => setNewPassword(event.target.value)} required disabled={isLoading} />
            </div>
            <div className="space-y-2">
              <Label htmlFor="confirmation">Confirm new password</Label>
              <PasswordInput id="confirmation" autoComplete="new-password" minLength={12} value={confirmation} onChange={(event) => setConfirmation(event.target.value)} required disabled={isLoading} />
            </div>
            {error && <p role="alert" className="text-sm text-red-600">{error}</p>}
            <Button className="w-full" size="lg" type="submit" disabled={isLoading}>
              {isLoading ? <Loader2 className="h-4 w-4 animate-spin" /> : <KeyRound className="h-4 w-4" />}
              Change password
            </Button>
            <Button className="w-full" type="button" variant="ghost" disabled={isLoading} onClick={() => signOut({ callbackUrl: "/login" })}>Sign out</Button>
          </form>
        </CardContent>
      </Card>
    </main>
  );
}