"use client";

import { useMemo, useState, useTransition } from "react";
import { toast } from "sonner";
import { Link2, Plus, Trash2, UserCog, Users } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Checkbox } from "@/components/ui/checkbox";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import {
  addContributorUser,
  bulkToggleContributorActive,
  toggleContributorActive,
  updateAggregatorAccessSettings,
  updateContributorAccessSettings,
  type ManagedContributor,
} from "@/app/actions/overseer/settings";
import {
  type AggregatorAccessSettings,
  type ContributorAccessSettings,
} from "@/lib/overseer-settings";
import {
  assignUserToProject,
  removeUserAssignment,
  type Project,
  type ProjectAssignment,
} from "@/app/actions/admin/projects";

interface OverseerSettingsManagerProps {
  initialContributorAccess: ContributorAccessSettings;
  initialAggregatorAccess: AggregatorAccessSettings;
  initialContributors: ManagedContributor[];
  initialProjects: Project[];
}

function buildContributorEmail(name: string) {
  const parts = name
    .trim()
    .split(/\s+/)
    .map((part) => part.toLowerCase().replace(/[^a-z]/g, ""))
    .filter(Boolean);

  if (parts.length < 2) {
    return "";
  }

  const firstName = parts[0];
  const lastName = parts[parts.length - 1];
  return `${lastName}.${firstName}@epa.gov`;
}

