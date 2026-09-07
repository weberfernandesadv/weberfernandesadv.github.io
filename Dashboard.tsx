import { useState } from "react";
import { trpc } from "@/lib/trpc";
import { useAuth } from "@/_core/hooks/useAuth";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { toast } from "sonner";
import { Plus, Trash2, Scale, Search, Loader2, AlertCircle, Pencil, AlertTriangle, Clock, FileDown, FileText, Upload } from "lucide-react";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";
import { formatarNumeroCnj, extrairTribunalDoCnj, validarNumeroCnj } from "@/lib/cnj";
import { calcularPrazo, getPrazoDias, dateToInputValue, isProximosDiasUteis, type TipoManifestacao as TipoManifestacaoPrazos } from "@/lib/prazos";

const TIPOS_MANIFESTACAO = [
  "Recurso",
  "Resposta",
  "Apelação",
  "Embargos de declaração",
  "Contestação",
  "Impugnação",
  "Autos conclusos",
  "Conciliação",
  "Audiência",
  "Outro",
] as const;

const TIPOS_COM_HORARIO: TipoManifestacao[] = ["Conciliação", "Audiência"];

type TipoManifestacao = typeof TIPOS_MANIFESTACAO[number];

type EditProcessoState = {
  id: number;
  dataLimite: string;
  dataIntimacao: string;
  tipoManifestacao: string;
  horario: string;
  cliente: string;
  clienteCpf: string;
  anotacao: string;
  resumoProcessual: string;
  tribunal: string;
  processoIntegralUrl: string | null;
  processoIntegralNome: string | null;
  ultimaMovimentacaoUrl: string | null;
  ultimaMovimentacaoNome: string | null;
  processoIntegralFile: File | null;
  ultimaMovimentacaoFile: File | null;
};

const MAX_PDF_SIZE_BYTES = 25 * 1024 * 1024;

function validarPdf(file: File | null): string | null {
  if (!file) return null;
  if (file.type !== "application/pdf" && !file.name.toLowerCase().endsWith(".pdf")) {
    return "Envie somente arquivos PDF.";
  }
  if (file.size > MAX_PDF_SIZE_BYTES) {
    return "Cada PDF deve ter no máximo 25 MB.";
  }
  return null;
}

const TIPO_CORES: Record<TipoManifestacao, string> = {
  "Recurso": "bg-orange-500/15 text-orange-400 border-orange-500/25",
  "Resposta": "bg-blue-500/15 text-blue-400 border-blue-500/25",
  "Apelação": "bg-purple-500/15 text-purple-400 border-purple-500/25",
  "Embargos de declaração": "bg-red-500/15 text-red-400 border-red-500/25",
  "Contestação": "bg-indigo-500/15 text-indigo-400 border-indigo-500/25",
  "Impugnação": "bg-pink-500/15 text-pink-400 border-pink-500/25",
  "Autos conclusos": "bg-yellow-500/15 text-yellow-400 border-yellow-500/25",
  "Conciliação": "bg-green-500/15 text-green-400 border-green-500/25",
  "Audiência": "bg-cyan-500/15 text-cyan-400 border-cyan-500/25",
  "Outro": "bg-muted text-muted-foreground border-border",
};

// Converte Date ou string ISO para string de data local no formato YYYY-MM-DD (sem deslocamento de fuso)
function toLocalDateStr(d: Date | string): string {
  if (typeof d === "string") {
    return d.substring(0, 10);
  }
  const yyyy = d.getUTCFullYear();
  const mm = String(d.getUTCMonth() + 1).padStart(2, "0");
  const dd = String(d.getUTCDate()).padStart(2, "0");
  return `${yyyy}-${mm}-${dd}`;
}

function formatarData(d: Date | string | null | undefined) {
  if (!d) return "—";
  const [yyyy, mm, dd] = toLocalDateStr(d).split("-");
  return `${dd}/${mm}/${yyyy}`;
}

function hojeBrasilia(): string {
  const agora = new Date();
  const brasilia = new Date(agora.getTime() - 3 * 60 * 60 * 1000);
  return brasilia.toISOString().split("T")[0];
}

function isVencido(d: Date | string | null | undefined) {
  if (!d) return false;
  const dataStr = toLocalDateStr(d);
  return dataStr < hojeBrasilia();
}

function isProximo(d: Date | string | null | undefined) {
  if (!d) return false;
  const dataStr = toLocalDateStr(d);
  const hojeStr = hojeBrasilia();
  const dataDate = new Date(dataStr + "T12:00:00Z");
  const hojeDate = new Date(hojeStr + "T12:00:00Z");
  const diff = (dataDate.getTime() - hojeDate.getTime()) / (1000 * 60 * 60 * 24);
  return diff >= 0 && diff <= 7;
}

