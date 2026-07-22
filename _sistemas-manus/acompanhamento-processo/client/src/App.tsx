import { Toaster } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/NotFound";
import { Route, Switch, Router as WouterRouter } from "wouter";
import ErrorBoundary from "./components/ErrorBoundary";
import DashboardLayout from "./components/DashboardLayout";
import { ThemeProvider } from "./contexts/ThemeContext";
import Home from "./pages/Home";
import Dashboard from "./pages/Dashboard";
import Novidades from "./pages/Novidades";
import Login from "./pages/Login";
import CadastroCliente from "./pages/CadastroCliente";
import Leads from "./pages/Leads";

function Router() {
  const base = typeof window !== "undefined" && window.location.pathname.includes("/acompanhamento-processo")
    ? "/acompanhamento-processo"
    : "";

  return (
    <WouterRouter base={base}>
      <Switch>
        <Route path="/">
          <DashboardLayout>
            <Dashboard />
          </DashboardLayout>
        </Route>
        <Route path="/dashboard">
          <DashboardLayout>
            <Dashboard />
          </DashboardLayout>
        </Route>
        <Route path="/novidades">
          <DashboardLayout>
            <Novidades />
          </DashboardLayout>
        </Route>
        <Route path="/leads">
          <DashboardLayout>
            <Leads />
          </DashboardLayout>
        </Route>
        <Route path="/login" component={Login} />
        <Route path="/cadastro-cliente" component={CadastroCliente} />
        <Route path="/404" component={NotFound} />
        <Route>
          <DashboardLayout>
            <Dashboard />
          </DashboardLayout>
        </Route>
      </Switch>
    </WouterRouter>
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
