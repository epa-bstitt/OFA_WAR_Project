"use client";

import { useEffect, useState, type ReactElement, type ReactNode } from "react";
import { OverseerReviewDeck } from "./OverseerReviewDeck";
import type { OverseerSubmission } from "./OverseerReviewDeck";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { CheckCircle, Clock, FileText } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

interface ReviewStatsProps {
  pending: number;
  updated: number;
  approved: number;
  startApprovedEmpty?: boolean;
  pendingModalTitle?: string;
  pendingModalDescription?: string;
  pendingModalContent?: ReactNode;
  updatedModalTitle?: string;
  updatedModalDescription?: string;
  updatedModalContent?: ReactNode;
  approvedModalTitle?: string;
  approvedModalDescription?: string;
  approvedModalContent?: ReactNode;
}

type DeckNodeProps = {
  submissions: OverseerSubmission[];
  currentUserId: string;
  reviewMode?: "actionable" | "readonly";
};

function isDeckNode(content: ReactNode): content is ReactElement<DeckNodeProps> {
  return Boolean(
    content &&
      typeof content === "object" &&
      "props" in content &&
      Array.isArray((content as { props?: DeckNodeProps }).props?.submissions) &&
      typeof (content as { props?: DeckNodeProps }).props?.currentUserId === "string"
  );
}

