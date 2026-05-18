import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { ContractManager } from "@/components/features/contracts/ContractManager";
import { auth } from "@/lib/auth";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { getContractsOutlookFromDb } from "@/lib/contracts-db";

export const metadata: Metadata = {
  title: "Contract Management Section",
  description: "Create and manage active contracts",
};

export const dynamic = "force-dynamic";

export default async function ContractsPage() {
  const session = await auth();
  if (!session?.user) {
    redirect("/login");
  }

  const isProgramOverseer = session.user.role === "PROGRAM_OVERSEER";
  if (isProgramOverseer) {
    redirect("/approve?view=list");
  }

  const hasPermission = await hasMinimumRoleLevel("AGGREGATOR");
  if (!hasPermission) {
    redirect("/dashboard");
  }

  const contracts = await getContractsOutlookFromDb();

  return (
    <div className="space-y-6">
      <PageHeader
        title="Contract Management Section"
        description="Create, edit, and delete active contracts. Click any contract name to view high-level details and linked WAR entries."
        quickLinks={[{ label: "WAR Review", href: "/review" }]}
      />
      <ContractManager initialContracts={contracts} />
    </div>
  );
}
