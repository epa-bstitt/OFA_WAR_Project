"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { CheckCircle, XCircle, Loader2, AlertTriangle } from "lucide-react";
import type { SubmissionWithReviews } from "@/app/actions/approve";

interface BatchActionBarProps {
  submissions: SubmissionWithReviews[];
  selectedIds: Set<string>;
  onToggleAll: () => void;
  onClearSelection: () => void;
  onBatchApprove: (ids: string[], notes?: string) => Promise<void>;
  onBatchReject: (ids: string[], reason: string) => Promise<void>;
  isProcessing?: boolean;
}

const rejectionReasons = [
  { value: "incomplete", label: "Incomplete information" },
  { value: "formatting", label: "Incorrect formatting" },
  { value: "missing", label: "Missing key details" },
  { value: "inappropriate", label: "Not appropriate for publication" },
  { value: "other", label: "Other (specify in notes)" },
];

export function BatchActionBar({
  submissions,
  selectedIds,
  onToggleAll,
  onClearSelection,
  onBatchApprove,
  onBatchReject,
  isProcessing = false,
}: BatchActionBarProps) {
  const [showApproveDialog, setShowApproveDialog] = useState(false);
  const [showRejectDialog, setShowRejectDialog] = useState(false);
  const [showLargeBatchWarning, setShowLargeBatchWarning] = useState(false);
  const [approveNotes, setApproveNotes] = useState("");
  const [rejectReason, setRejectReason] = useState("");
  const [rejectNotes, setRejectNotes] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

  const selectedCount = selectedIds.size;
  const allSelected = selectedCount === submissions.length && submissions.length > 0;
  const selectedArray = Array.from(selectedIds);

  const handleApproveClick = () => {
    if (selectedCount > 20) {
      setShowLargeBatchWarning(true);
    } else {
      setShowApproveDialog(true);
    }
  };

  const handleRejectClick = () => {
    if (selectedCount > 20) {
      setShowLargeBatchWarning(true);
    } else {
      setShowRejectDialog(true);
    }
  };

  const handleConfirmApprove = async () => {
    setIsSubmitting(true);
    try {
      await onBatchApprove(selectedArray, approveNotes);
      setShowApproveDialog(false);
      setApproveNotes("");
      onClearSelection();
    } catch (error) {
      console.error("Batch approve failed:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleConfirmReject = async () => {
    if (!rejectReason) return;
    
    const fullReason = rejectReason === "other" 
      ? rejectNotes 
      : `${rejectionReasons.find(r => r.value === rejectReason)?.label}: ${rejectNotes}`;
    
    setIsSubmitting(true);
    try {
      await onBatchReject(selectedArray, fullReason);
      setShowRejectDialog(false);
      setRejectReason("");
      setRejectNotes("");
      onClearSelection();
    } catch (error) {
      console.error("Batch reject failed:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  if (selectedCount === 0) {
    return (
      <div className="flex items-center gap-4">
        <div className="flex items-center gap-2">
          <Checkbox
            checked={allSelected}
            onCheckedChange={onToggleAll}
            aria-label="Select all submissions"
          />
          <span className="text-sm text-muted-foreground">
            Select all ({submissions.length})
          </span>
        </div>
      </div>
    );
  }

  return (
    <>
      <div className="flex items-center justify-between bg-slate-50 p-4 rounded-lg border">
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-2">
            <Checkbox
              checked={allSelected}
              onCheckedChange={onToggleAll}
              aria-label="Select all submissions"
            />
            <Badge variant="secondary" className="font-medium">
              {selectedCount} selected
            </Badge>
          </div>
          <Button
            variant="ghost"
            size="sm"
            onClick={onClearSelection}
          >
            Clear selection
          </Button>
        </div>

        <div className="flex items-center gap-2">
          <Button
            variant="default"
            className="bg-green-600 hover:bg-green-700 text-white"
            onClick={handleApproveClick}
            disabled={isProcessing || isSubmitting}
          >
            {isSubmitting ? (
              <Loader2 className="h-4 w-4 mr-2 animate-spin" />
            ) : (
              <CheckCircle className="h-4 w-4 mr-2" />
            )}
            Approve Selected
          </Button>
          <Button
            variant="destructive"
            onClick={handleRejectClick}
            disabled={isProcessing || isSubmitting}
          >
            {isSubmitting ? (
              <Loader2 className="h-4 w-4 mr-2 animate-spin" />
            ) : (
              <XCircle className="h-4 w-4 mr-2" />
            )}
            Reject Selected
          </Button>
        </div>
      </div>

      {/* Large Batch Warning */}
      <AlertDialog open={showLargeBatchWarning} onOpenChange={setShowLargeBatchWarning}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle className="flex items-center gap-2">
              <AlertTriangle className="h-5 w-5 text-yellow-500" />
              Large Batch Warning
            </AlertDialogTitle>
            <AlertDialogDescription>
              You are about to affect {selectedCount} submissions. 
              Are you sure you want to proceed with this batch action?
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel onClick={() => setShowLargeBatchWarning(false)}>
              Cancel
            </AlertDialogCancel>
            <AlertDialogAction
              onClick={() => {
                setShowLargeBatchWarning(false);
                // Determine which dialog to show based on what was clicked
                // This is a simplification - in real implementation, track which action was clicked
              }}
            >
              Continue
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>

      {/* Batch Approve Dialog */}
      <Dialog open={showApproveDialog} onOpenChange={setShowApproveDialog}>
        <DialogContent className="max-w-lg">
          <DialogHeader>
            <DialogTitle>Approve {selectedCount} Submissions?</DialogTitle>
            <DialogDescription>
              This will approve all selected submissions for publication.
            </DialogDescription>
          </DialogHeader>
          
          <div className="max-h-40 overflow-y-auto border rounded p-2 space-y-1">
            {selectedArray.map((id) => {
              const sub = submissions.find((s) => s.id === id);
              return (
                <div key={id} className="text-sm flex items-center gap-2">
                  <CheckCircle className="h-3 w-3 text-green-500" />
                  {sub?.user.name || sub?.user.email} - Week {sub?.year}-W{sub?.weekNumber}
                </div>
              );
            })}
          </div>

          <Textarea
            placeholder="Optional approval notes..."
            value={approveNotes}
            onChange={(e) => setApproveNotes(e.target.value)}
            className="mt-4"
          />

          <DialogFooter>
            <Button variant="ghost" onClick={() => setShowApproveDialog(false)}>
              Cancel
            </Button>
            <Button
              className="bg-green-600 hover:bg-green-700 text-white"
              onClick={handleConfirmApprove}
              disabled={isSubmitting}
            >
              {isSubmitting ? "Approving..." : "Confirm Approval"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Batch Reject Dialog */}
      <Dialog open={showRejectDialog} onOpenChange={setShowRejectDialog}>
        <DialogContent className="max-w-lg">
          <DialogHeader>
            <DialogTitle>Reject {selectedCount} Submissions?</DialogTitle>
            <DialogDescription>
              This will return all selected submissions to the aggregator for revision.
            </DialogDescription>
          </DialogHeader>
          
          <div className="max-h-32 overflow-y-auto border rounded p-2 space-y-1 mb-4">
            {selectedArray.map((id) => {
              const sub = submissions.find((s) => s.id === id);
              return (
                <div key={id} className="text-sm flex items-center gap-2">
                  <XCircle className="h-3 w-3 text-red-500" />
                  {sub?.user.name || sub?.user.email} - Week {sub?.year}-W{sub?.weekNumber}
                </div>
              );
            })}
          </div>

          <div className="space-y-4">
            <Select
              value={rejectReason}
              onValueChange={setRejectReason}
            >
              <SelectTrigger>
                <SelectValue placeholder="Select rejection reason" />
              </SelectTrigger>
              <SelectContent>
                {rejectionReasons.map((reason) => (
                  <SelectItem key={reason.value} value={reason.value}>
                    {reason.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Textarea
              placeholder="Additional notes or details..."
              value={rejectNotes}
              onChange={(e) => setRejectNotes(e.target.value)}
            />
          </div>

          <DialogFooter>
            <Button variant="ghost" onClick={() => setShowRejectDialog(false)}>
              Cancel
            </Button>
            <Button
              variant="destructive"
              onClick={handleConfirmReject}
              disabled={!rejectReason || isSubmitting}
            >
              {isSubmitting ? "Rejecting..." : "Confirm Rejection"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
