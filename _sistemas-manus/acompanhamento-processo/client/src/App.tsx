import { Toaster } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import ErrorBoundary from "./components/ErrorBoundary";
import DashboardLayout from "./components/DashboardLayout";
import { ThemeProvider } from "./contexts/ThemeContext";
import Dashboard from "./pages/Dashboard";
import Novidades from "./pages/Novidades";
import Login from "./pages/Login";
import CadastroCliente from "./pages/CadastroCliente";
import Leads from "./pages/Leads";

function Router() {
  const path = typeof window !== "undefined" ? window.location.pathname : "/";
  const cleanPath = path.replace(/^\/acompanhamento-processo/, "") || "/";

  if (cleanPath.startsWith("/novidades")) {
    return (
      <DashboardLayout>
        <Novidades />
      </DashboardLayout>
    );
  }
  if (cleanPath.startsWith("/leads")) {
    return (
      <DashboardLayout>
        <Leads />
      </DashboardLayout>
    );
  }
  if (cleanPath.startsWith("/login")) {
    return <Login />;
  }
  if (cleanPath.startsWith("/cadastro-cliente")) {
    return <CadastroCliente />;
  }

  // Default: Always render DashboardLayout with Dashboard!
  return (
    <DashboardLayout>
      <Dashboard />
    </DashboardLayout>
  );
}

function App() {
  return (
    <ErrorBoundary>
      <ThemeProvider defaultTheme="dark">
        <TooltipProvider>
          <Toaster />
          <Router />
        </TooltipProvider>
      </ThemeProvider>
    </ErrorBoundary>
  );
}

export default App;
