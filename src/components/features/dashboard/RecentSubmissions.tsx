import Link from "next/link";
import { format } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { StatusBadge } from "@/components/features/submissions/StatusBadge";
import type { SubmissionWithReviews } from "@/app/actions/submissions";
import { ChevronRight } from "lucide-react";

interface RecentSubmissionsProps {
  submissions: SubmissionWithReviews[];
}

export function RecentSubmissions({ submissions }: RecentSubmissionsProps) {
  const recentSubmissions = submissions.slice(0, 5);

  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between pb-2">
        <CardTitle className="text-lg">Recent Submissions</CardTitle>
        <Link href="/submissions">
          <Button variant="ghost" size="sm">
            View All
            <ChevronRight className="ml-1 h-4 w-4" />
          </Button>
        </Link>
      </CardHeader>
      <CardContent>
        {recentSubmissions.length === 0 ? (
          <p className="text-sm text-muted-foreground text-center py-4">
            No submissions yet.
          </p>
        ) : (
          <div className="space-y-3">
            {recentSubmissions.map((submission) => (
              <Link
                key={submission.id}
                href={`/submissions/${submission.id}`}
                className="flex items-center justify-between p-3 rounded-lg hover:bg-slate-50 transition-colors"
              >
                <div className="space-y-1">
                  <div className="flex items-center gap-2">
                    <StatusBadge status={submission.status} />
                    <span className="text-sm font-medium">
                      Week of {format(new Date(submission.weekOf), "MMM d, yyyy")}
                    </span>
                  </div>
                  <p className="text-xs text-muted-foreground">
                    {format(new Date(submission.createdAt), "MMM d, yyyy 'at' h:mm a")}
                  </p>
                </div>
                <ChevronRight className="h-4 w-4 text-muted-foreground" />
              </Link>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
