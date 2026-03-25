import { Metadata } from "next";
import { redirect } from "next/navigation";
import Link from "next/link";
import { PageHeader } from "@/components/shared/PageHeader";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import {
  Users,
  Shield,
  Settings,
  FileText,
  Database,
  AlertTriangle,
} from "lucide-react";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";
import { getUserStats } from "@/app/actions/admin/users";
import { getAuditStats } from "@/app/actions/audit";
import { MockModeToggle } from "@/components/features/admin/MockModeToggle";
import { isMockModeEnabled } from "@/lib/admin/mock-mode-server";
import { mockUserStats, mockAuditStats } from "@/lib/admin/mock-data";

export const metadata: Metadata = {
  title: "Admin Dashboard",
  description: "System administration and management",
};

export const dynamic = "force-dynamic";

export default async function AdminDashboardPage() {
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

  // Check if mock mode is enabled
  const useMockData = isMockModeEnabled();

  let userStats, auditStats;

  if (useMockData) {
    // Use mock data
    userStats = mockUserStats;
    auditStats = mockAuditStats;
  } else {
    // Fetch from real database
    const [userStatsResult, auditStatsResult] = await Promise.all([
      getUserStats(),
      getAuditStats(7),
    ]);

    userStats = userStatsResult.success ? userStatsResult.stats : null;
    auditStats = auditStatsResult.success ? auditStatsResult.stats : null;
  }

  const adminLinks = [
    {
      title: "User Management",
      description: "Manage users, roles, and account status",
      href: "/admin/users",
      icon: Users,
      color: "bg-blue-500",
    },
    {
      title: "Audit Logs",
      description: "View system audit logs and compliance data",
      href: "/admin/audit",
      icon: Shield,
      color: "bg-green-500",
    },
    {
      title: "System Settings",
      description: "Configure system-wide settings",
      href: "/admin/settings",
      icon: Settings,
      color: "bg-purple-500",
    },
    {
      title: "Database",
      description: "Monitor database health and performance",
      href: "/admin/database",
      icon: Database,
      color: "bg-orange-500",
    },
  ];

  return (
    <div className="space-y-6">
      <PageHeader
        title="Admin Dashboard"
        description="System administration and management panel."
      />

      {/* Mock Mode Toggle */}
      <MockModeToggle />

      {/* Security Warning */}
      <Alert variant="destructive">
        <AlertTriangle className="h-4 w-4" />
        <AlertTitle>Admin Access - Actions Are Logged</AlertTitle>
        <AlertDescription>
          All actions performed in the admin panel are recorded in the audit log for compliance and security purposes.
        </AlertDescription>
      </Alert>

      {/* Quick Stats */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Total Users
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{userStats?.totalUsers || 0}</div>
            <p className="text-xs text-muted-foreground mt-1">
              {userStats?.activeUsers || 0} active
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Audit Events (7 days)
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{auditStats?.totalEvents || 0}</div>
            <p className="text-xs text-muted-foreground mt-1">
              System activity tracked
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Administrators
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-purple-600">
              {userStats?.byRole?.ADMINISTRATOR || 0}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              With full access
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              System Status
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-2">
              <div className="h-3 w-3 rounded-full bg-green-500" />
              <span className="text-lg font-medium text-green-600">Operational</span>
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              All systems normal
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Admin Links */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {adminLinks.map((link) => (
          <Card key={link.href} className="hover:shadow-md transition-shadow">
            <CardContent className="p-6">
              <div className="flex items-start gap-4">
                <div className={`p-3 rounded-lg ${link.color} bg-opacity-10`}>
                  <link.icon className={`h-6 w-6 ${link.color.replace('bg-', 'text-')}`} />
                </div>
                <div className="flex-1">
                  <h3 className="font-semibold text-lg">{link.title}</h3>
                  <p className="text-sm text-muted-foreground mt-1">
                    {link.description}
                  </p>
                  <Button variant="ghost" className="mt-4 p-0 h-auto" asChild>
                    <Link href={link.href}>Access {link.title} →</Link>
                  </Button>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Recent Activity Summary */}
      <Card>
        <CardHeader>
          <CardTitle>Recent Activity</CardTitle>
        </CardHeader>
        <CardContent>
          {auditStats?.eventsByAction && Object.keys(auditStats.eventsByAction).length > 0 ? (
            <div className="space-y-2">
              {Object.entries(auditStats.eventsByAction)
                .slice(0, 5)
                .map(([action, count]) => (
                  <div key={action} className="flex items-center justify-between">
                    <span className="text-sm font-medium">{action}</span>
                    <span className="text-sm text-muted-foreground">{count} events</span>
                  </div>
                ))}
            </div>
          ) : (
            <p className="text-muted-foreground">No recent activity recorded</p>
          )}
          <Button variant="outline" className="mt-4 w-full" asChild>
            <Link href="/admin/audit">View Full Audit Log</Link>
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
