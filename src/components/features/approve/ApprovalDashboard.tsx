"use client";

import { useState } from "react";
import Link from "next/link";
import { format } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import type { SubmissionWithReviews } from "@/app/actions/approve";
import { BatchActionBar } from "./BatchActionBar";
import {
  MoreHorizontal,
  CheckCircle,
  XCircle,
  Download,
  FileSpreadsheet,
  Eye,
  ChevronDown,
  ChevronUp,
} from "lucide-react";

interface ApprovalDashboardProps {
  submissions: SubmissionWithReviews[];
  stats: {
    totalInReview: number;
    approvedThisWeek: number;
    pendingCount: number;
    averageReviewTime: number;
  };
  onApprove: (id: string, notes?: string) => Promise<void>;
  onReject: (id: string, reason: string) => Promise<void>;
  onBatchApprove?: (ids: string[], notes?: string) => Promise<void>;
  onBatchReject?: (ids: string[], reason: string) => Promise<void>;
  onExport: (ids?: string[]) => Promise<{ csv: string; filename: string } | null>;
}

export function ApprovalDashboard({
  submissions,
  stats,
  onApprove,
  onReject,
  onBatchApprove,
  onBatchReject,
  onExport,
}: ApprovalDashboardProps) {
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [rejectId, setRejectId] = useState<string | null>(null);
  const [rejectReason, setRejectReason] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isExporting, setIsExporting] = useState(false);

  const toggleSelection = (id: string) => {
    const newSet = new Set(selectedIds);
    if (newSet.has(id)) {
      newSet.delete(id);
    } else {
      newSet.add(id);
    }
    setSelectedIds(newSet);
  };

  const toggleAll = () => {
    if (selectedIds.size === submissions.length) {
      setSelectedIds(new Set());
    } else {
      setSelectedIds(new Set(submissions.map((s) => s.id)));
    }
  };

  const handleApprove = async (id: string) => {
    setIsSubmitting(true);
    try {
      await onApprove(id);
    } catch (error) {
      console.error("Failed to approve:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleReject = async () => {
    if (!rejectId || !rejectReason.trim()) return;
    setIsSubmitting(true);
    try {
      await onReject(rejectId, rejectReason);
      setRejectId(null);
      setRejectReason("");
    } catch (error) {
      console.error("Failed to reject:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleExport = async () => {
    setIsExporting(true);
    try {
      const selectedArray = Array.from(selectedIds);
      const result = await onExport(selectedArray.length > 0 ? selectedArray : undefined);
      if (result) {
        // Download CSV
        const blob = new Blob([result.csv], { type: "text/csv;charset=utf-8;" });
        const link = document.createElement("a");
        link.href = URL.createObjectURL(blob);
        link.download = result.filename;
        link.click();
      }
    } catch (error) {
      console.error("Failed to export:", error);
    } finally {
      setIsExporting(false);
    }
  };

  const hasEdits = (submission: SubmissionWithReviews) => {
    const review = submission.reviews[0];
    if (!review) return false;
    return review.editedTerseVersion && review.editedTerseVersion !== review.aiTerseVersion;
  };

  if (submissions.length === 0) {
    return (
      <div className="space-y-6">
        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">
                Awaiting Approval
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold">{stats.totalInReview}</div>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">
                Approved This Week
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold text-green-600">
                {stats.approvedThisWeek}
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">
                Pending Review
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold text-yellow-600">
                {stats.pendingCount}
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">
                Avg Review Time
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold">
                {stats.averageReviewTime}h
              </div>
            </CardContent>
          </Card>
        </div>

        <Card>
          <CardContent className="py-12 text-center">
              <CheckCircle className="h-12 w-12 text-green-500 mx-auto mb-4" />
            <h3 className="text-lg font-semibold mb-2">
              All Caught Up!
            </h3>
            <p className="text-muted-foreground">
              No submissions are currently awaiting approval.
            </p>
            <p className="text-sm text-muted-foreground mt-2">
              You've approved {stats.approvedThisWeek} WARs this week.
            </p>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Awaiting Approval
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{stats.totalInReview}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Approved This Week
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-green-600">
              {stats.approvedThisWeek}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Pending Review
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-yellow-600">
              {stats.pendingCount}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Avg Review Time
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">
              {stats.averageReviewTime}h
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Batch Actions */}
      {onBatchApprove && onBatchReject && (
        <BatchActionBar
          submissions={submissions}
          selectedIds={selectedIds}
          onToggleAll={toggleAll}
          onClearSelection={() => setSelectedIds(new Set())}
          onBatchApprove={onBatchApprove}
          onBatchReject={onBatchReject}
          isProcessing={isSubmitting}
        />
      )}

      {/* Actions */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Button
            variant="outline"
            onClick={handleExport}
            disabled={isExporting}
          >
            <Download className="h-4 w-4 mr-2" />
            {isExporting ? "Exporting..." : "Export CSV"}
          </Button>
          {selectedIds.size > 0 && (
            <Badge variant="secondary">
              {selectedIds.size} selected
            </Badge>
          )}
        </div>
      </div>

      {/* Submissions Table */}
      <Card>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-[40px]">
                <Checkbox
                  checked={selectedIds.size === submissions.length && submissions.length > 0}
                  onCheckedChange={toggleAll}
                />
              </TableHead>
              <TableHead>Contributor</TableHead>
              <TableHead>Week</TableHead>
              <TableHead>Status</TableHead>
              <TableHead>Reviewer</TableHead>
              <TableHead>AI Confidence</TableHead>
              <TableHead>Edits</TableHead>
              <TableHead className="w-[120px]">Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {submissions.map((submission) => {
              const review = submission.reviews[0];
              const isExpanded = expandedId === submission.id;
              const edited = hasEdits(submission);

              return (
                <>
                  <TableRow key={submission.id}>
                    <TableCell>
                      <Checkbox
                        checked={selectedIds.has(submission.id)}
                        onCheckedChange={() => toggleSelection(submission.id)}
                      />
                    </TableCell>
                    <TableCell>
                      <div className="font-medium">
                        {submission.user.name || submission.user.email}
                      </div>
                      <div className="text-sm text-muted-foreground">
                        {submission.user.email}
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline">
                        {submission.year}-W{submission.weekNumber.toString().padStart(2, "0")}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge className="bg-blue-100 text-blue-800 hover:bg-blue-100">
                        In Review
                      </Badge>
                    </TableCell>
                    <TableCell>
                      {review?.reviewer.name || review?.reviewer.email || "N/A"}
                    </TableCell>
                    <TableCell>
                      {submission.aiConfidence ? (
                        <Badge
                          variant={submission.aiConfidence > 0.8 ? "default" : "secondary"}
                        >
                          {(submission.aiConfidence * 100).toFixed(0)}%
                        </Badge>
                      ) : (
                        <span className="text-muted-foreground">N/A</span>
                      )}
                    </TableCell>
                    <TableCell>
                      {edited ? (
                        <Badge variant="outline" className="border-orange-300 text-orange-700">
                          Edited
                        </Badge>
                      ) : (
                        <span className="text-muted-foreground text-sm">None</span>
                      )}
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        <Button
                          variant="ghost"
                          size="icon"
                          onClick={() => setExpandedId(isExpanded ? null : submission.id)}
                        >
                          {isExpanded ? (
                            <ChevronUp className="h-4 w-4" />
                          ) : (
                            <ChevronDown className="h-4 w-4" />
                          )}
                        </Button>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="icon">
                              <MoreHorizontal className="h-4 w-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem asChild>
                              <Link href={`/approve/${submission.id}`}>
                                <Eye className="h-4 w-4 mr-2" />
                                View Details
                              </Link>
                            </DropdownMenuItem>
                            <DropdownMenuItem
                              onClick={() => handleApprove(submission.id)}
                              disabled={isSubmitting}
                              className="text-green-600 focus:text-green-600"
                            >
                              <CheckCircle className="h-4 w-4 mr-2" />
                              Approve
                            </DropdownMenuItem>
                            <DropdownMenuItem
                              onClick={() => setRejectId(submission.id)}
                              className="text-red-600 focus:text-red-600"
                            >
                              <XCircle className="h-4 w-4 mr-2" />
                              Reject
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </TableCell>
                  </TableRow>
                  {isExpanded && (
                    <TableRow key={`${submission.id}-expanded`}>
                      <TableCell colSpan={8} className="bg-slate-50">
                        <div className="py-4 space-y-4">
                          <div className="grid grid-cols-2 gap-4">
                            <div>
                              <h4 className="text-sm font-medium mb-2">Raw Text</h4>
                              <div className="bg-white p-3 rounded border text-sm max-h-40 overflow-y-auto">
                                {submission.rawText}
                              </div>
                            </div>
                            <div>
                              <h4 className="text-sm font-medium mb-2">Final Terse Version</h4>
                              <div className="bg-white p-3 rounded border text-sm max-h-40 overflow-y-auto">
                                {submission.terseText || "N/A"}
                              </div>
                            </div>
                          </div>
                          {edited && review && (
                            <div>
                              <h4 className="text-sm font-medium mb-2">Edit History</h4>
                              <div className="grid grid-cols-2 gap-4">
                                <div className="bg-white p-3 rounded border text-sm">
                                  <div className="text-xs text-muted-foreground mb-1">
                                    AI Output
                                  </div>
                                  {review.aiTerseVersion || "N/A"}
                                </div>
                                <div className="bg-white p-3 rounded border text-sm">
                                  <div className="text-xs text-muted-foreground mb-1">
                                    After Edits
                                  </div>
                                  {review.editedTerseVersion || "N/A"}
                                </div>
                              </div>
                              {review.notes && (
                                <div className="mt-2 text-sm">
                                  <span className="font-medium">Reviewer Notes:</span>{" "}
                                  {review.notes}
                                </div>
                              )}
                            </div>
                          )}
                          <div className="text-sm text-muted-foreground">
                            Submitted: {format(new Date(submission.createdAt), "MMM d, yyyy h:mm a")}
                          </div>
                        </div>
                      </TableCell>
                    </TableRow>
                  )}
                </>
              );
            })}
          </TableBody>
        </Table>
      </Card>

      {/* Reject Dialog */}
      <Dialog open={!!rejectId} onOpenChange={() => setRejectId(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Reject Submission</DialogTitle>
            <DialogDescription>
              Please provide a reason for rejecting this submission. This will be sent back to the aggregator for revision.
            </DialogDescription>
          </DialogHeader>
          <Textarea
            placeholder="Enter rejection reason..."
            value={rejectReason}
            onChange={(e) => setRejectReason(e.target.value)}
            className="min-h-[100px]"
          />
          <DialogFooter>
            <Button variant="ghost" onClick={() => setRejectId(null)}>
              Cancel
            </Button>
            <Button
              variant="destructive"
              onClick={handleReject}
              disabled={!rejectReason.trim() || isSubmitting}
            >
              {isSubmitting ? "Rejecting..." : "Reject"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
