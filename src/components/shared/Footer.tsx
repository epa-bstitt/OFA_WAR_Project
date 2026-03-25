import Link from "next/link";
import { siteConfig } from "@/config/site";

export function Footer() {
  return (
    <footer className="border-t bg-slate-50">
      <div className="container mx-auto px-4 py-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {/* EPA Info */}
          <div>
            <h3 className="font-semibold text-[#005ea2] mb-2">
              {siteConfig.name}
            </h3>
            <p className="text-sm text-slate-600">
              U.S. Environmental Protection Agency
            </p>
            <p className="text-sm text-slate-600">
              Weekly Activity Report (WAR) Modernization
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="font-semibold text-slate-700 mb-2">Quick Links</h3>
            <ul className="space-y-1 text-sm">
              <li>
                <Link
                  href="https://www.epa.gov/privacy"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-slate-600 hover:text-[#005ea2]"
                >
                  Privacy Policy
                </Link>
              </li>
              <li>
                <Link
                  href="https://www.epa.gov/accessibility"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-slate-600 hover:text-[#005ea2]"
                >
                  Accessibility
                </Link>
              </li>
              <li>
                <Link
                  href="https://www.epa.gov"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-slate-600 hover:text-[#005ea2]"
                >
                  EPA.gov
                </Link>
              </li>
            </ul>
          </div>

          {/* Federal Notices */}
          <div>
            <h3 className="font-semibold text-slate-700 mb-2">
              Federal Notices
            </h3>
            <p className="text-xs text-slate-500">
              This is a U.S. Federal Government computer system.
              Unauthorized access is prohibited.
            </p>
            <p className="text-xs text-slate-500 mt-2">
              © {new Date().getFullYear()} U.S. Environmental Protection Agency
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}
