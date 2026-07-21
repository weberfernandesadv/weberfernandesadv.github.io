with open('client/src/pages/Admin.tsx', 'r') as f:
    content = f.read()

OLD = '''  // ─── Handlers de download ──────────────────────────────────────────────
  const handleBaixar = async (tipo: string, id: number, nome: string) => {
    setBaixandoId(id);
    const endpointMap: Record<string, string> = {
      procuracao: `/api/gerar-procuracao-por-id/${id}`,
      contrato: `/api/contrato-por-id/${id}`,
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
      const nomeArquivo = response.headers.get("Content-Disposition")?.match(/filename="(.+)"/)?.[1] ?? `${tipo}_${nome.replace(/\\s+/g, "_").toUpperCase()}.docx`;
      const a = document.createElement("a"); a.href = url; a.download = nomeArquivo;
      document.body.appendChild(a); a.click(); a.remove(); URL.revokeObjectURL(url);
      toast.success("Download iniciado!", { description: nome });
      // Marcar como gerado
      if (tipo === "procuracao") marcarPMutation.mutate({ id });
      else if (tipo === "contrato") marcarCMutation.mutate({ id });
      else if (tipo === "declaracao") marcarDMutation.mutate({ id });
      else if (tipo === "procuracaoPa") marcarPAMutation.mutate({ id });
      else if (tipo === "procuracaoWeberAna") marcarWAMutation.mutate({ id });
    } catch (err: unknown) {
      toast.error("Erro ao baixar documento", { description: err instanceof Error ? err.message : "Erro desconhecido." });
    } finally {
      setBaixandoId(null);
    }
  };'''

NEW = '''  // ─── Salvar Seção III e baixar contrato ──────────────────────────────────
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
      const nomeArq = response.headers.get("Content-Disposition")?.match(/filename="(.+)"/)?.[1] ?? `Contrato_${nome.replace(/\\s+/g, "_").toUpperCase()}.docx`;
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
      const nomeArquivo = response.headers.get("Content-Disposition")?.match(/filename="(.+)"/)?.[1] ?? `${tipo}_${nome.replace(/\\s+/g, "_").toUpperCase()}.docx`;
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
  };'''

if OLD in content:
    content = content.replace(OLD, NEW, 1)
    with open('client/src/pages/Admin.tsx', 'w') as f:
        f.write(content)
    print("SUCCESS: handleBaixar updated")
else:
    print("ERROR: OLD text not found")
    # Show what's around that area
    idx = content.find('const handleBaixar')
    print(repr(content[idx:idx+200]))
