"use client";

import { useEffect, useMemo, useRef } from "react";
import { useRouter } from "next/navigation";
import { toast } from "sonner";
import type { MockContract } from "@/lib/mock-contracts";

const RECOMPETES_CATEGORY = "New Awards and Recompetes";
const OUTLOOK_CATEGORY = "Current and Active Contracts/Purchase Order Outlook";
const LEGACY_CATEGORY = "Legacy Contracts";

type Audience = "contributor" | "overseer";

interface ContractLifecycleNotifierProps {
  contracts: MockContract[];
  audience: Audience;
  canAutoMove: boolean;
}

function toTimestamp(value: string) {
  const trimmed = value.trim();
  if (!trimmed) {
    return Number.NaN;
  }

  const parsed = new Date(trimmed).getTime();
  return Number.isNaN(parsed) ? Number.NaN : parsed;
}

function getDaysRemaining(endDate: string) {
  const endTs = toTimestamp(endDate);
  if (Number.isNaN(endTs)) {
    return Number.NaN;
  }

  const today = new Date();
  today.setHours(0, 0, 0, 0);
  return Math.ceil((endTs - today.getTime()) / (1000 * 60 * 60 * 24));
}

function getIntervalKey(daysRemaining: number) {
  if (daysRemaining <= 7) {
    return `daily-${daysRemaining}`;
  }

  return `weekly-${Math.ceil(daysRemaining / 7)}`;
}

function getTargetCategory(currentCategory: string) {
  if (currentCategory === RECOMPETES_CATEGORY) {
    return OUTLOOK_CATEGORY;
  }

  if (currentCategory === OUTLOOK_CATEGORY) {
    return LEGACY_CATEGORY;
  }

  return null;
}

function getTransitionLabel(currentCategory: string) {
  if (currentCategory === RECOMPETES_CATEGORY) {
    return "Current and Active Contracts/Purchase Order Outlook";
  }

  if (currentCategory === OUTLOOK_CATEGORY) {
    return "Legacy Contracts";
  }

  return null;
}

export function ContractLifecycleNotifier({ contracts, audience, canAutoMove }: ContractLifecycleNotifierProps) {
  const router = useRouter();
  const inFlightRef = useRef<Set<string>>(new Set());

  const lifecycleContracts = useMemo(
    () =>
      contracts.filter(
        (contract) =>
          contract.category === RECOMPETES_CATEGORY || contract.category === OUTLOOK_CATEGORY
      ),
    [contracts]
  );

  useEffect(() => {
    if (typeof window === "undefined") {
      return;
    }

    const candidates = lifecycleContracts
      .map((contract) => {
        const daysRemaining = getDaysRemaining(contract.activeContract.ultimateCompletionDate);
        if (Number.isNaN(daysRemaining) || daysRemaining <= 0 || daysRemaining > 30) {
          return null;
        }

        const transitionLabel = getTransitionLabel(contract.category);
        if (!transitionLabel) {
          return null;
        }

        const intervalKey = getIntervalKey(daysRemaining);
        const storageKey = [
          "contract-lifecycle-notify",
          audience,
          contract.id,
          contract.category,
          contract.activeContract.ultimateCompletionDate,
          intervalKey,
        ].join(":");

        if (window.localStorage.getItem(storageKey)) {
          return null;
        }

        return {
          contract,
          daysRemaining,
          transitionLabel,
          storageKey,
        };
      })
      .filter((item): item is NonNullable<typeof item> => Boolean(item))
      .sort((a, b) => a.daysRemaining - b.daysRemaining);

    if (candidates.length === 0) {
      return;
    }

    const message = candidates
      .map(
        ({ contract, daysRemaining, transitionLabel }) =>
          `${contract.contractName}: ${contract.activeContract.ultimateCompletionDate} (${daysRemaining} day${daysRemaining === 1 ? "" : "s"} left) -> moves to ${transitionLabel}`
      )
      .join("\n");

    toast("Contract date notification", {
      description: message,
      duration: 5000,
      action: {
        label: "OK",
        onClick: () => {},
      },
    });

    candidates.forEach((item) => {
      window.localStorage.setItem(item.storageKey, "shown");
    });
  }, [lifecycleContracts, audience]);

  useEffect(() => {
    if (!canAutoMove) {
      return;
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const toMove = lifecycleContracts.filter((contract) => {
      if (inFlightRef.current.has(contract.id)) {
        return false;
      }

      const endTs = toTimestamp(contract.activeContract.ultimateCompletionDate);
      return !Number.isNaN(endTs) && endTs <= today.getTime();
    });

    if (toMove.length === 0) {
      return;
    }

    let cancelled = false;

    const runMoves = async () => {
      toMove.forEach((contract) => inFlightRef.current.add(contract.id));

      try {
        await Promise.all(
          toMove.map(async (contract) => {
            const targetCategory = getTargetCategory(contract.category);
            if (!targetCategory) {
              return;
            }

            const response = await fetch(`/api/contracts/${contract.id}`, {
              method: "PUT",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({
                contractName: contract.contractName,
                cor: contract.activeContract.cor,
                contractNumber: contract.activeContract.contractNumber,
                office: contract.activeContract.office,
                nextPeriodOfPerf: contract.activeContract.nextPeriodOfPerf,
                ultimateCompletionDate: contract.activeContract.ultimateCompletionDate,
                co: contract.activeContract.co,
                cs: contract.activeContract.cs,
                orderNumber: contract.activeContract.orderNumber,
                category: targetCategory,
                assigneeIds: contract.assigneeIds ?? [],
              }),
            });

            if (!response.ok) {
              const payload = await response.json().catch(() => ({}));
              throw new Error(payload?.error || `Failed to move ${contract.contractName}.`);
            }
          })
        );

        if (!cancelled) {
          toast.success(
            `${toMove.length} contract${toMove.length === 1 ? "" : "s"} moved automatically by completion date trigger.`
          );
          router.refresh();
        }
      } catch (error) {
        if (!cancelled) {
          const message =
            error instanceof Error
              ? error.message
              : "Failed to auto-move contract(s) by completion date trigger.";
          toast.error(message);
        }
      } finally {
        toMove.forEach((contract) => inFlightRef.current.delete(contract.id));
      }
    };

    void runMoves();

    return () => {
      cancelled = true;
    };
  }, [lifecycleContracts, canAutoMove, router]);

  return null;
}
