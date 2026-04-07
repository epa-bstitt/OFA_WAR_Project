"use client";

import { useState, useEffect, useCallback } from "react";
import { Switch } from "@/components/ui/switch";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Database, Leaf } from "lucide-react";

interface MockModeToggleProps {
  onToggle?: (isMock: boolean) => void;
  className?: string;
}

// Cookie helper functions
function setCookie(name: string, value: string, days: number = 7) {
  const expires = new Date(Date.now() + days * 864e5).toUTCString();
  document.cookie = `${name}=${encodeURIComponent(value)}; expires=${expires}; path=/; SameSite=Lax`;
}

function getCookie(name: string): string | null {
  const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
  return match ? decodeURIComponent(match[2]) : null;
}

export function MockModeToggle({ onToggle, className = "" }: MockModeToggleProps) {
  const [isMockMode, setIsMockMode] = useState(false);
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    // Check cookie for saved preference
    const saved = getCookie("admin-mock-mode");
    if (saved !== null) {
      const isMock = saved === "true";
      setIsMockMode(isMock);
      onToggle?.(isMock);
    }
  }, [onToggle]);

  const handleToggle = useCallback((checked: boolean) => {
    setIsMockMode(checked);
    setCookie("admin-mock-mode", checked.toString());
    onToggle?.(checked);
    
    // Reload page to switch data source
    window.location.reload();
  }, [onToggle]);

  if (!mounted) {
    return null;
  }

  return (
    <div className={`flex items-center gap-3 p-3 rounded-lg border ${isMockMode ? 'bg-amber-50 border-amber-200' : 'bg-green-50 border-green-200'} ${className}`}>
      <div className="flex items-center gap-2">
        {isMockMode ? (
          <Leaf className="h-5 w-5 text-amber-600" />
        ) : (
          <Database className="h-5 w-5 text-green-600" />
        )}
        <div className="flex flex-col">
          <Label htmlFor="mock-mode" className="cursor-pointer font-medium">
            {isMockMode ? "Mock Data Mode" : "Live Database"}
          </Label>
          <span className="text-xs text-muted-foreground">
            {isMockMode 
              ? "Using sample data (no DB connection)" 
              : "Connected to real database"}
          </span>
        </div>
      </div>
      
      <div className="flex items-center gap-2 ml-auto">
        <Badge variant={isMockMode ? "secondary" : "default"} className={isMockMode ? "bg-amber-100 text-amber-800" : "bg-green-100 text-green-800"}>
          {isMockMode ? "Mock" : "Live"}
        </Badge>
        <Switch
          id="mock-mode"
          checked={isMockMode}
          onCheckedChange={handleToggle}
        />
      </div>
    </div>
  );
}

// Hook to check if mock mode is enabled
export function useMockMode(): boolean {
  const [isMockMode, setIsMockMode] = useState(false);

  useEffect(() => {
    const saved = getCookie("admin-mock-mode");
    setIsMockMode(saved === "true");
  }, []);

  return isMockMode;
}
