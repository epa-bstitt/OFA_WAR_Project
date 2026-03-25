import { Metadata } from "next";
import Link from "next/link";
import { CheckCircle, FileText, List, LayoutDashboard } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";

export const metadata: Metadata = {
  title: "WAR Submitted Successfully",
  description: "Your weekly activity report has been submitted",
};

export const dynamic = "force-dynamic";

export default function SubmissionSuccessPage() {
  return (
    <Card className="w-full max-w-md mx-auto">
      <CardHeader className="text-center">
        <div className="flex justify-center mb-4">
          <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center">
            <CheckCircle className="h-8 w-8 text-green-600" />
          </div>
        </div>
        <CardTitle className="text-2xl">WAR Submitted!</CardTitle>
        <CardDescription>
          Your weekly activity report has been submitted successfully and is now pending review.
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-3">
        <Link href="/submit" className="block">
          <Button variant="outline" className="w-full">
            <FileText className="mr-2 h-4 w-4" />
            Submit Another WAR
          </Button>
        </Link>
        <Link href="/submissions" className="block">
          <Button variant="outline" className="w-full">
            <List className="mr-2 h-4 w-4" />
            View My Submissions
          </Button>
        </Link>
        <Link href="/dashboard" className="block">
          <Button className="w-full">
            <LayoutDashboard className="mr-2 h-4 w-4" />
            Go to Dashboard
          </Button>
        </Link>
      </CardContent>
    </Card>
  );
}
