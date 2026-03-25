"use client";

import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Search, X } from "lucide-react";

interface ReviewFiltersProps {
  search: string;
  onSearchChange: (value: string) => void;
  contributorFilter: string;
  onContributorFilterChange: (value: string) => void;
  weekFilter: string;
  onWeekFilterChange: (value: string) => void;
  contributors: { id: string; name: string | null }[];
}

export function ReviewFilters({
  search,
  onSearchChange,
  contributorFilter,
  onContributorFilterChange,
  weekFilter,
  onWeekFilterChange,
  contributors,
}: ReviewFiltersProps) {
  const hasFilters = search || contributorFilter !== "all" || weekFilter !== "all";

  const clearFilters = () => {
    onSearchChange("");
    onContributorFilterChange("all");
    onWeekFilterChange("all");
  };

  // Generate last 4 weeks for filter
  const weeks = Array.from({ length: 4 }, (_, i) => {
    const date = new Date();
    date.setDate(date.getDate() - i * 7);
    return {
      value: date.toISOString().split("T")[0],
      label: `Week of ${date.toLocaleDateString("en-US", { month: "short", day: "numeric" })}`,
    };
  });

  return (
    <div className="flex flex-col sm:flex-row gap-3 items-start sm:items-center">
      <div className="relative flex-1 w-full sm:max-w-sm">
        <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
        <Input
          placeholder="Search by contributor..."
          value={search}
          onChange={(e) => onSearchChange(e.target.value)}
          className="pl-9"
        />
      </div>

      <div className="flex gap-2 w-full sm:w-auto">
        <Select value={contributorFilter} onValueChange={onContributorFilterChange}>
          <SelectTrigger className="w-[180px]">
            <SelectValue placeholder="All Contributors" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Contributors</SelectItem>
            {contributors.map((contributor) => (
              <SelectItem key={contributor.id} value={contributor.id}>
                {contributor.name || "Unknown"}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <Select value={weekFilter} onValueChange={onWeekFilterChange}>
          <SelectTrigger className="w-[180px]">
            <SelectValue placeholder="All Weeks" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">All Weeks</SelectItem>
            {weeks.map((week) => (
              <SelectItem key={week.value} value={week.value}>
                {week.label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        {hasFilters && (
          <Button variant="ghost" size="icon" onClick={clearFilters}>
            <X className="h-4 w-4" />
          </Button>
        )}
      </div>
    </div>
  );
}
