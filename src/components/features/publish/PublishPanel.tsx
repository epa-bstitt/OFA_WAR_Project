"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { ExternalLink, BookOpen, Loader2, CheckCircle, AlertCircle } from "lucide-react";
import type { PublicationResult } from "@/app/actions/publish";

interface Submission {
  id: string;
  terseText: string | null;
  year: number;
  weekNumber: number;
  weekOf: Date;
  status: string;
  user: {
    id: string;
    name: string | null;
    email: string;
  };
  aiConfidence: number | null;
  oneNoteUrl: string | null;
  publishedAt: Date | null;
}

interface PublishPanelProps {
  submissions: Submission[];
  sections: Array<{ id: string; displayName: string }>;
  defaultSectionId: string | null;
  onPublish: (submissionIds: string[], sectionId: string) => Promise<{ success: true; results: PublicationResult[]; pageUrls: string[] } | { success: false; error: string }>;
}

export function PublishPanel({
  submissions,
  sections,
  defaultSectionId,
  onPublish,
}: PublishPanelProps) {
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [selectedSection, setSelectedSection] = useState(defaultSectionId || "");
  const [isPublishing, setIsPublishing] = useState(false);
  const [showConfirmDialog, setShowConfirmDialog] = useState(false);
  const [publishResult, setPublishResult] = useState<{
    success: boolean;
    count: number;
    pageUrls: string[];
    error?: string;
  } | null>(null);
  const [showResultDialog, setShowResultDialog] = useState(false);

  const approvedSubmissions = submissions.filter((s) => s.status === "APPROVED");
  const publishedSubmissions = submissions.filter((s) => s.status === "PUBLISHED");

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
    const approvedIds = approvedSubmissions.map((s) => s.id);
    const allSelected = approvedIds.every((id) => selectedIds.has(id));
    
    if (allSelected) {
      // Deselect all approved
      const newSet = new Set(selectedIds);
      approvedIds.forEach((id) => newSet.delete(id));
      setSelectedIds(newSet);
    } else {
      // Select all approved
      const newSet = new Set(selectedIds);
      approvedIds.forEach((id) => newSet.add(id));
      setSelectedIds(newSet);
    }
  };

  const handlePublish = async () => {
    if (selectedIds.size === 0 || !selectedSection) return;
    
    setIsPublishing(true);
    try {
      const result = await onPublish(Array.from(selectedIds), selectedSection);
      
      if (result.success) {
        const successCount = result.results.filter((r) => r.success).length;
        setPublishResult({
          success: true,
          count: successCount,
          pageUrls: result.pageUrls,
        });
        setSelectedIds(new Set());
      } else {
        setPublishResult({
          success: false,
          count: 0,
          pageUrls: [],
          error: result.error,
        });
      }
      setShowResultDialog(true);
    } catch (error) {
      setPublishResult({
        success: false,
        count: 0,
        pageUrls: [],
        error: "Failed to publish",
      });
      setShowResultDialog(true);
    } finally {
      setIsPublishing(false);
      setShowConfirmDialog(false);
    }
  };

  return (
    <div className="space-y-6">
      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Approved & Ready
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-green-600">
              {approvedSubmissions.length}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Already Published
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">
              {publishedSubmissions.length}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Selected for Publish
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-blue-600">
              {selectedIds.size}
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Publish Controls */}
      <Card>
        <CardHeader>
          <CardTitle>Publish to OneNote</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {sections.length === 0 ? (
            <div className="text-center py-8">
              <AlertCircle className="h-12 w-12 text-yellow-500 mx-auto mb-4" />
              <p className="text-muted-foreground">
                No OneNote sections configured. Please set up Microsoft Graph integration.
              </p>
            </div>
          ) : (
            <>
              <div className="flex items-center gap-4">
                <div className="flex-1">
                  <label className="text-sm font-medium mb-2 block">
                    Select OneNote Section
                  </label>
                  <Select
                    value={selectedSection}
                    onValueChange={setSelectedSection}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Choose a section..." />
                    </SelectTrigger>
                    <SelectContent>
                      {sections.map((section) => (
                        <SelectItem key={section.id} value={section.id}>
                          {section.displayName}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div className="pt-6">
                  <Button
                    onClick={() => setShowConfirmDialog(true)}
                    disabled={selectedIds.size === 0 || !selectedSection || isPublishing}
                  >
                    {isPublishing ? (
                      <>
                        <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                        Publishing...
                      </>
                    ) : (
                      <>
                        <BookOpen className="h-4 w-4 mr-2" />
                        Publish {selectedIds.size > 0 && `(${selectedIds.size})`}
                      </>
                    )}
                  </Button>
                </div>
              </div>

              {approvedSubmissions.length === 0 ? (
                <div className="text-center py-8">
                  <CheckCircle className="h-12 w-12 text-green-500 mx-auto mb-4" />
                  <p className="text-muted-foreground">
                    All approved submissions have been published!
                  </p>
                </div>
              ) : (
                <div className="border rounded-lg">
                  <table className="w-full">
                    <thead className="bg-slate-50">
                      <tr>
                        <th className="w-12 p-3">
                          <Checkbox
                            checked={
                              approvedSubmissions.length > 0 &&
                              approvedSubmissions.every((s) => selectedIds.has(s.id))
                            }
                            onCheckedChange={toggleAll}
                          />
                        </th>
                        <th className="text-left p-3 text-sm font-medium">Contributor</th>
                        <th className="text-left p-3 text-sm font-medium">Week</th>
                        <th className="text-left p-3 text-sm font-medium">Status</th>
                        <th className="text-left p-3 text-sm font-medium">OneNote Link</th>
                      </tr>
                    </thead>
                    <tbody>
                      {submissions.map((submission) => (
                        <tr key={submission.id} className="border-t">
                          <td className="p-3">
                            <Checkbox
                              checked={selectedIds.has(submission.id)}
                              onCheckedChange={() => toggleSelection(submission.id)}
                              disabled={submission.status === "PUBLISHED"}
                            />
                          </td>
                          <td className="p-3">
                            <div className="font-medium">
                              {submission.user.name || submission.user.email}
                            </div>
                          </td>
                          <td className="p-3">
                            <Badge variant="outline">
                              {submission.year}-W
                              {submission.weekNumber.toString().padStart(2, "0")}
                            </Badge>
                          </td>
                          <td className="p-3">
                            {submission.status === "PUBLISHED" ? (
                              <Badge className="bg-green-100 text-green-800">
                                Published
                              </Badge>
                            ) : (
                              <Badge className="bg-blue-100 text-blue-800">
                                Approved
                              </Badge>
                            )}
                          </td>
                          <td className="p-3">
                            {submission.oneNoteUrl ? (
                              <a
                                href={submission.oneNoteUrl}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="text-blue-600 hover:underline flex items-center"
                              >
                                <ExternalLink className="h-3 w-3 mr-1" />
                                View
                              </a>
                            ) : (
                              <span className="text-muted-foreground text-sm">-</span>
                            )}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </>
          )}
        </CardContent>
      </Card>

      {/* Confirm Dialog */}
      <Dialog open={showConfirmDialog} onOpenChange={setShowConfirmDialog}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Confirm Publication</DialogTitle>
            <DialogDescription>
              You are about to publish {selectedIds.size} submission(s) to OneNote.
              This action cannot be undone.
            </DialogDescription>
          </DialogHeader>
          <DialogFooter>
            <Button variant="ghost" onClick={() => setShowConfirmDialog(false)}>
              Cancel
            </Button>
            <Button onClick={handlePublish} disabled={isPublishing}>
              {isPublishing ? "Publishing..." : "Confirm Publish"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Result Dialog */}
      <Dialog open={showResultDialog} onOpenChange={setShowResultDialog}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>
              {publishResult?.success ? "Publication Complete" : "Publication Failed"}
            </DialogTitle>
          </DialogHeader>
          {publishResult?.success ? (
            <div className="space-y-4">
              <p className="text-green-600">
                Successfully published {publishResult.count} submission(s).
              </p>
              {publishResult.pageUrls.length > 0 && (
                <div>
                  <p className="text-sm font-medium mb-2">OneNote Pages:</p>
                  <ul className="space-y-1">
                    {publishResult.pageUrls.map((url, idx) => (
                      <li key={idx}>
                        <a
                          href={url}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-blue-600 hover:underline text-sm"
                        >
                          <ExternalLink className="h-3 w-3 inline mr-1" />
                          View Page {idx + 1}
                        </a>
                      </li>
                    ))}
                  </ul>
                </div>
              )}
            </div>
          ) : (
            <p className="text-red-600">{publishResult?.error}</p>
          )}
          <DialogFooter>
            <Button onClick={() => setShowResultDialog(false)}>Close</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
