import Link from "next/link";
import { Pencil, Trash2 } from "lucide-react";
import type { MockContract } from "@/lib/mock-contracts";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

interface NewAwardsRecompetesTableProps {
  contracts: MockContract[];
  getAssigneeLabel?: (contract: MockContract) => string;
  getAssigneeDetails?: (contract: MockContract) => Array<{ name: string; email: string }>;
  onEdit: (contract: MockContract) => void;
  onDelete: (contractId: string) => void;
  onMove?: (contractId: string, targetTab: "outlook" | "recompetes" | "legacy") => void;
  moveTargets?: Array<{
    value: "outlook" | "recompetes" | "legacy";
    label: string;
  }>;
  isDeleting?: boolean;
}

export function NewAwardsRecompetesTable({
  contracts,
  getAssigneeLabel,
  onEdit,
  onDelete,
  onMove,
  moveTargets = [],
  isDeleting = false,
}: NewAwardsRecompetesTableProps) {
  return (
    <div className="rounded-xl border border-slate-200 bg-white shadow-sm">
      <div className="max-h-[560px] overflow-auto">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Upcoming Procurement</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Assigned To</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Begin ITOD Engagement</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">CGER</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">SRO</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">FITARA</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Acquisition Planning Complete</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Solicitation Issue</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Proposal Received</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Award Complete</TableHead>
            <TableHead className="sticky right-0 top-0 z-20 w-[360px] bg-slate-50 text-right">Actions</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {contracts.length === 0 ? (
            <TableRow>
              <TableCell colSpan={11} className="text-sm text-slate-500">
                No new awards or recompetes match your current view. Adjust filters or use New Contract to add one.
              </TableCell>
            </TableRow>
          ) : (
            contracts.map((contract) => (
              <TableRow key={contract.id}>
                <TableCell className="font-medium">
                  <Link
                    href={`/contracts/${contract.id}/wars`}
                    className="text-[#005ea2] underline-offset-2 hover:underline"
                  >
                    {contract.contractName}
                  </Link>
                </TableCell>
                <TableCell>{getAssigneeLabel ? getAssigneeLabel(contract) : "Unassigned"}</TableCell>
                <TableCell>{contract.activeContract.paltBeginOitoEngagement || contract.activeContract.co || "-"}</TableCell>
                <TableCell>{contract.activeContract.contractNumber || "-"}</TableCell>
                <TableCell>{contract.activeContract.cs || "-"}</TableCell>
                <TableCell>{contract.activeContract.orderNumber || "-"}</TableCell>
                <TableCell>{contract.activeContract.nextPeriodOfPerf || "-"}</TableCell>
                <TableCell>{contract.activeContract.office || "-"}</TableCell>
                <TableCell>{contract.activeContract.ultimateCompletionDate || "-"}</TableCell>
                <TableCell>{contract.activeContract.paltOitoEngagement || "-"}</TableCell>
                <TableCell className="sticky right-0 bg-white">
                  <div className="flex items-center justify-end gap-2">
                    <Button type="button" variant="ghost" size="sm" onClick={() => onEdit(contract)}>
                      <Pencil className="mr-1 h-3.5 w-3.5" />
                      Edit
                    </Button>
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      onClick={() => onDelete(contract.id)}
                      disabled={isDeleting}
                    >
                      <Trash2 className="mr-1 h-3.5 w-3.5" />
                      Delete
                    </Button>
                    {onMove && moveTargets.length > 0 && (
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button type="button" variant="outline" size="sm">
                            Move
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          {moveTargets.map((target) => (
                            <DropdownMenuItem
                              key={target.value}
                              onSelect={(event) => {
                                event.preventDefault();
                                onMove(contract.id, target.value);
                              }}
                            >
                              {target.label}
                            </DropdownMenuItem>
                          ))}
                        </DropdownMenuContent>
                      </DropdownMenu>
                    )}
                  </div>
                </TableCell>
              </TableRow>
            ))
          )}
        </TableBody>
      </Table>
      </div>
    </div>
  );
}
