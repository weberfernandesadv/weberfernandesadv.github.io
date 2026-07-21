import { useState } from "react";
import { trpc } from "@/lib/trpc";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Skeleton } from "@/components/ui/skeleton";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { toast } from "sonner";
import { CheckCircle2, XCircle, Users, TrendingUp, Award } from "lucide-react";

type FilterType = "all" | "active" | "settled";

export default function ClientsListPage() {
  const { data: clients, isLoading, refetch } = trpc.clients.listAlpha.useQuery();
  const markSettled = trpc.clients.markSettled.useMutation({
    onSuccess: () => { refetch(); toast.success("Contrato marcado como adimplido."); },
    onError: () => toast.error("Erro ao marcar contrato como adimplido."),
  });
  const markUnsettled = trpc.clients.markUnsettled.useMutation({
    onSuccess: () => { refetch(); toast.success("Adimplemento revertido."); },
    onError: () => toast.error("Erro ao reverter adimplemento."),
  });

  const [filter, setFilter] = useState<FilterType>("all");
  const [confirmSettle, setConfirmSettle] = useState<{ id: number; name: string } | null>(null);
  const [confirmUnsettle, setConfirmUnsettle] = useState<{ id: number; name: string } | null>(null);

  const formatCurrency = (value: string | number) =>
    new Intl.NumberFormat("pt-BR", { style: "currency", currency: "BRL" }).format(Number(value));

  const formatDate = (ts: number) =>
    new Date(ts).toLocaleDateString("pt-BR");

  const filtered = (clients ?? []).filter((c) => {
    if (filter === "active") return !c.settledAt;
    if (filter === "settled") return !!c.settledAt;
    return true;
  });

  const grouped = filtered.reduce<Record<string, typeof filtered>>((acc, client) => {
    const letter = client.name.charAt(0).toUpperCase();
    if (!acc[letter]) acc[letter] = [];
    acc[letter].push(client);
    return acc;
  }, {});

  const letters = Object.keys(grouped).sort();
  const totalClients = (clients ?? []).length;
  const settledCount = (clients ?? []).filter((c) => !!c.settledAt).length;
  const activeCount = totalClients - settledCount;

  if (isLoading) {
    return (
      <div className="max-w-4xl mx-auto py-8 px-4 space-y-4">
        <Skeleton className="h-10 w-64" />
        {[...Array(5)].map((_, i) => (
          <Skeleton key={i} className="h-20 w-full rounded-xl" />
        ))}
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto py-8 px-4">
      <div className="mb-8">
        <h1
          className="text-3xl font-bold text-foreground mb-1"
          style={{ fontFamily: "'Playfair Display', serif" }}
        >
          Lista de Clientes
        </h1>
        <p className="text-muted-foreground text-sm">
          Relação alfabética de todos os contratos cadastrados
        </p>
      </div>

      <div className="grid grid-cols-3 gap-4 mb-8">
        <div className="rounded-xl border bg-card p-4 flex items-center gap-3">
          <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center">
            <Users className="h-5 w-5 text-primary" />
          </div>
          <div>
            <p className="text-2xl font-bold">{totalClients}</p>
            <p className="text-xs text-muted-foreground">Total de clientes</p>
          </div>
        </div>
        <div className="rounded-xl border bg-card p-4 flex items-center gap-3">
          <div className="h-10 w-10 rounded-full bg-amber-100 flex items-center justify-center">
            <TrendingUp className="h-5 w-5 text-amber-600" />
          </div>
          <div>
            <p className="text-2xl font-bold">{activeCount}</p>
            <p className="text-xs text-muted-foreground">Contratos ativos</p>
          </div>
        </div>
        <div className="rounded-xl border bg-card p-4 flex items-center gap-3">
          <div className="h-10 w-10 rounded-full bg-emerald-100 flex items-center justify-center">
            <Award className="h-5 w-5 text-emerald-600" />
          </div>
          <div>
            <p className="text-2xl font-bold">{settledCount}</p>
            <p className="text-xs text-muted-foreground">Adimplidos</p>
          </div>
        </div>
      </div>

      <div className="flex gap-2 mb-6">
        {(["all", "active", "settled"] as FilterType[]).map((f) => (
          <Button
            key={f}
            variant={filter === f ? "default" : "outline"}
            size="sm"
            onClick={() => setFilter(f)}
            className="rounded-full px-4"
          >
            {f === "all" ? "Todos" : f === "active" ? "Ativos" : "Adimplidos"}
          </Button>
        ))}
      </div>

      {letters.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-20 text-center">
          <Users className="h-12 w-12 text-muted-foreground/30 mb-4" />
          <p className="text-muted-foreground">Nenhum cliente encontrado.</p>
        </div>
      ) : (
        <div className="space-y-8">
          {letters.map((letter) => (
            <div key={letter}>
              <div className="flex items-center gap-3 mb-3">
                <span
                  className="text-2xl font-bold text-primary"
                  style={{ fontFamily: "'Playfair Display', serif", minWidth: "2rem" }}
                >
                  {letter}
                </span>
                <div className="flex-1 h-px bg-border" />
              </div>
              <div className="space-y-3">
                {grouped[letter].map((client) => {
                  const progress =
                    client.totalInstallments > 0
                      ? Math.round((client.paidCount / client.totalInstallments) * 100)
                      : 0;
                  const isSettled = !!client.settledAt;

                  return (
                    <div
                      key={client.id}
                      className={`rounded-xl border bg-card p-4 transition-all ${
                        isSettled ? "opacity-75 border-emerald-200 bg-emerald-50/30" : ""
                      }`}
                    >
                      <div className="flex items-start justify-between gap-4">
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-1 flex-wrap">
                            <span className="font-semibold text-foreground truncate">
                              {client.name}
                            </span>
                            {isSettled && (
                              <Badge className="bg-emerald-100 text-emerald-700 border-emerald-200 text-xs">
                                <CheckCircle2 className="h-3 w-3 mr-1" />
                                Adimplido em {formatDate(client.settledAt!)}
                              </Badge>
                            )}
                          </div>
                          <div className="flex flex-wrap gap-4 text-sm text-muted-foreground mb-3">
                            <span>
                              Contrato:{" "}
                              <span className="font-medium text-foreground">
                                {formatCurrency(client.totalFees)}
                              </span>
                            </span>
                            <span>
                              Parcelas:{" "}
                              <span className="font-medium text-foreground">
                                {client.paidCount}/{client.totalInstallments} pagas
                              </span>
                            </span>
                            <span>
                              Valor/parcela:{" "}
                              <span className="font-medium text-foreground">
                                {formatCurrency(client.installmentValue)}
                              </span>
                            </span>
                          </div>
                          <div className="flex items-center gap-2">
                            <Progress value={progress} className="h-1.5 flex-1" />
                            <span className="text-xs text-muted-foreground w-8 text-right">
                              {progress}%
                            </span>
                          </div>
                        </div>
                        <div className="shrink-0">
                          {isSettled ? (
                            <Button
                              variant="outline"
                              size="sm"
                              className="text-xs border-emerald-300 text-emerald-700 hover:bg-emerald-50"
                              onClick={() =>
                                setConfirmUnsettle({ id: client.id, name: client.name })
                              }
                            >
                              <XCircle className="h-3.5 w-3.5 mr-1" />
                              Reverter
                            </Button>
                          ) : (
                            <Button
                              variant="outline"
                              size="sm"
                              className="text-xs border-amber-300 text-amber-700 hover:bg-amber-50"
                              onClick={() =>
                                setConfirmSettle({ id: client.id, name: client.name })
                              }
                            >
                              <CheckCircle2 className="h-3.5 w-3.5 mr-1" />
                              Adimplir
                            </Button>
                          )}
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          ))}
        </div>
      )}

      <AlertDialog
        open={!!confirmSettle}
        onOpenChange={(open) => !open && setConfirmSettle(null)}
      >
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Confirmar adimplemento</AlertDialogTitle>
            <AlertDialogDescription>
              Deseja marcar o contrato de <strong>{confirmSettle?.name}</strong> como adimplido?
              A data de hoje será registrada automaticamente.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancelar</AlertDialogCancel>
            <AlertDialogAction
              className="bg-emerald-600 hover:bg-emerald-700"
              onClick={() => {
                if (confirmSettle) {
                  markSettled.mutate({ id: confirmSettle.id });
                  setConfirmSettle(null);
                }
              }}
            >
              Confirmar adimplemento
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>

      <AlertDialog
        open={!!confirmUnsettle}
        onOpenChange={(open) => !open && setConfirmUnsettle(null)}
      >
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Reverter adimplemento</AlertDialogTitle>
            <AlertDialogDescription>
              Deseja reverter o adimplemento do contrato de{" "}
              <strong>{confirmUnsettle?.name}</strong>?
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancelar</AlertDialogCancel>
            <AlertDialogAction
              onClick={() => {
                if (confirmUnsettle) {
                  markUnsettled.mutate({ id: confirmUnsettle.id });
                  setConfirmUnsettle(null);
                }
              }}
            >
              Reverter
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
