"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { AlertCircle, CheckCircle, Clock, FileText } from "lucide-react";

interface ReviewStatsProps {
  pending: number;
  reviewedToday: number;
  overdue: number;
  totalThisWeek: number;
}

export function ReviewStats({
  pending,
  reviewedToday,
  overdue,
  totalThisWeek,
}: ReviewStatsProps) {
  const items = [
    {
      title: "Pending Review",
      value: pending,
      icon: Clock,
      color: "text-blue-600",
      bgColor: "bg-blue-50",
      description: "Awaiting your review",
    },
    {
      title: "Reviewed Today",
      value: reviewedToday,
      icon: CheckCircle,
      color: "text-green-600",
      bgColor: "bg-green-50",
      description: "Your activity today",
    },
    {
      title: "Overdue",
      value: overdue,
      icon: AlertCircle,
      color: "text-red-600",
      bgColor: "bg-red-50",
      description: "> 7 days old",
    },
    {
      title: "This Week",
      value: totalThisWeek,
      icon: FileText,
      color: "text-purple-600",
      bgColor: "bg-purple-50",
      description: "Total submissions",
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
              <div className={`text-2xl font-bold ${item.value > 0 && item.title === "Overdue" ? "text-red-600" : ""}`}>
                {item.value}
              </div>
              <p className="text-xs text-muted-foreground">{item.description}</p>
            </CardContent>
          </Card>
        );
      })}
    </div>
  );
}
