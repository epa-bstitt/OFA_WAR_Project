"use client";

import { useMemo, useState } from "react";
import { format } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import type { BiWeeklyStaffSubmissionPeriod } from "@/app/actions/review";
import { Mail } from "lucide-react";

interface BiWeeklyStaffCardsProps {
  periods: BiWeeklyStaffSubmissionPeriod[];
}

function getInitials(name: string): string {
  const parts = name
    .split(" ")
    .filter(Boolean)
    .slice(0, 2)
    .map((part) => part[0]?.toUpperCase() || "");

  return parts.join("") || "NA";
}

const statusStyles = {
  NOT_STARTED: {
    label: "No Submission",
    cardClass: "border-red-300 bg-red-50/80",
    badgeClass: "bg-red-600 text-white hover:bg-red-600",
  },
  IN_PROGRESS: {
    label: "Started, Not Finished",
    cardClass: "border-amber-300 bg-amber-50/80",
    badgeClass: "bg-amber-600 text-white hover:bg-amber-600",
  },
  COMPLETED: {
    label: "Completed",
    cardClass: "border-emerald-300 bg-emerald-50/80",
    badgeClass: "bg-emerald-600 text-white hover:bg-emerald-600",
  },
} as const;

export function BiWeeklyStaffCards({ periods }: BiWeeklyStaffCardsProps) {
  const [selectedPeriodId, setSelectedPeriodId] = useState(periods[0]?.periodId || "");

  const selectedPeriod = useMemo(
    () => periods.find((period) => period.periodId === selectedPeriodId) || periods[0],
    [periods, selectedPeriodId]
  );

  if (!selectedPeriod) {
    return null;
  }

  const needsAttention = selectedPeriod.cards.filter((card) => card.status !== "COMPLETED");
  const completed = selectedPeriod.cards.filter((card) => card.status === "COMPLETED");

  function buildReminderHref(
    name: string,
    email: string,
    remainingProjects: string[],
    deadline: Date
  ): string {
    const subject = `WAR Submission Reminder - ${selectedPeriod.label}`;
    const projectLine =
      remainingProjects.length > 0
        ? `Projects still missing updates:\n- ${remainingProjects.join("\n- ")}`
        : "Please submit your WAR updates for your assigned projects if anything is still outstanding.";

    const body = [
      `Hi ${name},`,
      "",
      `This is a reminder to submit your WAR report updates for ${selectedPeriod.label}.`,
      `Submission deadline: ${format(new Date(deadline), "EEE, MMM d, yyyy 'at' h:mm a")}.`,
      "",
      projectLine,
      "",
      "Thank you,",
      "WAR Review Team",
    ].join("\n");

    return `mailto:${email}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
  }

  return (
    <div className="space-y-4">
      <Card>
        <CardHeader className="pb-3">
          <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div>
              <CardTitle>Bi-Weekly Staff Submission Status</CardTitle>
              <p className="text-sm text-muted-foreground">
                Track who has submitted all WAR updates and which project updates are still missing before the deadline.
              </p>
            </div>
            <div className="w-full sm:w-72">
              <Select value={selectedPeriod.periodId} onValueChange={setSelectedPeriodId}>
                <SelectTrigger>
                  <SelectValue placeholder="Select bi-week period" />
                </SelectTrigger>
                <SelectContent>
                  {periods.map((period) => (
                    <SelectItem key={period.periodId} value={period.periodId}>
                      {period.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>
        </CardHeader>
        <CardContent className="pt-0 text-sm text-muted-foreground">
          Submission deadline: <span className="font-medium text-slate-800">{format(new Date(selectedPeriod.deadline), "EEE, MMM d, yyyy 'at' h:mm a")}</span>
        </CardContent>
      </Card>

      <section className="space-y-3">
        <h3 className="text-sm font-semibold uppercase tracking-wide text-slate-700">Needs Attention</h3>
        {needsAttention.length === 0 ? (
          <Card>
            <CardContent className="py-6 text-center text-sm text-muted-foreground">
              Everyone is complete for this bi-week period.
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {needsAttention.map((card) => {
              const style = statusStyles[card.status];
              return (
                <Card key={card.userId} className={style.cardClass}>
                  <CardHeader className="pb-2">
                    <div className="flex items-center justify-between gap-3">
                      <div className="flex items-center gap-3">
                        <Avatar className="h-12 w-12 border border-white/80">
                          <AvatarImage src={card.profileImageUrl} alt={`${card.name} profile`} />
                          <AvatarFallback>{getInitials(card.name)}</AvatarFallback>
                        </Avatar>
                        <div>
                          <p className="font-semibold text-slate-900">{card.name}</p>
                          <p className="text-xs text-slate-600">{card.email}</p>
                        </div>
                      </div>
                      <Badge className={style.badgeClass}>{style.label}</Badge>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-2 text-sm">
                    <p className="text-slate-700">
                      Submitted {card.submittedCount} of {card.totalProjects} assigned projects
                    </p>
                    <div>
                      <p className="text-xs font-semibold uppercase tracking-wide text-slate-700">Projects still missing updates</p>
                      {card.remainingProjects.length === 0 ? (
                        <p className="mt-1 text-xs text-slate-700">No project-level gaps detected.</p>
                      ) : (
                        <ul className="mt-1 list-disc pl-5 text-xs text-slate-700">
                          {card.remainingProjects.map((project) => (
                            <li key={`${card.userId}-${project}`}>{project}</li>
                          ))}
                        </ul>
                      )}
                    </div>
                    <a href={buildReminderHref(card.name, card.email, card.remainingProjects, selectedPeriod.deadline)}>
                      <Badge className="mt-1 bg-slate-800 text-white hover:bg-slate-800">
                        <Mail className="mr-1 h-3.5 w-3.5" />
                        Email Reminder
                      </Badge>
                    </a>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        )}
      </section>

      <section className="space-y-3">
        <h3 className="text-sm font-semibold uppercase tracking-wide text-emerald-700">Completed</h3>
        {completed.length === 0 ? (
          <Card>
            <CardContent className="py-6 text-center text-sm text-muted-foreground">
              No completed staff submissions yet for this bi-week period.
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
            {completed.map((card) => {
              const style = statusStyles[card.status];
              return (
                <Card key={card.userId} className={style.cardClass}>
                  <CardHeader className="pb-2">
                    <div className="flex items-center justify-between gap-3">
                      <div className="flex items-center gap-3">
                        <Avatar className="h-12 w-12 border border-white/80">
                          <AvatarImage src={card.profileImageUrl} alt={`${card.name} profile`} />
                          <AvatarFallback>{getInitials(card.name)}</AvatarFallback>
                        </Avatar>
                        <div>
                          <p className="font-semibold text-slate-900">{card.name}</p>
                          <p className="text-xs text-slate-600">{card.email}</p>
                        </div>
                      </div>
                      <Badge className={style.badgeClass}>{style.label}</Badge>
                    </div>
                  </CardHeader>
                  <CardContent className="space-y-1 text-sm text-slate-700">
                    <p>Submitted {card.submittedCount} of {card.totalProjects} assigned projects</p>
                    <p className="text-xs text-emerald-800">All required WAR submissions are complete for this period.</p>
                    <a href={buildReminderHref(card.name, card.email, card.remainingProjects, selectedPeriod.deadline)}>
                      <Badge className="mt-1 bg-slate-800 text-white hover:bg-slate-800">
                        <Mail className="mr-1 h-3.5 w-3.5" />
                        Email Reminder
                      </Badge>
                    </a>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        )}
      </section>
    </div>
  );
}
