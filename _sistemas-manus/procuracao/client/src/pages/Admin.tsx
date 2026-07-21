import { useState, useCallback, useEffect } from "react";
import { trpc } from "@/lib/trpc";
import { useAuth } from "@/_core/hooks/useAuth";
import DashboardLayout from "@/components/DashboardLayout";
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";
import {
  Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle,
} from "@/components/ui/dialog";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { toast } from "sonner";
import {
  Download, Trash2, FileText, Users, RefreshCw, ShieldAlert, Loader2,
  CheckCircle2, Clock, Search, X, Link2, Copy, FileSignature, Scale,
  Baby, ClipboardList, MessageSquarePlus, Save, Upload, FolderOpen,
  ToggleLeft, ToggleRight, Eye,
} from "lucide-react";

// ─── Helpers ──────────────────────────────────────────────────────────────
function formatarData(ts: Date | string | number | null | undefined): string {
  if (!ts) return "—";
  const d = new Date(ts);
  return d.toLocaleDateString("pt-BR", { day: "2-digit", month: "2-digit", year: "numeric", hour: "2-digit", minute: "2-digit" });
}

function StatusBadge({ status }: { status: string | null | undefined }) {
  if (status === "gerada" || status === "gerado") {
    return (
      <Badge className="gap-1 text-xs bg-emerald-100 text-emerald-700 border-emerald-200 hover:bg-emerald-100">
        <CheckCircle2 size={11} />Gerado
      </Badge>
    );
  }
  return (
    <Badge variant="outline" className="gap-1 text-xs text-amber-600 border-amber-300 bg-amber-50">
      <Clock size={11} />Pendente
    </Badge>
  );
}

// ─── Acesso negado ────────────────────────────────────────────────────────
function AcessoNegado() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4 text-center px-4">
      <div className="w-16 h-16 rounded-full bg-red-100 flex items-center justify-center">
        <ShieldAlert size={32} className="text-red-500" />
      </div>
      <h2 className="text-xl font-semibold text-foreground">Acesso Restrito</h2>
      <p className="text-muted-foreground text-sm max-w-sm">
        Esta área é exclusiva para administradores.
      </p>
    </div>
  );
}

// ─── Painel de Modelos Dinâmicos ─────────────────────────────────────────
type ModeloDinamicoItem = {
  id: number;
  nome: string;
  slug: string;
  descricao: string | null;
  ativo: number;
  criadoEm: Date | string | null;
};

type SubmissaoModeloItem = {
  id: number;
  nome: string;
  cpf: string;
  status: string | null;
  criadoEm: Date | string | null;
  downloadToken: string | null;
};

