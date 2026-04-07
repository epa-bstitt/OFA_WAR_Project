import { Loading } from "@/components/shared/Loading";

export default function DashboardLoading() {
  return (
    <div className="space-y-6">
      <Loading text="Loading dashboard..." />
    </div>
  );
}
