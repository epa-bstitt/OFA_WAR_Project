"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { 
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { 
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { CheckCircle, XCircle, MessageSquare, ChevronRight, ChevronLeft } from "lucide-react";
import { COMMENT_TEMPLATES } from "./TerseEditor";

interface ReviewActionsProps {
  submissionId: string;
  terseText: string;
  onApprove: (id: string, terseText: string, comment?: string) => Promise<void>;
  onReject: (id: string, reason: string) => Promise<void>;
  onSkip?: () => void;
  hasNext?: boolean;
  hasPrev?: boolean;
}

export function ReviewActions({
  submissionId,
  terseText,
  onApprove,
  onReject,
  onSkip,
  hasNext = false,
  hasPrev = false,
}: ReviewActionsProps) {
  const router = useRouter();
  const [isApproving, setIsApproving] = useState(false);
  const [isRejecting, setIsRejecting] = useState(false);
  const [showRejectDialog, setShowRejectDialog] = useState(false);
  const [comment, setComment] = useState("");
  const [rejectReason, setRejectReason] = useState("");

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

  const handleReject = async () => {
    if (!rejectReason) return;
    
    setIsRejecting(true);
    try {
      await onReject(submissionId, rejectReason);
      router.push("/review");
    } catch (error) {
      console.error("Failed to reject:", error);
    } finally {
      setIsRejecting(false);
      setShowRejectDialog(false);
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
            variant="destructive"
            onClick={() => setShowRejectDialog(true)}
            disabled={isApproving || isRejecting}
          >
            <XCircle className="h-4 w-4 mr-2" />
            Reject
          </Button>
          <Button
            variant="default"
            onClick={handleApprove}
            disabled={isApproving || isRejecting}
            className="bg-green-600 hover:bg-green-700"
          >
            <CheckCircle className="h-4 w-4 mr-2" />
            {isApproving ? "Approving..." : "Approve"}
          </Button>
        </div>
      </div>

      {/* Reject Dialog */}
      <Dialog open={showRejectDialog} onOpenChange={setShowRejectDialog}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Reject Submission</DialogTitle>
            <DialogDescription>
              Please provide a reason for rejecting this submission. This will be shared with the contributor.
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-4 py-4">
            <div className="space-y-2">
              <Label htmlFor="reject-reason">Rejection Reason</Label>
              <Textarea
                id="reject-reason"
                value={rejectReason}
                onChange={(e) => setRejectReason(e.target.value)}
                placeholder="Explain why this submission is being rejected..."
                className="min-h-[100px]"
              />
            </div>
          </div>
          <DialogFooter>
            <Button variant="ghost" onClick={() => setShowRejectDialog(false)}>
              Cancel
            </Button>
            <Button
              variant="destructive"
              onClick={handleReject}
              disabled={!rejectReason.trim() || isRejecting}
            >
              {isRejecting ? "Rejecting..." : "Confirm Reject"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Keyboard shortcuts hint */}
      <div className="text-xs text-muted-foreground text-center">
        Keyboard shortcuts: Ctrl+Enter to Approve • Esc to Cancel
      </div>
    </div>
  );
}
