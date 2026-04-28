import { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { Plus, Settings } from "lucide-react";
import { PageHeader } from "@/components/shared/PageHeader";
import { Button } from "@/components/ui/button";
import { ContractsOutlookTable } from "@/components/features/contracts/ContractsOutlookTable";
import { auth } from "@/lib/auth";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { getContractsOutlook } from "@/lib/mock-contracts";

export const metadata: Metadata = {
  title: "Current and Active Contracts/Purchase Order Outlook",
  description: "High-level contract details and linked WAR history",
};

export const dynamic = "force-dynamic";

export default async function ContractsOutlookPage() {
  const session = await auth();
  if (!session?.user) {
    redirect("/login");
  }

  const hasPermission = await hasMinimumRoleLevel("AGGREGATOR");
  if (!hasPermission) {
    redirect("/dashboard");
  }

  const contracts = getContractsOutlook();

  return (
    <div className="space-y-6">
      <PageHeader
        title="Current and Active Contracts/Purchase Order Outlook"
        description="Table view of active contract details. Contract names open all WAR entries submitted for that contract."
      >
        <Link href="/contracts">
          <Button variant="outline">
            <Plus className="mr-2 h-4 w-4" />
            Create Contract
          </Button>
        </Link>
        <Link href="/contracts">
          <Button>
            <Settings className="mr-2 h-4 w-4" />
            Manage Contracts
          </Button>
        </Link>
      </PageHeader>

      <ContractsOutlookTable contracts={contracts} />
    </div>
  );
}
