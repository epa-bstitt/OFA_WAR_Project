import { redirect } from "next/navigation";
import { Metadata } from "next";
import { ProjectManager } from "@/components/features/admin/ProjectManager";
import { PageHeader } from "@/components/shared/PageHeader";
import { getProjects } from "@/app/actions/admin/projects";
import { getUsers } from "@/app/actions/admin/users";
import { auth } from "@/lib/auth";

export const metadata: Metadata = {
  title: "Project Management",
  description: "Manage projects and assign contributors",
};

export const dynamic = "force-dynamic";

export default async function ProjectsPage() {
  const session = await auth();

  // Check authentication
  if (!session?.user?.id) {
    redirect("/login");
  }

  // Check role - only ADMINISTRATOR or PROGRAM_OVERSEER can access
  const allowedRoles = ["ADMINISTRATOR", "PROGRAM_OVERSEER"];
  if (!allowedRoles.includes(session.user.role as string)) {
    redirect("/dashboard");
  }

  // Fetch projects and users
  const [projectsResult, usersResult] = await Promise.all([
    getProjects(),
    getUsers(),
  ]);

  if (!projectsResult.success || !usersResult.success) {
    // If either request fails, show empty state
    const emptyProjects = projectsResult.success ? projectsResult.projects : [];
    const emptyUsers = usersResult.success ? usersResult.users : [];

    return (
      <div className="space-y-6">
        <PageHeader
          title="Project Management"
          description="Create projects, add components, and assign contributors"
        />
        <ProjectManager initialProjects={emptyProjects} users={emptyUsers} />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="Project Management"
        description="Create projects, add components, and assign contributors"
      />
      <ProjectManager
        initialProjects={projectsResult.projects}
        users={usersResult.users}
      />
    </div>
  );
}
