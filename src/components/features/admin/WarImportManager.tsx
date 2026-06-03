"use client";

import { useEffect, useState } from "react";
import { AlertCircle, CheckCircle2, Loader2, Upload } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";

interface ImportSummary {
  filesProcessed: number;
  projectsUpserted: number;
  usersUpserted: number;
  assignmentsCreated: number;
  submissionsCreated: number;
  warnings: string[];
}

interface ImportJobHistoryItem {
  id: string;
  archiveName: string;
  dryRun: boolean;
  status: string;
  filesProcessed: number;
  projectsUpserted: number;
  usersUpserted: number;
  assignmentsCreated: number;
  submissionsCreated: number;
  warnings: string | null;
  errorMessage: string | null;
  createdAt: string;
  completedAt: string | null;
  initiatedBy: {
    id: string;
    name: string | null;
    email: string;
  } | null;
  fileResults: Array<{
    id: string;
    sourcePath: string;
    status: string;
    message: string | null;
  }>;
}

export function WarImportManager() {
  const [zipFile, setZipFile] = useState<File | null>(null);
  const [dryRun, setDryRun] = useState(true);
  const [isUploading, setIsUploading] = useState(false);
  const [isLoadingHistory, setIsLoadingHistory] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [summary, setSummary] = useState<ImportSummary | null>(null);
  const [history, setHistory] = useState<ImportJobHistoryItem[]>([]);

  useEffect(() => {
    void loadHistory();
  }, []);

  async function loadHistory() {
    setIsLoadingHistory(true);
    try {
      const response = await fetch("/api/admin/import", { method: "GET" });
      const payload = await response.json();
      if (!response.ok) {
        setError(payload?.error ?? "Failed to load import history.");
        return;
      }

      setHistory((payload.jobs as ImportJobHistoryItem[]) ?? []);
    } catch (loadError) {
      console.error("Failed to load import history", loadError);
      setError("Failed to load import history.");
    } finally {
      setIsLoadingHistory(false);
    }
  }

  function renderStatusBadge(status: string) {
    if (status === "COMPLETED") {
      return <Badge className="bg-green-600">Completed</Badge>;
    }
    if (status === "FAILED") {
      return <Badge variant="destructive">Failed</Badge>;
    }
    if (status === "RUNNING") {
      return <Badge className="bg-blue-600">Running</Badge>;
    }
    return <Badge variant="secondary">{status}</Badge>;
  }

  async function handleUpload() {
    if (!zipFile) {
      setError("Please choose a ZIP file before running import.");
      return;
    }

    setIsUploading(true);
    setError(null);
    setSummary(null);

    try {
      const formData = new FormData();
      formData.append("archive", zipFile);
      formData.append("dryRun", dryRun ? "true" : "false");

      const response = await fetch("/api/admin/import", {
        method: "POST",
        body: formData,
      });

      const payload = await response.json();
      if (!response.ok) {
        setError(payload?.error ?? "Import failed.");
        return;
      }

      setSummary(payload.summary as ImportSummary);
      await loadHistory();
    } catch (uploadError) {
      console.error("WAR import failed", uploadError);
      setError("Upload failed. Please try again.");
    } finally {
      setIsUploading(false);
    }
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>DOCX ZIP Import</CardTitle>
        <CardDescription>
          Expected format: folders represent categories, DOCX filenames become card titles, and names in parentheses
          become assignees.
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="space-y-2">
          <Label htmlFor="war-import-zip">ZIP archive</Label>
          <Input
            id="war-import-zip"
            type="file"
            accept=".zip,application/zip"
            onChange={(event) => setZipFile(event.target.files?.[0] ?? null)}
          />
        </div>

        <div className="flex items-center gap-2">
          <Checkbox
            id="war-import-dry-run"
            checked={dryRun}
            onCheckedChange={(checked) => setDryRun(Boolean(checked))}
          />
          <Label htmlFor="war-import-dry-run">Dry run only (no database writes)</Label>
        </div>

        <Button onClick={handleUpload} disabled={isUploading || !zipFile}>
          {isUploading ? <Loader2 className="mr-2 h-4 w-4 animate-spin" /> : <Upload className="mr-2 h-4 w-4" />}
          {isUploading ? "Processing..." : "Run Import"}
        </Button>

        {error ? (
          <Alert variant="destructive">
            <AlertCircle className="h-4 w-4" />
            <AlertTitle>Import failed</AlertTitle>
            <AlertDescription>{error}</AlertDescription>
          </Alert>
        ) : null}

        {summary ? (
          <Alert>
            <CheckCircle2 className="h-4 w-4" />
            <AlertTitle>Import completed</AlertTitle>
            <AlertDescription>
              Processed {summary.filesProcessed} DOCX file(s), upserted {summary.projectsUpserted} project(s), upserted{" "}
              {summary.usersUpserted} user(s), created {summary.assignmentsCreated} assignment(s), and created{" "}
              {summary.submissionsCreated} submission(s).
              {summary.warnings.length > 0 ? ` Warnings: ${summary.warnings.join(" | ")}` : ""}
            </AlertDescription>
          </Alert>
        ) : null}

        <div className="space-y-2">
          <div className="flex items-center justify-between">
            <h3 className="text-sm font-semibold">Past Import Jobs</h3>
            <Button variant="outline" size="sm" onClick={() => void loadHistory()} disabled={isLoadingHistory}>
              {isLoadingHistory ? "Loading..." : "Refresh"}
            </Button>
          </div>

          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Started</TableHead>
                <TableHead>Archive</TableHead>
                <TableHead>Status</TableHead>
                <TableHead>Mode</TableHead>
                <TableHead>Files</TableHead>
                <TableHead>Projects</TableHead>
                <TableHead>Users</TableHead>
                <TableHead>Assignments</TableHead>
                <TableHead>Submissions</TableHead>
                <TableHead>Failures</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {history.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={10} className="text-center text-muted-foreground py-6">
                    {isLoadingHistory ? "Loading import history..." : "No import jobs recorded yet."}
                  </TableCell>
                </TableRow>
              ) : (
                history.map((job) => {
                  const failureCount = job.fileResults.filter((result) => result.status === "FAILED").length;
                  return (
                    <TableRow key={job.id}>
                      <TableCell>{new Date(job.createdAt).toLocaleString()}</TableCell>
                      <TableCell className="max-w-[220px] truncate" title={job.archiveName}>
                        {job.archiveName}
                      </TableCell>
                      <TableCell>{renderStatusBadge(job.status)}</TableCell>
                      <TableCell>{job.dryRun ? "Dry run" : "Apply"}</TableCell>
                      <TableCell>{job.filesProcessed}</TableCell>
                      <TableCell>{job.projectsUpserted}</TableCell>
                      <TableCell>{job.usersUpserted}</TableCell>
                      <TableCell>{job.assignmentsCreated}</TableCell>
                      <TableCell>{job.submissionsCreated}</TableCell>
                      <TableCell>
                        {failureCount > 0 ? (
                          <span className="text-red-600">{failureCount}</span>
                        ) : (
                          <span className="text-muted-foreground">0</span>
                        )}
                      </TableCell>
                    </TableRow>
                  );
                })
              )}
            </TableBody>
          </Table>
        </div>
      </CardContent>
    </Card>
  );
}