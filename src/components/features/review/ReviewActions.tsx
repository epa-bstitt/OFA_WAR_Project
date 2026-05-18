"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { 
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { CheckCircle, MessageSquare, ChevronRight, ChevronLeft } from "lucide-react";
import { COMMENT_TEMPLATES } from "./TerseEditor";

interface ReviewActionsProps {
  submissionId: string;
  terseText: string;
  onApprove: (id: string, terseText: string, comment?: string) => Promise<void>;
  onSkip?: () => void;
  hasNext?: boolean;
  hasPrev?: boolean;
}

export function ReviewActions({
  submissionId,
  terseText,
  onApprove,
  onSkip,
  hasNext = false,
  hasPrev = false,
}: ReviewActionsProps) {
  const router = useRouter();
  const [isApproving, setIsApproving] = useState(false);
  const [comment, setComment] = useState("");

  const handleApprove = async () => {
    setIsApproving(true);
    try {
      await onApprove(submissionId, terseText, comment || undefined);
      router.push("/review");
    } catch (error) {
      console.error("Failed to approve:", error);
    } finally {
      setIsApproving(false);
    }
  };

  return (
    <div className="flex flex-col gap-4">
      {/* Comment Section */}
      <div className="space-y-2">
        <Label htmlFor="comment">Edit Notes (optional)</Label>
        <Select
          value={comment}
          onValueChange={setComment}
        >
          <SelectTrigger className="w-full">
            <SelectValue placeholder="Select a quick reason or type below..." />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="">None</SelectItem>
            {COMMENT_TEMPLATES.map((template) => (
              <SelectItem key={template} value={template}>
                {template}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
        <Textarea
          id="comment"
          value={comment}
          onChange={(e) => setComment(e.target.value)}
          placeholder="What changes did you make and why?"
          className="min-h-[80px]"
        />
      </div>

      {/* Action Buttons */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Button
            variant="outline"
            size="sm"
            onClick={onSkip}
            disabled={!hasNext}
          >
            <ChevronLeft className="h-4 w-4 mr-1" />
            Previous
          </Button>
          <Button
            variant="outline"
            size="sm"
            onClick={onSkip}
            disabled={!hasNext}
          >
            Skip
            <ChevronRight className="h-4 w-4 ml-1" />
          </Button>
        </div>

        <div className="flex items-center gap-2">
          <Button
            variant="default"
            onClick={handleApprove}
            disabled={isApproving}
            className="bg-green-600 hover:bg-green-700"
          >
            <CheckCircle className="h-4 w-4 mr-2" />
            {isApproving ? "Approving..." : "Approve"}
          </Button>
        </div>
      </div>

      {/* Keyboard shortcuts hint */}
      <div className="text-xs text-muted-foreground text-center">Keyboard shortcuts: Ctrl+Enter to Approve</div>
    </div>
  );
}
