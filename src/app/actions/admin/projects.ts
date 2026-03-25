"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { hasRequiredRole, hasMinimumRole } from "@/lib/auth";
import { z } from "zod";

// Types
export interface Project {
  id: string;
  name: string;
  description: string | null;
  status: "ACTIVE" | "ON_HOLD" | "COMPLETED" | "CANCELLED";
  createdBy: string | null;
  createdAt: Date;
  updatedAt: Date;
  components?: ProjectComponent[];
  assignments?: ProjectAssignment[];
}

export interface ProjectComponent {
  id: string;
  projectId: string;
  name: string;
  description: string | null;
  createdAt: Date;
  updatedAt: Date;
}

export interface ProjectAssignment {
  id: string;
  userId: string;
  projectId: string;
  componentId: string | null;
  assignedBy: string | null;
  assignedAt: Date;
  user?: {
    id: string;
    name: string | null;
    email: string;
  };
  component?: ProjectComponent | null;
}

// Validation schemas
const createProjectSchema = z.object({
  name: z.string().min(1, "Project name is required"),
  description: z.string().optional(),
  status: z.enum(["ACTIVE", "ON_HOLD", "COMPLETED", "CANCELLED"]).default("ACTIVE"),
});

const updateProjectSchema = createProjectSchema.partial();

const createComponentSchema = z.object({
  name: z.string().min(1, "Component name is required"),
  description: z.string().optional(),
});

const assignUserSchema = z.object({
  userId: z.string(),
  projectId: z.string(),
  componentId: z.string().optional(),
});

/**
 * Check if user has admin permissions (ADMINISTRATOR or PROGRAM_OVERSEER)
 */
async function checkAdminPermission() {
  const session = await auth();
  if (!session?.user?.id) {
    return { authorized: false, error: "Not authenticated" };
  }

  const isAdmin = hasRequiredRole(session.user.role, ["ADMINISTRATOR"]) || 
                  hasRequiredRole(session.user.role, ["PROGRAM_OVERSEER"]);
  
  if (!isAdmin) {
    return { authorized: false, error: "Unauthorized - Admin access required" };
  }

  return { authorized: true, userId: session.user.id };
}

/**
 * Get all projects with their components and assignments
 */
export async function getProjects(): Promise<
  { success: true; projects: Project[] } | { success: false; error: string }
> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    const projects = await prisma.project.findMany({
      include: {
        components: true,
        assignments: {
          include: {
            user: {
              select: {
                id: true,
                name: true,
                email: true,
              },
            },
            component: true,
          },
        },
      },
      orderBy: {
        createdAt: "desc",
      },
    });

    return { success: true, projects };
  } catch (error) {
    console.error("Error fetching projects:", error);
    return { success: false, error: "Failed to fetch projects" };
  }
}

/**
 * Get a single project by ID
 */
export async function getProjectById(
  id: string
): Promise<{ success: true; project: Project } | { success: false; error: string }> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    const project = await prisma.project.findUnique({
      where: { id },
      include: {
        components: true,
        assignments: {
          include: {
            user: {
              select: {
                id: true,
                name: true,
                email: true,
              },
            },
            component: true,
          },
        },
      },
    });

    if (!project) {
      return { success: false, error: "Project not found" };
    }

    return { success: true, project };
  } catch (error) {
    console.error("Error fetching project:", error);
    return { success: false, error: "Failed to fetch project" };
  }
}

/**
 * Create a new project
 */
export async function createProject(
  data: z.infer<typeof createProjectSchema>
): Promise<{ success: true; project: Project } | { success: false; error: string }> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    const validated = createProjectSchema.parse(data);

    const project = await prisma.project.create({
      data: {
        name: validated.name,
        description: validated.description,
        status: validated.status,
        createdBy: authCheck.userId,
      },
    });

    revalidatePath("/admin/projects");
    return { success: true, project };
  } catch (error) {
    if (error instanceof z.ZodError) {
      return { success: false, error: error.issues[0].message };
    }
    console.error("Error creating project:", error);
    return { success: false, error: "Failed to create project" };
  }
}

/**
 * Update a project
 */