export function OverseerSettingsManager({
  initialContributorAccess,
  initialAggregatorAccess,
  initialContributors,
  initialProjects,
}: OverseerSettingsManagerProps) {
  const [activeTab, setActiveTab] = useState("contributor");
  const [contributorAccess, setContributorAccess] = useState(initialContributorAccess);
  const [aggregatorAccess, setAggregatorAccess] = useState(initialAggregatorAccess);
  const [contributors, setContributors] = useState(initialContributors);
  const [projects, setProjects] = useState(initialProjects);
  const [selectedProjectByContributor, setSelectedProjectByContributor] = useState<Record<string, string>>({});
  const [selectedContributorIds, setSelectedContributorIds] = useState<string[]>([]);
  const [contributorSearch, setContributorSearch] = useState("");
  const [contributorStatusFilter, setContributorStatusFilter] = useState<"all" | "active" | "disabled">("all");
  const [isAddDialogOpen, setIsAddDialogOpen] = useState(false);
  const [newContributorName, setNewContributorName] = useState("");
  const [newContributorEmail, setNewContributorEmail] = useState("");
  const [isPending, startTransition] = useTransition();

  const filteredContributors = useMemo(() => {
    const normalizedSearch = contributorSearch.trim().toLowerCase();

    return contributors.filter((contributor) => {
      if (contributorStatusFilter === "active" && !contributor.isActive) {
        return false;
      }

      if (contributorStatusFilter === "disabled" && contributor.isActive) {
        return false;
      }

      if (!normalizedSearch) {
        return true;
      }

      return `${contributor.name ?? ""} ${contributor.email}`.toLowerCase().includes(normalizedSearch);
    });
  }, [contributors, contributorSearch, contributorStatusFilter]);

  const visibleContributorIds = filteredContributors.map((contributor) => contributor.id);
  const allVisibleSelected =
    visibleContributorIds.length > 0 && visibleContributorIds.every((id) => selectedContributorIds.includes(id));

  // Only show projects that are not COMPLETED (deleted) in the assignment dropdown
  const assignableProjects = useMemo(
    () =>
      projects
        .filter((project) => project.status !== "COMPLETED")
        .sort((left, right) => left.name.localeCompare(right.name)),
    [projects]
  );

  function getProjectOptionLabel(project: Project) {
    return project.status === "COMPLETED"
      ? `${project.name} (Deleted in WAR Review)`
      : project.name;
  }

  function getContributorAssignments(contributorId: string) {
    return projects.flatMap((project) =>
      (project.assignments ?? [])
        .filter((assignment) => assignment.userId === contributorId)
        .map((assignment) => ({
          projectId: project.id,
          projectName: project.name,
          assignment,
        }))
    );
  }

  function updateAccessSetting(
    field: keyof ContributorAccessSettings,
    checked: boolean
  ) {
    const nextSettings = {
      ...contributorAccess,
      [field]: checked,
    };

    setContributorAccess(nextSettings);
    startTransition(async () => {
      const result = await updateContributorAccessSettings(nextSettings);
      if (!result.success) {
        setContributorAccess(contributorAccess);
        toast.error(result.error);
        return;
      }

      toast.success("Contributor settings updated.");
    });
  }

  function updateAggregatorSetting(
    field: keyof AggregatorAccessSettings,
    checked: boolean
  ) {
    const nextSettings = {
      ...aggregatorAccess,
      [field]: checked,
    };

    setAggregatorAccess(nextSettings);
    startTransition(async () => {
      const result = await updateAggregatorAccessSettings(nextSettings);
      if (!result.success) {
        setAggregatorAccess(aggregatorAccess);
        toast.error(result.error);
        return;
      }

      toast.success("Aggregator settings updated.");
    });
  }

  function handleContributorToggle(userId: string, nextState: boolean) {
    const previousContributors = contributors;
    setContributors((prev) =>
      prev.map((contributor) =>
        contributor.id === userId ? { ...contributor, isActive: nextState } : contributor
      )
    );

    startTransition(async () => {
      const result = await toggleContributorActive(userId, nextState);
      if (!result.success) {
        setContributors(previousContributors);
        toast.error(result.error);
        return;
      }

      toast.success(nextState ? "Contributor enabled." : "Contributor disabled.");
    });
  }

  function toggleContributorSelection(contributorId: string, checked: boolean) {
    setSelectedContributorIds((prev) =>
      checked ? Array.from(new Set([...prev, contributorId])) : prev.filter((id) => id !== contributorId)
    );
  }

  function toggleSelectAllVisible(checked: boolean) {
    setSelectedContributorIds((prev) => {
      if (!checked) {
        return prev.filter((id) => !visibleContributorIds.includes(id));
      }

      return Array.from(new Set([...prev, ...visibleContributorIds]));
    });
  }

  function handleBulkContributorToggle(nextState: boolean) {
    if (selectedContributorIds.length === 0) {
      toast.error("Select at least one contributor first.");
      return;
    }

    const selectedIds = selectedContributorIds;
    const previousContributors = contributors;

    setContributors((prev) =>
      prev.map((contributor) =>
        selectedIds.includes(contributor.id) ? { ...contributor, isActive: nextState } : contributor
      )
    );

    startTransition(async () => {
      const result = await bulkToggleContributorActive(selectedIds, nextState);
      if (!result.success) {
        setContributors(previousContributors);
        toast.error(result.error);
        return;
      }

      setSelectedContributorIds([]);
      toast.success(nextState ? "Selected contributors enabled." : "Selected contributors disabled.");
    });
  }

  function handleAddContributor() {
    startTransition(async () => {
      const result = await addContributorUser({
        name: newContributorName,
        email: newContributorEmail,
      });

      if (!result.success) {
        toast.error(result.error);
        return;
      }

      setContributors((prev) => [result.contributor, ...prev]);
      setNewContributorName("");
      setNewContributorEmail("");
      setIsAddDialogOpen(false);
      toast.success("Contributor added.");
    });
  }

  function handleNewContributorNameChange(value: string) {
    setNewContributorName(value);
    setNewContributorEmail(buildContributorEmail(value));
  }

  function handleAssignProject(contributorId: string) {
    const projectId = selectedProjectByContributor[contributorId];
    if (!projectId) {
      toast.error("Select a contract before assigning it.");
      return;
    }

    startTransition(async () => {
      const result = await assignUserToProject({ userId: contributorId, projectId });
      if (!result.success) {
        toast.error(result.error);
        return;
      }

      setProjects((prev) =>
        prev.map((project) =>
          project.id === projectId
            ? {
                ...project,
                assignments: [...(project.assignments ?? []), result.assignment as ProjectAssignment],
              }
            : project
        )
      );
      setSelectedProjectByContributor((prev) => ({ ...prev, [contributorId]: "" }));
      toast.success("Contract assigned.");
    });
  }

  function handleRemoveAssignment(assignmentId: string) {
    startTransition(async () => {
      const result = await removeUserAssignment(assignmentId);
      if (!result.success) {
        toast.error(result.error);
        return;
      }

      setProjects((prev) =>
        prev.map((project) => ({
          ...project,
          assignments: (project.assignments ?? []).filter((assignment) => assignment.id !== assignmentId),
        }))
      );
      toast.success("Assignment removed.");
    });
  }

  return (
    <div className="space-y-6">
      <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger value="contributor">
            <Users className="mr-2 h-4 w-4" />
            Contributor
          </TabsTrigger>
          <TabsTrigger value="aggregator">
            <UserCog className="mr-2 h-4 w-4" />
            Aggregator
          </TabsTrigger>
        </TabsList>

        <TabsContent value="contributor" className="space-y-6">
          <Card>
            <CardHeader>
              <CardTitle>Contributor Access Controls</CardTitle>
              <CardDescription>
                Decide which core contributor workspace surfaces remain visible.
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="flex items-center justify-between gap-4 rounded-lg border border-slate-200 p-4">
                <div className="space-y-1">
                  <p className="font-medium text-slate-900">Enable contributor dashboard</p>
                  <p className="text-sm text-slate-600">
                    When off, contributors see a message that their dashboard is unavailable.
                  </p>
                </div>
                <Switch
                  checked={contributorAccess.dashboardEnabled}
                  onCheckedChange={(checked) => updateAccessSetting("dashboardEnabled", checked)}
                  disabled={isPending}
                />
              </div>

              <div className="flex items-center justify-between gap-4 rounded-lg border border-slate-200 p-4">
                <div className="space-y-1">
                  <p className="font-medium text-slate-900">Show contract update cards</p>
                  <p className="text-sm text-slate-600">
                    Controls whether contributors can see their contract cards on the dashboard.
                  </p>
                </div>
                <Switch
                  checked={contributorAccess.contractCardsVisible}
                  onCheckedChange={(checked) => updateAccessSetting("contractCardsVisible", checked)}
                  disabled={isPending}
                />
              </div>

              <div className="flex items-center justify-between gap-4 rounded-lg border border-slate-200 p-4">
                <div className="space-y-1">
                  <p className="font-medium text-slate-900">Enable detailed editor</p>
                  <p className="text-sm text-slate-600">
                    Turns the contributor advanced editor on or off inside contract update cards.
                  </p>
                </div>
                <Switch
                  checked={contributorAccess.enhancedEditorEnabled}
                  onCheckedChange={(checked) => updateAccessSetting("enhancedEditorEnabled", checked)}
                  disabled={isPending}
                />
              </div>

              <div className="flex items-center justify-between gap-4 rounded-lg border border-slate-200 p-4">
                <div className="space-y-1">
                  <p className="font-medium text-slate-900">Allow contributor submissions</p>
                  <p className="text-sm text-slate-600">
                    Keeps contract cards visible but locks drafting and submit actions when turned off.
                  </p>
                </div>
                <Switch
                  checked={contributorAccess.submissionEnabled}
                  onCheckedChange={(checked) => updateAccessSetting("submissionEnabled", checked)}
                  disabled={isPending}
                />
              </div>

              <div className="flex items-center justify-between gap-4 rounded-lg border border-slate-200 p-4">
                <div className="space-y-1">
                  <p className="font-medium text-slate-900">Reopen contributor cards after deadline</p>
                  <p className="text-sm text-slate-600">
                    Temporarily keeps all contributor cards editable and submittable after the Tuesday 5:00 PM cutoff until you switch this back off.
                  </p>
                </div>
                <Switch
                  checked={contributorAccess.deadlineOverrideEnabled}
                  onCheckedChange={(checked) => updateAccessSetting("deadlineOverrideEnabled", checked)}
                  disabled={isPending}
                />
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between gap-4">
              <div>
                <CardTitle>Contributor Roster</CardTitle>
                <CardDescription>
                  Add contributors and toggle whether each contributor account is active.
                </CardDescription>
              </div>
              <Button type="button" onClick={() => setIsAddDialogOpen(true)}>
                <Plus className="mr-2 h-4 w-4" />
                Add Person
              </Button>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid gap-3 rounded-lg border border-slate-200 p-4 lg:grid-cols-[minmax(0,1fr)_220px_auto_auto] lg:items-end">
                <div className="space-y-2">
                  <Label htmlFor="contributor-search">Search People</Label>
                  <Input
                    id="contributor-search"
                    value={contributorSearch}
                    onChange={(event) => setContributorSearch(event.target.value)}
                    placeholder="Search by name or email"
                  />
                </div>
                <div className="space-y-2">
                  <Label>Status</Label>
                  <Select
                    value={contributorStatusFilter}
                    onValueChange={(value: "all" | "active" | "disabled") => setContributorStatusFilter(value)}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="All contributors" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">All contributors</SelectItem>
                      <SelectItem value="active">Active only</SelectItem>
                      <SelectItem value="disabled">Disabled only</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => handleBulkContributorToggle(true)}
                  disabled={isPending || selectedContributorIds.length === 0}
                >
                  Enable Selected
                </Button>
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => handleBulkContributorToggle(false)}
                  disabled={isPending || selectedContributorIds.length === 0}
                >
                  Disable Selected
                </Button>
              </div>

              <div className="flex flex-wrap items-center justify-between gap-3 rounded-lg bg-slate-50 px-4 py-3 text-sm text-slate-600">
                <div className="flex items-center gap-3">
                  <div className="flex items-center gap-2">
                    <Checkbox
                      id="select-all-visible-contributors"
                      checked={allVisibleSelected}
                      onCheckedChange={(checked) => toggleSelectAllVisible(checked === true)}
                      disabled={filteredContributors.length === 0 || isPending}
                    />
                    <Label htmlFor="select-all-visible-contributors" className="text-sm text-slate-600">
                      Select visible contributors
                    </Label>
                  </div>
                  <span>{selectedContributorIds.length} selected</span>
                </div>
                <span>
                  Showing {filteredContributors.length} of {contributors.length} contributors
                </span>
              </div>

              {contributors.length === 0 ? (
                <div className="rounded-lg border border-dashed border-slate-300 p-6 text-sm text-slate-600">
                  No contributors found yet.
                </div>
              ) : filteredContributors.length === 0 ? (
                <div className="rounded-lg border border-dashed border-slate-300 p-6 text-sm text-slate-600">
                  No contributors match the current search or filter.
                </div>
              ) : (
                filteredContributors.map((contributor) => (
                  <div
                    key={contributor.id}
                    className="space-y-4 rounded-lg border border-slate-200 p-4"
                  >
                    <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                      <div className="flex items-start gap-3">
                        <Checkbox
                          checked={selectedContributorIds.includes(contributor.id)}
                          onCheckedChange={(checked) => toggleContributorSelection(contributor.id, checked === true)}
                          disabled={isPending}
                          aria-label={`Select ${contributor.name || contributor.email}`}
                        />
                        <div className="space-y-1">
                          <div className="flex items-center gap-2">
                          <p className="font-medium text-slate-900">{contributor.name || "Unnamed Contributor"}</p>
                          <Badge variant={contributor.isActive ? "default" : "secondary"}>
                            {contributor.isActive ? "Active" : "Disabled"}
                          </Badge>
                          </div>
                          <p className="text-sm text-slate-600">{contributor.email}</p>
                        </div>
                      </div>

                      <div className="flex items-center gap-3">
                        <Label htmlFor={`contributor-toggle-${contributor.id}`} className="text-sm text-slate-600">
                          {contributor.isActive ? "On" : "Off"}
                        </Label>
                        <Switch
                          id={`contributor-toggle-${contributor.id}`}
                          checked={contributor.isActive}
                          onCheckedChange={(checked) => handleContributorToggle(contributor.id, checked)}
                          disabled={isPending}
                        />
                      </div>
                    </div>

                    <div className="space-y-3 rounded-lg bg-slate-50 p-4">
                      <div className="flex items-center gap-2 text-sm font-medium text-slate-900">
                        <Link2 className="h-4 w-4" />
                        Contract Assignments
                      </div>

                      <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
                        <div className="flex-1">
                          <Select
                            value={selectedProjectByContributor[contributor.id] ?? ""}
                            onValueChange={(value) =>
                              setSelectedProjectByContributor((prev) => ({
                                ...prev,
                                [contributor.id]: value,
                              }))
                            }
                          >
                            <SelectTrigger>
                              <SelectValue placeholder="Assign a contract" />
                            </SelectTrigger>
                            <SelectContent>
                              {assignableProjects.map((project) => (
                                <SelectItem key={project.id} value={project.id}>
                                  {getProjectOptionLabel(project)}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                        </div>
                        <Button
                          type="button"
                          variant="outline"
                          onClick={() => handleAssignProject(contributor.id)}
                          disabled={isPending || !selectedProjectByContributor[contributor.id]}
                        >
                          Assign Contract
                        </Button>
                      </div>

                      <div className="space-y-2">
                        {getContributorAssignments(contributor.id).length === 0 ? (
                          <p className="text-sm text-slate-600">No contracts assigned yet.</p>
                        ) : (
                          getContributorAssignments(contributor.id).map(({ projectName, assignment }) => (
                            <div
                              key={assignment.id}
                              className="flex items-center justify-between gap-3 rounded-md border border-slate-200 bg-white px-3 py-2"
                            >
                              <div>
                                <p className="text-sm font-medium text-slate-900">{projectName}</p>
                                {assignment.component?.name ? (
                                  <p className="text-xs text-slate-500">Component: {assignment.component.name}</p>
                                ) : null}
                              </div>
                              <Button
                                type="button"
                                variant="ghost"
                                size="sm"
                                onClick={() => handleRemoveAssignment(assignment.id)}
                                disabled={isPending}
                              >
                                <Trash2 className="mr-2 h-4 w-4" />
                                Remove
                              </Button>
                            </div>
                          ))
                        )}
                      </div>
                    </div>
                  </div>
                ))
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="aggregator">
          <Card>
            <CardHeader>
              <CardTitle>Aggregator Settings</CardTitle>
              <CardDescription>
                Control which Aggregator workflow pages are available.
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="flex items-center justify-between gap-4 rounded-lg border border-slate-200 p-4">
                <div className="space-y-1">
                  <p className="font-medium text-slate-900">Enable review dashboard</p>
                  <p className="text-sm text-slate-600">
                    When off, Aggregators see a restricted message on WAR Review.
                  </p>
                </div>
                <Switch
                  checked={aggregatorAccess.reviewDashboardEnabled}
                  onCheckedChange={(checked) => updateAggregatorSetting("reviewDashboardEnabled", checked)}
                  disabled={isPending}
                />
              </div>

              <div className="flex items-center justify-between gap-4 rounded-lg border border-slate-200 p-4">
                <div className="space-y-1">
                  <p className="font-medium text-slate-900">Enable prompt template management</p>
                  <p className="text-sm text-slate-600">
                    When off, Aggregators cannot access AI Prompt Templates pages.
                  </p>
                </div>
                <Switch
                  checked={aggregatorAccess.promptTemplateManagementEnabled}
                  onCheckedChange={(checked) =>
                    updateAggregatorSetting("promptTemplateManagementEnabled", checked)
                  }
                  disabled={isPending}
                />
              </div>
            </CardContent>
          </Card>
        </TabsContent>

      </Tabs>

      <Dialog open={isAddDialogOpen} onOpenChange={setIsAddDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Add Contributor</DialogTitle>
            <DialogDescription>
              Create a contributor record that can be enabled or disabled from this settings page.
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="new-contributor-name">Name</Label>
              <Input
                id="new-contributor-name"
                value={newContributorName}
                onChange={(event) => handleNewContributorNameChange(event.target.value)}
                placeholder="Jordan Smith"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="new-contributor-email">Email</Label>
              <Input
                id="new-contributor-email"
                type="email"
                value={newContributorEmail}
                onChange={(event) => setNewContributorEmail(event.target.value)}
                placeholder="smith.jordan@epa.gov"
              />
              <p className="text-xs text-slate-500">
                Auto-generated from first and last name using the EPA format.
              </p>
            </div>
          </div>

          <DialogFooter>
            <Button type="button" variant="outline" onClick={() => setIsAddDialogOpen(false)}>
              Cancel
            </Button>
            <Button
              type="button"
              onClick={handleAddContributor}
              disabled={isPending || !newContributorName.trim() || !newContributorEmail.trim()}
            >
              {isPending ? "Saving..." : "Add Contributor"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
