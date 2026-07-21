import { trpc } from "@/lib/trpc";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { toast } from "sonner";
import { Bell, CheckCheck, Loader2, Sparkles } from "lucide-react";

export default function Novidades() {
  const utils = trpc.useUtils();
  const { data: novidades, isLoading } = trpc.novidades.list.useQuery();

  const marcarLidaMutation = trpc.novidades.marcarLida.useMutation({
    onSuccess: () => {
      utils.novidades.list.invalidate();
      utils.novidades.countNaoLidas.invalidate();
    },
  });

  const marcarTodasMutation = trpc.novidades.marcarTodasLidas.useMutation({
    onSuccess: () => {
      utils.novidades.list.invalidate();
      utils.novidades.countNaoLidas.invalidate();
      toast.success("Todas as novidades marcadas como lidas.");
    },
  });

  const naoLidas = novidades?.filter((n) => !n.lida).length ?? 0;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-foreground">Novidades</h1>
          <p className="text-muted-foreground text-sm mt-1">
            {naoLidas > 0
              ? `${naoLidas} notificação${naoLidas !== 1 ? "ões" : ""} não lida${naoLidas !== 1 ? "s" : ""}`
              : "Todas as notificações foram lidas"}
          </p>
        </div>

        {naoLidas > 0 && (
          <Button
            variant="outline"
            size="sm"
            className="border-border text-foreground hover:bg-accent gap-2"
            onClick={() => marcarTodasMutation.mutate()}
            disabled={marcarTodasMutation.isPending}
          >
            {marcarTodasMutation.isPending ? (
              <Loader2 className="w-3.5 h-3.5 animate-spin" />
            ) : (
              <CheckCheck className="w-3.5 h-3.5" />
            )}
            Marcar todas como lidas
          </Button>
        )}
      </div>

      {/* Divider */}
      <div className="h-px bg-gradient-to-r from-transparent via-border to-transparent" />

      {/* Lista */}
      {isLoading ? (
        <div className="flex items-center justify-center py-16">
          <Loader2 className="w-6 h-6 animate-spin text-primary" />
        </div>
      ) : !novidades?.length ? (
        <div className="flex flex-col items-center justify-center py-20 text-center">
          <div className="w-16 h-16 rounded-2xl bg-primary/10 flex items-center justify-center mb-4">
            <Sparkles className="w-8 h-8 text-primary/60" />
          </div>
          <h3 className="text-lg font-semibold text-foreground mb-2">Nenhuma novidade</h3>
          <p className="text-muted-foreground text-sm max-w-xs">
            Quando houver atualizações nos seus processos, elas aparecerão aqui.
          </p>
        </div>
      ) : (
        <div className="grid gap-3">
          {novidades.map((n) => (
            <div
              key={n.id}
              className={`flex items-start gap-4 p-4 rounded-xl border transition-all duration-200 cursor-pointer ${
                n.lida
                  ? "border-border bg-card opacity-60 hover:opacity-80"
                  : "border-primary/30 bg-primary/5 hover:bg-primary/8"
              }`}
              onClick={() => {
                if (!n.lida) marcarLidaMutation.mutate({ id: n.id });
              }}
            >
              <div
                className={`w-10 h-10 rounded-lg flex items-center justify-center shrink-0 ${
                  n.lida ? "bg-muted" : "bg-primary/15"
                }`}
              >
                <Bell className={`w-5 h-5 ${n.lida ? "text-muted-foreground" : "text-primary"}`} />
              </div>

              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 mb-1">
                  <span className={`text-sm font-semibold ${n.lida ? "text-muted-foreground" : "text-foreground"}`}>
                    {n.titulo}
                  </span>
                  {!n.lida && (
                    <Badge className="bg-primary text-primary-foreground text-xs px-1.5 py-0 h-4">
                      Nova
                    </Badge>
                  )}
                </div>
                {n.conteudo && (
                  <p className="text-xs text-muted-foreground leading-relaxed">{n.conteudo}</p>
                )}
                <p className="text-xs text-muted-foreground/50 mt-1.5">
                  {(() => {
                    // Exibir em UTC-3 (Brasília) independente do fuso do navegador
                    const d = new Date(new Date(n.createdAt).getTime() - 3 * 60 * 60 * 1000);
                    const [ano, mes, dia] = d.toISOString().split("T")[0].split("-");
                    const [h, min] = d.toISOString().split("T")[1].split(":");
                    return `${dia}/${mes}/${ano} ${h}:${min}`;
                  })()}
                </p>
              </div>

              {!n.lida && (
                <div className="w-2 h-2 rounded-full bg-primary shrink-0 mt-1.5" />
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