export default function Dashboard() {
  const { user } = useAuth();
  const isCliente = user?.role === "cliente";

  const [openCreate, setOpenCreate] = useState(false);
  const [busca, setBusca] = useState("");
  const [editProcesso, setEditProcesso] = useState<EditProcessoState | null>(null);

  // Form state
  const [numeroCnj, setNumeroCnj] = useState("");
  const [tribunal, setTribunal] = useState("");
  const [dataLimite, setDataLimite] = useState("");
  const [dataIntimacao, setDataIntimacao] = useState("");
  const [tipoManifestacao, setTipoManifestacao] = useState<TipoManifestacao | "">("")
  const [horario, setHorario] = useState("");
  const [cliente, setCliente] = useState("");
  const [clienteCpf, setClienteCpf] = useState("");
  const [anotacao, setAnotacao] = useState("");
  const [resumoProcessual, setResumoProcessual] = useState("");
  const [processoIntegralFile, setProcessoIntegralFile] = useState<File | null>(null);
  const [ultimaMovimentacaoFile, setUltimaMovimentacaoFile] = useState<File | null>(null);
  const [isUploading, setIsUploading] = useState(false);
  const [cnjError, setCnjError] = useState("");

  const utils = trpc.useUtils();
  const { data: processos, isLoading } = trpc.processos.list.useQuery();

  const processosFiltrados = (processos ?? []).filter((p) => {
    if (!busca.trim()) return true;
    const termo = busca.toLowerCase().trim();
    return (
      p.numeroCnj.toLowerCase().includes(termo) ||
      (p.cliente ?? "").toLowerCase().includes(termo)
    );
  });

  const createMutation = trpc.processos.create.useMutation();
  const updateMutation = trpc.processos.update.useMutation();

  const deleteMutation = trpc.processos.delete.useMutation({
    onSuccess: () => {
      utils.processos.list.invalidate();
      toast.success("Processo removido.");
    },
    onError: () => toast.error("Erro ao remover processo."),
  });

  function formatarCpfInput(rawVal: string) {
    const raw = rawVal.replace(/\D/g, "");
    let formatted = raw;
    if (raw.length > 3) formatted = raw.substring(0, 3) + "." + raw.substring(3);
    if (raw.length > 6) formatted = formatted.substring(0, 7) + "." + raw.substring(6);
    if (raw.length > 9) formatted = formatted.substring(0, 11) + "-" + raw.substring(9);
    return formatted.substring(0, 14);
  }

  function handleClienteCpfChange(e: React.ChangeEvent<HTMLInputElement>) {
    setClienteCpf(formatarCpfInput(e.target.value));
  }

  function exportarPDF() {
    const lista = processos ?? [];
    if (lista.length === 0) {
      toast.error("Nenhum processo para exportar.");
      return;
    }

    const doc = new jsPDF({ orientation: "landscape", unit: "mm", format: "a4" });

    // Cabeçalho
    doc.setFontSize(16);
    doc.setTextColor(30, 30, 60);
    doc.text("Acompanhamento de Processos", 14, 16);
    doc.setFontSize(9);
    doc.setTextColor(120, 120, 120);
    
    const agoraBrasilia = new Date(new Date().getTime() - 3 * 60 * 60 * 1000);
    const [anoH, mesH, diaH] = agoraBrasilia.toISOString().split("T")[0].split("-");
    const dataHoje = `${diaH}/${mesH}/${anoH}`;
    doc.text(`Gerado em: ${dataHoje}  |  Total: ${lista.length} processo(s)`, 14, 22);

    const rows = lista.map((p, i) => [
      String(i + 1),
      p.numeroCnj,
      p.tribunal ?? "",
      p.dataLimite ? (() => { const [y,m,d] = (typeof p.dataLimite === "string" ? p.dataLimite : p.dataLimite.toISOString()).substring(0,10).split("-"); return `${d}/${m}/${y}`; })() + (p.horario ? `\n${p.horario}` : "") : "",
      p.tipoManifestacao ?? "",
      p.cliente ?? "",
      p.anotacao ?? "",
      p.resumoProcessual ?? "",
      p.ultimaMovimentacaoNome ? `PDF: ${p.ultimaMovimentacaoNome}` : "",
    ]);

    autoTable(doc, {
      startY: 27,
      head: [["#", "Número CNJ", "Tribunal", "Data Limite", "Manifestação", "Cliente", "Anotação", "Resumo processual", "Última movimentação"]],
      body: rows,
      styles: { fontSize: 8, cellPadding: 3, overflow: "linebreak" },
      headStyles: { fillColor: [20, 20, 50], textColor: 255, fontStyle: "bold" },
      alternateRowStyles: { fillColor: [245, 245, 252] },
      columnStyles: {
        0: { cellWidth: 8 },
        1: { cellWidth: 52, font: "courier" },
        2: { cellWidth: 18 },
        3: { cellWidth: 22 },
        4: { cellWidth: 30 },
        5: { cellWidth: 35 },
        6: { cellWidth: 32 },
        7: { cellWidth: 42 },
        8: { cellWidth: 34 },
      },
      margin: { left: 14, right: 14 },
    });

    doc.save(`processos_${dataHoje.replace(/\//g, "-")}.pdf`);
    toast.success("PDF exportado com sucesso!");
  }

  function calcularPrazoAutomatico(tipo: TipoManifestacao | "", trib: string, intimacao: string) {
    if (!tipo || !trib || !intimacao) return;
    const dias = getPrazoDias(tipo as TipoManifestacaoPrazos, trib);
    if (dias === null) return;
    const dataInicio = new Date(intimacao + "T12:00:00Z");
    const dataFim = calcularPrazo(tipo as TipoManifestacaoPrazos, trib, dataInicio);
    if (dataFim) setDataLimite(dateToInputValue(dataFim));
  }

  function handleTipoChange(v: string) {
    const tipo = v as TipoManifestacao;
    setTipoManifestacao(tipo);
    if (!TIPOS_COM_HORARIO.includes(tipo)) setHorario("");
    calcularPrazoAutomatico(tipo, tribunal, dataIntimacao);
  }

  function handleIntimacaoChange(e: React.ChangeEvent<HTMLInputElement>) {
    const val = e.target.value;
    setDataIntimacao(val);
    calcularPrazoAutomatico(tipoManifestacao, tribunal, val);
  }

  function resetForm() {
    setNumeroCnj(""); setTribunal(""); setDataLimite(""); setDataIntimacao("");
    setTipoManifestacao(""); setHorario(""); setCliente(""); setClienteCpf(""); setAnotacao("");
    setResumoProcessual(""); setProcessoIntegralFile(null); setUltimaMovimentacaoFile(null); setCnjError("");
  }

  async function uploadPdf(processoId: number, tipo: "processoIntegral" | "ultimaMovimentacao", file: File) {
    const apiBase = window.location.pathname.startsWith("/plataformas/processos") ? "/api_processos" : "/api";
    const response = await fetch(`${apiBase}/processos/${processoId}/arquivo?tipo=${tipo}`, {
      method: "POST",
      credentials: "include",
      headers: {
        "Content-Type": "application/pdf",
        "X-File-Name": encodeURIComponent(file.name),
      },
      body: file,
    });
    if (!response.ok) {
      let message = "Erro ao enviar o PDF.";
      try { message = (await response.json()).error || message; } catch { /* resposta não JSON */ }
      throw new Error(message);
    }
  }

  async function uploadSelectedPdfs(processoId: number, files: Array<["processoIntegral" | "ultimaMovimentacao", File | null]>) {
    const selected = files.filter(
      (entry): entry is ["processoIntegral" | "ultimaMovimentacao", File] => Boolean(entry[1]),
    );
    if (selected.length === 0) return;
    setIsUploading(true);
    try {
      for (const [tipo, file] of selected) await uploadPdf(processoId, tipo, file);
    } finally {
      setIsUploading(false);
    }
  }

  function validarArquivosSelecionados(files: Array<File | null>) {
    const error = files.map(validarPdf).find(Boolean);
    if (error) { toast.error(error); return false; }
    return true;
  }

  function handleCnjChange(e: React.ChangeEvent<HTMLInputElement>) {
    const formatted = formatarNumeroCnj(e.target.value);
    setNumeroCnj(formatted);
    setCnjError("");
    const info = extrairTribunalDoCnj(formatted);
    setTribunal(info ? info.sigla : "");
  }

  async function handleSubmitCreate(e: React.FormEvent) {
    e.preventDefault();
    if (!validarNumeroCnj(numeroCnj)) {
      setCnjError("Número CNJ inválido. Formato: NNNNNNN-DD.AAAA.J.TT.OOOO");
      return;
    }
    if (!tribunal) { setCnjError("Tribunal não identificado."); return; }
    if (!validarArquivosSelecionados([processoIntegralFile, ultimaMovimentacaoFile])) return;

    try {
      const result = await createMutation.mutateAsync({
        numeroCnj, tribunal,
        dataLimite: dataLimite || null,
        dataIntimacao: dataIntimacao || null,
        tipoManifestacao: tipoManifestacao as TipoManifestacao || null,
        horario: horario || null,
        cliente: cliente || null,
        clienteCpf: clienteCpf || null,
        anotacao: anotacao || null,
        resumoProcessual: resumoProcessual || null,
      });
      if (result.id) {
        await uploadSelectedPdfs(result.id, [
          ["processoIntegral", processoIntegralFile],
          ["ultimaMovimentacao", ultimaMovimentacaoFile],
        ]);
      }
      await utils.processos.list.invalidate();
      await utils.novidades.countNaoLidas.invalidate();
      toast.success("Processo cadastrado com sucesso!");
      setOpenCreate(false);
      resetForm();
    } catch (error) {
      toast.error("Erro ao cadastrar: " + (error instanceof Error ? error.message : "tente novamente"));
    }
  }

  async function handleSubmitEdit(e: React.FormEvent) {
    e.preventDefault();
    if (!editProcesso) return;
    if (!validarArquivosSelecionados([editProcesso.processoIntegralFile, editProcesso.ultimaMovimentacaoFile])) return;

    try {
      await updateMutation.mutateAsync({
        id: editProcesso.id,
        dataLimite: editProcesso.dataLimite || null,
        dataIntimacao: editProcesso.dataIntimacao || null,
        tipoManifestacao: editProcesso.tipoManifestacao as TipoManifestacao || null,
        horario: editProcesso.horario || null,
        cliente: editProcesso.cliente || null,
        clienteCpf: editProcesso.clienteCpf || null,
        anotacao: editProcesso.anotacao || null,
        resumoProcessual: editProcesso.resumoProcessual || null,
      });
      await uploadSelectedPdfs(editProcesso.id, [
        ["processoIntegral", editProcesso.processoIntegralFile],
        ["ultimaMovimentacao", editProcesso.ultimaMovimentacaoFile],
      ]);
      await utils.processos.list.invalidate();
      toast.success("Processo atualizado!");
      setEditProcesso(null);
    } catch (error) {
      toast.error("Erro ao atualizar: " + (error instanceof Error ? error.message : "tente novamente"));
    }
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-foreground">Meus Processos</h1>
          <p className="text-muted-foreground text-sm mt-1">
            {busca.trim() ? (
              <>{processosFiltrados.length} de {processos?.length ?? 0} processo{(processos?.length ?? 0) !== 1 ? "s" : ""}</>
            ) : (
              <>{processos?.length ?? 0} processo{(processos?.length ?? 0) !== 1 ? "s" : ""} monitorado{(processos?.length ?? 0) !== 1 ? "s" : ""}</>
            )}
          </p>
        </div>

        {/* Barra de pesquisa */}
        <div className="relative w-72">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
          <Input
            className="pl-9 bg-input border-border focus-visible:ring-primary h-9 text-sm"
            placeholder="Buscar por cliente ou nº CNJ..."
            value={busca}
            onChange={e => setBusca(e.target.value)}
          />
          {busca && (
            <button
              onClick={() => setBusca("")}
              className="absolute right-2.5 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
            >
              ✕
            </button>
          )}
        </div>

        <Button
          variant="outline"
          className="gap-2 border-border text-muted-foreground hover:text-foreground hover:bg-muted/40"
          onClick={exportarPDF}
        >
          <FileDown className="w-4 h-4" />
          Exportar PDF
        </Button>

        {!isCliente && (
          <Dialog open={openCreate} onOpenChange={(v) => { setOpenCreate(v); if (!v) resetForm(); }}>
            <DialogTrigger asChild>
              <Button className="bg-primary text-primary-foreground hover:bg-primary/90 gap-2">
                <Plus className="w-4 h-4" />
                Adicionar Processo
              </Button>
            </DialogTrigger>
            <DialogContent className="bg-card border-border max-w-lg max-h-[90vh] overflow-y-auto">
              <DialogHeader>
                <DialogTitle className="text-foreground text-xl font-semibold">Novo Processo</DialogTitle>
              </DialogHeader>
              <form onSubmit={handleSubmitCreate} className="space-y-4 mt-2">
                {/* CNJ */}
                <div className="space-y-1.5">
                  <label className="text-sm font-medium text-foreground">Número CNJ <span className="text-destructive">*</span></label>
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input className="pl-9 bg-input border-border font-mono focus-visible:ring-primary" placeholder="0000000-00.0000.0.00.0000" value={numeroCnj} onChange={handleCnjChange} maxLength={25} autoFocus />
                  </div>
                  {cnjError && <div className="flex items-center gap-1.5 text-destructive text-xs"><AlertCircle className="w-3.5 h-3.5" />{cnjError}</div>}
                </div>

                {/* Tribunal */}
                <div className="space-y-1.5">
                  <label className="text-sm font-medium text-foreground">Tribunal</label>
                  <div className="relative">
                    <Input className="bg-muted border-border font-mono cursor-not-allowed" value={tribunal} readOnly placeholder="Preenchido automaticamente" />
                    {tribunal && <Badge className="absolute right-2 top-1/2 -translate-y-1/2 bg-primary/20 text-primary border-primary/30 text-xs">{tribunal}</Badge>}
                  </div>
                </div>

                {/* Tipo de Manifestação */}
                <div className="space-y-1.5">
                  <label className="text-sm font-medium text-foreground">Tipo de Manifestação</label>
                  <Select value={tipoManifestacao} onValueChange={handleTipoChange}>
                    <SelectTrigger className="bg-input border-border focus:ring-primary">
                      <SelectValue placeholder="Selecionar..." />
                    </SelectTrigger>
                    <SelectContent className="bg-popover border-border">
                      {TIPOS_MANIFESTACAO.map(t => <SelectItem key={t} value={t}>{t}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>

                {/* Data de Intimação + Data Limite */}
                <div className="grid grid-cols-2 gap-3">
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Data da Intimação</label>
                    <Input type="date" className="bg-input border-border focus-visible:ring-primary text-foreground" value={dataIntimacao} onChange={handleIntimacaoChange} />
                    <p className="text-xs text-muted-foreground">Preencha para calcular o prazo automaticamente</p>
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Data Limite</label>
                    <Input type="date" className="bg-input border-border focus-visible:ring-primary text-foreground" value={dataLimite} onChange={e => setDataLimite(e.target.value)} />
                    {tipoManifestacao && getPrazoDias(tipoManifestacao as TipoManifestacaoPrazos, tribunal) !== null && (
                      <p className="text-xs text-primary/80">
                        Prazo: {getPrazoDias(tipoManifestacao as TipoManifestacaoPrazos, tribunal)} dias úteis ({tribunal.toUpperCase().includes("TRT") ? "CLT" : "CPC"})
                      </p>
                    )}
                  </div>
                </div>

                {/* Horário — aparece apenas para Conciliação e Audiência */}
                {TIPOS_COM_HORARIO.includes(tipoManifestacao as TipoManifestacao) && (
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Horário <span className="text-muted-foreground font-normal">(opcional)</span></label>
                    <Input type="time" className="bg-input border-border focus-visible:ring-primary text-foreground" value={horario} onChange={e => setHorario(e.target.value)} />
                  </div>
                )}

                {/* Cliente */}
                <div className="grid grid-cols-2 gap-3">
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Cliente <span className="text-muted-foreground font-normal">(opcional)</span></label>
                    <Input className="bg-input border-border focus-visible:ring-primary" placeholder="Nome do cliente" value={cliente} onChange={e => setCliente(e.target.value)} />
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">CPF do Cliente <span className="text-muted-foreground font-normal">(opcional)</span></label>
                    <Input className="bg-input border-border focus-visible:ring-primary" placeholder="000.000.000-00" value={clienteCpf} onChange={handleClienteCpfChange} maxLength={14} />
                  </div>
                </div>

                {/* Anotação */}
                <div className="space-y-1.5">
                  <label className="text-sm font-medium text-foreground">Anotação <span className="text-muted-foreground font-normal">(opcional)</span></label>
                  <Textarea className="bg-input border-border focus-visible:ring-primary resize-none" placeholder="Observações sobre o processo..." value={anotacao} onChange={e => setAnotacao(e.target.value)} rows={2} />
                </div>

                {/* Resumo processual */}
                <div className="space-y-1.5">
                  <label className="text-sm font-medium text-foreground">Resumo processual <span className="text-muted-foreground font-normal">(opcional)</span></label>
                  <Textarea className="bg-input border-border focus-visible:ring-primary resize-y" placeholder="Descreva o resumo do processo..." value={resumoProcessual} onChange={e => setResumoProcessual(e.target.value)} rows={4} />
                </div>

                {/* PDFs */}
                <div className="grid grid-cols-1 gap-3">
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Processo na íntegra <span className="text-muted-foreground font-normal">(PDF, opcional)</span></label>
                    <Input type="file" accept="application/pdf,.pdf" className="bg-input border-border file:text-foreground" onChange={e => setProcessoIntegralFile(e.target.files?.[0] ?? null)} />
                    {processoIntegralFile && <p className="text-xs text-muted-foreground flex items-center gap-1"><Upload className="w-3 h-3" />{processoIntegralFile.name}</p>}
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Última movimentação <span className="text-muted-foreground font-normal">(PDF, opcional)</span></label>
                    <Input type="file" accept="application/pdf,.pdf" className="bg-input border-border file:text-foreground" onChange={e => setUltimaMovimentacaoFile(e.target.files?.[0] ?? null)} />
                    {ultimaMovimentacaoFile && <p className="text-xs text-muted-foreground flex items-center gap-1"><Upload className="w-3 h-3" />{ultimaMovimentacaoFile.name}</p>}
                  </div>
                </div>

                <div className="flex gap-3 pt-1">
                  <Button type="button" variant="outline" className="flex-1 border-border" onClick={() => setOpenCreate(false)}>Cancelar</Button>
                  <Button type="submit" className="flex-1 bg-primary text-primary-foreground" disabled={createMutation.isPending || isUploading}>
                    {createMutation.isPending || isUploading ? <><Loader2 className="w-4 h-4 animate-spin mr-2" />Salvando...</> : "Cadastrar"}
                  </Button>
                </div>
              </form>
            </DialogContent>
          </Dialog>
        )}
      </div>

      {/* Divider */}
      <div className="h-px bg-gradient-to-r from-transparent via-border to-transparent" />

      {/* Tabela */}
      {isLoading ? (
        <div className="flex items-center justify-center py-16"><Loader2 className="w-6 h-6 animate-spin text-primary" /></div>
      ) : !processos?.length ? (
        <div className="flex flex-col items-center justify-center py-20 text-center">
          <div className="w-16 h-16 rounded-2xl bg-primary/10 flex items-center justify-center mb-4">
            <Scale className="w-8 h-8 text-primary/60" />
          </div>
          <h3 className="text-lg font-semibold text-foreground mb-2">Nenhum processo cadastrado</h3>
          <p className="text-muted-foreground text-sm max-w-xs">Adicione um processo pelo número CNJ para começar a monitorar.</p>
        </div>
      ) : !processosFiltrados.length ? (
        <div className="flex flex-col items-center justify-center py-16 text-center">
          <div className="w-12 h-12 rounded-xl bg-muted flex items-center justify-center mb-3">
            <Search className="w-6 h-6 text-muted-foreground" />
          </div>
          <p className="text-foreground font-medium mb-1">Nenhum resultado encontrado</p>
          <p className="text-muted-foreground text-sm">Tente buscar por outro nome ou número CNJ.</p>
          <button onClick={() => setBusca("")} className="mt-3 text-primary text-sm hover:underline">Limpar busca</button>
        </div>
      ) : (
        <div className="rounded-xl border border-border overflow-hidden">
          {/* Cabeçalho da tabela */}
          <div className="min-w-[1180px] grid grid-cols-[2fr_1.6fr_1fr_1fr_1fr_1.5fr_1.25fr_auto] gap-0 bg-muted/50 border-b border-border px-4 py-2.5">
            {["Processo / Tribunal", "Resumo processual", "Data Limite", "Manifestação", "Cliente", "Anotação", "Última movimentação", ""].map((h, i) => {
              if (i === 7 && isCliente) return null;
              return <div key={i} className="text-xs font-semibold text-muted-foreground uppercase tracking-wider">{h}</div>;
            })}
          </div>

          {/* Linhas */}
          <div className="divide-y divide-border">
            {processosFiltrados.map((p) => {
              const semPrazo = p.tipoManifestacao === "Autos conclusos" || p.tipoManifestacao === "Outro";
              const dataManual = p.tipoManifestacao === "Audiência" || p.tipoManifestacao === "Conciliação";
              const vencido = !semPrazo && isVencido(p.dataLimite);
              const proximoUteis = !semPrazo && !dataManual && !vencido && isProximosDiasUteis(p.dataLimite, p.tribunal, 3);
              const proximo = !semPrazo && !vencido && !proximoUteis && isProximo(p.dataLimite);
              const rowStyle = vencido
                ? { background: "rgba(239,68,68,0.18)", borderLeft: "4px solid rgb(239,68,68)" }
                : proximoUteis
                ? { background: "rgba(239,68,68,0.10)", borderLeft: "4px solid rgb(239,68,68)" }
                : proximo
                ? { background: "rgba(234,179,8,0.10)", borderLeft: "3px solid rgb(234,179,8)" }
                : {};
              return (
                <div key={p.id} style={rowStyle} className={`min-w-[1180px] grid grid-cols-[2fr_1.6fr_1fr_1fr_1fr_1.5fr_1.25fr_auto] gap-0 items-center px-4 py-3 transition-colors group hover:brightness-110`}>
                  {/* Processo + Tribunal */}
                  <div className="flex items-center gap-2 min-w-0">
                    {vencido && (
                      <AlertTriangle className="w-4 h-4 text-red-500 shrink-0" />
                    )}
                    {proximoUteis && (
                      <AlertTriangle className="w-4 h-4 text-red-400 shrink-0" />
                    )}
                    {proximo && (
                      <Clock className="w-4 h-4 text-yellow-500 shrink-0" />
                    )}
                    <div className="min-w-0">
                      <p className="font-mono text-xs font-medium text-foreground truncate">{p.numeroCnj}</p>
                      <Badge className="mt-0.5 bg-primary/15 text-primary border-primary/25 text-xs">{p.tribunal}</Badge>
                    </div>
                  </div>

                  {/* Resumo processual */}
                  <div className="text-xs text-muted-foreground pr-2 whitespace-pre-line overflow-hidden" title={p.resumoProcessual ?? undefined}>
                    {p.resumoProcessual || "—"}
                  </div>

                  {/* Data Limite */}
                  <div>
                    {p.dataLimite ? (
                      <div className="flex flex-col gap-0.5">
                        <span className={`text-xs font-medium px-2 py-0.5 rounded-md ${
                          vencido ? "bg-destructive/15 text-destructive" :
                          proximoUteis ? "bg-red-500/15 text-red-400 font-bold" :
                          proximo ? "bg-yellow-500/15 text-yellow-400" :
                          "text-foreground"
                        }`}>
                          {formatarData(p.dataLimite)}
                        </span>
                        {p.horario && (
                          <span className="text-xs text-muted-foreground px-2">⏰ {p.horario}</span>
                        )}
                      </div>
                    ) : (
                      <span className="text-muted-foreground text-xs">—</span>
                    )}
                  </div>

                  {/* Tipo Manifestação */}
                  <div>
                    {p.tipoManifestacao ? (
                      <Badge className={`text-xs border ${TIPO_CORES[p.tipoManifestacao as TipoManifestacao] ?? "bg-muted text-muted-foreground border-border"}`}>
                        {p.tipoManifestacao}
                      </Badge>
                    ) : (
                      <span className="text-muted-foreground text-xs">—</span>
                    )}
                  </div>

                  {/* Cliente */}
                  <div className="text-xs text-foreground truncate">
                    {p.cliente || <span className="text-muted-foreground">—</span>}
                  </div>

                  {/* Anotação */}
                  <div className="text-xs text-muted-foreground truncate pr-2">
                    {p.anotacao || "—"}
                  </div>

                  {/* Última movimentação */}
                  <div className="text-xs pr-2 min-w-0">
                    {p.ultimaMovimentacaoUrl ? (
                      <a href={p.ultimaMovimentacaoUrl} target="_blank" rel="noreferrer" className="inline-flex items-center gap-1 text-primary hover:underline max-w-full">
                        <FileText className="w-3.5 h-3.5 shrink-0" />
                        <span className="truncate">{p.ultimaMovimentacaoNome || "Abrir PDF"}</span>
                      </a>
                    ) : <span className="text-muted-foreground">—</span>}
                  </div>

                  {/* Ações */}
                  {!isCliente && (
                    <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                      <Button
                        variant="ghost" size="icon"
                        className="w-7 h-7 text-muted-foreground hover:text-foreground hover:bg-accent"
                        onClick={() => setEditProcesso({
                          id: p.id,
                          dataLimite: p.dataLimite ? toLocalDateStr(p.dataLimite) : "",
                          dataIntimacao: p.dataIntimacao ? toLocalDateStr(p.dataIntimacao) : "",
                          tipoManifestacao: p.tipoManifestacao ?? "",
                          horario: p.horario ?? "",
                          cliente: p.cliente ?? "",
                          clienteCpf: p.clienteCpf ? formatarCpfInput(p.clienteCpf) : "",
                          anotacao: p.anotacao ?? "",
                          resumoProcessual: p.resumoProcessual ?? "",
                          processoIntegralUrl: p.processoIntegralUrl ?? null,
                          processoIntegralNome: p.processoIntegralNome ?? null,
                          ultimaMovimentacaoUrl: p.ultimaMovimentacaoUrl ?? null,
                          ultimaMovimentacaoNome: p.ultimaMovimentacaoNome ?? null,
                          processoIntegralFile: null,
                          ultimaMovimentacaoFile: null,
                          tribunal: p.tribunal,
                        })}
                      >
                        <Pencil className="w-3.5 h-3.5" />
                      </Button>
                      <Button
                        variant="ghost" size="icon"
                        className="w-7 h-7 text-muted-foreground hover:text-destructive hover:bg-destructive/10"
                        onClick={() => deleteMutation.mutate({ id: p.id })}
                        disabled={deleteMutation.isPending}
                      >
                        <Trash2 className="w-3.5 h-3.5" />
                      </Button>
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Modal de edição */}
      {!isCliente && (
        <Dialog open={!!editProcesso} onOpenChange={(v) => { if (!v) setEditProcesso(null); }}>
          <DialogContent className="bg-card border-border max-w-lg max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle className="text-foreground text-xl font-semibold">Editar Processo</DialogTitle>
            </DialogHeader>
            {editProcesso && (
              <form onSubmit={handleSubmitEdit} className="space-y-4 mt-2">
                {/* Tipo de Manifestação */}
                <div className="space-y-1.5">
                  <label className="text-sm font-medium text-foreground">Tipo de Manifestação</label>
                  <Select
                    value={editProcesso.tipoManifestacao}
                    onValueChange={v => {
                      const novoTipo = v as TipoManifestacao;
                      let novaDataLimite = editProcesso.dataLimite;
                      if (editProcesso.dataIntimacao && novoTipo) {
                        const dias = getPrazoDias(novoTipo as TipoManifestacaoPrazos, editProcesso.tribunal);
                        if (dias !== null) {
                          const dataInicio = new Date(editProcesso.dataIntimacao + "T12:00:00Z");
                          const dataFim = calcularPrazo(novoTipo as TipoManifestacaoPrazos, editProcesso.tribunal, dataInicio);
                          if (dataFim) novaDataLimite = dateToInputValue(dataFim);
                        }
                      }
                      setEditProcesso(prev => prev ? {
                        ...prev,
                        tipoManifestacao: v,
                        horario: TIPOS_COM_HORARIO.includes(novoTipo) ? prev.horario : "",
                        dataLimite: novaDataLimite,
                      } : null);
                    }}
                  >
                    <SelectTrigger className="bg-input border-border focus:ring-primary">
                      <SelectValue placeholder="Selecionar..." />
                    </SelectTrigger>
                    <SelectContent className="bg-popover border-border">
                      {TIPOS_MANIFESTACAO.map(t => <SelectItem key={t} value={t}>{t}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>

                {/* Data de Intimação + Data Limite */}
                <div className="grid grid-cols-2 gap-3">
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Data da Intimação</label>
                    <Input
                      type="date"
                      className="bg-input border-border focus-visible:ring-primary text-foreground"
                      value={editProcesso.dataIntimacao}
                      onChange={e => {
                        const val = e.target.value;
                        let novaDataLimite = editProcesso.dataLimite;
                        if (val && editProcesso.tipoManifestacao) {
                          const dias = getPrazoDias(editProcesso.tipoManifestacao as TipoManifestacaoPrazos, editProcesso.tribunal);
                          if (dias !== null) {
                            const dataInicio = new Date(val + "T12:00:00Z");
                            const dataFim = calcularPrazo(editProcesso.tipoManifestacao as TipoManifestacaoPrazos, editProcesso.tribunal, dataInicio);
                            if (dataFim) novaDataLimite = dateToInputValue(dataFim);
                          }
                        }
                        setEditProcesso(prev => prev ? { ...prev, dataIntimacao: val, dataLimite: novaDataLimite } : null);
                      }}
                    />
                    <p className="text-xs text-muted-foreground">Preencha para calcular o prazo automaticamente</p>
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Data Limite</label>
                    <Input
                      type="date"
                      className="bg-input border-border focus-visible:ring-primary text-foreground"
                      value={editProcesso.dataLimite}
                      onChange={e => setEditProcesso(prev => prev ? { ...prev, dataLimite: e.target.value } : null)}
                    />
                    {editProcesso.tipoManifestacao && getPrazoDias(editProcesso.tipoManifestacao as TipoManifestacaoPrazos, editProcesso.tribunal) !== null && (
                      <p className="text-xs text-primary/80">
                        Prazo: {getPrazoDias(editProcesso.tipoManifestacao as TipoManifestacaoPrazos, editProcesso.tribunal)} dias úteis ({editProcesso.tribunal.toUpperCase().includes("TRT") ? "CLT" : "CPC"})
                      </p>
                    )}
                  </div>
                </div>

                {/* Horário — aparece apenas para Conciliação e Audiência */}
                {TIPOS_COM_HORARIO.includes(editProcesso.tipoManifestacao as TipoManifestacao) && (
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Horário <span className="text-muted-foreground font-normal">(opcional)</span></label>
                    <Input type="time" className="bg-input border-border focus-visible:ring-primary text-foreground"
                      value={editProcesso.horario}
                      onChange={e => setEditProcesso(prev => prev ? { ...prev, horario: e.target.value } : null)}
                    />
                  </div>
                )}

                {/* Cliente */}
                <div className="grid grid-cols-2 gap-3">
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Cliente</label>
                    <Input className="bg-input border-border focus-visible:ring-primary" placeholder="Nome do cliente"
                      value={editProcesso.cliente}
                      onChange={e => setEditProcesso(prev => prev ? { ...prev, cliente: e.target.value } : null)}
                    />
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">CPF do Cliente</label>
                    <Input className="bg-input border-border focus-visible:ring-primary" placeholder="000.000.000-00"
                      value={editProcesso.clienteCpf}
                      onChange={e => setEditProcesso(prev => prev ? { ...prev, clienteCpf: formatarCpfInput(e.target.value) } : null)}
                      maxLength={14}
                    />
                  </div>
                </div>

                {/* Anotação */}
                <div className="space-y-1.5">
                  <label className="text-sm font-medium text-foreground">Anotação</label>
                  <Textarea className="bg-input border-border focus-visible:ring-primary resize-none"
                    placeholder="Observações..." rows={2}
                    value={editProcesso.anotacao}
                    onChange={e => setEditProcesso(prev => prev ? { ...prev, anotacao: e.target.value } : null)}
                  />
                </div>

                {/* Resumo processual */}
                <div className="space-y-1.5">
                  <label className="text-sm font-medium text-foreground">Resumo processual</label>
                  <Textarea className="bg-input border-border focus-visible:ring-primary resize-y"
                    placeholder="Descreva o resumo do processo..." rows={4}
                    value={editProcesso.resumoProcessual}
                    onChange={e => setEditProcesso(prev => prev ? { ...prev, resumoProcessual: e.target.value } : null)}
                  />
                </div>

                {/* PDFs substituíveis */}
                <div className="grid grid-cols-1 gap-3">
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Processo na íntegra <span className="text-muted-foreground font-normal">(PDF)</span></label>
                    {editProcesso.processoIntegralUrl && <a href={editProcesso.processoIntegralUrl} target="_blank" rel="noreferrer" className="inline-flex items-center gap-1 text-xs text-primary hover:underline"><FileText className="w-3.5 h-3.5" />{editProcesso.processoIntegralNome || "Abrir PDF atual"}</a>}
                    <Input type="file" accept="application/pdf,.pdf" className="bg-input border-border file:text-foreground" onChange={e => setEditProcesso(prev => prev ? { ...prev, processoIntegralFile: e.target.files?.[0] ?? null } : null)} />
                    {editProcesso.processoIntegralFile && <p className="text-xs text-muted-foreground flex items-center gap-1"><Upload className="w-3 h-3" />Novo: {editProcesso.processoIntegralFile.name}</p>}
                  </div>
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium text-foreground">Última movimentação <span className="text-muted-foreground font-normal">(PDF)</span></label>
                    {editProcesso.ultimaMovimentacaoUrl && <a href={editProcesso.ultimaMovimentacaoUrl} target="_blank" rel="noreferrer" className="inline-flex items-center gap-1 text-xs text-primary hover:underline"><FileText className="w-3.5 h-3.5" />{editProcesso.ultimaMovimentacaoNome || "Abrir PDF atual"}</a>}
                    <Input type="file" accept="application/pdf,.pdf" className="bg-input border-border file:text-foreground" onChange={e => setEditProcesso(prev => prev ? { ...prev, ultimaMovimentacaoFile: e.target.files?.[0] ?? null } : null)} />
                    {editProcesso.ultimaMovimentacaoFile && <p className="text-xs text-muted-foreground flex items-center gap-1"><Upload className="w-3 h-3" />Novo: {editProcesso.ultimaMovimentacaoFile.name}</p>}
                  </div>
                </div>

                <div className="flex gap-3 pt-1">
                  <Button type="button" variant="outline" className="flex-1 border-border" onClick={() => setEditProcesso(null)}>Cancelar</Button>
                  <Button type="submit" className="flex-1 bg-primary text-primary-foreground" disabled={updateMutation.isPending || isUploading}>
                    {updateMutation.isPending || isUploading ? <><Loader2 className="w-4 h-4 animate-spin mr-2" />Salvando...</> : "Salvar"}
                  </Button>
                </div>
              </form>
            )}
          </DialogContent>
        </Dialog>
      )}
    </div>
  );
}
