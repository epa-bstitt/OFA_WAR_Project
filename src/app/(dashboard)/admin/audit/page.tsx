import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { AuditLogViewer } from "@/components/features/audit/AuditLogViewer";
import {
  getAuditLogs,
  getAuditActions,
  getAuditResourceTypes,
  exportAuditLogs,
} from "@/app/actions/audit";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";
import { MockModeToggle } from "@/components/features/admin/MockModeToggle";
import { isMockModeEnabled } from "@/lib/admin/mock-mode-server";
import { mockAuditLogs, mockAuditStats, auditActions, resourceTypes } from "@/lib/admin/mock-data";

export const metadata: Metadata = {
  title: "My Submissions",
  description: "View and manage your WAR submissions",
};

export const dynamic = "force-dynamic";

interface AuditPageProps {
  searchParams: {
    page?: string;
    action?: string;
    resourceType?: string;
    search?: string;
    startDate?: string;
    endDate?: string;
  };
}

export default async function AuditPage({ searchParams }: AuditPageProps) {
  // Check authentication
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  // Check permissions (ADMINISTRATOR only)
  const hasPermission = await hasMinimumRoleLevel("ADMINISTRATOR");
  if (!hasPermission) {
    redirect("/unauthorized");
  }

  // Parse pagination
  const page = parseInt(searchParams.page || "1", 10);
  const pageSize = 50;

  // Parse filters
  const filters = {
    action: searchParams.action,
    resourceType: searchParams.resourceType,
    search: searchParams.search,
    startDate: searchParams.startDate ? new Date(searchParams.startDate) : undefined,
    endDate: searchParams.endDate ? new Date(searchParams.endDate) : undefined,
  };

  // Check if mock mode is enabled
  const useMockData = isMockModeEnabled();

  let logsResult, actionsResult, resourceTypesResult;

  if (useMockData) {
    // Use mock data - filter logs based on search params
    let filteredLogs = mockAuditLogs;
    if (searchParams.action) {
      filteredLogs = filteredLogs.filter(log => log.action === searchParams.action);
    }
    if (searchParams.resourceType) {
      filteredLogs = filteredLogs.filter(log => log.resourceType === searchParams.resourceType);
    }
    
    logsResult = { 
      success: true, 
      logs: filteredLogs,
      total: filteredLogs.length
    };
    actionsResult = { success: true, actions: auditActions };
    resourceTypesResult = { success: true, resourceTypes };
  } else {
    // Fetch from real database
    [logsResult, actionsResult, resourceTypesResult] = await Promise.all([
      getAuditLogs(filters, page, pageSize),
      getAuditActions(),
      getAuditResourceTypes(),
    ]);
  }

  if (!logsResult.success) {
    return (
      <div className="p-8 text-center">
        <p className="text-red-600">Failed to load audit logs</p>
      </div>
    );
  }

  // Server actions for client component
  async function handlePageChange(newPage: number) {
    "use server";
    const params = new URLSearchParams();
    params.set("page", newPage.toString());
    if (filters.action) params.set("action", filters.action);
    if (filters.resourceType) params.set("resourceType", filters.resourceType);
    if (filters.search) params.set("search", filters.search);
    if (searchParams.startDate) params.set("startDate", searchParams.startDate);
    if (searchParams.endDate) params.set("endDate", searchParams.endDate);
    redirect(`/admin/audit?${params.toString()}`);
  }

  async function handleFilterChange(newFilters: {
    action?: string;
    resourceType?: string;
    search?: string;
    startDate?: string;
    endDate?: string;
  }) {
    "use server";
    const params = new URLSearchParams();
    params.set("page", "1");
    if (newFilters.action) params.set("action", newFilters.action);
    if (newFilters.resourceType) params.set("resourceType", newFilters.resourceType);
    if (newFilters.search) params.set("search", newFilters.search);
    if (newFilters.startDate) params.set("startDate", newFilters.startDate);
    if (newFilters.endDate) params.set("endDate", newFilters.endDate);
    redirect(`/admin/audit?${params.toString()}`);
  }

  // Server actions for client component (export disabled in mock mode)
  async function handleExport(format: "csv" | "json") {
    "use server";
    if (useMockData) {
      throw new Error("Export is disabled in mock mode");
    }
    const result = await exportAuditLogs(format, filters);
    if (!result.success) {
      throw new Error(result.error);
    }
    // Return data for download - this triggers file download in the component
    const response = { data: result.data, filename: result.filename };
    return response;
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="Audit Logs"
        description="View and export system audit logs for compliance and security monitoring."
      />

      {/* Mock Mode Toggle */}
      <MockModeToggle />

      <AuditLogViewer
        logs={logsResult.logs.map((log) => ({
          ...log,
          createdAt: log.createdAt.toISOString(),
        }))}
        total={logsResult.total}
        page={page}
        pageSize={pageSize}
        actions={actionsResult.success ? actionsResult.actions : []}
        resourceTypes={resourceTypesResult.success ? resourceTypesResult.resourceTypes : []}
        onPageChange={handlePageChange}
        onFilterChange={handleFilterChange}
        onExport={handleExport}
      />
    </div>
  );
}
