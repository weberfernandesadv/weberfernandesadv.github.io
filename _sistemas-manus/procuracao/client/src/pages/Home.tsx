import { Scale, FileText, Lock, ArrowRight } from "lucide-react";
import { Button } from "@/components/ui/button";
import { getLoginUrl } from "@/const";
import { useAuth } from "@/_core/hooks/useAuth";
import { useEffect } from "react";
import { useLocation } from "wouter";

export default function Home() {
  const { isAuthenticated, loading } = useAuth();
  const [, navigate] = useLocation();

  // Se já estiver logado, redirecionar para o painel
  useEffect(() => {
    if (!loading && isAuthenticated) {
      navigate("/admin");
    }
  }, [loading, isAuthenticated, navigate]);

  return (
    <div className="min-h-screen bg-[#0f1a2e] flex flex-col">
      {/* Header */}
      <header className="border-b border-white/10 px-6 py-4">
        <div className="max-w-5xl mx-auto flex items-center gap-3">
          <div className="w-9 h-9 rounded-lg bg-amber-500/20 flex items-center justify-center">
            <Scale size={18} className="text-amber-400" />
          </div>
          <div>
            <p className="text-white font-semibold text-sm leading-none">Gerador de Documentos</p>
            <p className="text-white/40 text-xs mt-0.5">Sistema Jurídico</p>
          </div>
        </div>
      </header>

      {/* Hero */}
      <main className="flex-1 flex items-center justify-center px-6 py-16">
        <div className="max-w-lg w-full text-center space-y-8">
          {/* Ícone central */}
          <div className="flex justify-center">
            <div className="w-20 h-20 rounded-2xl bg-amber-500/10 border border-amber-500/20 flex items-center justify-center">
              <FileText size={36} className="text-amber-400" />
            </div>
          </div>

          {/* Título */}
          <div className="space-y-3">
            <h1 className="text-3xl font-bold text-white leading-tight">
              Painel do Advogado
            </h1>
            <p className="text-white/60 text-base leading-relaxed">
              Gere e envie documentos jurídicos personalizados para seus clientes de forma rápida e segura.
            </p>
          </div>

          {/* Cards de documentos disponíveis */}
          <div className="grid grid-cols-2 gap-3 text-left">
            {[
              { label: "Procuração Ad Judicia", color: "text-amber-400" },
              { label: "Procuração PA (Menor)", color: "text-blue-400" },
              { label: "Contrato de Honorários", color: "text-purple-400" },
              { label: "Declaração de Hipossuficiência", color: "text-emerald-400" },
            ].map((doc) => (
              <div
                key={doc.label}
                className="rounded-lg border border-white/10 bg-white/5 px-4 py-3 flex items-center gap-2"
              >
                <div className={`w-1.5 h-1.5 rounded-full flex-shrink-0 ${doc.color.replace("text-", "bg-")}`} />
                <span className="text-white/70 text-xs font-medium leading-tight">{doc.label}</span>
              </div>
            ))}
          </div>

          {/* Botão de login */}
          <div className="space-y-3">
            <Button
              size="lg"
              className="w-full gap-2 bg-amber-500 hover:bg-amber-400 text-[#0f1a2e] font-semibold text-base h-12"
              onClick={() => { window.location.href = getLoginUrl("/admin"); }}
              disabled={loading}
            >
              <Lock size={16} />
              Entrar no painel
              <ArrowRight size={16} />
            </Button>
            <p className="text-white/30 text-xs">
              Acesso exclusivo para o advogado responsável
            </p>
          </div>
        </div>
      </main>

      {/* Footer */}
      <footer className="border-t border-white/10 px-6 py-4 text-center">
        <p className="text-white/20 text-xs">
          © {new Date().getFullYear()} Sistema Jurídico · Documentos gerados com segurança
        </p>
      </footer>
    </div>
  );
}
