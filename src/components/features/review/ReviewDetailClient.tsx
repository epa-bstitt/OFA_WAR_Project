"use client";

import { useState, useCallback } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { format } from "date-fns";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import { RawPanel } from "@/components/features/review/RawPanel";
import { TerseEditor } from "@/components/features/review/TerseEditor";
import { ReviewActions } from "@/components/features/review/ReviewActions";
import {
  approveSubmission,
  rejectSubmission,
  type SubmissionWithUser,
} from "@/app/actions/review";
import { ArrowLeft, Eye } from "lucide-react";

interface ReviewDetailPageProps {
  submission: SubmissionWithUser;
  nextId?: string;
  prevId?: string;
  queueSize?: number;
  currentPosition?: number;
}

export default function ReviewDetailPage({
  submission,
  nextId,
  prevId,
  queueSize = 1,
  currentPosition = 1,
}: ReviewDetailPageProps) {
  const router = useRouter();
  const [terseText, setTerseText] = useState(submission.terseVersion || submission.rawText);

  const handleApprove = useCallback(
    async (id: string, text: string, comment?: string) => {
      const result = await approveSubmission(id, text, comment);
      if (!result.success) {
        throw new Error(result.error);
      }
    },
    []
  );

  const handleReject = useCallback(async (id: string, reason: string) => {
    const result = await rejectSubmission(id, reason);
    if (!result.success) {
      throw new Error(result.error);
    }
  }, []);

  const handleSkip = useCallback(() => {
    if (nextId) {
      router.push(`/review/${nextId}`);
    }
  }, [nextId, router]);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link href="/review">
            <Button variant="ghost" size="sm">
              <ArrowLeft className="h-4 w-4 mr-1" />
              Back to Queue
            </Button>
          </Link>
          <div>
            <h1 className="text-xl font-semibold">
              Review Submission {currentPosition} of {queueSize}
            </h1>
            <p className="text-sm text-muted-foreground">
              Week of {format(new Date(submission.weekOf), "MMMM d, yyyy")}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          {submission.isAiGenerated && (
            <Badge variant="secondary">AI-assisted</Badge>
          )}
          <Link href={`/submissions/${submission.id}`}>
            <Button variant="ghost" size="sm">
              <Eye className="h-4 w-4 mr-1" />
              View Details
            </Button>
          </Link>
        </div>
      </div>

      <Separator />

      {/* Side-by-Side Layout */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Left: Raw Text */}
        <RawPanel submission={submission} />

        {/* Right: Terse Editor */}
        <TerseEditor
          submissionId={submission.id}
          initialTerseText={terseText}
          onChange={setTerseText}
        />
      </div>

      {/* Actions */}
      <Card>
        <CardContent className="pt-6">
          <ReviewActions
            submissionId={submission.id}
            terseText={terseText}
            onApprove={handleApprove}
            onReject={handleReject}
            onSkip={handleSkip}
            hasNext={!!nextId}
            hasPrev={!!prevId}
          />
        </CardContent>
      </Card>
    </div>
  );
}
