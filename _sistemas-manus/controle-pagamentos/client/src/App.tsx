import { Toaster } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/NotFound";
import { Route, Switch, Router as WouterRouter } from "wouter";
import ErrorBoundary from "./components/ErrorBoundary";
import { ThemeProvider } from "./contexts/ThemeContext";
import ClientsPage from "./pages/ClientsPage";
import ClientDetailPage from "./pages/ClientDetailPage";
import CarnePage from "./pages/CarnePage";
import ClientsListPage from "./pages/ClientsListPage";
import DashboardLayout from "./components/DashboardLayout";
import Login from "./pages/Login";

function Router() {
  const base = typeof window !== "undefined" && window.location.pathname.includes("/controle-pagamentos")
    ? "/controle-pagamentos"
    : "";

  return (
    <WouterRouter base={base}>
      <Switch>
        {/* Rotas protegidas envolvidas pelo layout administrativo */}
        <Route path="/">
          <DashboardLayout>
            <ClientsPage />
          </DashboardLayout>
        </Route>

        <Route path="/clientes/:id">
          <DashboardLayout>
            <ClientDetailPage />
          </DashboardLayout>
        </Route>

        <Route path="/carne">
          <DashboardLayout>
            <CarnePage />
          </DashboardLayout>
        </Route>

        <Route path="/lista">
          <DashboardLayout>
            <ClientsListPage />
          </DashboardLayout>
        </Route>

        {/* Rota de login */}
        <Route path="/login" component={Login} />

        <Route path="/404" component={NotFound} />
        <Route>
          <DashboardLayout>
            <ClientsPage />
          </DashboardLayout>
        </Route>
      </Switch>
    </WouterRouter>
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
