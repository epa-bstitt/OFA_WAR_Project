"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";

interface AutoRefreshProps {
  intervalMs?: number;
  enabled?: boolean;
}

export function AutoRefresh({ intervalMs = 45000, enabled = true }: AutoRefreshProps) {
  const router = useRouter();

  useEffect(() => {
    if (!enabled || intervalMs <= 0) {
      return;
    }

    const timerId = window.setInterval(() => {
      router.refresh();
    }, intervalMs);

    return () => {
      window.clearInterval(timerId);
    };
  }, [enabled, intervalMs, router]);

  return null;
}
