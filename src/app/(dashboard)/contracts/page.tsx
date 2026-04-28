import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { ContractManager } from "@/components/features/contracts/ContractManager";
import { auth } from "@/lib/auth";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { getContractsOutlook } from "@/lib/mock-contracts";

export const metadata: Metadata = {
  title: "Contracts",
  description: "Create and manage active contracts",
};

export const dynamic = "force-dynamic";

export default async function ContractsPage() {
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
        title="Contracts"
        description="Create, edit, and delete active contracts. Click any contract name to view high-level details and linked WAR entries."
      />
      <ContractManager initialContracts={contracts} />
    </div>
  );
}
