import { Metadata } from "next";
import Link from "next/link";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { siteConfig } from "@/config/site";

export const metadata: Metadata = {
  title: "Authentication Error",
  description: "An error occurred during authentication",
};

interface AuthErrorPageProps {
  searchParams: { error?: string };
}

function getErrorMessage(error: string): string {
  const errorMessages: Record<string, string> = {
    Configuration: "There is a problem with the server configuration.",
    AccessDenied: "You do not have permission to sign in.",
    Verification: "The verification token has expired or has already been used.",
    OAuthSignin: "Error in the OAuth sign-in process.",
    OAuthCallback: "Error in the OAuth callback process.",
    OAuthCreateAccount: "Could not create OAuth provider account.",
    EmailCreateAccount: "Could not create email provider account.",
    Callback: "Error in the OAuth callback.",
    OAuthAccountNotLinked: "The email on this account is already linked to another account.",
    EmailSignin: "Error sending the email sign-in link.",
    CredentialsSignin: "The sign-in credentials are invalid.",
    SessionRequired: "You must be signed in to access this page.",
    Default: "An unknown error occurred during authentication.",
  };

  return errorMessages[error] || errorMessages.Default;
}

export default function AuthErrorPage({ searchParams }: AuthErrorPageProps) {
  const error = searchParams.error || "Default";
  const errorMessage = getErrorMessage(error);

  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-50 px-4">
      <Card className="w-full max-w-md">
        <CardHeader className="space-y-1 text-center">
          <CardTitle className="text-2xl font-bold text-red-600">
            Authentication Error
          </CardTitle>
          <CardDescription>
            {siteConfig.name}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="p-4 bg-red-50 border border-red-200 rounded-md">
            <p className="text-sm text-red-800 text-center">{errorMessage}</p>
          </div>
          <Link href="/login" className="w-full">
            <Button className="w-full" size="lg" variant="outline">
              Back to Login
            </Button>
          </Link>
          <Link href="/" className="w-full">
            <Button className="w-full" size="lg" variant="ghost">
              Go to Home
            </Button>
          </Link>
        </CardContent>
      </Card>
    </div>
  );
}
