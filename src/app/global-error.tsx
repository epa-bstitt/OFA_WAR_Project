"use client";

import { useEffect } from "react";
import { EPALogo } from "@/components/shared/EPALogo";

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error("Global error:", error);
  }, [error]);

  return (
    <html>
      <body>
        <div className="min-h-screen flex items-center justify-center bg-slate-50 p-4">
          <div className="max-w-md w-full bg-white rounded-lg shadow-lg p-6 text-center">
            <div className="flex justify-center mb-4">
              <EPALogo size="lg" />
            </div>
            <h1 className="text-2xl font-bold text-red-600 mb-2">
              Critical Error
            </h1>
            <p className="text-slate-600 mb-6">
              A critical error has occurred. Please try again or contact support.
            </p>
            <button
              onClick={reset}
              className="bg-[#005ea2] text-white px-6 py-2 rounded-md hover:bg-[#004c86] transition-colors"
            >
              Try Again
            </button>
          </div>
        </div>
      </body>
    </html>
  );
}
