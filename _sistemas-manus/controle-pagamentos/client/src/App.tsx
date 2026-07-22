import { Toaster } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import ErrorBoundary from "./components/ErrorBoundary";
import { ThemeProvider } from "./contexts/ThemeContext";
import ClientsPage from "./pages/ClientsPage";
import ClientDetailPage from "./pages/ClientDetailPage";
import CarnePage from "./pages/CarnePage";
import ClientsListPage from "./pages/ClientsListPage";
import DashboardLayout from "./components/DashboardLayout";
import Login from "./pages/Login";

function Router() {
  const path = typeof window !== "undefined" ? window.location.pathname : "/";
  const cleanPath = path.replace(/^\/controle-pagamentos/, "") || "/";

  if (cleanPath.startsWith("/clientes/")) {
    return (
      <DashboardLayout>
        <ClientDetailPage />
      </DashboardLayout>
    );
  }
  if (cleanPath.startsWith("/carne")) {
    return (
      <DashboardLayout>
        <CarnePage />
      </DashboardLayout>
    );
  }
  if (cleanPath.startsWith("/lista")) {
    return (
      <DashboardLayout>
        <ClientsListPage />
      </DashboardLayout>
    );
  }
  if (cleanPath.startsWith("/login")) {
    return <Login />;
  }

  // Default: Always render DashboardLayout with ClientsPage!
  return (
    <DashboardLayout>
      <ClientsPage />
    </DashboardLayout>
  );
}

function App() {
  return (
    <ErrorBoundary>
      <ThemeProvider defaultTheme="light">
        <TooltipProvider>
          <Toaster />
          <Router />
        </TooltipProvider>
      </ThemeProvider>
    </ErrorBoundary>
  );
}

export default App;