function PainelModelos() {
  const origin = window.location.origin;
  const [modelos, setModelos] = useState<ModeloDinamicoItem[]>([]);
  const [loadingModelos, setLoadingModelos] = useState(true);
  const [uploadDialog, setUploadDialog] = useState(false);
  const [uploadNome, setUploadNome] = useState("");
  const [uploadDesc, setUploadDesc] = useState("");
  const [uploadFile, setUploadFile] = useState<File | null>(null);
  const [uploading, setUploading] = useState(false);
  const [submissoesDialog, setSubmissoesDialog] = useState<ModeloDinamicoItem | null>(null);
  const [submissoes, setSubmissoes] = useState<SubmissaoModeloItem[]>([]);
  const [loadingSubmissoes, setLoadingSubmissoes] = useState(false);

  const carregarModelos = useCallback(async () => {
    setLoadingModelos(true);
    try {
      const r = await fetch("/api/admin/modelos", { credentials: "include" });
      if (!r.ok) throw new Error("Erro ao carregar modelos");
      const data = await r.json();
      setModelos(data);
    } catch (err: unknown) {
      toast.error("Erro ao carregar modelos", { description: err instanceof Error ? err.message : "Erro desconhecido" });
    } finally {
      setLoadingModelos(false);
    }
  }, []);

  useEffect(() => { carregarModelos(); }, [carregarModelos]);

  const handleUpload = async () => {
    if (!uploadNome.trim() || !uploadFile) {
      toast.error("Preencha o nome e selecione um arquivo .docx");
      return;
    }
    setUploading(true);
    try {
      const form = new FormData();
      form.append("nome", uploadNome.trim());
      if (uploadDesc.trim()) form.append("descricao", uploadDesc.trim());
      form.append("arquivo", uploadFile);
      const r = await fetch("/api/admin/modelos", { method: "POST", body: form, credentials: "include" });
      if (!r.ok) {
        const err = await r.json().catch(() => ({}));
        throw new Error(err?.erro || "Erro ao fazer upload");
      }
      const data = await r.json();
      toast.success("Modelo cadastrado!", { description: `Link: ${origin}/modelo/${data.slug}` });
      setUploadDialog(false);
      setUploadNome(""); setUploadDesc(""); setUploadFile(null);
      carregarModelos();
    } catch (err: unknown) {
      toast.error("Erro ao fazer upload", { description: err instanceof Error ? err.message : "Erro desconhecido" });
    } finally {
      setUploading(false);
    }
  };

  const handleToggle = async (modelo: ModeloDinamicoItem) => {
    try {
      const r = await fetch(`/api/admin/modelos/${modelo.id}/toggle`, { method: "PATCH", credentials: "include" });
      if (!r.ok) throw new Error("Erro ao alterar status");
      toast.success(modelo.ativo ? "Modelo desativado" : "Modelo ativado");
      carregarModelos();
    } catch (err: unknown) {
      toast.error("Erro ao alterar status", { description: err instanceof Error ? err.message : "Erro desconhecido" });
    }
  };

  const handleExcluirModelo = async (modelo: ModeloDinamicoItem) => {
    if (!confirm(`Excluir o modelo "${modelo.nome}"? Esta ação não pode ser desfeita.`)) return;
    try {
      const r = await fetch(`/api/admin/modelos/${modelo.id}`, { method: "DELETE", credentials: "include" });
      if (!r.ok) throw new Error("Erro ao excluir");
      toast.success("Modelo excluído");
      carregarModelos();
    } catch (err: unknown) {
      toast.error("Erro ao excluir", { description: err instanceof Error ? err.message : "Erro desconhecido" });
    }
  };

  const handleVerSubmissoes = async (modelo: ModeloDinamicoItem) => {
    setSubmissoesDialog(modelo);
    setLoadingSubmissoes(true);
    try {
      const r = await fetch(`/api/admin/modelos/${modelo.id}/submissoes`, { credentials: "include" });
      if (!r.ok) throw new Error("Erro ao carregar submissões");
      const data = await r.json();
      setSubmissoes(data);
    } catch (err: unknown) {
      toast.error("Erro ao carregar submissões", { description: err instanceof Error ? err.message : "Erro desconhecido" });
    } finally {
      setLoadingSubmissoes(false);
    }
  };

  const handleBaixarSubmissao = async (sub: SubmissaoModeloItem) => {
    try {
      window.open(`/api/admin/submissoes/${sub.id}/download`, "_blank");
    } catch (err: unknown) {
      toast.error("Erro ao baixar documento");
    }
  };

  const copiarLink = (slug: string, nome: string) => {
    const url = `${origin}/modelo/${slug}`;
    navigator.clipboard.writeText(url).then(() => {
      toast.success("Link copiado!", { description: `${nome} — ${url}` });
    }).catch(() => toast.error("Não foi possível copiar o link."));
  };

  return (
    <div className="space-y-5">
      <div className="flex items-center justify-between flex-wrap gap-3">
        <div>
          <h2 className="text-lg font-semibold">Meus Modelos de Procuração</h2>
          <p className="text-muted-foreground text-sm mt-1">
            Faça upload de modelos .docx personalizados. O sistema preencherá automaticamente os dados do cliente (nome, CPF, endereço, data, etc.).
          </p>
        </div>
        <Button onClick={() => setUploadDialog(true)} className="gap-2 bg-purple-700 hover:bg-purple-800 text-white">
          <Upload size={15} />Novo Modelo
        </Button>
      </div>

      {loadingModelos ? (
        <div className="flex items-center justify-center py-12"><Loader2 size={24} className="animate-spin text-muted-foreground" /></div>
      ) : modelos.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-16 text-center">
          <FolderOpen size={40} className="text-muted-foreground/40 mb-3" />
          <p className="text-muted-foreground text-sm">Nenhum modelo cadastrado ainda.</p>
          <p className="text-muted-foreground text-xs mt-1">Clique em "Novo Modelo" para fazer upload de um .docx com os mesmos placeholders da Procuração Ad Judicia.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {modelos.map((m) => (
            <div key={m.id} className={`rounded-xl border bg-card p-5 shadow-sm flex flex-col gap-3 ${!m.ativo ? "opacity-60" : ""}`}>
              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-lg bg-purple-100 flex items-center justify-center flex-shrink-0">
                  <FileText size={18} className="text-purple-600" />
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2">
                    <p className="font-semibold text-sm truncate">{m.nome}</p>
                    {m.ativo ? (
                      <Badge className="text-[10px] h-4 px-1.5 bg-emerald-100 text-emerald-700 border-emerald-200 hover:bg-emerald-100">Ativo</Badge>
                    ) : (
                      <Badge variant="outline" className="text-[10px] h-4 px-1.5 text-slate-500">Inativo</Badge>
                    )}
                  </div>
                  {m.descricao && <p className="text-xs text-muted-foreground mt-0.5 line-clamp-2">{m.descricao}</p>}
                  <p className="text-xs text-muted-foreground mt-1">Criado em {formatarData(m.criadoEm)}</p>
                </div>
              </div>
              <div className="flex items-center gap-2 bg-muted/50 rounded-lg px-3 py-2 border">
                <Link2 size={12} className="text-muted-foreground flex-shrink-0" />
                <span className="text-xs font-mono text-muted-foreground truncate flex-1">{origin}/modelo/{m.slug}</span>
              </div>
              <div className="flex gap-2 flex-wrap">
                <Button size="sm" variant="default" className="flex-1 gap-1.5 h-8 text-xs bg-[#1a2744] hover:bg-[#243660]" onClick={() => copiarLink(m.slug, m.nome)}>
                  <Copy size={12} />Copiar link
                </Button>
                <Button size="sm" variant="outline" className="h-8 text-xs gap-1.5" onClick={() => handleVerSubmissoes(m)}>
                  <Eye size={12} />Submissões
                </Button>
                <Button size="sm" variant="outline" className={`h-8 text-xs gap-1.5 ${m.ativo ? "text-amber-600 border-amber-300" : "text-emerald-600 border-emerald-300"}`} onClick={() => handleToggle(m)}>
                  {m.ativo ? <ToggleLeft size={12} /> : <ToggleRight size={12} />}
                  {m.ativo ? "Desativar" : "Ativar"}
                </Button>
                <Button size="sm" variant="outline" className="h-8 text-xs gap-1.5 text-red-600 border-red-300 hover:bg-red-50" onClick={() => handleExcluirModelo(m)}>
                  <Trash2 size={12} />Excluir
                </Button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Dialog de upload de novo modelo */}
      <Dialog open={uploadDialog} onOpenChange={(open) => { if (!open) { setUploadDialog(false); setUploadNome(""); setUploadDesc(""); setUploadFile(null); } }}>
        <DialogContent className="max-w-lg">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2"><Upload size={18} className="text-purple-600" />Novo Modelo de Procuração</DialogTitle>
            <DialogDescription>
              Faça upload de um arquivo .docx com os mesmos placeholders da Procuração Ad Judicia. O sistema preencherá automaticamente os dados do cliente.
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-4 py-2">
            <div className="space-y-1.5">
              <label className="text-sm font-semibold">Nome do Modelo <span className="text-red-500">*</span></label>
              <Input value={uploadNome} onChange={e => setUploadNome(e.target.value)} placeholder="Ex.: Procuração Especial para Inventário" />
            </div>
            <div className="space-y-1.5">
              <label className="text-sm font-semibold">Descrição <span className="text-muted-foreground font-normal text-xs">(opcional)</span></label>
              <Textarea value={uploadDesc} onChange={e => setUploadDesc(e.target.value)} placeholder="Ex.: Procuração para representação em inventário extrajudicial" rows={2} className="resize-none" />
            </div>
            <div className="space-y-1.5">
              <label className="text-sm font-semibold">Arquivo .docx <span className="text-red-500">*</span></label>
              <div className="border-2 border-dashed border-slate-200 rounded-lg p-4 text-center cursor-pointer hover:border-purple-300 hover:bg-purple-50/30 transition-colors" onClick={() => document.getElementById('upload-docx')?.click()}>
                {uploadFile ? (
                  <div className="flex items-center justify-center gap-2">
                    <FileText size={16} className="text-purple-600" />
                    <span className="text-sm font-medium text-purple-700">{uploadFile.name}</span>
                    <button onClick={(e) => { e.stopPropagation(); setUploadFile(null); }} className="text-slate-400 hover:text-red-500"><X size={14} /></button>
                  </div>
                ) : (
                  <div>
                    <Upload size={24} className="text-slate-300 mx-auto mb-2" />
                    <p className="text-sm text-slate-500">Clique para selecionar o arquivo .docx</p>
                    <p className="text-xs text-slate-400 mt-1">Use os mesmos placeholders da Procuração Ad Judicia</p>
                  </div>
                )}
              </div>
              <input id="upload-docx" type="file" accept=".docx,application/vnd.openxmlformats-officedocument.wordprocessingml.document" className="hidden" onChange={e => setUploadFile(e.target.files?.[0] ?? null)} />
            </div>
            <div className="bg-blue-50 border border-blue-200 rounded-lg p-3">
              <p className="text-xs text-blue-800 font-semibold mb-1">Placeholders suportados:</p>
              <p className="text-xs text-blue-700 font-mono leading-relaxed">
                {`"Nome", "nacionalidade", "estado civil", "Profissão", "inscrito(a)", "CPF", "RG", "naturalidade", "nome do pai", "nome da mãe", "logradouro", "quadra", "lote", "setor", "cidade", "estado", "CEP", "data"`}
              </p>
            </div>
          </div>
          <DialogFooter className="gap-2">
            <Button variant="outline" onClick={() => { setUploadDialog(false); setUploadNome(""); setUploadDesc(""); setUploadFile(null); }}>Cancelar</Button>
            <Button onClick={handleUpload} disabled={uploading || !uploadNome.trim() || !uploadFile} className="gap-2 bg-purple-700 hover:bg-purple-800">
              {uploading ? <Loader2 size={14} className="animate-spin" /> : <Upload size={14} />}
              {uploading ? "Enviando..." : "Fazer Upload"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Dialog de submissões do modelo */}
      <Dialog open={!!submissoesDialog} onOpenChange={(open) => !open && setSubmissoesDialog(null)}>
        <DialogContent className="max-w-3xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2"><Eye size={18} className="text-purple-600" />Submissões — {submissoesDialog?.nome}</DialogTitle>
            <DialogDescription>Clientes que preencheram o formulário deste modelo.</DialogDescription>
          </DialogHeader>
          {loadingSubmissoes ? (
            <div className="flex items-center justify-center py-8"><Loader2 size={24} className="animate-spin text-muted-foreground" /></div>
          ) : submissoes.length === 0 ? (
            <div className="text-center py-8 text-muted-foreground text-sm">Nenhuma submissão ainda.</div>
          ) : (
            <div className="overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Nome</TableHead>
                    <TableHead>CPF</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Data</TableHead>
                    <TableHead className="text-right">Ações</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {submissoes.map((s) => (
                    <TableRow key={s.id}>
                      <TableCell className="font-medium text-sm">{s.nome}</TableCell>
                      <TableCell className="text-sm font-mono">{s.cpf}</TableCell>
                      <TableCell><StatusBadge status={s.status} /></TableCell>
                      <TableCell className="text-xs text-muted-foreground">{formatarData(s.criadoEm)}</TableCell>
                      <TableCell className="text-right">
                        <Button size="sm" variant="outline" className="h-7 text-xs gap-1.5" onClick={() => handleBaixarSubmissao(s)}>
                          <Download size={12} />Baixar
                        </Button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}

// ─── Painel de Links ──────────────────────────────────────────────────────
function PainelLinks() {
  const origin = window.location.origin;
  const links = [
    { label: "Procuração Ad Judicia", desc: "Procuração particular com poderes ad judicia", path: "/procuracao", icon: <FileSignature size={18} className="text-amber-600" /> },
    { label: "Procuração PA (Menor)", desc: "Representação de menor por genitora/responsável", path: "/procuracao-pa", icon: <Baby size={18} className="text-blue-600" /> },
    { label: "Procuração Weber e Ana Laura", desc: "Procuração ad judicia com dois outorgados", path: "/procuracao-weber-ana", icon: <FileSignature size={18} className="text-rose-600" /> },
    { label: "Contrato de Honorários", desc: "Contrato de honorários advocatícios", path: "/contrato", icon: <ClipboardList size={18} className="text-purple-600" /> },
    { label: "Declaração de Hipossuficiência", desc: "Declaração para gratuidade de justiça", path: "/declaracao", icon: <Scale size={18} className="text-emerald-600" /> },
  ];

  const copiar = (path: string, label: string) => {
    const url = `${origin}${path}`;
    navigator.clipboard.writeText(url).then(() => {
      toast.success("Link copiado!", { description: `${label} — ${url}` });
    }).catch(() => {
      toast.error("Não foi possível copiar o link.");
    });
  };

  return (
    <div className="space-y-4">
      <div>
        <h2 className="text-lg font-semibold">Links dos Formulários</h2>
        <p className="text-muted-foreground text-sm mt-1">
          Copie o link do documento que deseja enviar ao cliente pelo WhatsApp ou e-mail.
        </p>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {links.map((l) => (
          <div key={l.path} className="rounded-xl border bg-card p-5 shadow-sm flex flex-col gap-3">
            <div className="flex items-start gap-3">
              <div className="w-10 h-10 rounded-lg bg-muted flex items-center justify-center flex-shrink-0">
                {l.icon}
              </div>
              <div className="flex-1 min-w-0">
                <p className="font-semibold text-sm">{l.label}</p>
                <p className="text-xs text-muted-foreground mt-0.5">{l.desc}</p>
              </div>
            </div>
            <div className="flex items-center gap-2 bg-muted/50 rounded-lg px-3 py-2 border">
              <Link2 size={12} className="text-muted-foreground flex-shrink-0" />
              <span className="text-xs font-mono text-muted-foreground truncate flex-1">
                {origin}{l.path}
              </span>
            </div>
            <div className="flex gap-2">
              <Button
                size="sm"
                variant="default"
                className="flex-1 gap-1.5 h-8 text-xs bg-[#1a2744] hover:bg-[#243660]"
                onClick={() => copiar(l.path, l.label)}
              >
                <Copy size={12} />
                Copiar link
              </Button>
              <Button
                size="sm"
                variant="outline"
                className="h-8 text-xs gap-1.5"
                onClick={() => window.open(`${origin}${l.path}`, "_blank")}
              >
                <FileText size={12} />
                Abrir
              </Button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

// ─── Tabela genérica de documentos ────────────────────────────────────────
interface DocItem {
  id: number;
  nome: string;
  cpf?: string | null;
  cidade?: string | null;
  criadoEm?: Date | string | number | null;
  status?: string | null;
  observacoes?: string | null;
  nomeMenor?: string | null;
  tipoAcao?: string | null; // usado para contratos: indica se Seção III já foi preenchida
}

interface TabelaDocumentosProps {
  tipo: "procuracao" | "contrato" | "declaracao" | "procuracaoPa" | "procuracaoWeberAna";
  titulo: string;
  items: DocItem[] | undefined;
  isLoading: boolean;
  error: unknown;
  onBaixar: (id: number, nome: string) => void;
  onPreencherSecaoIII?: (id: number, nome: string) => void; // exclusivo para contratos
  onExcluir: (id: number, nome: string) => void;
  onObservacao: (id: number, nome: string, obs: string | null | undefined) => void;
  baixandoId: number | null;
  deletandoId: number | null;
  onRefresh: () => void;
}

function TabelaDocumentos({
  tipo, titulo, items, isLoading, error, onBaixar, onPreencherSecaoIII, onExcluir, onObservacao,
  baixandoId, deletandoId, onRefresh,
}: TabelaDocumentosProps) {
  const [filtro, setFiltro] = useState<"todos" | "pendente" | "gerada" | "gerado">("todos");
  const [busca, setBusca] = useState("");

  const base = filtro === "todos" ? (items ?? []) : (items ?? []).filter(p => p.status === filtro || (filtro === "gerada" && p.status === "gerado"));
  const term = busca.trim().toLowerCase();
  const digits = term.replace(/\D/g, "");
  const lista = term ? base.filter(p =>
    p.nome.toLowerCase().includes(term) ||
    (p.nomeMenor && p.nomeMenor.toLowerCase().includes(term)) ||
    (digits.length > 0 && p.cpf && p.cpf.replace(/\D/g, "").includes(digits))
  ) : base;

  const pendentes = (items ?? []).filter(p => p.status === "pendente").length;
  const geradas = (items ?? []).filter(p => p.status === "gerada" || p.status === "gerado").length;

  return (
    <div className="space-y-4">
      {/* Header */}
      <div className="flex items-center justify-between flex-wrap gap-3">
        <div>
          <h2 className="text-lg font-semibold">{titulo}</h2>
          <p className="text-muted-foreground text-sm mt-0.5">
            {items?.length ?? 0} formulário{(items?.length ?? 0) !== 1 ? "s" : ""} recebido{(items?.length ?? 0) !== 1 ? "s" : ""}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm" onClick={onRefresh} className="gap-2 h-8 text-xs">
            <RefreshCw size={13} />Atualizar
          </Button>
        </div>
      </div>

      {/* Cards resumo */}
      <div className="grid grid-cols-3 gap-3">
        <div className="rounded-xl border bg-card p-4 shadow-sm">
          <div className="flex items-center gap-2">
            <Users size={15} className="text-blue-600" />
            <p className="text-xs text-muted-foreground">Total</p>
          </div>
          <p className="text-2xl font-bold mt-1">{items?.length ?? "—"}</p>
        </div>
        <div className="rounded-xl border bg-card p-4 shadow-sm">
          <div className="flex items-center gap-2">
            <Clock size={15} className="text-amber-600" />
            <p className="text-xs text-muted-foreground">Pendentes</p>
          </div>
          <p className="text-2xl font-bold mt-1">{pendentes}</p>
        </div>
        <div className="rounded-xl border bg-card p-4 shadow-sm">
          <div className="flex items-center gap-2">
            <CheckCircle2 size={15} className="text-emerald-600" />
            <p className="text-xs text-muted-foreground">Gerados</p>
          </div>
          <p className="text-2xl font-bold mt-1">{geradas}</p>
        </div>
      </div>

      {/* Tabela */}
      <div className="rounded-xl border bg-card shadow-sm overflow-hidden">
        <div className="px-5 py-3 border-b flex flex-wrap items-center gap-2">
          <FileText size={15} className="text-muted-foreground" />
          <h3 className="font-semibold text-sm">Formulários</h3>
          <div className="relative ml-auto w-full sm:w-52">
            <Search size={13} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-muted-foreground pointer-events-none" />
            <Input value={busca} onChange={(e) => setBusca(e.target.value)} placeholder="Buscar por nome ou CPF..." className="h-7 pl-8 pr-7 text-xs" />
            {busca && (
              <button onClick={() => setBusca("")} className="absolute right-2 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground">
                <X size={12} />
              </button>
            )}
          </div>
          <div className="flex items-center gap-1">
            <Button size="sm" variant={filtro === "todos" ? "default" : "outline"} onClick={() => setFiltro("todos")} className={`h-7 text-xs px-2.5 ${filtro === "todos" ? "bg-[#1a2744] hover:bg-[#243660]" : ""}`}>Todos</Button>
            <Button size="sm" variant={filtro === "pendente" ? "default" : "outline"} onClick={() => setFiltro("pendente")} className={`h-7 text-xs px-2.5 gap-1 ${filtro === "pendente" ? "bg-amber-500 hover:bg-amber-600 border-amber-500" : "text-amber-600 border-amber-300 hover:bg-amber-50"}`}><Clock size={10} />Pendentes</Button>
            <Button size="sm" variant={filtro === "gerada" ? "default" : "outline"} onClick={() => setFiltro("gerada")} className={`h-7 text-xs px-2.5 gap-1 ${filtro === "gerada" ? "bg-emerald-600 hover:bg-emerald-700 border-emerald-600" : "text-emerald-700 border-emerald-300 hover:bg-emerald-50"}`}><CheckCircle2 size={10} />Gerados</Button>
          </div>
          <Badge variant="secondary" className="text-xs">{lista.length} resultado{lista.length !== 1 ? "s" : ""}</Badge>
        </div>

        {isLoading ? (
          <div className="flex items-center justify-center py-12 gap-3 text-muted-foreground">
            <Loader2 size={20} className="animate-spin" /><span className="text-sm">Carregando...</span>
          </div>
        ) : error ? (
          <div className="flex flex-col items-center justify-center py-12 gap-2 text-center px-4">
            <ShieldAlert size={24} className="text-red-400" />
            <p className="text-sm text-muted-foreground">Erro ao carregar os registros.</p>
          </div>
        ) : lista.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12 gap-3 text-center px-4">
            <div className="w-12 h-12 rounded-full bg-muted flex items-center justify-center">
              <FileText size={20} className="text-muted-foreground" />
            </div>
            <p className="text-sm font-medium">Nenhum registro encontrado</p>
            <p className="text-xs text-muted-foreground max-w-xs">
              {busca.trim() ? `Nenhum resultado para "${busca.trim()}".` : "Nenhum formulário recebido ainda."}
            </p>
          </div>
        ) : (
          <>
            {/* Tabela desktop */}
            <div className="hidden md:block overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead className="w-[40px]">#</TableHead>
                    <TableHead>{tipo === "procuracaoPa" ? "Menor / Genitora" : "Nome"}</TableHead>
                    <TableHead>CPF</TableHead>
                    {tipo !== "procuracaoPa" && <TableHead>Cidade</TableHead>}
                    <TableHead>Recebido em</TableHead>
                    <TableHead>Status</TableHead>
                    <TableHead>Obs.</TableHead>
                    <TableHead className="text-right">Ações</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {lista.map((p) => (
                    <TableRow key={p.id} className="hover:bg-muted/30 transition-colors">
                      <TableCell className="text-muted-foreground text-xs font-mono">{p.id}</TableCell>
                      <TableCell className="font-medium">
                        {tipo === "procuracaoPa" ? (
                          <div>
                            <p className="font-semibold text-sm">{p.nomeMenor ?? p.nome}</p>
                            <p className="text-xs text-muted-foreground">{p.nome}</p>
                          </div>
                        ) : p.nome}
                      </TableCell>
                      <TableCell className="font-mono text-sm text-muted-foreground">{p.cpf ?? "—"}</TableCell>
                      {tipo !== "procuracaoPa" && <TableCell className="text-sm text-muted-foreground">{p.cidade ?? "—"}</TableCell>}
                      <TableCell className="text-sm text-muted-foreground whitespace-nowrap">{formatarData(p.criadoEm)}</TableCell>
                      <TableCell><StatusBadge status={p.status} /></TableCell>
                      <TableCell>
                        <button
                          onClick={() => onObservacao(p.id, tipo === "procuracaoPa" ? (p.nomeMenor ?? p.nome) : p.nome, p.observacoes)}
                          className="text-muted-foreground hover:text-foreground transition-colors"
                          title={p.observacoes ? p.observacoes : "Adicionar observação"}
                        >
                          <MessageSquarePlus size={15} className={p.observacoes ? "text-blue-500" : ""} />
                        </button>
                      </TableCell>
                      <TableCell className="text-right">
                        <div className="flex items-center justify-end gap-2">
                          {/* Para contratos sem Seção III: mostrar botão de preenchimento em destaque */}
                          {tipo === "contrato" && !p.tipoAcao && onPreencherSecaoIII ? (
                            <Button size="sm" variant="default" onClick={() => onPreencherSecaoIII(p.id, p.nome)} disabled={baixandoId === p.id} className="gap-1.5 h-8 text-xs bg-amber-500 hover:bg-amber-600 text-white">
                              <ClipboardList size={12} />
                              Preencher Dados do Processo
                            </Button>
                          ) : (
                            <Button size="sm" variant="default" onClick={() => onBaixar(p.id, tipo === "procuracaoPa" ? (p.nomeMenor ?? p.nome) : p.nome)} disabled={baixandoId === p.id} className="gap-1.5 h-8 text-xs bg-[#1a2744] hover:bg-[#243660]">
                              {baixandoId === p.id ? <Loader2 size={12} className="animate-spin" /> : <Download size={12} />}
                              Baixar .docx
                            </Button>
                          )}
                          <Button size="sm" variant="outline" onClick={() => onExcluir(p.id, tipo === "procuracaoPa" ? (p.nomeMenor ?? p.nome) : p.nome)} disabled={deletandoId === p.id} className="gap-1.5 h-8 text-xs text-destructive hover:text-destructive hover:bg-destructive/10 border-destructive/30">
                            {deletandoId === p.id ? <Loader2 size={12} className="animate-spin" /> : <Trash2 size={12} />}
                            Excluir
                          </Button>
                        </div>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>

            {/* Cards mobile */}
            <div className="md:hidden divide-y">
              {lista.map((p) => (
                <div key={p.id} className="p-4 space-y-3">
                  <div className="flex items-start justify-between gap-2">
                    <div>
                      <p className="font-semibold text-sm">{tipo === "procuracaoPa" ? (p.nomeMenor ?? p.nome) : p.nome}</p>
                      {tipo === "procuracaoPa" && <p className="text-xs text-muted-foreground">{p.nome}</p>}
                      <p className="text-xs text-muted-foreground font-mono">{p.cpf ?? "—"}</p>
                    </div>
                    <div className="flex items-center gap-1.5 shrink-0">
                      <StatusBadge status={p.status} />
                      <Badge variant="outline" className="text-xs">#{p.id}</Badge>
                    </div>
                  </div>
                  <div className="flex items-center gap-4 text-xs text-muted-foreground">
                    {tipo !== "procuracaoPa" && <span>{p.cidade ?? "—"}</span>}
                    <span>·</span>
                    <span>{formatarData(p.criadoEm)}</span>
                  </div>
                  {p.observacoes && (
                    <p className="text-xs text-blue-600 bg-blue-50 rounded px-2 py-1 border border-blue-100">{p.observacoes}</p>
                  )}
                  <div className="flex gap-2">
                    {tipo === "contrato" && !p.tipoAcao && onPreencherSecaoIII ? (
                      <Button size="sm" onClick={() => onPreencherSecaoIII(p.id, p.nome)} disabled={baixandoId === p.id} className="flex-1 gap-1.5 h-8 text-xs bg-amber-500 hover:bg-amber-600 text-white">
                        <ClipboardList size={12} />
                        Preencher Dados do Processo
                      </Button>
                    ) : (
                      <Button size="sm" onClick={() => onBaixar(p.id, tipo === "procuracaoPa" ? (p.nomeMenor ?? p.nome) : p.nome)} disabled={baixandoId === p.id} className="flex-1 gap-1.5 h-8 text-xs bg-[#1a2744] hover:bg-[#243660]">
                        {baixandoId === p.id ? <Loader2 size={12} className="animate-spin" /> : <Download size={12} />}
                        Baixar .docx
                      </Button>
                    )}
                    <Button size="sm" variant="outline" onClick={() => onObservacao(p.id, tipo === "procuracaoPa" ? (p.nomeMenor ?? p.nome) : p.nome, p.observacoes)} className="h-8 text-xs gap-1 text-blue-600 border-blue-200 hover:bg-blue-50">
                      <MessageSquarePlus size={12} />
                    </Button>
                    <Button size="sm" variant="outline" onClick={() => onExcluir(p.id, tipo === "procuracaoPa" ? (p.nomeMenor ?? p.nome) : p.nome)} disabled={deletandoId === p.id} className="h-8 text-xs text-destructive hover:text-destructive border-destructive/30">
                      {deletandoId === p.id ? <Loader2 size={12} className="animate-spin" /> : <Trash2 size={12} />}
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          </>
        )}
      </div>
    </div>
  );
}

// ─── Conteúdo principal do painel ─────────────────────────────────────────
function AdminContent() {
  const { user } = useAuth();
  const [deletandoId, setDeletandoId] = useState<number | null>(null);
  const [baixandoId, setBaixandoId] = useState<number | null>(null);
  const [confirmarExclusao, setConfirmarExclusao] = useState<{ id: number; nome: string; tipo: string } | null>(null);
  const [obsDialog, setObsDialog] = useState<{ id: number; nome: string; tipo: string; texto: string } | null>(null);
  const [salvandoObs, setSalvandoObs] = useState(false);
  const [abaAtiva, setAbaAtiva] = useState("links");
  const [secaoIIIDialog, setSecaoIIIDialog] = useState<{ id: number; nome: string } | null>(null);
  const [secaoIII, setSecaoIII] = useState({
    tipoAcao: "", tribunal: "", faseProcessual: "",
    valorTotal: "", valorEntrada: "", dataEntrada: "",
    numParcelas: "1", valorParcela: "", dataPrimeiraParcela: "",
  });
  const [salvandoSecaoIII, setSalvandoSecaoIII] = useState(false);

  const utils = trpc.useUtils();

  // ─── Queries ───────────────────────────────────────────────────────────
  const { data: procuracoes, isLoading: loadP, error: errP } = trpc.procuracao.listar.useQuery();
  const { data: contratos, isLoading: loadC, error: errC } = trpc.contrato.listar.useQuery();
  const { data: declaracoes, isLoading: loadD, error: errD } = trpc.declaracao.listar.useQuery();
  const { data: procuracoesPa, isLoading: loadPA, error: errPA } = trpc.procuracaoPa.listar.useQuery();
  const { data: procuracoeswA, isLoading: loadWA, error: errWA } = trpc.procuracaoWeberAna.listar.useQuery();

  // ─── Mutations ─────────────────────────────────────────────────────────
  const marcarPMutation = trpc.procuracao.marcarGerada.useMutation({ onSuccess: () => utils.procuracao.listar.invalidate() });
  const marcarCMutation = trpc.contrato.marcarGerado.useMutation({ onSuccess: () => utils.contrato.listar.invalidate() });
  const marcarDMutation = trpc.declaracao.marcarGerada.useMutation({ onSuccess: () => utils.declaracao.listar.invalidate() });
  const marcarPAMutation = trpc.procuracaoPa.marcarGerada.useMutation({ onSuccess: () => utils.procuracaoPa.listar.invalidate() });
  const marcarWAMutation = trpc.procuracaoWeberAna.marcarGerada.useMutation({ onSuccess: () => utils.procuracaoWeberAna.listar.invalidate() });

  const deletarPMutation = trpc.procuracao.deletar.useMutation({ onSuccess: () => { utils.procuracao.listar.invalidate(); toast.success("Excluído com sucesso."); setConfirmarExclusao(null); }, onError: (e) => toast.error("Erro ao excluir", { description: e.message }), onSettled: () => setDeletandoId(null) });
  const deletarCMutation = trpc.contrato.deletar.useMutation({ onSuccess: () => { utils.contrato.listar.invalidate(); toast.success("Excluído com sucesso."); setConfirmarExclusao(null); }, onError: (e) => toast.error("Erro ao excluir", { description: e.message }), onSettled: () => setDeletandoId(null) });
  const deletarDMutation = trpc.declaracao.deletar.useMutation({ onSuccess: () => { utils.declaracao.listar.invalidate(); toast.success("Excluído com sucesso."); setConfirmarExclusao(null); }, onError: (e) => toast.error("Erro ao excluir", { description: e.message }), onSettled: () => setDeletandoId(null) });
  const deletarPAMutation = trpc.procuracaoPa.deletar.useMutation({ onSuccess: () => { utils.procuracaoPa.listar.invalidate(); toast.success("Excluído com sucesso."); setConfirmarExclusao(null); }, onError: (e) => toast.error("Erro ao excluir", { description: e.message }), onSettled: () => setDeletandoId(null) });
  const deletarWAMutation = trpc.procuracaoWeberAna.deletar.useMutation({ onSuccess: () => { utils.procuracaoWeberAna.listar.invalidate(); toast.success("Excluído com sucesso."); setConfirmarExclusao(null); }, onError: (e) => toast.error("Erro ao excluir", { description: e.message }), onSettled: () => setDeletandoId(null) });

  const obsP = trpc.procuracao.salvarObservacoes.useMutation({ onSuccess: () => utils.procuracao.listar.invalidate() });
  const obsC = trpc.contrato.salvarObservacoes.useMutation({ onSuccess: () => utils.contrato.listar.invalidate() });
  const obsD = trpc.declaracao.salvarObservacoes.useMutation({ onSuccess: () => utils.declaracao.listar.invalidate() });
  const obsPA = trpc.procuracaoPa.salvarObservacoes.useMutation({ onSuccess: () => utils.procuracaoPa.listar.invalidate() });
  const obsWA = trpc.procuracaoWeberAna.salvarObservacoes.useMutation({ onSuccess: () => utils.procuracaoWeberAna.listar.invalidate() });

  if (user && user.role !== "admin") return <AcessoNegado />;

  // ─── Salvar Seção III e baixar contrato ──────────────────────────────────
  const handleBaixarContrato = async (id: number, nome: string) => {
    setBaixandoId(id);
    try {
      const response = await fetch(`/api/contrato-por-id/${id}`, { credentials: "include" });
      if (!response.ok) {
        const err = await response.json().catch(() => ({}));
        throw new Error(err?.erro || "Erro ao gerar o contrato.");
      }
      const blob = await response.blob();
      const url = URL.createObjectURL(blob);
      const nomeArq = response.headers.get("Content-Disposition")?.match(/filename="(.+)"/)?.[1] ?? `Contrato_${nome.replace(/\s+/g, "_").toUpperCase()}.docx`;
      const a = document.createElement("a"); a.href = url; a.download = nomeArq;
      document.body.appendChild(a); a.click(); a.remove(); URL.revokeObjectURL(url);
      toast.success("Download iniciado!", { description: nome });
      marcarCMutation.mutate({ id });
    } catch (err: unknown) {
      toast.error("Erro ao baixar contrato", { description: err instanceof Error ? err.message : "Erro desconhecido." });
    } finally {
      setBaixandoId(null);
    }
  };

  const salvarSecaoIII = async () => {
    if (!secaoIIIDialog) return;
    setSalvandoSecaoIII(true);
    try {
      const response = await fetch(`/api/contrato/${secaoIIIDialog.id}/secao-iii`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          tipoAcao: secaoIII.tipoAcao.trim(),
          tribunal: secaoIII.tribunal.trim(),
          faseProcessual: secaoIII.faseProcessual.trim(),
          valorTotal: secaoIII.valorTotal.trim(),
          valorEntrada: secaoIII.valorEntrada.trim(),
          dataEntrada: secaoIII.dataEntrada.trim(),
          numParcelas: parseInt(secaoIII.numParcelas, 10),
          valorParcela: secaoIII.valorParcela.trim(),
          dataPrimeiraParcela: secaoIII.dataPrimeiraParcela.trim(),
        }),
      });
      if (!response.ok) {
        const err = await response.json().catch(() => ({}));
        throw new Error(err?.erro || "Erro ao salvar Seção III.");
      }
      toast.success("Seção III salva! Gerando documento...");
      const id = secaoIIIDialog.id;
      const nome = secaoIIIDialog.nome;
      setSecaoIIIDialog(null);
      await handleBaixarContrato(id, nome);
      utils.contrato.listar.invalidate();
    } catch (err: unknown) {
      toast.error("Erro ao salvar Seção III", { description: err instanceof Error ? err.message : "Erro desconhecido." });
    } finally {
      setSalvandoSecaoIII(false);
    }
  };

  // ─── Handlers de download ──────────────────────────────────────────────
  const handleBaixar = async (tipo: string, id: number, nome: string) => {
    // Para contratos: verificar se a Seção III já está preenchida
    if (tipo === "contrato") {
      const contrato = contratos?.find(c => c.id === id);
      if (!contrato?.tipoAcao) {
        // Seção III não preenchida: abrir modal
        setSecaoIII({ tipoAcao: "", tribunal: "", faseProcessual: "", valorTotal: "", valorEntrada: "", dataEntrada: "", numParcelas: "1", valorParcela: "", dataPrimeiraParcela: "" });
        setSecaoIIIDialog({ id, nome });
        return;
      }
      // Seção III já preenchida: baixar diretamente
      await handleBaixarContrato(id, nome);
      return;
    }
    setBaixandoId(id);
    const endpointMap: Record<string, string> = {
      procuracao: `/api/gerar-procuracao-por-id/${id}`,
      declaracao: `/api/declaracao-por-id/${id}`,
      procuracaoPa: `/api/procuracao-pa-por-id/${id}`,
      procuracaoWeberAna: `/api/procuracao-weber-ana-por-id/${id}`,
    };
    try {
      const response = await fetch(endpointMap[tipo], { credentials: "include" });
      if (!response.ok) {
        const err = await response.json().catch(() => ({}));
        throw new Error(err?.erro || "Erro ao gerar o documento.");
      }
      const blob = await response.blob();
      const url = URL.createObjectURL(blob);
      const nomeArquivo = response.headers.get("Content-Disposition")?.match(/filename="(.+)"/)?.[1] ?? `${tipo}_${nome.replace(/\s+/g, "_").toUpperCase()}.docx`;
      const a = document.createElement("a"); a.href = url; a.download = nomeArquivo;
      document.body.appendChild(a); a.click(); a.remove(); URL.revokeObjectURL(url);
      toast.success("Download iniciado!", { description: nome });
      if (tipo === "procuracao") marcarPMutation.mutate({ id });
      else if (tipo === "declaracao") marcarDMutation.mutate({ id });
      else if (tipo === "procuracaoPa") marcarPAMutation.mutate({ id });
      else if (tipo === "procuracaoWeberAna") marcarWAMutation.mutate({ id });
    } catch (err: unknown) {
      toast.error("Erro ao baixar documento", { description: err instanceof Error ? err.message : "Erro desconhecido." });
    } finally {
      setBaixandoId(null);
    }
  };

  const handleExcluir = (tipo: string, id: number, nome: string) => setConfirmarExclusao({ id, nome, tipo });

  const confirmarDelete = () => {
    if (!confirmarExclusao) return;
    setDeletandoId(confirmarExclusao.id);
    const { id, tipo } = confirmarExclusao;
    if (tipo === "procuracao") deletarPMutation.mutate({ id });
    else if (tipo === "contrato") deletarCMutation.mutate({ id });
    else if (tipo === "declaracao") deletarDMutation.mutate({ id });
    else if (tipo === "procuracaoPa") deletarPAMutation.mutate({ id });
    else if (tipo === "procuracaoWeberAna") deletarWAMutation.mutate({ id });
  };

  const handleObservacao = (tipo: string, id: number, nome: string, obs: string | null | undefined) => {
    setObsDialog({ id, nome, tipo, texto: obs ?? "" });
  };

  const salvarObservacao = async () => {
    if (!obsDialog) return;
    setSalvandoObs(true);
    try {
      const { id, tipo, texto } = obsDialog;
      if (tipo === "procuracao") await obsP.mutateAsync({ id, observacoes: texto });
      else if (tipo === "contrato") await obsC.mutateAsync({ id, observacoes: texto });
      else if (tipo === "declaracao") await obsD.mutateAsync({ id, observacoes: texto });
      else if (tipo === "procuracaoPa") await obsPA.mutateAsync({ id, observacoes: texto });
      else if (tipo === "procuracaoWeberAna") await obsWA.mutateAsync({ id, observacoes: texto });
      toast.success("Observação salva!");
      setObsDialog(null);
    } catch (err: unknown) {
      toast.error("Erro ao salvar observação", { description: err instanceof Error ? err.message : "Erro desconhecido." });
    } finally {
      setSalvandoObs(false);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between flex-wrap gap-3">
        <div>
          <h1 className="text-2xl font-semibold tracking-tight">Painel do Advogado</h1>
          <p className="text-muted-foreground text-sm mt-1">Gerencie os formulários enviados pelos clientes e baixe os documentos.</p>
        </div>
      </div>

      <Tabs value={abaAtiva} onValueChange={setAbaAtiva}>
        <TabsList className="flex-wrap h-auto gap-1 mb-2">
          <TabsTrigger value="links" className="gap-1.5 text-xs font-semibold">
            <Link2 size={13} />Enviar Link ao Cliente
          </TabsTrigger>
          <TabsTrigger value="procuracao" className="gap-1.5 text-xs">
            <FileSignature size={13} />Procuração Ad Judicia
            {(procuracoes?.filter(p => p.status === "pendente").length ?? 0) > 0 && (
              <Badge className="ml-1 h-4 px-1.5 text-[10px] bg-amber-500 text-white border-0">{procuracoes!.filter(p => p.status === "pendente").length}</Badge>
            )}
          </TabsTrigger>
          <TabsTrigger value="procuracaoPa" className="gap-1.5 text-xs">
            <Baby size={13} />Procuração PA
            {(procuracoesPa?.filter(p => p.status === "pendente").length ?? 0) > 0 && (
              <Badge className="ml-1 h-4 px-1.5 text-[10px] bg-amber-500 text-white border-0">{procuracoesPa!.filter(p => p.status === "pendente").length}</Badge>
            )}
          </TabsTrigger>
          <TabsTrigger value="contrato" className="gap-1.5 text-xs">
            <ClipboardList size={13} />Contratos
            {(contratos?.filter(p => p.status === "pendente").length ?? 0) > 0 && (
              <Badge className="ml-1 h-4 px-1.5 text-[10px] bg-amber-500 text-white border-0">{contratos!.filter(p => p.status === "pendente").length}</Badge>
            )}
          </TabsTrigger>
          <TabsTrigger value="declaracao" className="gap-1.5 text-xs">
            <Scale size={13} />Declarações
            {(declaracoes?.filter(p => p.status === "pendente").length ?? 0) > 0 && (
              <Badge className="ml-1 h-4 px-1.5 text-[10px] bg-amber-500 text-white border-0">{declaracoes!.filter(p => p.status === "pendente").length}</Badge>
            )}
          </TabsTrigger>
          <TabsTrigger value="weberAna" className="gap-1.5 text-xs">
            <FileSignature size={13} />Proc. Weber e Ana Laura
            {(procuracoeswA?.filter(p => p.status === "pendente").length ?? 0) > 0 && (
              <Badge className="ml-1 h-4 px-1.5 text-[10px] bg-amber-500 text-white border-0">{procuracoeswA!.filter(p => p.status === "pendente").length}</Badge>
            )}
          </TabsTrigger>
          <TabsTrigger value="modelos" className="gap-1.5 text-xs font-semibold text-purple-700">
            <FolderOpen size={13} />Meus Modelos
          </TabsTrigger>
        </TabsList>

        <TabsContent value="procuracao">
          <TabelaDocumentos
            tipo="procuracao" titulo="Procurações Ad Judicia"
            items={procuracoes} isLoading={loadP} error={errP}
            onBaixar={(id, nome) => handleBaixar("procuracao", id, nome)}
            onExcluir={(id, nome) => handleExcluir("procuracao", id, nome)}
            onObservacao={(id, nome, obs) => handleObservacao("procuracao", id, nome, obs)}
            baixandoId={baixandoId} deletandoId={deletandoId}
            onRefresh={() => utils.procuracao.listar.invalidate()}
          />
        </TabsContent>

        <TabsContent value="procuracaoPa">
          <TabelaDocumentos
            tipo="procuracaoPa" titulo="Procurações PA (Menor)"
            items={procuracoesPa?.map(p => ({ ...p, nome: p.nome, nomeMenor: p.nomeMenor }))}
            isLoading={loadPA} error={errPA}
            onBaixar={(id, nome) => handleBaixar("procuracaoPa", id, nome)}
            onExcluir={(id, nome) => handleExcluir("procuracaoPa", id, nome)}
            onObservacao={(id, nome, obs) => handleObservacao("procuracaoPa", id, nome, obs)}
            baixandoId={baixandoId} deletandoId={deletandoId}
            onRefresh={() => utils.procuracaoPa.listar.invalidate()}
          />
        </TabsContent>

        <TabsContent value="contrato">
          <TabelaDocumentos
            tipo="contrato" titulo="Contratos de Honorários"
            items={contratos?.map(c => ({ ...c, tipoAcao: (c as any).tipoAcao ?? null }))}
            isLoading={loadC} error={errC}
            onBaixar={(id, nome) => handleBaixar("contrato", id, nome)}
            onPreencherSecaoIII={(id, nome) => {
              setSecaoIII({ tipoAcao: "", tribunal: "", faseProcessual: "", valorTotal: "", valorEntrada: "", dataEntrada: "", numParcelas: "1", valorParcela: "", dataPrimeiraParcela: "" });
              setSecaoIIIDialog({ id, nome });
            }}
            onExcluir={(id, nome) => handleExcluir("contrato", id, nome)}
            onObservacao={(id, nome, obs) => handleObservacao("contrato", id, nome, obs)}
            baixandoId={baixandoId} deletandoId={deletandoId}
            onRefresh={() => utils.contrato.listar.invalidate()}
          />
        </TabsContent>

        <TabsContent value="declaracao">
          <TabelaDocumentos
            tipo="declaracao" titulo="Declarações de Hipossuficiência"
            items={declaracoes} isLoading={loadD} error={errD}
            onBaixar={(id, nome) => handleBaixar("declaracao", id, nome)}
            onExcluir={(id, nome) => handleExcluir("declaracao", id, nome)}
            onObservacao={(id, nome, obs) => handleObservacao("declaracao", id, nome, obs)}
            baixandoId={baixandoId} deletandoId={deletandoId}
            onRefresh={() => utils.declaracao.listar.invalidate()}
          />
        </TabsContent>

        <TabsContent value="weberAna">
          <TabelaDocumentos
            tipo="procuracaoWeberAna" titulo="Procurações Weber e Ana Laura"
            items={procuracoeswA} isLoading={loadWA} error={errWA}
            onBaixar={(id, nome) => handleBaixar("procuracaoWeberAna", id, nome)}
            onExcluir={(id, nome) => handleExcluir("procuracaoWeberAna", id, nome)}
            onObservacao={(id, nome, obs) => handleObservacao("procuracaoWeberAna", id, nome, obs)}
            baixandoId={baixandoId} deletandoId={deletandoId}
            onRefresh={() => utils.procuracaoWeberAna.listar.invalidate()}
          />
        </TabsContent>

        <TabsContent value="links">
          <PainelLinks />
        </TabsContent>

        <TabsContent value="modelos">
          <PainelModelos />
        </TabsContent>
      </Tabs>

      {/* Dialog de confirmação de exclusão */}
      <Dialog open={!!confirmarExclusao} onOpenChange={(open) => !open && setConfirmarExclusao(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Confirmar exclusão</DialogTitle>
            <DialogDescription>
              Tem certeza que deseja excluir o registro de <strong>{confirmarExclusao?.nome}</strong>? Esta ação não pode ser desfeita.
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="gap-2">
            <Button variant="outline" onClick={() => setConfirmarExclusao(null)}>Cancelar</Button>
            <Button variant="destructive" onClick={confirmarDelete}               disabled={deletarPMutation.isPending || deletarCMutation.isPending || deletarDMutation.isPending || deletarPAMutation.isPending || deletarWAMutation.isPending} className="gap-2">
              {(deletarPMutation.isPending || deletarCMutation.isPending || deletarDMutation.isPending || deletarPAMutation.isPending || deletarWAMutation.isPending) && <Loader2 size={14} className="animate-spin" />}
              Excluir registro
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Dialog de Seção III — Dados do Processo e Honorários */}
      <Dialog open={!!secaoIIIDialog} onOpenChange={(open) => !open && setSecaoIIIDialog(null)}>
        <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <ClipboardList size={18} className="text-purple-600" />
              Seção III — Dados do Processo e Honorários
            </DialogTitle>
            <DialogDescription>
              Preencha os dados do processo e honorários para <strong>{secaoIIIDialog?.nome}</strong>. Após salvar, o contrato será gerado automaticamente.
            </DialogDescription>
          </DialogHeader>
          <div className="space-y-4 py-2">
            <div className="grid grid-cols-1 gap-3">
              <div className="space-y-1">
                <label className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">Tipo de Ação *</label>
                <Input value={secaoIII.tipoAcao} onChange={e => setSecaoIII(s => ({...s, tipoAcao: e.target.value}))} placeholder="Ex.: Ação de Cobrança" className="h-8 text-sm" />
              </div>
              <div className="space-y-1">
                <label className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">Tribunal de Origem *</label>
                <Input value={secaoIII.tribunal} onChange={e => setSecaoIII(s => ({...s, tribunal: e.target.value}))} placeholder="Ex.: Tribunal de Justiça do Estado de Goiás" className="h-8 text-sm" />
              </div>
              <div className="space-y-1">
                <label className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">Fase Processual *</label>
                <Input value={secaoIII.faseProcessual} onChange={e => setSecaoIII(s => ({...s, faseProcessual: e.target.value}))} placeholder="Ex.: Fase de conhecimento — audiências" className="h-8 text-sm" />
              </div>
            </div>
            <div className="border-t pt-3">
              <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide mb-3">Honorários</p>
              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Valor Total (R$) *</label>
                  <Input value={secaoIII.valorTotal} onChange={e => setSecaoIII(s => ({...s, valorTotal: e.target.value}))} placeholder="Ex.: 3000,00" className="h-8 text-sm" />
                </div>
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Valor de Entrada (R$) *</label>
                  <Input value={secaoIII.valorEntrada} onChange={e => setSecaoIII(s => ({...s, valorEntrada: e.target.value}))} placeholder="Ex.: 1000,00" className="h-8 text-sm" />
                </div>
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Data de Entrada *</label>
                  <Input value={secaoIII.dataEntrada} onChange={e => setSecaoIII(s => ({...s, dataEntrada: e.target.value}))} placeholder="DD/MM/AAAA" className="h-8 text-sm" maxLength={10} />
                </div>
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Nº de Parcelas *</label>
                  <Input type="number" min="1" max="24" value={secaoIII.numParcelas} onChange={e => setSecaoIII(s => ({...s, numParcelas: e.target.value}))} placeholder="Ex.: 4" className="h-8 text-sm" />
                </div>
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Valor de Cada Parcela (R$) *</label>
                  <Input value={secaoIII.valorParcela} onChange={e => setSecaoIII(s => ({...s, valorParcela: e.target.value}))} placeholder="Ex.: 500,00" className="h-8 text-sm" />
                </div>
                <div className="space-y-1">
                  <label className="text-xs font-medium text-muted-foreground">Data da 1ª Parcela *</label>
                  <Input value={secaoIII.dataPrimeiraParcela} onChange={e => setSecaoIII(s => ({...s, dataPrimeiraParcela: e.target.value}))} placeholder="DD/MM/AAAA" className="h-8 text-sm" maxLength={10} />
                </div>
              </div>
            </div>
          </div>
          <DialogFooter className="gap-2">
            <Button variant="outline" onClick={() => setSecaoIIIDialog(null)}>Cancelar</Button>
            <Button
              onClick={salvarSecaoIII}
              disabled={salvandoSecaoIII || !secaoIII.tipoAcao || !secaoIII.tribunal || !secaoIII.faseProcessual || !secaoIII.valorTotal || !secaoIII.valorEntrada || !secaoIII.dataEntrada || !secaoIII.valorParcela || !secaoIII.dataPrimeiraParcela}
              className="gap-2 bg-[#1a2744] hover:bg-[#243660]"
            >
              {salvandoSecaoIII ? <Loader2 size={14} className="animate-spin" /> : <Download size={14} />}
              Salvar e Gerar Contrato
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Dialog de observações */}
      <Dialog open={!!obsDialog} onOpenChange={(open) => !open && setObsDialog(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <MessageSquarePlus size={18} className="text-blue-500" />
              Observações — {obsDialog?.nome}
            </DialogTitle>
            <DialogDescription>
              Adicione anotações internas sobre este cliente (ex.: "aguardando assinatura", "entregue pessoalmente").
            </DialogDescription>
          </DialogHeader>
          <Textarea
            value={obsDialog?.texto ?? ""}
            onChange={(e) => setObsDialog(prev => prev ? { ...prev, texto: e.target.value } : null)}
            placeholder="Ex.: Aguardando assinatura. Cliente retorna na quinta-feira."
            rows={4}
            className="resize-none"
          />
          <DialogFooter className="gap-2">
            <Button variant="outline" onClick={() => setObsDialog(null)}>Cancelar</Button>
            <Button onClick={salvarObservacao} disabled={salvandoObs} className="gap-2 bg-[#1a2744] hover:bg-[#243660]">
              {salvandoObs ? <Loader2 size={14} className="animate-spin" /> : <Save size={14} />}
              Salvar observação
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}

// ─── Página Admin ─────────────────────────────────────────────────────────
export default function Admin() {
  return (
    <DashboardLayout>
      <AdminContent />
    </DashboardLayout>
  );
}
