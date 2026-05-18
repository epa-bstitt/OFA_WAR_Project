import Link from "next/link";
import { cn } from "@/lib/utils";

interface PageHeaderLink {
  label: string;
  href: string;
}

interface PageHeaderProps {
  title: string;
  description?: string;
  children?: React.ReactNode;
  className?: string;
  section?: string;
  breadcrumbs?: PageHeaderLink[];
  quickLinks?: PageHeaderLink[];
}

export function PageHeader({
  title,
  description,
  children,
  className,
  section,
  breadcrumbs,
  quickLinks,
}: PageHeaderProps) {
  return (
    <div className={cn("mb-6", className)}>
      <div className="rounded-2xl border border-slate-200 bg-white/95 px-5 py-4 shadow-sm">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div className="space-y-3">
          <h1 className="text-2xl font-bold text-slate-900">{title}</h1>
          {description && (
            <p className="mt-1 text-sm text-slate-600">{description}</p>
          )}
            {quickLinks?.length ? (
              <div className="flex flex-wrap gap-2 pt-1">
                {quickLinks.map((item) => (
                  <Link
                    key={`${item.href}-${item.label}`}
                    href={item.href}
                    className="rounded-full border border-slate-200 bg-slate-50 px-3 py-1.5 text-xs font-medium text-slate-700 transition hover:border-slate-300 hover:bg-slate-100 hover:text-slate-900"
                  >
                    {item.label}
                  </Link>
                ))}
              </div>
            ) : null}
          </div>
          {children && <div className="flex items-center gap-2">{children}</div>}
        </div>
      </div>
    </div>
  );
}
