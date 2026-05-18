"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { resubmitInfoNeededSubmission } from "@/app/actions/submissions";

interface SubmissionEditFormProps {
  submissionId: string;
  initialText: string;
}

export function SubmissionEditForm({ submissionId, initialText }: SubmissionEditFormProps) {
  const router = useRouter();
  const [rawText, setRawText] = useState(initialText);
  const [error, setError] = useState<string | null>(null);
  const [isPending, startTransition] = useTransition();

  function onSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setError(null);

    startTransition(async () => {
      const result = await resubmitInfoNeededSubmission(submissionId, rawText);
      if (!result.success) {
        setError(result.error);
        return;
      }

      router.push(`/submissions/${submissionId}`);
      router.refresh();
    });
  }

  return (
    <form onSubmit={onSubmit} className="space-y-4">
      {error && (
        <Alert variant="destructive">
          <AlertTitle>Unable to resubmit</AlertTitle>
          <AlertDescription>{error}</AlertDescription>
        </Alert>
      )}

      <Textarea
        value={rawText}
        onChange={(event) => setRawText(event.target.value)}
        className="min-h-[220px]"
        placeholder="Update your WAR content with requested changes"
      />

      <div className="flex items-center justify-end gap-2">
        <Button type="button" variant="outline" onClick={() => router.back()} disabled={isPending}>
          Cancel
        </Button>
        <Button type="submit" disabled={isPending}>
          {isPending ? "Resubmitting..." : "Resubmit for Review"}
        </Button>
      </div>
    </form>
  );
}
