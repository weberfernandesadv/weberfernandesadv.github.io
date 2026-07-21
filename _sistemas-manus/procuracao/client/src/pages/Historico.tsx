import { trpc } from "@/lib/trpc";
import { Button } from "@/components/ui/button";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { Skeleton } from "@/components/ui/skeleton";
import { toast } from "sonner";
import { Link } from "wouter";
import { ArrowLeft, Download, Trash2, FileText, Scale, History } from "lucide-react";
import { useState } from "react";

const NAVY = "#0f1e3d";
const NAVY_LIGHT = "#1a2f5a";
const GOLD = "#d4af37";
const GOLD_DIM = "rgba(212,175,55,0.15)";
const GOLD_BORDER = "rgba(212,175,55,0.3)";
const WHITE = "#ffffff";
const WHITE_DIM = "rgba(255,255,255,0.6)";
const WHITE_FAINT = "rgba(255,255,255,0.08)";
const CARD_BG = "#f8f7f4";
const RED = "#ef4444";

export default function Historico() {
  const utils = trpc.useUtils();
  const { data: lista, isLoading, error } = trpc.procuracao.listar.useQuery();
  const deletar = trpc.procuracao.deletar.useMutation({
    onSuccess: () => {
      utils.procuracao.listar.invalidate();
      toast.success("Registro excluído com sucesso.");
    },
    onError: () => toast.error("Erro ao excluir o registro."),
  });

  const [baixandoId, setBaixandoId] = useState<number | null>(null);

  async function handleRedownload(id: number, nome: string) {
    setBaixandoId(id);
    try {
      const res = await fetch(`/api/gerar-procuracao-por-id/${id}`);
      if (!res.ok) throw new Error("Falha ao gerar documento");
      const blob = await res.blob();
      const url = URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      const nomeArquivo = nome.split(" ").slice(0, 2).join("_").replace(/[^a-zA-ZÀ-ÿ0-9_]/g, "").toUpperCase();
      a.download = `Procuracao_${nomeArquivo}.docx`;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(url);
      toast.success("Procuração baixada com sucesso.");
    } catch {
      toast.error("Erro ao baixar a procuração.");
    } finally {
      setBaixandoId(null);
    }
  }

  function formatarData(date: Date | string) {
    const d = new Date(date);
    return d.toLocaleDateString("pt-BR", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
      hour: "2-digit",
      minute: "2-digit",
    });
  }

  return (
    <div className="min-h-screen" style={{ background: `linear-gradient(160deg, ${NAVY} 0%, ${NAVY_LIGHT} 40%, #1e3a6e 100%)` }}>
      {/* Header */}
      <header style={{ borderBottom: "1px solid rgba(255,255,255,0.1)", background: "rgba(255,255,255,0.05)", backdropFilter: "blur(8px)" }}>
        <div className="container py-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="flex items-center justify-center w-9 h-9 rounded-full" style={{ background: "rgba(212,175,55,0.2)", border: "1px solid rgba(212,175,55,0.3)" }}>
              <Scale size={18} style={{ color: GOLD }} />
            </div>
            <div>
              <h1 className="text-lg font-semibold leading-tight tracking-wide" style={{ color: WHITE, fontFamily: "Georgia, serif" }}>
                Gerador de Procuração
              </h1>
              <p className="text-xs" style={{ color: WHITE_DIM }}>Histórico de Documentos</p>
            </div>
          </div>
          <Link href="/">
            <button
              className="flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition-all duration-150"
              style={{ background: GOLD_DIM, border: `1px solid ${GOLD_BORDER}`, color: GOLD }}
              onMouseEnter={(e) => { e.currentTarget.style.background = "rgba(212,175,55,0.25)"; }}
              onMouseLeave={(e) => { e.currentTarget.style.background = GOLD_DIM; }}
            >
              <ArrowLeft size={15} />
              Novo Documento
            </button>
          </Link>
        </div>
      </header>

      <main className="container py-10">
        {/* Título */}
        <div className="mb-8 flex items-center gap-3">
          <History size={24} style={{ color: GOLD }} />
          <div>
            <h2 className="text-2xl font-bold" style={{ color: WHITE, fontFamily: "Georgia, serif" }}>
              Histórico de Procurações
            </h2>
            <p className="text-sm mt-0.5" style={{ color: WHITE_DIM }}>
              Todos os documentos gerados ficam registrados aqui. Baixe ou exclua registros conforme necessário.
            </p>
          </div>
        </div>

        {/* Card principal */}
        <div className="rounded-2xl overflow-hidden shadow-2xl" style={{ background: CARD_BG }}>
          {/* Faixa decorativa */}
          <div className="h-1.5 w-full" style={{ background: "linear-gradient(90deg, #b8860b, #d4a017, #b8860b)" }} />

          {isLoading ? (
            <div className="p-8 space-y-3">
              {[...Array(5)].map((_, i) => (
                <Skeleton key={i} className="h-12 w-full rounded-lg" />
              ))}
            </div>
          ) : error ? (
            <div className="p-16 text-center">
              <p className="text-red-500 font-medium">Erro ao carregar o histórico. Tente novamente.</p>
            </div>
          ) : !lista || lista.length === 0 ? (
            <div className="p-16 text-center">
              <FileText size={48} className="mx-auto mb-4 opacity-20" style={{ color: NAVY }} />
              <p className="text-lg font-semibold text-slate-600 mb-1">Nenhuma procuração gerada ainda</p>
              <p className="text-sm text-slate-400 mb-6">Os documentos gerados aparecerão aqui automaticamente.</p>
              <Link href="/">
                <Button style={{ background: NAVY, color: WHITE }}>
                  Gerar primeira procuração
                </Button>
              </Link>
            </div>
          ) : (
            <>
              {/* Cabeçalho do card */}
              <div className="px-6 py-4 flex items-center justify-between border-b border-slate-200">
                <span className="text-sm font-medium text-slate-500">
                  {lista.length} {lista.length === 1 ? "documento registrado" : "documentos registrados"}
                </span>
                <span className="text-xs px-2.5 py-1 rounded-full font-medium" style={{ background: GOLD_DIM, color: "#8a6d00", border: `1px solid ${GOLD_BORDER}` }}>
                  Mais recente primeiro
                </span>
              </div>

              {/* Tabela — desktop */}
              <div className="hidden md:block overflow-x-auto">
                <Table>
                  <TableHeader>
                    <TableRow className="border-slate-200 bg-slate-50">
                      {["#", "Nome", "CPF", "Profissão", "Cidade", "Gerado em", "Ações"].map((h) => (
                        <TableHead key={h} className="text-xs font-semibold uppercase tracking-wider text-slate-500">
                          {h}
                        </TableHead>
                      ))}
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {lista.map((p) => (
                      <TableRow key={p.id} className="border-slate-100 hover:bg-slate-50 transition-colors">
                        <TableCell className="text-xs text-slate-400">#{p.id}</TableCell>
                        <TableCell className="font-semibold text-slate-800">{p.nome}</TableCell>
                        <TableCell className="font-mono text-sm text-slate-500">{p.cpf}</TableCell>
                        <TableCell className="text-slate-600">{p.profissao}</TableCell>
                        <TableCell className="text-slate-600">{p.cidade}</TableCell>
                        <TableCell className="text-sm text-slate-500">{formatarData(p.criadoEm)}</TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <Button
                              size="sm"
                              variant="outline"
                              className="gap-1 text-xs h-8"
                              disabled={baixandoId === p.id}
                              onClick={() => handleRedownload(p.id, p.nome)}
                              style={{ borderColor: NAVY, color: NAVY }}
                            >
                              <Download size={12} />
                              {baixandoId === p.id ? "Gerando..." : "Baixar"}
                            </Button>
                            <AlertDialog>
                              <AlertDialogTrigger asChild>
                                <Button size="sm" variant="outline" className="gap-1 text-xs h-8" style={{ borderColor: RED, color: RED }}>
                                  <Trash2 size={12} />
                                </Button>
                              </AlertDialogTrigger>
                              <AlertDialogContent>
                                <AlertDialogHeader>
                                  <AlertDialogTitle>Excluir registro?</AlertDialogTitle>
                                  <AlertDialogDescription>
                                    O registro de <strong>{p.nome}</strong> será removido permanentemente do histórico. Esta ação não pode ser desfeita.
                                  </AlertDialogDescription>
                                </AlertDialogHeader>
                                <AlertDialogFooter>
                                  <AlertDialogCancel>Cancelar</AlertDialogCancel>
                                  <AlertDialogAction
                                    onClick={() => deletar.mutate({ id: p.id })}
                                    style={{ background: RED, color: WHITE }}
                                  >
                                    Excluir
                                  </AlertDialogAction>
                                </AlertDialogFooter>
                              </AlertDialogContent>
                            </AlertDialog>
                          </div>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>

              {/* Cards — mobile */}
              <div className="md:hidden divide-y divide-slate-100">
                {lista.map((p) => (
                  <div key={p.id} className="p-4 space-y-3">
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <p className="font-semibold text-sm text-slate-800">{p.nome}</p>
                        <p className="text-xs font-mono text-slate-400 mt-0.5">{p.cpf}</p>
                      </div>
                      <span className="text-xs text-slate-400">#{p.id}</span>
                    </div>
                    <div className="flex flex-wrap gap-x-3 gap-y-1 text-xs text-slate-500">
                      <span>{p.profissao}</span>
                      <span>·</span>
                      <span>{p.cidade}</span>
                      <span>·</span>
                      <span>{formatarData(p.criadoEm)}</span>
                    </div>
                    <div className="flex gap-2">
                      <Button
                        size="sm"
                        variant="outline"
                        className="gap-1 text-xs flex-1"
                        disabled={baixandoId === p.id}
                        onClick={() => handleRedownload(p.id, p.nome)}
                        style={{ borderColor: NAVY, color: NAVY }}
                      >
                        <Download size={12} />
                        {baixandoId === p.id ? "Gerando..." : "Baixar"}
                      </Button>
                      <AlertDialog>
                        <AlertDialogTrigger asChild>
                          <Button size="sm" variant="outline" className="gap-1 text-xs" style={{ borderColor: RED, color: RED }}>
                            <Trash2 size={12} />
                          </Button>
                        </AlertDialogTrigger>
                        <AlertDialogContent>
                          <AlertDialogHeader>
                            <AlertDialogTitle>Excluir registro?</AlertDialogTitle>
                            <AlertDialogDescription>
                              O registro de <strong>{p.nome}</strong> será removido permanentemente.
                            </AlertDialogDescription>
                          </AlertDialogHeader>
                          <AlertDialogFooter>
                            <AlertDialogCancel>Cancelar</AlertDialogCancel>
                            <AlertDialogAction
                              onClick={() => deletar.mutate({ id: p.id })}
                              style={{ background: RED, color: WHITE }}
                            >
                              Excluir
                            </AlertDialogAction>
                          </AlertDialogFooter>
                        </AlertDialogContent>
                      </AlertDialog>
                    </div>
                  </div>
                ))}
              </div>
            </>
          )}
        </div>
      </main>
    </div>
  );
}
