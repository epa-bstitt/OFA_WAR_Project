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
  getAssigneeDetails,
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
            <TableHead className="sticky top-0 z-10 bg-slate-50">Contract End Date</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">PALT Start</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Submit APP (PALT + 2 weeks)</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Engagement Meeting</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Submit SRO (APP + 2 weeks)</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Submit CGER (SRO + 2 weeks)</TableHead>
            <TableHead className="sticky top-0 z-10 bg-slate-50">Notes</TableHead>
            <TableHead className="sticky right-0 top-0 z-20 w-[360px] bg-slate-50 text-right">Actions</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {contracts.length === 0 ? (
            <TableRow>
              <TableCell colSpan={10} className="text-sm text-slate-500">
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
                <TableCell>
                  {(() => {
                    const details = getAssigneeDetails?.(contract) || [];

                    if (details.length === 0) {
                      return (
                        <span className="inline-flex rounded-full bg-slate-100 px-2.5 py-1 text-xs font-medium text-slate-700">
                          {getAssigneeLabel?.(contract) || "Unassigned"}
                        </span>
                      );
                    }

                    return (
                      <div className="flex flex-wrap gap-1">
                        {details.map((assignee, index) => (
                          <span
                            key={`${contract.id}-${assignee.email || assignee.name}-${index}`}
                            title={assignee.email}
                            className="inline-flex rounded-full bg-amber-100 px-2.5 py-1 text-xs font-medium text-amber-800"
                          >
                            {assignee.name}
                          </span>
                        ))}
                      </div>
                    );
                  })()}
                </TableCell>
                <TableCell>{contract.activeContract.ultimateCompletionDate || "-"}</TableCell>
                <TableCell>{contract.activeContract.nextPeriodOfPerf || "-"}</TableCell>
                <TableCell>{contract.activeContract.cor || "-"}</TableCell>
                <TableCell>{contract.activeContract.co || "-"}</TableCell>
                <TableCell>{contract.activeContract.cs || "-"}</TableCell>
                <TableCell>{contract.activeContract.contractNumber || "-"}</TableCell>
                <TableCell>{contract.activeContract.office || "-"}</TableCell>
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
