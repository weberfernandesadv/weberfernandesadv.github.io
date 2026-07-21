import { Toaster } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/NotFound";
import { Route, Switch } from "wouter";
import ErrorBoundary from "./components/ErrorBoundary";
import { ThemeProvider } from "./contexts/ThemeContext";
import Home from "./pages/Home";
import Admin from "./pages/Admin";
import Login from "./pages/Login";
import Procuracao from "./pages/Procuracao";
import Contrato from "./pages/Contrato";
import Declaracao from "./pages/Declaracao";
import ProcuracaoPa from "./pages/ProcuracaoPa";
import ProcuracaoWeberAna from "./pages/ProcuracaoWeberAna";
import ModeloDinamico from "./pages/ModeloDinamico";

function Router() {
  return (
    <Switch>
      {/* Página inicial — login do advogado */}
      <Route path={"/"} component={Home} />

      {/* Painel do advogado */}
      <Route path={"/admin"} component={Admin} />

      {/* Login local */}
      <Route path={"/login"} component={Login} />

      {/* Formulários públicos — acessados pelo cliente via link enviado pelo advogado */}
      <Route path={"/procuracao"} component={Procuracao} />
      <Route path={"/contrato"} component={Contrato} />
      <Route path={"/declaracao"} component={Declaracao} />
      <Route path={"/procuracao-pa"} component={ProcuracaoPa} />
      <Route path={"/procuracao-weber-ana"} component={ProcuracaoWeberAna} />

      {/* Formulários dinâmicos — modelos personalizados criados pelo advogado */}
      <Route path={"/modelo/:slug"} component={ModeloDinamico} />

      <Route path={"/404"} component={NotFound} />
      <Route component={NotFound} />
    </Switch>
  );
}

function App() {
  return (
    <ErrorBoundary>
      <ThemeProvider defaultTheme="light">
        <TooltipProvider>
          <Toaster position="top-right" richColors />
          <Router />
        </TooltipProvider>
      </ThemeProvider>
    </ErrorBoundary>
  );
}

export default App;
