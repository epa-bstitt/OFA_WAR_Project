"use client";

import { AlertCircle, RefreshCcw } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { cn } from "@/lib/utils";

interface ErrorDisplayProps {
  title?: string;
  message?: string;
  retry?: () => void;
  error?: Error;
  className?: string;
}

export function ErrorDisplay({
  title = "Something went wrong",
  message = "An unexpected error occurred. Please try again.",
  retry,
  error,
  className,
}: ErrorDisplayProps) {
  // Log error to console for debugging
  if (error && typeof window !== "undefined") {
    console.error("ErrorDisplay caught error:", error);
  }

  return (
    <Card className={cn("w-full max-w-md mx-auto", className)}>
      <CardHeader className="text-center">
        <div className="flex justify-center mb-4">
          <AlertCircle className="h-12 w-12 text-red-500" />
        </div>
        <CardTitle className="text-xl text-red-600">{title}</CardTitle>
        <CardDescription>{message}</CardDescription>
      </CardHeader>
      <CardContent className="flex flex-col gap-3">
        {retry && (
          <Button onClick={retry} className="w-full" variant="outline">
            <RefreshCcw className="mr-2 h-4 w-4" />
            Try Again
          </Button>
        )}
        {process.env.NODE_ENV === "development" && error && (
          <div className="mt-4 p-3 bg-slate-100 rounded text-xs font-mono overflow-auto max-h-40">
            <p className="font-semibold mb-1">Debug Info (dev only):</p>
            <p>{error.message}</p>
            {error.stack && (
              <pre className="mt-2 whitespace-pre-wrap">{error.stack}</pre>
            )}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
