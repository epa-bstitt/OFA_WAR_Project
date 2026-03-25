import Link from "next/link";
import { Metadata } from "next";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Search, Home } from "lucide-react";
import { siteConfig } from "@/config/site";

export const metadata: Metadata = {
  title: "Page Not Found",
  description: "The requested page could not be found",
};

export default function NotFoundPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-50 px-4">
      <Card className="w-full max-w-md">
        <CardHeader className="text-center">
          <div className="flex justify-center mb-4">
            <Search className="h-12 w-12 text-[#005ea2]" />
          </div>
          <CardTitle className="text-2xl font-bold">Page Not Found</CardTitle>
          <CardDescription>
            The page you're looking for doesn't exist or has been moved.
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-3">
          <Link href="/dashboard" className="w-full">
            <Button className="w-full" size="lg">
              <Home className="mr-2 h-4 w-4" />
              Go to Dashboard
            </Button>
          </Link>
          <Link href="/" className="w-full">
            <Button className="w-full" size="lg" variant="outline">
              Go to Home
            </Button>
          </Link>
          <p className="text-xs text-center text-slate-500 mt-4">
            {siteConfig.name} - EPA Business Platform
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