export async function updateProject(
  id: string,
  data: z.infer<typeof updateProjectSchema>
): Promise<{ success: true; project: Project } | { success: false; error: string }> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    const validated = updateProjectSchema.parse(data);

    const project = await prisma.project.update({
      where: { id },
      data: validated,
    });

    revalidatePath("/admin/projects");
    return { success: true, project };
  } catch (error) {
    if (error instanceof z.ZodError) {
      return { success: false, error: error.issues[0].message };
    }
    console.error("Error updating project:", error);
    return { success: false, error: "Failed to update project" };
  }
}

/**
 * Delete a project
 */
export async function deleteProject(
  id: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    await prisma.project.delete({
      where: { id },
    });

    revalidatePath("/admin/projects");
    return { success: true };
  } catch (error) {
    console.error("Error deleting project:", error);
    return { success: false, error: "Failed to delete project" };
  }
}

/**
 * Create a component for a project
 */
export async function createComponent(
  projectId: string,
  data: z.infer<typeof createComponentSchema>
): Promise<{ success: true; component: ProjectComponent } | { success: false; error: string }> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    const validated = createComponentSchema.parse(data);

    const component = await prisma.projectComponent.create({
      data: {
        projectId,
        name: validated.name,
        description: validated.description,
      },
    });

    revalidatePath("/admin/projects");
    return { success: true, component };
  } catch (error) {
    if (error instanceof z.ZodError) {
      return { success: false, error: error.issues[0].message };
    }
    console.error("Error creating component:", error);
    return { success: false, error: "Failed to create component" };
  }
}

/**
 * Delete a component
 */
export async function deleteComponent(
  id: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    await prisma.projectComponent.delete({
      where: { id },
    });

    revalidatePath("/admin/projects");
    return { success: true };
  } catch (error) {
    console.error("Error deleting component:", error);
    return { success: false, error: "Failed to delete component" };
  }
}

/**
 * Assign a user to a project (and optionally a specific component)
 */
export async function assignUserToProject(
  data: z.infer<typeof assignUserSchema>
): Promise<{ success: true; assignment: ProjectAssignment } | { success: false; error: string }> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    const validated = assignUserSchema.parse(data);

    // Check if assignment already exists
    const existing = await prisma.projectAssignment.findFirst({
      where: {
        userId: validated.userId,
        projectId: validated.projectId,
        componentId: validated.componentId || null,
      },
    });

    if (existing) {
      return { success: false, error: "User is already assigned to this project/component" };
    }

    const assignment = await prisma.projectAssignment.create({
      data: {
        userId: validated.userId,
        projectId: validated.projectId,
        componentId: validated.componentId,
        assignedBy: authCheck.userId,
      },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
        component: true,
      },
    });

    revalidatePath("/admin/projects");
    return { success: true, assignment };
  } catch (error) {
    if (error instanceof z.ZodError) {
      return { success: false, error: error.issues[0].message };
    }
    console.error("Error assigning user:", error);
    return { success: false, error: "Failed to assign user" };
  }
}

/**
 * Remove a user assignment from a project
 */
export async function removeUserAssignment(
  assignmentId: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const authCheck = await checkAdminPermission();
    if (!authCheck.authorized) {
      return { success: false, error: authCheck.error! };
    }

    await prisma.projectAssignment.delete({
      where: { id: assignmentId },
    });

    revalidatePath("/admin/projects");
    return { success: true };
  } catch (error) {
    console.error("Error removing assignment:", error);
    return { success: false, error: "Failed to remove assignment" };
  }
}

/**
 * Get projects for current user (for dropdown in submission form)
 */
export async function getMyProjects(): Promise<
  { success: true; projects: Project[] } | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Get projects where user is assigned
    const assignments = await prisma.projectAssignment.findMany({
      where: {
        userId: session.user.id,
      },
      include: {
        project: {
          include: {
            components: true,
          },
        },
        component: true,
      },
    });

    // Extract unique projects
    const projectsMap = new Map<string, Project>();
    assignments.forEach((assignment: typeof assignments[0]) => {
      if (!projectsMap.has(assignment.project.id)) {
        projectsMap.set(assignment.project.id, assignment.project);
      }
    });

    const projects = Array.from(projectsMap.values());

    return { success: true, projects };
  } catch (error) {
    console.error("Error fetching my projects:", error);
    return { success: false, error: "Failed to fetch projects" };
  }
}
