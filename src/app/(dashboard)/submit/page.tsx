import { Metadata } from "next";
import { PageHeader } from "@/components/shared/PageHeader";
import { SubmissionForm } from "@/components/features/submit/SubmissionForm";

export const metadata: Metadata = {
  title: "Submit Weekly Activity Report",
  description: "Submit your weekly status update",
};

export const dynamic = "force-dynamic";

export default function SubmitPage() {
  return (
    <div className="space-y-6">
      <PageHeader
        title="Submit Weekly Activity Report"
        description="Enter your weekly status update below. Your report will be reviewed and approved before publication."
      />
      <SubmissionForm />
    </div>
  );
}
