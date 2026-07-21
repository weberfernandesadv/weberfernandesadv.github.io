import { useAuth } from "@/_core/hooks/useAuth";
import { Button } from "@/components/ui/button";
import { getLoginUrl } from "@/const";
import { Scale, Search, Shield, Bell, ArrowRight, Gavel } from "lucide-react";
import { useEffect } from "react";
import { useLocation } from "wouter";

export default function Home() {
  const { isAuthenticated, loading } = useAuth();
  const [, navigate] = useLocation();

  useEffect(() => {
    if (!loading && isAuthenticated) {
      navigate("/dashboard");
    }
  }, [loading, isAuthenticated, navigate]);

  if (!loading && isAuthenticated) {
    return null;
  }

  return (
    <div className="min-h-screen bg-background text-foreground overflow-hidden">
      {/* Header */}
      <header className="fixed top-0 left-0 right-0 z-50 border-b border-border/50 bg-background/80 backdrop-blur-xl">
        <div className="container flex items-center justify-between h-16">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-lg bg-primary/20 flex items-center justify-center">
              <Scale className="w-4 h-4 text-primary" />
            </div>
            <span className="font-semibold text-foreground tracking-tight">
              Acompanhamento de Processos
            </span>
          </div>
          <a href={getLoginUrl()}>
            <Button size="sm" className="bg-primary text-primary-foreground hover:bg-primary/90 font-medium">
              Entrar
            </Button>
          </a>
        </div>
      </header>

      {/* Hero Section */}
      <section className="relative pt-32 pb-24 px-4">
        {/* Background glow */}
        <div className="absolute inset-0 overflow-hidden pointer-events-none">
          <div className="absolute top-1/4 left-1/2 -translate-x-1/2 w-[600px] h-[600px] rounded-full bg-primary/5 blur-3xl" />
          <div className="absolute top-1/3 left-1/4 w-[300px] h-[300px] rounded-full bg-primary/3 blur-2xl" />
        </div>

        <div className="container relative text-center max-w-4xl mx-auto">
          {/* Badge */}
          <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full border border-primary/30 bg-primary/10 text-primary text-sm font-medium mb-8">
            <Gavel className="w-3.5 h-3.5" />
            Sistema Jurídico Inteligente
          </div>

          {/* Title */}
          <h1 className="text-5xl md:text-6xl lg:text-7xl font-bold text-foreground mb-6 leading-tight">
            Monitore seus{" "}
            <span className="text-primary">processos</span>{" "}
            com precisão
          </h1>

          <p className="text-lg md:text-xl text-muted-foreground mb-10 max-w-2xl mx-auto leading-relaxed">
            Acompanhe processos judiciais em tempo real. Busque pelo número CNJ, identifique o tribunal automaticamente e receba atualizações sempre que houver novidades.
          </p>

          {/* CTA */}
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
            <a href={getLoginUrl()}>
              <Button size="lg" className="bg-primary text-primary-foreground hover:bg-primary/90 font-semibold px-8 h-12 text-base gap-2">
                Começar agora
                <ArrowRight className="w-4 h-4" />
              </Button>
            </a>
          </div>
        </div>
      </section>

      {/* Features */}
      <section className="py-20 px-4">
        <div className="container max-w-5xl mx-auto">
          <div className="text-center mb-14">
            <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-4">
              Tudo que você precisa
            </h2>
            <p className="text-muted-foreground text-lg">
              Uma plataforma completa para acompanhamento jurídico
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {[
              {
                icon: Search,
                title: "Busca por CNJ",
                desc: "Informe o número CNJ e o tribunal é identificado automaticamente — sem digitação manual.",
              },
              {
                icon: Bell,
                title: "Aba Novidades",
                desc: "Receba e visualize atualizações de processos em uma aba dedicada, organizada e clara.",
              },
              {
                icon: Shield,
                title: "Seguro e Privado",
                desc: "Autenticação via Manus OAuth. Seus processos ficam protegidos e acessíveis só por você.",
              },
            ].map((f) => (
              <div
                key={f.title}
                className="p-6 rounded-2xl border border-border bg-card hover:border-primary/30 transition-all duration-300 group"
              >
                <div className="w-10 h-10 rounded-xl bg-primary/15 flex items-center justify-center mb-4 group-hover:bg-primary/25 transition-colors">
                  <f.icon className="w-5 h-5 text-primary" />
                </div>
                <h3 className="text-lg font-semibold text-foreground mb-2">{f.title}</h3>
                <p className="text-muted-foreground text-sm leading-relaxed">{f.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Tribunais */}
      <section className="py-16 px-4 border-t border-border/50">
        <div className="container max-w-5xl mx-auto text-center">
          <p className="text-muted-foreground text-sm mb-6 uppercase tracking-widest font-medium">
            Tribunais suportados
          </p>
          <div className="flex flex-wrap justify-center gap-3">
            {["STF", "STJ", "TST", "TSE", "TRF1", "TRF2", "TRF3", "TRF4", "TRF5", "TRT1", "TRT2", "TRT15", "TJSP", "TJRJ", "TJMG", "TJGO", "TJRS", "TJBA"].map((t) => (
              <span
                key={t}
                className="px-3 py-1.5 rounded-lg border border-border bg-card text-muted-foreground text-xs font-mono hover:border-primary/40 hover:text-primary transition-colors"
              >
                {t}
              </span>
            ))}
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-8 px-4 border-t border-border/50">
        <div className="container flex flex-col sm:flex-row items-center justify-between gap-4">
          <div className="flex items-center gap-2 text-muted-foreground text-sm">
            <Scale className="w-4 h-4" />
            <span>Acompanhamento de Processos</span>
          </div>
          <p className="text-muted-foreground text-xs">
            Sistema de monitoramento jurídico
          </p>
        </div>
      </footer>
    </div>
  );
}
