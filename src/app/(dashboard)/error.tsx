"use client";

import { useEffect } from "react";
import { ErrorDisplay } from "@/components/shared/ErrorDisplay";

export default function DashboardError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error("Dashboard error:", error);
  }, [error]);

  return (
    <div className="p-6">
      <ErrorDisplay
        title="Dashboard Error"
        message="Something went wrong while loading the dashboard. Please try again."
        retry={reset}
        error={error}
      />
    </div>
  );
}
