"use client";

import { useMemo, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import type { MockContractSubmission } from "@/lib/mock-contracts";

interface WarEntriesListProps {
  entries: MockContractSubmission[];
}

export function WarEntriesList({ entries }: WarEntriesListProps) {
  const [showAll, setShowAll] = useState(false);

  const visibleEntries = useMemo(
    () => (showAll ? entries : entries.slice(0, 1)),
    [entries, showAll]
  );

  const hiddenCount = Math.max(entries.length - 1, 0);

  return (
    <div className="space-y-4">
      {visibleEntries.map((entry) => (
        <Card key={entry.id}>
          <CardHeader>
            <div className="flex flex-wrap items-center justify-between gap-2">
              <CardTitle className="text-base">Week of {entry.weekOf}</CardTitle>
              <Badge variant="secondary">{entry.status.replace("_", " ")}</Badge>
            </div>
          </CardHeader>
          <CardContent className="space-y-2">
            <p className="text-xs text-slate-500">Submitted: {entry.submittedAt}</p>
            <p className="text-sm leading-6 text-slate-700">{entry.summary}</p>
          </CardContent>
        </Card>
      ))}

      {entries.length > 1 && (
        <div>
          <Button type="button" variant="outline" onClick={() => setShowAll((prev) => !prev)}>
            {showAll ? "Show less" : `More updates (${hiddenCount})`}
          </Button>
        </div>
      )}
    </div>
  );
}
