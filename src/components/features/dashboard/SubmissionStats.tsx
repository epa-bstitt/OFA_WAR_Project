"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import type { SubmissionWithReviews } from "@/app/actions/submissions";
import { FileText, Clock, CheckCircle, BookOpen } from "lucide-react";

interface SubmissionStatsProps {
  submissions: SubmissionWithReviews[];
}

export function SubmissionStats({ submissions }: SubmissionStatsProps) {
  const currentYear = new Date().getFullYear();
  
  const yearSubmissions = submissions.filter(
    (s) => new Date(s.createdAt).getFullYear() === currentYear
  );

  const stats = {
    total: yearSubmissions.length,
    pending: yearSubmissions.filter((s) => s.status === "SUBMITTED" || s.status === "IN_REVIEW").length,
    approved: yearSubmissions.filter((s) => s.status === "APPROVED").length,
    published: yearSubmissions.filter((s) => s.status === "PUBLISHED").length,
  };

  const items = [
    {
      title: "Total Submissions",
      value: stats.total,
      icon: FileText,
      color: "text-blue-600",
      bgColor: "bg-blue-50",
    },
    {
      title: "Pending Review",
      value: stats.pending,
      icon: Clock,
      color: "text-yellow-600",
      bgColor: "bg-yellow-50",
    },
    {
      title: "Approved",
      value: stats.approved,
      icon: CheckCircle,
      color: "text-green-600",
      bgColor: "bg-green-50",
    },
    {
      title: "Published",
      value: stats.published,
      icon: BookOpen,
      color: "text-purple-600",
      bgColor: "bg-purple-50",
    },
  ];

  return (
    <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
      {items.map((item) => {
        const Icon = item.icon;
        return (
          <Card key={item.title}>
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">
                {item.title}
              </CardTitle>
              <div className={`${item.bgColor} p-2 rounded-md`}>
                <Icon className={`h-4 w-4 ${item.color}`} />
              </div>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{item.value}</div>
              <p className="text-xs text-muted-foreground">{currentYear}</p>
            </CardContent>
          </Card>
        );
      })}
    </div>
  );
}
