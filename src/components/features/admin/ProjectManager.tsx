"use client";

import { useState, useCallback } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Plus, Trash2, Users, FolderKanban, Layers } from "lucide-react";
import { toast } from "sonner";
import type {
  Project,
  ProjectComponent,
  ProjectAssignment,
} from "@/app/actions/admin/projects";
import {
  createProject,
  updateProject,
  deleteProject,
  createComponent,
  deleteComponent,
  assignUserToProject,
  removeUserAssignment,
} from "@/app/actions/admin/projects";
import type { User } from "@/app/actions/admin/users";

interface ProjectManagerProps {
  initialProjects: Project[];
  users: User[];
}

const statusColors: Record<string, string> = {
  ACTIVE: "bg-green-100 text-green-800",
  ON_HOLD: "bg-yellow-100 text-yellow-800",
  COMPLETED: "bg-blue-100 text-blue-800",
  CANCELLED: "bg-red-100 text-red-800",
};

export function ProjectManager({ initialProjects, users }: ProjectManagerProps) {
  const [projects, setProjects] = useState<Project[]>(initialProjects);
  const [selectedProject, setSelectedProject] = useState<Project | null>(null);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [isAssignDialogOpen, setIsAssignDialogOpen] = useState(false);
  const [activeTab, setActiveTab] = useState("projects");

  // Form states
  const [newProjectName, setNewProjectName] = useState("");
  const [newProjectDescription, setNewProjectDescription] = useState("");
  const [newProjectStatus, setNewProjectStatus] = useState<Project["status"]>("ACTIVE");
  const [newComponentName, setNewComponentName] = useState("");
  const [newComponentDescription, setNewComponentDescription] = useState("");
  const [selectedUserId, setSelectedUserId] = useState("");
  const [selectedComponentId, setSelectedComponentId] = useState<string | undefined>();

  const handleCreateProject = async () => {
    const result = await createProject({
      name: newProjectName,
      description: newProjectDescription,
      status: newProjectStatus,
    });

    if (result.success) {
      setProjects([...projects, result.project]);
      setNewProjectName("");
      setNewProjectDescription("");
      setNewProjectStatus("ACTIVE");
      setIsCreateDialogOpen(false);
      toast.success("Project created successfully");
    } else {
      toast.error(result.error);
    }
  };

  const handleDeleteProject = async (projectId: string) => {
    if (!confirm("Are you sure you want to delete this project?")) return;

    const result = await deleteProject(projectId);
    if (result.success) {
      setProjects(projects.filter((p) => p.id !== projectId));
      if (selectedProject?.id === projectId) {
        setSelectedProject(null);
      }
      toast.success("Project deleted successfully");
    } else {
      toast.error(result.error);
    }
  };

  const handleCreateComponent = async () => {
    if (!selectedProject) return;

    const result = await createComponent(selectedProject.id, {
      name: newComponentName,
      description: newComponentDescription,
    });

    if (result.success) {
      const updatedProject = {
        ...selectedProject,
        components: [...(selectedProject.components || []), result.component],
      };
      setSelectedProject(updatedProject);
      setProjects(
        projects.map((p) => (p.id === updatedProject.id ? updatedProject : p))
      );
      setNewComponentName("");
      setNewComponentDescription("");
      toast.success("Component created successfully");
    } else {
      toast.error(result.error);
    }
  };

  const handleDeleteComponent = async (componentId: string) => {
    if (!confirm("Are you sure you want to delete this component?")) return;

    const result = await deleteComponent(componentId);
    if (result.success && selectedProject) {
      const updatedProject = {
        ...selectedProject,
        components: selectedProject.components?.filter((c) => c.id !== componentId),
      };
      setSelectedProject(updatedProject);
      setProjects(
        projects.map((p) => (p.id === updatedProject.id ? updatedProject : p))
      );
      toast.success("Component deleted successfully");
    } else {
      toast.error((result as { success: false; error: string }).error || "Failed to delete component");
    }
  };

  const handleAssignUser = async () => {
    if (!selectedProject || !selectedUserId) return;

    const result = await assignUserToProject({
      userId: selectedUserId,
      projectId: selectedProject.id,
      componentId: selectedComponentId,
    });

    if (result.success) {
      const updatedProject = {
        ...selectedProject,
        assignments: [...(selectedProject.assignments || []), result.assignment],
      };
      setSelectedProject(updatedProject);
      setProjects(
        projects.map((p) => (p.id === updatedProject.id ? updatedProject : p))
      );
      setSelectedUserId("");
      setSelectedComponentId(undefined);
      setIsAssignDialogOpen(false);
      toast.success("User assigned successfully");
    } else {
      toast.error(result.error);
    }
  };

  const handleRemoveAssignment = async (assignmentId: string) => {
    const result = await removeUserAssignment(assignmentId);
    if (result.success && selectedProject) {
      const updatedProject = {
        ...selectedProject,
        assignments: selectedProject.assignments?.filter((a) => a.id !== assignmentId),
      };
      setSelectedProject(updatedProject);
      setProjects(
        projects.map((p) => (p.id === updatedProject.id ? updatedProject : p))
      );
      toast.success("Assignment removed");
    } else {
      toast.error((result as { success: false; error: string }).error || "Failed to remove assignment");
    }
  };

  const refreshProjects = useCallback(async () => {
    // Re-fetch projects
    const response = await fetch("/api/admin/projects");
    if (response.ok) {
      const data = await response.json();
      setProjects(data.projects);
    }
  }, []);

  return (
    <div className="space-y-6">
      <Tabs value={activeTab} onValueChange={setActiveTab}>
        <TabsList>
          <TabsTrigger value="projects">
            <FolderKanban className="mr-2 h-4 w-4" />
            Projects
          </TabsTrigger>
          <TabsTrigger value="details" disabled={!selectedProject}>
            <Layers className="mr-2 h-4 w-4" />
            Details
          </TabsTrigger>
        </TabsList>

        <TabsContent value="projects" className="space-y-4">
          <div className="flex justify-between items-center">
            <h2 className="text-xl font-semibold">Projects</h2>
            <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
              <DialogTrigger asChild>
                <Button>
                  <Plus className="mr-2 h-4 w-4" />
                  New Project
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>Create New Project</DialogTitle>
                  <DialogDescription>
                    Create a new project for multi-contributor reporting.
                  </DialogDescription>
                </DialogHeader>
                <div className="space-y-4 py-4">
                  <div className="space-y-2">
                    <Label htmlFor="name">Project Name</Label>
                    <Input
                      id="name"
                      value={newProjectName}
                      onChange={(e) => setNewProjectName(e.target.value)}
                      placeholder="Enter project name"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="description">Description</Label>
                    <Textarea
                      id="description"
                      value={newProjectDescription}
                      onChange={(e) => setNewProjectDescription(e.target.value)}
                      placeholder="Enter project description"
                      rows={3}
                    />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="status">Status</Label>
                    <Select
                      value={newProjectStatus}
                      onValueChange={(v) => setNewProjectStatus(v as Project["status"])}
                    >
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="ACTIVE">Active</SelectItem>
                        <SelectItem value="ON_HOLD">On Hold</SelectItem>
                        <SelectItem value="COMPLETED">Completed</SelectItem>
                        <SelectItem value="CANCELLED">Cancelled</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <DialogFooter>
                  <Button variant="outline" onClick={() => setIsCreateDialogOpen(false)}>
                    Cancel
                  </Button>
                  <Button onClick={handleCreateProject} disabled={!newProjectName}>
                    Create Project
                  </Button>
                </DialogFooter>
              </DialogContent>
            </Dialog>
          </div>

          <Card>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Name</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead>Components</TableHead>
                  <TableHead>Assigned Users</TableHead>
                  <TableHead className="w-[100px]">Actions</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {projects.map((project) => (
                  <TableRow
                    key={project.id}
                    className="cursor-pointer hover:bg-slate-50"
                    onClick={() => {
                      setSelectedProject(project);
                      setActiveTab("details");
                    }}
                  >
                    <TableCell className="font-medium">{project.name}</TableCell>
                    <TableCell>
                      <Badge className={statusColors[project.status]}>
                        {project.status}
                      </Badge>
                    </TableCell>
                    <TableCell>{project.components?.length || 0}</TableCell>
                    <TableCell>{project.assignments?.length || 0}</TableCell>
                    <TableCell>
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={(e) => {
                          e.stopPropagation();
                          handleDeleteProject(project.id);
                        }}
                      >
                        <Trash2 className="h-4 w-4 text-red-500" />
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
                {projects.length === 0 && (
                  <TableRow>
                    <TableCell colSpan={5} className="text-center text-muted-foreground py-8">
                      No projects yet. Create your first project above.
                    </TableCell>
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </Card>
        </TabsContent>

        <TabsContent value="details" className="space-y-4">
          {selectedProject && (
            <>
              <div className="flex justify-between items-start">
                <div>
                  <h2 className="text-2xl font-bold">{selectedProject.name}</h2>
                  <p className="text-muted-foreground">{selectedProject.description}</p>
                  <Badge className={`mt-2 ${statusColors[selectedProject.status]}`}>
                    {selectedProject.status}
                  </Badge>
                </div>
                <Button variant="outline" onClick={() => setActiveTab("projects")}>
                  Back to Projects
                </Button>
              </div>

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                {/* Components Section */}
                <Card>
                  <CardHeader>
                    <CardTitle className="text-lg flex items-center">
                      <Layers className="mr-2 h-5 w-5" />
                      Components
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="flex gap-2">
                      <Input
                        placeholder="Component name"
                        value={newComponentName}
                        onChange={(e) => setNewComponentName(e.target.value)}
                      />
                      <Input
                        placeholder="Description (optional)"
                        value={newComponentDescription}
                        onChange={(e) => setNewComponentDescription(e.target.value)}
                      />
                      <Button
                        onClick={handleCreateComponent}
                        disabled={!newComponentName}
                      >
                        <Plus className="h-4 w-4" />
                      </Button>
                    </div>

                    <ScrollArea className="h-[300px]">
                      <div className="space-y-2">
                        {selectedProject.components?.map((component) => (
                          <div
                            key={component.id}
                            className="flex items-center justify-between p-3 border rounded-lg"
                          >
                            <div>
                              <p className="font-medium">{component.name}</p>
                              {component.description && (
                                <p className="text-sm text-muted-foreground">
                                  {component.description}
                                </p>
                              )}
                            </div>
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => handleDeleteComponent(component.id)}
                            >
                              <Trash2 className="h-4 w-4 text-red-500" />
                            </Button>
                          </div>
                        ))}
                        {!selectedProject.components?.length && (
                          <p className="text-center text-muted-foreground py-8">
                            No components yet. Add components to track different parts of the project.
                          </p>
                        )}
                      </div>
                    </ScrollArea>
                  </CardContent>
                </Card>

                {/* Assignments Section */}
                <Card>
                  <CardHeader>
                    <CardTitle className="text-lg flex items-center">
                      <Users className="mr-2 h-5 w-5" />
                      Assigned Users
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <Dialog open={isAssignDialogOpen} onOpenChange={setIsAssignDialogOpen}>
                      <DialogTrigger asChild>
                        <Button className="w-full">
                          <Plus className="mr-2 h-4 w-4" />
                          Assign User
                        </Button>
                      </DialogTrigger>
                      <DialogContent>
                        <DialogHeader>
                          <DialogTitle>Assign User to Project</DialogTitle>
                          <DialogDescription>
                            Select a user to assign to this project or a specific component.
                          </DialogDescription>
                        </DialogHeader>
                        <div className="space-y-4 py-4">
                          <div className="space-y-2">
                            <Label>User</Label>
                            <Select
                              value={selectedUserId}
                              onValueChange={setSelectedUserId}
                            >
                              <SelectTrigger>
                                <SelectValue placeholder="Select a user" />
                              </SelectTrigger>
                              <SelectContent>
                                {users.map((user) => (
                                  <SelectItem key={user.id} value={user.id}>
                                    {user.name || user.email} ({user.role})
                                  </SelectItem>
                                ))}
                              </SelectContent>
                            </Select>
                          </div>
                          <div className="space-y-2">
                            <Label>Component (Optional)</Label>
                            <Select
                              value={selectedComponentId}
                              onValueChange={setSelectedComponentId}
                            >
                              <SelectTrigger>
                                <SelectValue placeholder="All components" />
                              </SelectTrigger>
                              <SelectContent>
                                <SelectItem value="">All components</SelectItem>
                                {selectedProject.components?.map((component) => (
                                  <SelectItem key={component.id} value={component.id}>
                                    {component.name}
                                  </SelectItem>
                                ))}
                              </SelectContent>
                            </Select>
                          </div>
                        </div>
                        <DialogFooter>
                          <Button variant="outline" onClick={() => setIsAssignDialogOpen(false)}>
                            Cancel
                          </Button>
                          <Button
                            onClick={handleAssignUser}
                            disabled={!selectedUserId}
                          >
                            Assign User
                          </Button>
                        </DialogFooter>
                      </DialogContent>
                    </Dialog>

                    <ScrollArea className="h-[300px]">
                      <div className="space-y-2">
                        {selectedProject.assignments?.map((assignment) => (
                          <div
                            key={assignment.id}
                            className="flex items-center justify-between p-3 border rounded-lg"
                          >
                            <div>
                              <p className="font-medium">
                                {assignment.user?.name || assignment.user?.email}
                              </p>
                              {assignment.component ? (
                                <p className="text-sm text-muted-foreground">
                                  Component: {assignment.component.name}
                                </p>
                              ) : (
                                <p className="text-sm text-muted-foreground">
                                  All components
                                </p>
                              )}
                            </div>
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => handleRemoveAssignment(assignment.id)}
                            >
                              <Trash2 className="h-4 w-4 text-red-500" />
                            </Button>
                          </div>
                        ))}
                        {!selectedProject.assignments?.length && (
                          <p className="text-center text-muted-foreground py-8">
                            No users assigned yet. Assign contributors to this project.
                          </p>
                        )}
                      </div>
                    </ScrollArea>
                  </CardContent>
                </Card>
              </div>
            </>
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
}
