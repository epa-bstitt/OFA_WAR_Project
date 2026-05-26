"use client";

import { useMemo, useState, useRef } from "react";
import { Download, Settings2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

type ExportContractOption = {
  id: string;
  name: string;
  category: "recompetes" | "outlook";
};


interface WarOverviewExportControlsProps {
  contracts: ExportContractOption[];
  currentPeriodId: string;
}


export function WarOverviewExportControls({ contracts, currentPeriodId }: WarOverviewExportControlsProps) {

  const [open, setOpen] = useState(false);
  const [includeSections, setIncludeSections] = useState<{ [key: string]: boolean }>({
    recompetes: true,
    outlook: true,
  });
  // Remember contract selection per section while modal is open
  const contractSelectionRef = useRef<{ [key: string]: Set<string> }>({
    recompetes: new Set(contracts.filter(c => c.category === "recompetes").map(c => c.id)),
    outlook: new Set(contracts.filter(c => c.category === "outlook").map(c => c.id)),
  });
  // Flat selected contract ids for visible contracts
  const [selectedContractIds, setSelectedContractIds] = useState<string[]>(contracts.map((contract) => contract.id));



  // Dynamically filter contracts for each section based on the current period
  const contractsBySection = useMemo(() => {
    return {
      recompetes: contracts.filter(
        (c) => c.category === "recompetes" && c.periodId === currentPeriodId
      ),
      outlook: contracts.filter(
        (c) => c.category === "outlook" && c.periodId === currentPeriodId
      ),
    };
  }, [contracts, currentPeriodId]);

  // Only show contracts from selected sections and current period
  const selectableContracts = useMemo(() => {
    let filtered: ExportContractOption[] = [];
    if (includeSections.recompetes) filtered = filtered.concat(contractsBySection.recompetes);
    if (includeSections.outlook) filtered = filtered.concat(contractsBySection.outlook);
    return filtered.sort((a, b) => a.name.localeCompare(b.name));
  }, [contractsBySection, includeSections]);

  const selectedContractSet = useMemo(() => new Set(selectedContractIds), [selectedContractIds]);
  const allSelected = selectableContracts.length > 0 && selectedContractIds.length === selectableContracts.length;
  const selectedCount = selectedContractIds.length;


  function toggleContract(contractId: string, checked: boolean) {
    const contract = contracts.find(c => c.id === contractId);
    if (!contract) return;
    const cat = contract.category;
    const selection = new Set(contractSelectionRef.current[cat]);
    if (checked) {
      selection.add(contractId);
    } else {
      selection.delete(contractId);
    }
    contractSelectionRef.current[cat] = selection;
    // If all contracts in this section are deselected, deselect the section
    const sectionContracts = contracts.filter(c => c.category === cat);
    if (selection.size === 0) {
      setIncludeSections(prev => ({ ...prev, [cat]: false }));
    } else if (!includeSections[cat]) {
      setIncludeSections(prev => ({ ...prev, [cat]: true }));
    }
    // Only update selectedContractIds for visible contracts
    setSelectedContractIds(
      contracts
        .filter(c => includeSections[c.category] && contractSelectionRef.current[c.category].has(c.id))
        .map(c => c.id)
    );
  }


  function toggleAllContracts(checked: boolean) {
    const visibleIds = selectableContracts.map(c => c.id);
    if (checked) {
      selectableContracts.forEach(c => contractSelectionRef.current[c.category].add(c.id));
      setSelectedContractIds(visibleIds);
      // Ensure all visible sections are selected
      const newSections = { ...includeSections };
      selectableContracts.forEach(c => { newSections[c.category] = true; });
      setIncludeSections(newSections);
    } else {
      selectableContracts.forEach(c => contractSelectionRef.current[c.category].delete(c.id));
      setSelectedContractIds([]);
      // Deselect sections if all contracts in that section are now unselected
      const newSections = { ...includeSections };
      Object.keys(includeSections).forEach(cat => {
        const sectionContracts = contracts.filter(c => c.category === cat);
        if (sectionContracts.every(c => !contractSelectionRef.current[cat].has(c.id))) {
          newSections[cat] = false;
        }
      });
      setIncludeSections(newSections);
    }
  }


  function downloadExport() {
    const includeCategories = Object.keys(includeSections).filter(cat => includeSections[cat]);
    if (includeCategories.length === 0 || selectedContractIds.length === 0) {
      return;
    }
    const params = new URLSearchParams();
    params.set("includeCategories", includeCategories.join(","));
    params.set("contractIds", selectedContractIds.join(","));
    window.location.assign(`/api/approve/export-war-overview?${params.toString()}`);
    // Reset all selections after export
    setTimeout(() => {
      setIncludeSections({ recompetes: true, outlook: true });
      contractSelectionRef.current = {
        recompetes: new Set(contracts.filter(c => c.category === "recompetes").map(c => c.id)),
        outlook: new Set(contracts.filter(c => c.category === "outlook").map(c => c.id)),
      };
      setSelectedContractIds(contracts.map(c => c.id));
    }, 300);
    setOpen(false);
  }

  // Reset all selections when modal closes
  function handleOpenChange(nextOpen: boolean) {
    setOpen(nextOpen);
    if (!nextOpen) {
      setIncludeSections({ recompetes: true, outlook: true });
      contractSelectionRef.current = {
        recompetes: new Set(contracts.filter(c => c.category === "recompetes").map(c => c.id)),
        outlook: new Set(contracts.filter(c => c.category === "outlook").map(c => c.id)),
      };
      setSelectedContractIds(contracts.map(c => c.id));
    }
  }

  // Table section select/clear all
  const allSectionsSelected = Object.values(includeSections).every(Boolean);
  function toggleAllSections(checked: boolean) {
    setIncludeSections({ recompetes: checked, outlook: checked });
    if (checked) {
      contractSelectionRef.current = {
        recompetes: new Set(contracts.filter(c => c.category === "recompetes").map(c => c.id)),
        outlook: new Set(contracts.filter(c => c.category === "outlook").map(c => c.id)),
      };
      setSelectedContractIds(contracts.map(c => c.id));
    } else {
      contractSelectionRef.current = { recompetes: new Set(), outlook: new Set() };
      setSelectedContractIds([]);
    }
  }

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogTrigger asChild>
        <Button type="button" variant="outline" size="sm" className="rounded-full">
          <Settings2 className="mr-1.5 h-3.5 w-3.5" />
          Export
        </Button>
      </DialogTrigger>
      <DialogContent className="max-w-xl">
        <DialogHeader>
          <DialogTitle>Export WAR Overview</DialogTitle>
          <DialogDescription>
            Choose which table sections and contracts to include in the editable Word export for the current bi-weekly period.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-5">
          <div className="space-y-3 rounded-lg border border-slate-200 p-3">
            <div className="flex items-center justify-between gap-2">
              <p className="text-sm font-semibold text-slate-900">Include table sections</p>
              <Button
                type="button"
                variant="ghost"
                size="sm"
                onClick={() => toggleAllSections(!allSectionsSelected)}
              >
                {allSectionsSelected ? "Clear all" : "Select all"}
              </Button>
            </div>
            <div className="flex flex-col gap-2 text-sm text-slate-700">
              <label className="flex items-center gap-2">
                <Checkbox
                  checked={includeSections.recompetes}
                  onCheckedChange={(checked) => {
                    setIncludeSections(prev => ({ ...prev, recompetes: checked === true }));
                    if (checked === true) {
                      contractSelectionRef.current.recompetes = new Set(contracts.filter(c => c.category === "recompetes").map(c => c.id));
                    } else {
                      contractSelectionRef.current.recompetes = new Set();
                    }
                    setSelectedContractIds(
                      contracts
                        .filter(c => includeSections[c.category] && contractSelectionRef.current[c.category].has(c.id))
                        .map(c => c.id)
                    );
                  }}
                />
                <span>New Awards and Recompetes</span>
              </label>
              <label className="flex items-center gap-2">
                <Checkbox
                  checked={includeSections.outlook}
                  onCheckedChange={(checked) => {
                    setIncludeSections(prev => ({ ...prev, outlook: checked === true }));
                    if (checked === true) {
                      contractSelectionRef.current.outlook = new Set(contracts.filter(c => c.category === "outlook").map(c => c.id));
                    } else {
                      contractSelectionRef.current.outlook = new Set();
                    }
                    setSelectedContractIds(
                      contracts
                        .filter(c => includeSections[c.category] && contractSelectionRef.current[c.category].has(c.id))
                        .map(c => c.id)
                    );
                  }}
                />
                <span>Current and Active Contracts/Purchase Order Outlook</span>
              </label>
            </div>
          </div>

          <div className="space-y-3 rounded-lg border border-slate-200 p-3">
            <div className="flex items-center justify-between gap-2">
              <p className="text-sm font-semibold text-slate-900">Include contracts</p>
              <Button
                type="button"
                variant="ghost"
                size="sm"
                onClick={() => toggleAllContracts(!allSelected)}
              >
                {allSelected ? "Clear all" : "Select all"}
              </Button>
            </div>

            <p className="text-xs text-slate-500">{selectedCount} selected</p>

            <div className="max-h-56 space-y-2 overflow-y-auto rounded-md border border-slate-100 p-2">
              {selectableContracts.map((contract) => {
                const checked = selectedContractSet.has(contract.id);
                return (
                  <label key={contract.id} className="flex items-start gap-2 rounded px-1 py-1 hover:bg-slate-50">
                    <Checkbox
                      checked={checked}
                      onCheckedChange={(value) => toggleContract(contract.id, value === true)}
                    />
                    <span className="text-sm text-slate-700">
                      {contract.name}
                      <span className="ml-2 text-xs text-slate-500">({contract.category})</span>
                    </span>
                  </label>
                );
              })}
            </div>
          </div>
        </div>

        <DialogFooter>
          <Button
            type="button"
            onClick={downloadExport}
            disabled={selectedContractIds.length === 0 || !Object.values(includeSections).some(Boolean)}
          >
            <Download className="mr-1.5 h-4 w-4" />
            Download Word Export
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
