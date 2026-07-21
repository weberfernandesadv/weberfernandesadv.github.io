import { cn } from "@/lib/utils";
import { AlertTriangle, RotateCcw } from "lucide-react";
import { Component, ReactNode } from "react";

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error: Error | null;
}

class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  render() {
    if (this.state.hasError) {
      return (
        <div
          className="flex items-center justify-center min-h-screen p-8"
          style={{ background: "linear-gradient(160deg, #0f1e3d 0%, #1a2f5a 40%, #1e3a6e 100%)" }}
        >
          <div className="flex flex-col items-center w-full max-w-sm p-8 rounded-2xl bg-white shadow-2xl text-center">
            <div className="w-16 h-16 rounded-full bg-amber-100 flex items-center justify-center mb-5">
              <AlertTriangle size={32} className="text-amber-600" />
            </div>

            <h2 className="text-xl font-semibold text-[#1a2744] mb-3">
              Ocorreu um problema
            </h2>

            <p className="text-slate-500 text-sm leading-relaxed mb-6">
              A página encontrou um erro inesperado. Por favor, recarregue e tente novamente.
              Se o problema persistir, entre em contato com o advogado responsável.
            </p>

            <button
              onClick={() => window.location.reload()}
              className={cn(
                "flex items-center gap-2 px-5 py-2.5 rounded-lg text-sm font-semibold",
                "bg-[#1a2744] text-white hover:bg-[#243660] transition-all duration-150"
              )}
            >
              <RotateCcw size={15} />
              Recarregar página
            </button>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}

export default ErrorBoundary;
