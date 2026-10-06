import { Header } from "./Header";
import { Footer } from "./Footer";
import { WorkModeProvider } from "./WorkModeProvider";

interface AppShellProps {
  children: React.ReactNode;
}

export function AppShell({ children }: AppShellProps) {
  return (
    <WorkModeProvider>
      <div className="min-h-screen flex flex-col">
        <Header />
        <div className="flex-1">
          <main id="main-content" className="flex-1 p-6 overflow-auto">
            {children}
          </main>
        </div>
        <Footer />
      </div>
    </WorkModeProvider>
  );
}
