"use client";

import Link from "next/link";
import { cn } from "@/lib/utils";

interface EPALogoProps {
  size?: "sm" | "md" | "lg";
  className?: string;
}

const sizeClasses = {
  sm: "h-8 w-8",
  md: "h-10 w-10",
  lg: "h-12 w-12",
};

export function EPALogo({ size = "md", className }: EPALogoProps) {
  return (
    <Link
      href="https://www.epa.gov"
      target="_blank"
      rel="noopener noreferrer"
      className={cn("flex items-center gap-2", className)}
      aria-label="U.S. Environmental Protection Agency (opens in new tab)"
    >
      <svg
        className={cn(sizeClasses[size], "text-[#005ea2]")}
        viewBox="0 0 100 100"
        fill="currentColor"
        xmlns="http://www.w3.org/2000/svg"
        aria-hidden="true"
      >
        {/* EPA Logo - Stylized representation */}
        <circle cx="50" cy="50" r="45" fill="#005ea2" />
        <circle cx="50" cy="50" r="35" fill="white" />
        <circle cx="50" cy="50" r="25" fill="#005ea2" />
        <text
          x="50"
          y="58"
          textAnchor="middle"
          fill="white"
          fontSize="20"
          fontWeight="bold"
          fontFamily="Arial, sans-serif"
        >
          EPA
        </text>
      </svg>
      <span className="font-semibold text-[#005ea2] hidden sm:inline-block">
        EPA Business Platform
      </span>
    </Link>
  );
}
