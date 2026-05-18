"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { format } from "date-fns";
import { useRouter } from "next/navigation";
import {
  BadgeCheck,
  Briefcase,
  Building2,
  CircleAlert,
  FileText,
  Landmark,
  Laptop,
  Sparkles,
  UserRound,
  Waypoints,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { createReview } from "@/app/actions/review";
import type { SubmissionWithUser } from "@/app/actions/review";
import { cn } from "@/lib/utils";
import { toast } from "sonner";

export interface OverseerSubmission extends SubmissionWithUser {
  contractName: string;
  assigneeLabel: string;
  contractCategory: string;
  contractDetails: {
    contractNumber: string;
    office: string;
    cor: string;
    nextPeriodOfPerf: string;
    ultimateCompletionDate: string;
    co: string;
    cs: string;
    orderNumber: string;
  };
  pastUpdates: Array<{
    id: string;
    weekOf: string;
    submittedAt: string;
    summary: string;
    status: string;
  }>;
}

interface OverseerReviewDeckProps {
  submissions: OverseerSubmission[];
  currentUserId: string;
  reviewMode?: "actionable" | "readonly";
  onApproved?: (submission: OverseerSubmission) => void;
}

type QueueFilter = "all" | "new" | "updated" | "info-needed";

type TransitionPreset = {
  outClass: string;
  inClass: string;
  shellGlow: string;
};

const PROFILE_IMAGE_POOL = [
  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=320&q=80",
  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=320&q=80",
  "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=320&q=80",
  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=320&q=80",
  "https://images.unsplash.com/photo-1521119989659-a83eee488004?auto=format&fit=crop&w=320&q=80",
  "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=320",
  "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=320",
  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=320",
  "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=320",
];

const TRANSITION_PRESETS: TransitionPreset[] = [
  {
    outClass: "animate-out fade-out zoom-out-95 slide-out-to-left-16 duration-500",
    inClass: "animate-in fade-in zoom-in-95 slide-in-from-right-16 duration-500",
    shellGlow: "from-sky-100 via-white to-cyan-50",
  },
  {
    outClass: "animate-out fade-out zoom-out-90 slide-out-to-top-10 duration-500",
    inClass: "animate-in fade-in zoom-in-90 slide-in-from-bottom-10 duration-500",
    shellGlow: "from-emerald-100 via-white to-teal-50",
  },
  {
    outClass: "animate-out fade-out zoom-out-95 slide-out-to-right-16 duration-500",
    inClass: "animate-in fade-in zoom-in-95 slide-in-from-left-16 duration-500",
    shellGlow: "from-indigo-100 via-white to-violet-50",
  },
  {
    outClass: "animate-out fade-out zoom-out-95 slide-out-to-bottom-10 duration-500",
    inClass: "animate-in fade-in zoom-in-95 slide-in-from-top-10 duration-500",
    shellGlow: "from-amber-100 via-white to-orange-50",
  },
];

function getRandomPreset() {
  return TRANSITION_PRESETS[Math.floor(Math.random() * TRANSITION_PRESETS.length)];
}

function getProfileImageForUser(userId: string) {
  let hash = 0;
  for (let i = 0; i < userId.length; i += 1) {
    hash = (hash + userId.charCodeAt(i) * (i + 1)) % PROFILE_IMAGE_POOL.length;
  }
  return PROFILE_IMAGE_POOL[hash];
}

function getProjectIcon(contractName: string) {
  const normalized = contractName.toLowerCase();
  if (normalized.includes("cloud") || normalized.includes("infrastructure")) {
    return Landmark;
  }
  if (normalized.includes("mobile") || normalized.includes("laptop") || normalized.includes("pc")) {
    return Laptop;
  }
  if (normalized.includes("platform") || normalized.includes("service")) {
    return Waypoints;
  }
  if (normalized.includes("support") || normalized.includes("admin")) {
    return Building2;
  }
  return Briefcase;
}

export function OverseerReviewDeck({
  submissions,
  currentUserId,
  reviewMode = "actionable",
  onApproved,
}: OverseerReviewDeckProps) {
  const router = useRouter();
  const [queue, setQueue] = useState<OverseerSubmission[]>(submissions);
  const [queueFilter, setQueueFilter] = useState<QueueFilter>("all");
  const [animationPreference, setAnimationPreference] = useState<"reduced" | "intense">("intense");
  const [activeIndex, setActiveIndex] = useState(0);
  const [inlineComment, setInlineComment] = useState("");
  const [verboseComment, setVerboseComment] = useState("");
  const [isVerboseOpen, setIsVerboseOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isReducingMotion, setIsReducingMotion] = useState(false);
  const [phase, setPhase] = useState<"idle" | "out" | "in">("idle");
  const [transitionPreset, setTransitionPreset] = useState<TransitionPreset>(getRandomPreset);

  const timeoutRef = useRef<number | null>(null);

  const preferenceStorageKey = `overseer-animation-preference:${currentUserId}`;

  useEffect(() => {
    const savedPreference = window.localStorage.getItem(preferenceStorageKey);
    if (savedPreference === "reduced" || savedPreference === "intense") {
      setAnimationPreference(savedPreference);
    }

    const media = window.matchMedia("(prefers-reduced-motion: reduce)");
    const applyPreference = () => setIsReducingMotion(media.matches);
    applyPreference();
    media.addEventListener("change", applyPreference);

    return () => {
      media.removeEventListener("change", applyPreference);
      if (timeoutRef.current) {
        window.clearTimeout(timeoutRef.current);
      }
    };
  }, [preferenceStorageKey]);

  useEffect(() => {
    window.localStorage.setItem(preferenceStorageKey, animationPreference);
  }, [animationPreference, preferenceStorageKey]);

  useEffect(() => {
    setQueue(submissions);
    setActiveIndex(0);
  }, [submissions]);

  const filteredQueue = useMemo(() => {
    if (reviewMode === "readonly") {
      return queue;
    }

    if (queueFilter === "info-needed") {
      return queue.filter((submission) => submission.status === "INFO_NEEDED");
    }

    if (queueFilter === "updated") {
      return queue.filter(
        (submission) =>
          submission.status === "SUBMITTED" &&
          submission.reviews?.[0]?.status === "CHANGES_REQUESTED"
      );
    }

    if (queueFilter === "new") {
      return queue.filter(
        (submission) =>
          submission.status === "SUBMITTED" &&
          submission.reviews?.[0]?.status !== "CHANGES_REQUESTED"
      );
    }

    return queue;
  }, [queue, queueFilter, reviewMode]);

  useEffect(() => {
    setActiveIndex(0);
  }, [queueFilter]);

  const current = filteredQueue[activeIndex] ?? null;
  const canMoveNext = filteredQueue.length > 1 && !isSubmitting;

  const motionClass = useMemo(() => {
    if (isReducingMotion || animationPreference === "reduced") {
      return "";
    }
    if (phase === "out") {
      return transitionPreset.outClass;
    }
    if (phase === "in") {
      return transitionPreset.inClass;
    }
    return "";
  }, [isReducingMotion, animationPreference, phase, transitionPreset]);

  function resetCommentFields() {
    setInlineComment("");
    setVerboseComment("");
    setIsVerboseOpen(false);
  }

  function applyTransition(stateUpdate: () => void) {
    if (isReducingMotion || animationPreference === "reduced") {
      stateUpdate();
      return;
    }

    setTransitionPreset(getRandomPreset());
    setPhase("out");

    timeoutRef.current = window.setTimeout(() => {
      stateUpdate();
      setTransitionPreset(getRandomPreset());
      setPhase("in");

      timeoutRef.current = window.setTimeout(() => {
        setPhase("idle");
      }, 450);
    }, 450);
  }

  function goToNextCard() {
    if (!canMoveNext) {
      return;
    }

    applyTransition(() => {
      setActiveIndex((prev) => (prev + 1) % filteredQueue.length);
      resetCommentFields();
    });
  }

  function removeCurrentCard() {
    applyTransition(() => {
      setQueue((prev) => {
        const next = prev.filter((item) => item.id !== current?.id);
        setActiveIndex(0);
        return next;
      });
      resetCommentFields();
    });
  }

  async function handleApprove() {
    if (!current || isSubmitting) {
      return;
    }

    setIsSubmitting(true);
    const comment = inlineComment.trim() || undefined;
    const result = await createReview(current.id, "APPROVED", comment);

    if (!result.success) {
      toast.error(result.error);
      setIsSubmitting(false);
      return;
    }

    toast.success("Submission approved. Moving to next card.");
    const approvedSubmission = { ...current, status: "APPROVED" as const };
    removeCurrentCard();
    setIsSubmitting(false);
    if (onApproved) {
      onApproved(approvedSubmission);
    } else {
      router.refresh();
    }
  }

  async function handleRequestChanges(source: "inline" | "verbose", variant: "info" | "change") {
    if (!current || isSubmitting) {
      return;
    }

    const baseComment = source === "inline" ? inlineComment.trim() : verboseComment.trim();
    if (!baseComment) {
      toast.error("Add a comment before sending a request.");
      return;
    }

    const prefix = variant === "info" ? "[Request More Information]" : "[Request Change]";

    setIsSubmitting(true);
    const result = await createReview(current.id, "CHANGES_REQUESTED", `${prefix} ${baseComment}`);

    if (!result.success) {
      toast.error(result.error);
      setIsSubmitting(false);
      return;
    }

    toast.success("Request sent. Moving to next card.");
    removeCurrentCard();
    router.refresh();
    setIsSubmitting(false);
  }

  if (queue.length === 0 || !current) {
    return (
      <Card>
        <CardContent className="py-12 text-center">
          <p className="text-base font-semibold text-slate-900">
            {queue.length === 0
              ? reviewMode === "readonly"
                ? "No entries available"
                : "Queue complete"
              : "No entries in this filter"}
          </p>
          <p className="mt-1 text-sm text-slate-600">
            {queue.length === 0
              ? reviewMode === "readonly"
                ? "No WAR submissions are available in this section yet."
                : "All available WAR submissions have been reviewed."
              : "Try switching filters to view another subset of submissions."}
          </p>
        </CardContent>
      </Card>
    );
  }

  const ProjectIcon = getProjectIcon(current.contractName);
  const userLabel = current.user.name || current.user.email || "Unknown Contributor";
  const initials = userLabel
    .split(" ")
    .map((part) => part[0])
    .join("")
    .slice(0, 2)
    .toUpperCase();

  return (
    <>
      <div className={cn("rounded-2xl bg-gradient-to-br p-[1px]", transitionPreset.shellGlow)}>
        <Card className={cn("overflow-hidden border-slate-200 bg-white/95 shadow-xl", motionClass)}>
          <CardHeader className="space-y-4 border-b border-slate-100 bg-slate-50/80">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div className="inline-flex items-center gap-2 rounded-full border border-slate-200 bg-white px-3 py-1 text-xs font-semibold uppercase tracking-[0.12em] text-slate-600">
                <Sparkles className="h-3.5 w-3.5 text-sky-600" />
                {reviewMode === "readonly" ? "Approved WAR Updates" : "Overseer Quick Review"}
              </div>
              <Badge variant="outline" className="text-slate-600">
                {activeIndex + 1} / {filteredQueue.length}
              </Badge>
            </div>

            {reviewMode === "actionable" ? (
              <div className="flex flex-wrap items-center gap-2">
                <Button
                  type="button"
                  variant={queueFilter === "all" ? "default" : "outline"}
                  size="sm"
                  onClick={() => setQueueFilter("all")}
                >
                  All ({queue.length})
                </Button>
                <Button
                  type="button"
                  variant={queueFilter === "new" ? "default" : "outline"}
                  size="sm"
                  onClick={() => setQueueFilter("new")}
                >
                  New ({queue.filter((item) => item.status === "SUBMITTED" && item.reviews?.[0]?.status !== "CHANGES_REQUESTED").length})
                </Button>
                <Button
                  type="button"
                  variant={queueFilter === "updated" ? "default" : "outline"}
                  size="sm"
                  onClick={() => setQueueFilter("updated")}
                >
                  Updated ({queue.filter((item) => item.status === "SUBMITTED" && item.reviews?.[0]?.status === "CHANGES_REQUESTED").length})
                </Button>
                <Button
                  type="button"
                  variant={queueFilter === "info-needed" ? "default" : "outline"}
                  size="sm"
                  onClick={() => setQueueFilter("info-needed")}
                >
                  Info Needed ({queue.filter((item) => item.status === "INFO_NEEDED").length})
                </Button>
                <span className="mx-1 h-5 w-px bg-slate-200" aria-hidden="true" />
                <Button
                  type="button"
                  variant={animationPreference === "reduced" ? "default" : "outline"}
                  size="sm"
                  onClick={() => setAnimationPreference("reduced")}
                >
                  Reduced Motion
                </Button>
                <Button
                  type="button"
                  variant={animationPreference === "intense" ? "default" : "outline"}
                  size="sm"
                  onClick={() => setAnimationPreference("intense")}
                >
                  Intense Motion
                </Button>
              </div>
            ) : null}

            <div className="grid gap-4 md:grid-cols-[1fr_auto] md:items-center">
              <div className="space-y-3">
                <div className="flex items-center gap-3">
                  <span className="inline-flex h-10 w-10 items-center justify-center rounded-xl bg-sky-100 text-sky-700">
                    <ProjectIcon className="h-5 w-5" />
                  </span>
                  <div>
                    <p className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Contract</p>
                    <CardTitle className="text-xl text-slate-900">{current.contractName}</CardTitle>
                    <Badge variant="secondary" className="mt-2">{current.contractCategory}</Badge>
                  </div>
                </div>
              </div>

              <div className="flex items-center gap-3 rounded-xl border border-slate-200 bg-white px-3 py-2">
                <Avatar className="h-10 w-10 border border-slate-200">
                  <AvatarImage src={getProfileImageForUser(current.userId)} alt={userLabel} />
                  <AvatarFallback>{initials || <UserRound className="h-4 w-4" />}</AvatarFallback>
                </Avatar>
                <div>
                  <p className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Contributor</p>
                  <p className="text-sm font-medium text-slate-800">{userLabel}</p>
                  <p className="text-xs text-slate-500">Assigned: {current.assigneeLabel}</p>
                  <p className="text-xs text-slate-500">
                    Status: {current.status === "INFO_NEEDED" ? "Info Needed" : current.status === "APPROVED" ? "Approved" : "Submitted"}
                  </p>
                </div>
              </div>
            </div>
          </CardHeader>

          <CardContent className="space-y-5 p-5">
            <div className="rounded-xl border border-slate-200 bg-slate-50 p-4">
              <div className="mb-2 flex items-center justify-between gap-2">
                <p className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">Most Recent Update</p>
                <p className="text-xs text-slate-500">
                  {format(new Date(current.updatedAt ?? current.createdAt), "MMM d, yyyy 'at' h:mm a")}
                </p>
              </div>
              <p className="text-sm leading-6 text-slate-800">{current.rawText}</p>
            </div>

            <details className="rounded-xl border border-slate-200 bg-white p-4">
              <summary className="cursor-pointer list-none text-sm font-semibold text-slate-900">
                <span className="inline-flex items-center gap-2"><span className="text-base">+</span> Contract Details</span>
              </summary>
              <div className="mt-3 grid gap-2 text-sm text-slate-700 sm:grid-cols-2">
                <p><span className="font-medium">Contract Number:</span> {current.contractDetails.contractNumber || "-"}</p>
                <p><span className="font-medium">Office:</span> {current.contractDetails.office || "-"}</p>
                <p><span className="font-medium">COR:</span> {current.contractDetails.cor || "-"}</p>
                <p><span className="font-medium">Next Period of Performance:</span> {current.contractDetails.nextPeriodOfPerf || "-"}</p>
                <p><span className="font-medium">Ultimate Completion Date:</span> {current.contractDetails.ultimateCompletionDate || "-"}</p>
                <p><span className="font-medium">CO:</span> {current.contractDetails.co || "-"}</p>
                <p><span className="font-medium">CS:</span> {current.contractDetails.cs || "-"}</p>
                <p><span className="font-medium">Order Number:</span> {current.contractDetails.orderNumber || "-"}</p>
              </div>
            </details>

            <details className="rounded-xl border border-slate-200 bg-white p-4">
              <summary className="cursor-pointer list-none text-sm font-semibold text-slate-900">
                <span className="inline-flex items-center gap-2"><span className="text-base">+</span> Past Updates</span>
              </summary>
              <div className="mt-3 space-y-3">
                {current.pastUpdates.length === 0 ? (
                  <p className="text-sm text-slate-600">No prior updates available.</p>
                ) : (
                  current.pastUpdates.map((entry) => (
                    <div key={entry.id} className="rounded-lg border border-slate-200 bg-slate-50 p-3">
                      <div className="mb-1 flex flex-wrap items-center justify-between gap-2">
                        <p className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">{entry.weekOf}</p>
                        <Badge variant="outline">{entry.status}</Badge>
                      </div>
                      <p className="text-xs text-slate-500">{entry.submittedAt}</p>
                      <p className="mt-2 text-sm text-slate-800">{entry.summary}</p>
                    </div>
                  ))
                )}
              </div>
            </details>

            {reviewMode === "actionable" ? (
              <div className="rounded-xl border border-slate-200 bg-white p-4">
                <p className="mb-2 text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">
                  Request More Information / Request Change
                </p>
                <Textarea
                  value={inlineComment}
                  onChange={(event) => setInlineComment(event.target.value)}
                  placeholder="Add a short note if this submission needs follow-up."
                  className="min-h-[90px]"
                />

                <div className="mt-3 flex flex-wrap gap-2">
                  <Button
                    type="button"
                    variant="outline"
                    disabled={isSubmitting}
                    onClick={() => handleRequestChanges("inline", "info")}
                  >
                    <CircleAlert className="mr-2 h-4 w-4" />
                    Request Info
                  </Button>
                  <Button
                    type="button"
                    variant="outline"
                    disabled={isSubmitting}
                    onClick={() => handleRequestChanges("inline", "change")}
                  >
                    <FileText className="mr-2 h-4 w-4" />
                    Request Change
                  </Button>
                  <Button type="button" variant="ghost" onClick={() => setIsVerboseOpen(true)}>
                    Add Detailed Response
                  </Button>
                </div>
              </div>
            ) : null}

            <div className="flex flex-wrap items-center justify-between gap-3 pt-1">
              <Button type="button" variant="secondary" onClick={goToNextCard} disabled={!canMoveNext}>
                Next WAR Entry
              </Button>

              {reviewMode === "actionable" ? (
                <Button type="button" disabled={isSubmitting} onClick={handleApprove} className="min-w-[180px]">
                  <BadgeCheck className="mr-2 h-4 w-4" />
                  {isSubmitting ? "Submitting..." : "Approve Submission"}
                </Button>
              ) : null}
            </div>
          </CardContent>
        </Card>
      </div>

      <Dialog open={isVerboseOpen} onOpenChange={setIsVerboseOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Detailed Reviewer Response</DialogTitle>
            <DialogDescription>
              Use this for a longer request when a short inline note is not enough.
            </DialogDescription>
          </DialogHeader>

          <Textarea
            value={verboseComment}
            onChange={(event) => setVerboseComment(event.target.value)}
            placeholder="Provide detailed context, required changes, and expected follow-up."
            className="min-h-[180px]"
          />

          <DialogFooter>
            <Button variant="outline" onClick={() => setIsVerboseOpen(false)}>
              Cancel
            </Button>
            <Button variant="outline" onClick={() => handleRequestChanges("verbose", "info")} disabled={isSubmitting}>
              Send Info Request
            </Button>
            <Button onClick={() => handleRequestChanges("verbose", "change")} disabled={isSubmitting}>
              Send Change Request
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