export function ReviewStats({
  pending,
  updated,
  approved,
  startApprovedEmpty = false,
  pendingModalTitle = "Pending Review",
  pendingModalDescription = "Review and process the current pending WAR updates.",
  pendingModalContent,
  updatedModalTitle = "Updated",
  updatedModalDescription = "Review contributor updates after requested changes.",
  updatedModalContent,
  approvedModalTitle = "Approved",
  approvedModalDescription = "Browse approved WAR submissions.",
  approvedModalContent,
}: ReviewStatsProps) {
  const [openModal, setOpenModal] = useState<"pending" | "updated" | "approved" | null>(null);
  const router = useRouter();

  const pendingDeck = isDeckNode(pendingModalContent) ? pendingModalContent : null;
  const updatedDeck = isDeckNode(updatedModalContent) ? updatedModalContent : null;
  const approvedDeck = isDeckNode(approvedModalContent) ? approvedModalContent : null;

  const [pendingQueue, setPendingQueue] = useState<OverseerSubmission[]>(
    pendingDeck?.props.submissions ?? []
  );
  const [updatedQueue, setUpdatedQueue] = useState<OverseerSubmission[]>(
    updatedDeck?.props.submissions ?? []
  );
  const [approvedQueue, setApprovedQueue] = useState<OverseerSubmission[]>(
    startApprovedEmpty ? [] : approvedDeck?.props.submissions ?? []
  );

  useEffect(() => {
    if (pendingDeck) {
      setPendingQueue(pendingDeck.props.submissions);
    }
  }, [pendingDeck]);

  useEffect(() => {
    if (updatedDeck) {
      setUpdatedQueue(updatedDeck.props.submissions);
    }
  }, [updatedDeck]);

  useEffect(() => {
    if (approvedDeck && !startApprovedEmpty) {
      setApprovedQueue(approvedDeck.props.submissions);
    }
  }, [approvedDeck, startApprovedEmpty]);

  function handleApproved(submission: OverseerSubmission) {
    const approvedSubmission: OverseerSubmission = {
      ...submission,
      status: "APPROVED",
    };

    setPendingQueue((prev) => prev.filter((item) => item.id !== submission.id));
    setUpdatedQueue((prev) => prev.filter((item) => item.id !== submission.id));
    setApprovedQueue((prev) => {
      const withoutDuplicate = prev.filter((item) => item.id !== submission.id);
      return [approvedSubmission, ...withoutDuplicate];
    });
    setOpenModal("approved");

    // Keep instant UX while reconciling with DB for real submissions.
    if (!submission.id.startsWith("mock-overseer-")) {
      router.refresh();
    }
  }

  const items = [
    {
      id: "pending" as const,
      title: "Pending Review",
      value: pendingDeck ? pendingQueue.length : pending,
      icon: Clock,
      color: "text-blue-600",
      bgColor: "bg-blue-50",
      description: "Awaiting your review",
      modalTitle: pendingModalTitle,
      modalDescription: pendingModalDescription,
      modalContent: pendingModalContent,
    },
    {
      id: "updated" as const,
      title: "Updated",
      value: updatedDeck ? updatedQueue.length : updated,
      icon: FileText,
      color: "text-purple-600",
      bgColor: "bg-purple-50",
      description: "Updated today",
      modalTitle: updatedModalTitle,
      modalDescription: updatedModalDescription,
      modalContent: updatedModalContent,
    },
    {
      id: "approved" as const,
      title: "Approved",
      value: approvedDeck ? approvedQueue.length : approved,
      icon: CheckCircle,
      color: "text-green-600",
      bgColor: "bg-green-50",
      description: "Approved this week",
      modalTitle: approvedModalTitle,
      modalDescription: approvedModalDescription,
      modalContent: approvedModalContent,
    },
  ];

  const activeModal = items.find((item) => item.id === openModal);

  return (
    <>
      <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
        {items.map((item) => {
          const Icon = item.icon;
          const isInteractiveCard = Boolean(item.modalContent);

          return (
            <Card
              key={item.title}
              className={isInteractiveCard ? "cursor-pointer transition hover:shadow-md" : undefined}
              onClick={isInteractiveCard ? () => setOpenModal(item.id) : undefined}
              role={isInteractiveCard ? "button" : undefined}
              tabIndex={isInteractiveCard ? 0 : undefined}
              onKeyDown={
                isInteractiveCard
                  ? (event) => {
                      if (event.key === "Enter" || event.key === " ") {
                        event.preventDefault();
                        setOpenModal(item.id);
                      }
                    }
                  : undefined
              }
            >
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">
                  {item.title}
                </CardTitle>
                <div className={`${item.bgColor} p-2 rounded-md`}>
                  <Icon className={`h-4 w-4 ${item.color}`} />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{item.value}</div>
                <p className="text-xs text-muted-foreground">{item.description}</p>
              </CardContent>
            </Card>
          );
        })}
      </div>

      {activeModal?.modalContent ? (
        <Dialog
          open={Boolean(openModal)}
          onOpenChange={(isOpen) => {
            if (!isOpen) {
              setOpenModal(null);
            }
          }}
        >
          <DialogContent className="w-[92vw] max-w-3xl max-h-[78vh] overflow-hidden p-4 sm:p-6">
            <DialogHeader>
              <DialogTitle>{activeModal.modalTitle}</DialogTitle>
              <DialogDescription>{activeModal.modalDescription}</DialogDescription>
            </DialogHeader>
            <div className="max-h-[calc(78vh-6.5rem)] overflow-auto pr-1">
              {openModal === "pending" && pendingDeck ? (
                <OverseerReviewDeck
                  submissions={pendingQueue}
                  currentUserId={pendingDeck.props.currentUserId}
                  reviewMode={pendingDeck.props.reviewMode}
                  onApproved={handleApproved}
                />
              ) : openModal === "updated" && updatedDeck ? (
                <OverseerReviewDeck
                  submissions={updatedQueue}
                  currentUserId={updatedDeck.props.currentUserId}
                  reviewMode={updatedDeck.props.reviewMode}
                  onApproved={handleApproved}
                />
              ) : openModal === "approved" && approvedDeck ? (
                <OverseerReviewDeck
                  submissions={approvedQueue}
                  currentUserId={approvedDeck.props.currentUserId}
                  reviewMode="readonly"
                />
              ) : activeModal.modalContent}
            </div>
          </DialogContent>
        </Dialog>
      ) : null}
    </>
  );
}
