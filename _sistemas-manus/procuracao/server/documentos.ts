/**
 * Rotas para Contrato de Honorários, Declaração de Hipossuficiência e Procuração PA.
 * Cada documento tem:
 *   POST /api/<tipo>          → salva dados no banco, retorna token de download
 *   GET  /api/download-<tipo>/:token → download público por token (enviado no e-mail)
 *   GET  /api/<tipo>-por-id/:id      → download protegido por admin
 */
import { Router, Request, Response } from "express";
import { z } from "zod";
import path from "path";
import fs from "fs";
import PizZip from "pizzip";
import { randomUUID } from "crypto";
import {
  salvarContrato, buscarContrato, buscarContratoPorToken, marcarContratoGerado, atualizarSecaoIIIContrato,
  salvarDeclaracao, buscarDeclaracao, buscarDeclaracaoPorToken, marcarDeclaracaoGerada,
  salvarProcuracaoPa, buscarProcuracaoPa, buscarProcuracaoPaPorToken, marcarProcuracaoPaGerada,
  salvarProcuracaoWeberAna, buscarProcuracaoWeberAna, buscarProcuracaoWeberAnaPorToken, marcarProcuracaoWeberAnaGerada,
} from "./db";
import { notifyOwner } from "./_core/notification";
import { sdk } from "./_core/sdk";
import { dataPorExtenso, substituirNoXml } from "./procuracao";

export const documentosRouter = Router();

// ─── Middleware de autenticação admin ─────────────────────────────────────────
async function requireAdmin(req: Request, res: Response, next: () => void) {
  try {
    const user = await sdk.authenticateRequest(req);
    if (!user || user.role !== "admin") {
      res.status(403).json({ erro: "Acesso negado — apenas administradores" });
      return;
    }
    next();
  } catch {
    res.status(401).json({ erro: "Não autenticado" });
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

function nomeArquivo(nome: string): string {
  return nome.split(" ").slice(0, 2).join("_").replace(/[^a-zA-ZÀ-ÿ0-9_]/g, "").toUpperCase();
}

function montarEndereco(d: {
  rua: string; quadra?: string | null; lote?: string | null;
  setor?: string | null; cidade: string; estado?: string | null; cep: string;
}): string {
  let e = d.rua;
  if (d.quadra) e += `, Quadra ${d.quadra}`;
  if (d.lote) e += `, Lote ${d.lote}`;
  if (d.setor) e += `, ${d.setor}`;
  if (d.cidade) e += `, ${d.cidade}`;
  if (d.estado) e += `/${d.estado}`;
  if (d.cep) e += `, CEP ${d.cep}`;
  return e;
}

function valorPorExtenso(valor: string): string {
  // Converte "1500,00" ou "1500.00" para "mil e quinhentos reais"
  // Implementação simplificada — retorna o valor formatado como R$ X,XX
  const num = parseFloat(valor.replace(",", "."));
  if (isNaN(num)) return valor;
  return `R$ ${num.toLocaleString("pt-BR", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function gerarParcelasDatas(dataPrimeira: string, numParcelas: number, valorParcela: string): string {
  // dataPrimeira no formato DD/MM/AAAA
  const [dia, mes, ano] = dataPrimeira.split("/").map(Number);
  const linhas: string[] = [];
  const ordinais = ["1ª", "2ª", "3ª", "4ª", "5ª", "6ª", "7ª", "8ª", "9ª", "10ª",
    "11ª", "12ª", "13ª", "14ª", "15ª", "16ª", "17ª", "18ª", "19ª", "20ª",
    "21ª", "22ª", "23ª", "24ª"];
  const valorFormatado = valorPorExtenso(valorParcela);
  for (let i = 0; i < numParcelas; i++) {
    let m = mes + i;
    let a = ano;
    while (m > 12) { m -= 12; a++; }
    const diaStr = String(dia).padStart(2, "0");
    const mesStr = String(m).padStart(2, "0");
    const ord = ordinais[i] ?? `${i + 1}ª`;
    linhas.push(`${ord} Parcela ${valorFormatado} em ${diaStr}/${mesStr}/${a}`);
  }
  return linhas.join(", ");
}

// ─── Schema de campos comuns do outorgante ────────────────────────────────────
const OutorganteSchema = z.object({
  nome: z.string().min(3, "Nome completo é obrigatório"),
  genero: z.string().min(2, "Gênero é obrigatório"),
  estadoCivil: z.string().min(2, "Estado civil é obrigatório"),
  profissao: z.string().min(2, "Profissão é obrigatória"),
  cpf: z.string().regex(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/, "CPF inválido — use xxx.xxx.xxx-xx"),
  rg: z.string().min(3, "RG é obrigatório"),
  naturalidade: z.string().min(2, "Naturalidade é obrigatória"),
  nomePai: z.string().min(2, "Nome do pai é obrigatório"),
  nomeMae: z.string().min(2, "Nome da mãe é obrigatório"),
  rua: z.string().min(3, "Rua/Avenida é obrigatória"),
  quadra: z.string().optional(),
  lote: z.string().optional(),
  setor: z.string().optional(),
  cidade: z.string().min(2, "Cidade é obrigatória"),
  estado: z.string().optional(),
  cep: z.string().regex(/^\d{5}-\d{3}$/, "CEP inválido — use xxxxx-xxx"),
});

// ─── Schema do Contrato ───────────────────────────────────────────────────────
// Dados enviados pelo cliente (qualificação + endereço + data de assinatura)
const ContratoSchema = OutorganteSchema.extend({
  dataContrato: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/, "Data do contrato inválida — use DD/MM/AAAA"),
});

// Seção III preenchida pelo advogado no Admin
const ContratoSecaoIIISchema = z.object({
  tipoAcao: z.string().min(3, "Tipo de ação é obrigatório"),
  tribunal: z.string().min(3, "Tribunal é obrigatório"),
  faseProcessual: z.string().min(3, "Fase processual é obrigatória"),
  valorTotal: z.string().min(1, "Valor total é obrigatório"),
  valorEntrada: z.string().min(1, "Valor de entrada é obrigatório"),
  dataEntrada: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/, "Data de entrada inválida — use DD/MM/AAAA"),
  numParcelas: z.number().int().min(1).max(24),
  valorParcela: z.string().min(1, "Valor da parcela é obrigatório"),
  dataPrimeiraParcela: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/, "Data da 1ª parcela inválida — use DD/MM/AAAA"),
});

// Schema completo para geração do documento (combina dados do cliente + Seção III)
const ContratoCompletoSchema = OutorganteSchema.extend({
  dataContrato: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/, "Data do contrato inválida — use DD/MM/AAAA"),
  tipoAcao: z.string().min(3),
  tribunal: z.string().min(3),
  faseProcessual: z.string().min(3),
  valorTotal: z.string().min(1),
  valorEntrada: z.string().min(1),
  dataEntrada: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/),
  numParcelas: z.number().int().min(1).max(24),
  valorParcela: z.string().min(1),
  dataPrimeiraParcela: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/),
});

// ─── Schema da Declaração ─────────────────────────────────────────────────────
const DeclaracaoSchema = OutorganteSchema.extend({
  dataDeclaracao: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/, "Data inválida — use DD/MM/AAAA"),
});

// ─── Schema da Procuração PA ──────────────────────────────────────────────────
const ProcuracaoPaSchema = OutorganteSchema.extend({
  nomeMenor: z.string().min(3, "Nome do menor é obrigatório"),
  cpfMenor: z.string().regex(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/, "CPF do menor inválido — use xxx.xxx.xxx-xx"),
  dataNascimento: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/, "Data de nascimento inválida — use DD/MM/AAAA"),
});

// ─── Gerador de Contrato ──────────────────────────────────────────────────────
function gerarContrato(d: z.infer<typeof ContratoCompletoSchema>): Buffer {
  const modeloPath = path.resolve(process.cwd(), "server", "modelo_contrato.docx");
  if (!fs.existsSync(modeloPath)) throw new Error("Modelo de contrato não encontrado.");

  const content = fs.readFileSync(modeloPath, "binary");
  const zip = new PizZip(content);
  let xml = zip.file("word/document.xml")!.asText();

  const nome = d.nome.trim().toUpperCase();
  const endereco = montarEndereco(d);
  const parcelasDatas = gerarParcelasDatas(d.dataPrimeiraParcela, d.numParcelas, d.valorParcela);
  const valorTotalFormatado = valorPorExtenso(d.valorTotal);
  const valorEntradaFormatado = valorPorExtenso(d.valorEntrada);
  const valorParcelaFormatado = valorPorExtenso(d.valorParcela);

  // Formatar data de assinatura como "Goiânia, dia X de mês de ano"
  const MESES_CONT = ['', 'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
    'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  const [diaC, mesC, anoC] = d.dataContrato.trim().split('/');
  const dataContratoFormatada = `Goiânia, ${parseInt(diaC, 10)} de ${MESES_CONT[parseInt(mesC, 10)]} de ${anoC}`;

  // Aspas tipográficas Unicode usadas no documento Word
  const AO = '\u201c'; // abre aspas “
  const AF = '\u201d'; // fecha aspas ”
  const q = (s: string) => `${AO}${s}${AF}`;

  // Concordância de gênero do contratante
  const feminino = d.genero.trim() === 'brasileira';
  const termoBrasileiro = feminino ? 'brasileira' : 'brasileiro';
  const termoInscrito = feminino ? 'inscrita' : 'inscrito';
  const termoFilho = feminino ? 'filha' : 'filho';
  const termoDomiciliado = feminino ? 'domiciliada' : 'domiciliado';

  // O contrato tem 3 ocorrências de "(Valor)" na ordem:
  // 1ª = valor total dos honorários
  // 2ª = valor de entrada (à vista)
  // 3ª = valor de cada parcela
  // Substituiremos uma por vez usando um placeholder temporário
  const TEMP_TOTAL = '\x00VALOR_TOTAL\x00';
  const TEMP_ENTRADA = '\x00VALOR_ENTRADA\x00';
  const TEMP_PARCELA_UNIT = '\x00VALOR_PARCELA_UNIT\x00';

  const substituicoes: [string, string][] = [
    // Dados do contratante
    [q('Nome'), nome],
    // Concordância de gênero: ', brasileiro' + '(a)' são 2 runs separados no XML
    [', brasileiro(a)', `, ${termoBrasileiro}`],
    [q('estado civil'), d.estadoCivil.trim()],
    [q('Profissão'), d.profissao.trim()],
    // Concordância de gênero: ', inscrito' + '(a)' são 2 runs separados no XML
    [', inscrito(a)', `, ${termoInscrito}`],
    [q('xxx.xxx.xxx-xx'), d.cpf.trim()],
    [q('xxxxxxxxx'), d.rg.trim()],
    [q('cidade-UF'), d.naturalidade.trim()],
    // Concordância de gênero: 'filho de' está em run separado
    ['filho de', `${termoFilho} de`],
    [q('nome do pai'), d.nomePai.trim()],
    [q('nome da mãe'), d.nomeMae.trim()],
    // Concordância de gênero: 'residente e domiciliado na' está em run separado
    ['residente e domiciliado na ', `residente e ${termoDomiciliado} na `],
    [q('logradouro, quadra, lote, Setor, Cidade, Estado, CEP'), endereco],
    // Dados do processo
    [q('tipo de ação'), d.tipoAcao.trim()],
    [q('tribunal de origem'), d.tribunal.trim()],
    [q('especificar a fase: ex. defesa prévia, audiências, recursos'), d.faseProcessual.trim()],
    // Valores: substituir as 3 ocorrências de "(Valor)" na ordem correta
    // Primeiro: marcar com temporários
    [q('(Valor)'), TEMP_TOTAL],      // 1ª ocorrência = valor total
    [q('(Valor)'), TEMP_ENTRADA],    // 2ª ocorrência = entrada
    [q('(Valor da prestação)'), valorParcelaFormatado],
    [q('(Parcelas)'), String(d.numParcelas)],
    [q('(Valor)'), TEMP_PARCELA_UNIT], // 3ª ocorrência = valor por parcela
    // Substituir data de entrada e parcelas
    ['15/05/2026', d.dataEntrada.trim()],
    ['1ª parcela: xx/xx/xxxx;', parcelasDatas],
    [q('data'), dataContratoFormatada],
    // Resolver temporários pelos valores reais
    [TEMP_TOTAL, valorTotalFormatado],
    [TEMP_ENTRADA, valorEntradaFormatado],
    [TEMP_PARCELA_UNIT, valorParcelaFormatado],
  ];

  xml = substituirNoXml(xml, substituicoes);
  zip.file("word/document.xml", xml);

  return zip.generate({
    type: "nodebuffer",
    mimeType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    compression: "DEFLATE",
  });
}

// ─── Gerador de Declaração ────────────────────────────────────────────────────
function gerarDeclaracao(d: z.infer<typeof DeclaracaoSchema>): Buffer {
  const modeloPath = path.resolve(process.cwd(), "server", "modelo_declaracao.docx");
  if (!fs.existsSync(modeloPath)) throw new Error("Modelo de declaração não encontrado.");

  const content = fs.readFileSync(modeloPath, "binary");
  const zip = new PizZip(content);
  let xml = zip.file("word/document.xml")!.asText();

  const nome = d.nome.trim().toUpperCase();
  const endereco = montarEndereco(d);

  const AO = '\u201c'; const AF = '\u201d';
  const q = (s: string) => `${AO}${s}${AF}`;

  // Concordância de gênero
  const feminino = d.genero.trim() === 'brasileira';
  const termoBrasileiro = feminino ? 'brasileira' : 'brasileiro';
  const termoInscrito = feminino ? 'inscrita' : 'inscrito';
  const termoFilho = feminino ? 'filha' : 'filho';
  const termoDomiciliado = feminino ? 'domiciliada' : 'domiciliado';

  // Formatar data como 'Goiânia, dia X de mês de ano'
  const [diaD, mesD, anoD] = d.dataDeclaracao.trim().split('/');
  const MESES_DECL = ['', 'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
    'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  const dataFormatada = `Goiânia, ${parseInt(diaD, 10)} de ${MESES_DECL[parseInt(mesD, 10)]} de ${anoD}`;

  const substituicoes: [string, string][] = [
    // Nome em maiúsculas (o modelo usa aspas tipográficas ao redor de 'Nome')
    [q('Nome'), nome],
    // Concordância de gênero: 'brasileiro(a)' está no mesmo run junto com estado civil e profissão
    ['brasileiro(a)', termoBrasileiro],
    [q('estado civil'), d.estadoCivil.trim()],
    [q('Profissão'), d.profissao.trim()],
    // Concordância de gênero: 'inscrito(a)' está no mesmo run
    ['inscrito(a)', termoInscrito],
    [q('xxx.xxx.xxx-xx'), d.cpf.trim()],
    [q('xxxxxxxxx'), d.rg.trim()],
    [q('cidade-UF'), d.naturalidade.trim()],
    // Concordância de gênero: 'filho de' está em run separado
    ['filho de', `${termoFilho} de`],
    [q('nome do pai'), d.nomePai.trim()],
    [q('nome da mãe'), d.nomeMae.trim()],
    // Concordância de gênero: 'residente e domiciliado na' está no run que contém pai/mãe e endereço
    ['residente e domiciliado na ', `residente e ${termoDomiciliado} na `],
    [q('logradouro, quadra, lote, Setor, Cidade, Estado, CEP'), endereco],
    // Data formatada como 'Goiânia, dia X de mês de ano'
    [q('data'), dataFormatada],
    // Nome em maiúsculas na assinatura (o modelo usa aspas tipográficas ao redor de 'nome' minúsculo)
    [q('nome'), nome],
  ];

  xml = substituirNoXml(xml, substituicoes);
  zip.file("word/document.xml", xml);

  return zip.generate({
    type: "nodebuffer",
    mimeType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    compression: "DEFLATE",
  });
}

// ─── Gerador de Procuração PA ─────────────────────────────────────────────────
function gerarProcuracaoPa(d: z.infer<typeof ProcuracaoPaSchema>): Buffer {
  const modeloPath = path.resolve(process.cwd(), "server", "modelo_procuracao_pa.docx");
  if (!fs.existsSync(modeloPath)) throw new Error("Modelo de Procuração PA não encontrado.");

  const content = fs.readFileSync(modeloPath, "binary");
  const zip = new PizZip(content);
  let xml = zip.file("word/document.xml")!.asText();

  const nomeGenitora = d.nome.trim().toUpperCase();
  const nomeMenor = d.nomeMenor.trim().toUpperCase();
  const endereco = montarEndereco(d);

  const AO = '\u201c'; const AF = '\u201d';
  const q = (s: string) => `${AO}${s}${AF}`;

  // Concordância de gênero da genitora
  const femininoGenitora = d.genero.trim() === 'brasileira';
  const termoInscritoGenitora = femininoGenitora ? 'inscrita' : 'inscrito';
  const termoFilhoGenitora = femininoGenitora ? 'filha' : 'filho';
  const termoDomiciliadoGenitora = femininoGenitora ? 'domiciliada' : 'domiciliado';

  const substituicoes: [string, string][] = [
    // Menor: 'nome do menor' e CPF do menor
    [q('nome do menor'), nomeMenor],
    // Menor: ', brasileiro(a)' está fragmentado em 3 runs: ', brasileir' + 'o' + '(a)'
    // A função substituirNoXml concatena runs adjacentes, então ', brasileiro(a)' funciona
    [', brasileiro(a)', `, ${femininoGenitora ? 'brasileira' : 'brasileiro'}`],
    [q('xxx.xxx.xxx-xx'), d.cpfMenor.trim()],   // primeiro CPF = do menor
    [q('data de nascimento no formato dia/mês/ano'), d.dataNascimento.trim()],
    // Genitora: Nome
    [q('Nome'), nomeGenitora],
    // Genitora: 'brasileiro(a)' está no mesmo run junto com estado civil e profissão
    ['brasileiro(a)', femininoGenitora ? 'brasileira' : 'brasileiro'],
    [q('estado civil'), d.estadoCivil.trim()],
    [q('Profissão'), d.profissao.trim()],
    // Genitora: 'inscrito(a)' está no mesmo run
    ['inscrito(a)', termoInscritoGenitora],
    [q('xxxxxxxxx'), d.rg.trim()],
    [q('cidade-UF'), d.naturalidade.trim()],
    // Genitora: 'filho de' está em run separado
    ['filho de', `${termoFilhoGenitora} de`],
    [q('nome do pai'), d.nomePai.trim()],
    [q('nome da mãe'), d.nomeMae.trim()],
    // Genitora: 'residente e domiciliado na' está em run separado
    ['residente e domiciliado na ', `residente e ${termoDomiciliadoGenitora} na `],
    [q('logradouro, quadra, lote, Setor, Cidade, Estado, CEP'), endereco],
    [q('data'), dataPorExtenso()],
  ];

  // Substituir o CPF da genitora (segundo placeholder restante após o do menor já ter sido substituído)
  substituicoes.push([q('xxx.xxx.xxx-xx'), d.cpf.trim()]);
  // Substituir o nome da genitora na assinatura
  substituicoes.push([q('Nome'), nomeGenitora]);

  xml = substituirNoXml(xml, substituicoes);
  zip.file("word/document.xml", xml);

  return zip.generate({
    type: "nodebuffer",
    mimeType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    compression: "DEFLATE",
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// ROTAS DO CONTRATO
// ═══════════════════════════════════════════════════════════════════════════════

documentosRouter.post("/contrato", async (req: Request, res: Response) => {
  const parsed = ContratoSchema.safeParse(req.body);
  if (!parsed.success) {
    const erros = parsed.error.issues.map((e: any) => ({ campo: e.path.join("."), mensagem: e.message }));
    res.status(400).json({ erro: "Dados inválidos", campos: erros });
    return;
  }

  try {
    const d = parsed.data;
    const downloadToken = randomUUID().replace(/-/g, "");

    const id = await salvarContrato({
      nome: d.nome.trim().toUpperCase(),
      genero: d.genero.trim(),
      estadoCivil: d.estadoCivil.trim(),
      profissao: d.profissao.trim(),
      cpf: d.cpf.trim(),
      rg: d.rg.trim(),
      naturalidade: d.naturalidade.trim(),
      nomePai: d.nomePai.trim(),
      nomeMae: d.nomeMae.trim(),
      rua: d.rua.trim(),
      quadra: d.quadra?.trim() ?? null,
      lote: d.lote?.trim() ?? null,
      setor: d.setor?.trim() ?? null,
      cidade: d.cidade.trim(),
      estado: d.estado?.trim() ?? null,
      cep: d.cep.trim(),
      dataContrato: d.dataContrato.trim(),
      downloadToken,
      // Seção III — campos omitidos intencionalmente; o banco usa NULL por padrão
    });

    const origem = req.headers.origin || req.headers.referer?.replace(/\/$/, "") || "https://procuracao-9hxvmh7v.manus.space";
    const linkPainel = `${origem}/admin`;
    notifyOwner({
      title: "Novo contrato recebido — aguarda Seção III",
      content: `Cliente: ${d.nome.trim().toUpperCase()}\nCPF: ${d.cpf.trim()}\nCidade: ${d.cidade.trim()}\n\nAcesse o painel para preencher os dados do processo e gerar o contrato:\n${linkPainel}`,
    }).catch((err) => console.warn("[Notificação] Falha:", err));

    res.status(200).json({ sucesso: true, mensagem: "Dados recebidos com sucesso.", id });
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Erro desconhecido";
    res.status(500).json({ erro: msg });
  }
});

// PUT /api/contrato/:id/secao-iii — advogado preenche Seção III (dados do processo + honorários)
documentosRouter.put("/contrato/:id/secao-iii", requireAdmin, async (req: Request, res: Response) => {
  const id = parseInt(req.params.id, 10);
  if (isNaN(id) || id <= 0) { res.status(400).json({ erro: "ID inválido" }); return; }

  const parsed = ContratoSecaoIIISchema.safeParse(req.body);
  if (!parsed.success) {
    const erros = parsed.error.issues.map((e: any) => ({ campo: e.path.join("."), mensagem: e.message }));
    res.status(400).json({ erro: "Dados inválidos", campos: erros });
    return;
  }

  try {
    const d = parsed.data;
    await atualizarSecaoIIIContrato(id, {
      tipoAcao: d.tipoAcao.trim(),
      tribunal: d.tribunal.trim(),
      faseProcessual: d.faseProcessual.trim(),
      valorTotal: d.valorTotal.trim(),
      valorEntrada: d.valorEntrada.trim(),
      dataEntrada: d.dataEntrada.trim(),
      numParcelas: d.numParcelas,
      valorParcela: d.valorParcela.trim(),
      dataPrimeiraParcela: d.dataPrimeiraParcela.trim(),
    });
    res.status(200).json({ sucesso: true, mensagem: "Seção III salva com sucesso." });
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Erro desconhecido";
    res.status(500).json({ erro: msg });
  }
});

documentosRouter.get("/download-contrato/:token", async (req: Request, res: Response) => {
  const { token } = req.params;
  if (!token || token.length < 20) { res.status(400).json({ erro: "Token inválido" }); return; }

  try {
    const registro = await buscarContratoPorToken(token);
    if (!registro) {
      res.status(404).send(`<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><title>Link inválido</title></head><body style="font-family:sans-serif;text-align:center;padding:60px;"><h2>Link inválido ou expirado</h2><p>Verifique o e-mail de notificação.</p></body></html>`);
      return;
    }

    const buffer = gerarContrato(registro as any);
    const arq = nomeArquivo(registro.nome);
    marcarContratoGerado(registro.id).catch(() => {});
    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="Contrato_${arq}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    res.status(500).json({ erro: err instanceof Error ? err.message : "Erro desconhecido" });
  }
});

documentosRouter.get("/contrato-por-id/:id", requireAdmin, async (req: Request, res: Response) => {
  const id = parseInt(req.params.id, 10);
  if (isNaN(id) || id <= 0) { res.status(400).json({ erro: "ID inválido" }); return; }

  try {
    const registro = await buscarContrato(id);
    if (!registro) { res.status(404).json({ erro: "Contrato não encontrado" }); return; }

    const buffer = gerarContrato(registro as any);
    const arq = nomeArquivo(registro.nome);
    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="Contrato_${arq}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    res.status(500).json({ erro: err instanceof Error ? err.message : "Erro desconhecido" });
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// ROTAS DA DECLARAÇÃO
// ═══════════════════════════════════════════════════════════════════════════════

documentosRouter.post("/declaracao", async (req: Request, res: Response) => {
  const parsed = DeclaracaoSchema.safeParse(req.body);
  if (!parsed.success) {
    const erros = parsed.error.issues.map((e: any) => ({ campo: e.path.join("."), mensagem: e.message }));
    res.status(400).json({ erro: "Dados inválidos", campos: erros });
    return;
  }

  try {
    const d = parsed.data;
    const downloadToken = randomUUID().replace(/-/g, "");

    const id = await salvarDeclaracao({
      nome: d.nome.trim().toUpperCase(),
      genero: d.genero.trim(),
      estadoCivil: d.estadoCivil.trim(),
      profissao: d.profissao.trim(),
      cpf: d.cpf.trim(),
      rg: d.rg.trim(),
      naturalidade: d.naturalidade.trim(),
      nomePai: d.nomePai.trim(),
      nomeMae: d.nomeMae.trim(),
      rua: d.rua.trim(),
      quadra: d.quadra?.trim() ?? null,
      lote: d.lote?.trim() ?? null,
      setor: d.setor?.trim() ?? null,
      cidade: d.cidade.trim(),
      estado: d.estado?.trim() ?? null,
      cep: d.cep.trim(),
      dataDeclaracao: d.dataDeclaracao.trim(),
      downloadToken,
    });

    const origem = req.headers.origin || req.headers.referer?.replace(/\/$/, "") || "https://procuracao-9hxvmh7v.manus.space";
    const linkDownload = `${origem}/api/download-declaracao/${downloadToken}`;
    const linkPainel = `${origem}/admin`;
    notifyOwner({
      title: "Nova declaração recebida",
      content: `Cliente: ${d.nome.trim().toUpperCase()}\nCPF: ${d.cpf.trim()}\nCidade: ${d.cidade.trim()}\n\n📥 BAIXAR DECLARAÇÃO:\n${linkDownload}\n\nPainel:\n${linkPainel}`,
    }).catch((err) => console.warn("[Notificação] Falha:", err));

    res.status(200).json({ sucesso: true, mensagem: "Dados recebidos com sucesso.", id });
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Erro desconhecido";
    res.status(500).json({ erro: msg });
  }
});

documentosRouter.get("/download-declaracao/:token", async (req: Request, res: Response) => {
  const { token } = req.params;
  if (!token || token.length < 20) { res.status(400).json({ erro: "Token inválido" }); return; }

  try {
    const registro = await buscarDeclaracaoPorToken(token);
    if (!registro) {
      res.status(404).send(`<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><title>Link inválido</title></head><body style="font-family:sans-serif;text-align:center;padding:60px;"><h2>Link inválido ou expirado</h2><p>Verifique o e-mail de notificação.</p></body></html>`);
      return;
    }

    const buffer = gerarDeclaracao(registro as any);
    const arq = nomeArquivo(registro.nome);
    marcarDeclaracaoGerada(registro.id).catch(() => {});
    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="Declaracao_${arq}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    res.status(500).json({ erro: err instanceof Error ? err.message : "Erro desconhecido" });
  }
});

documentosRouter.get("/declaracao-por-id/:id", requireAdmin, async (req: Request, res: Response) => {
  const id = parseInt(req.params.id, 10);
  if (isNaN(id) || id <= 0) { res.status(400).json({ erro: "ID inválido" }); return; }

  try {
    const registro = await buscarDeclaracao(id);
    if (!registro) { res.status(404).json({ erro: "Declaração não encontrada" }); return; }

    const buffer = gerarDeclaracao(registro as any);
    const arq = nomeArquivo(registro.nome);
    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="Declaracao_${arq}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    res.status(500).json({ erro: err instanceof Error ? err.message : "Erro desconhecido" });
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// ROTAS DA PROCURAÇÃO PA
// ═══════════════════════════════════════════════════════════════════════════════

documentosRouter.post("/procuracao-pa", async (req: Request, res: Response) => {
  const parsed = ProcuracaoPaSchema.safeParse(req.body);
  if (!parsed.success) {
    const erros = parsed.error.issues.map((e: any) => ({ campo: e.path.join("."), mensagem: e.message }));
    res.status(400).json({ erro: "Dados inválidos", campos: erros });
    return;
  }

  try {
    const d = parsed.data;
    const downloadToken = randomUUID().replace(/-/g, "");

    const id = await salvarProcuracaoPa({
      nomeMenor: d.nomeMenor.trim().toUpperCase(),
      cpfMenor: d.cpfMenor.trim(),
      dataNascimento: d.dataNascimento.trim(),
      nome: d.nome.trim().toUpperCase(),
      genero: d.genero.trim(),
      estadoCivil: d.estadoCivil.trim(),
      profissao: d.profissao.trim(),
      cpf: d.cpf.trim(),
      rg: d.rg.trim(),
      naturalidade: d.naturalidade.trim(),
      nomePai: d.nomePai.trim(),
      nomeMae: d.nomeMae.trim(),
      rua: d.rua.trim(),
      quadra: d.quadra?.trim() ?? null,
      lote: d.lote?.trim() ?? null,
      setor: d.setor?.trim() ?? null,
      cidade: d.cidade.trim(),
      estado: d.estado?.trim() ?? null,
      cep: d.cep.trim(),
      downloadToken,
    });

    const origem = req.headers.origin || req.headers.referer?.replace(/\/$/, "") || "https://procuracao-9hxvmh7v.manus.space";
    const linkDownload = `${origem}/api/download-procuracao-pa/${downloadToken}`;
    const linkPainel = `${origem}/admin`;
    notifyOwner({
      title: "Nova Procuração PA recebida",
      content: `Menor: ${d.nomeMenor.trim().toUpperCase()}\nGenitora: ${d.nome.trim().toUpperCase()}\nCPF: ${d.cpf.trim()}\nCidade: ${d.cidade.trim()}\n\n📥 BAIXAR PROCURAÇÃO PA:\n${linkDownload}\n\nPainel:\n${linkPainel}`,
    }).catch((err) => console.warn("[Notificação] Falha:", err));

    res.status(200).json({ sucesso: true, mensagem: "Dados recebidos com sucesso.", id });
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Erro desconhecido";
    res.status(500).json({ erro: msg });
  }
});

documentosRouter.get("/download-procuracao-pa/:token", async (req: Request, res: Response) => {
  const { token } = req.params;
  if (!token || token.length < 20) { res.status(400).json({ erro: "Token inválido" }); return; }

  try {
    const registro = await buscarProcuracaoPaPorToken(token);
    if (!registro) {
      res.status(404).send(`<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><title>Link inválido</title></head><body style="font-family:sans-serif;text-align:center;padding:60px;"><h2>Link inválido ou expirado</h2><p>Verifique o e-mail de notificação.</p></body></html>`);
      return;
    }

    const buffer = gerarProcuracaoPa(registro as any);
    const arq = nomeArquivo(registro.nomeMenor);
    marcarProcuracaoPaGerada(registro.id).catch(() => {});
    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="ProcuracaoPA_${arq}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    res.status(500).json({ erro: err instanceof Error ? err.message : "Erro desconhecido" });
  }
});

documentosRouter.get("/procuracao-pa-por-id/:id", requireAdmin, async (req: Request, res: Response) => {
  const id = parseInt(req.params.id, 10);
  if (isNaN(id) || id <= 0) { res.status(400).json({ erro: "ID inválido" }); return; }

  try {
    const registro = await buscarProcuracaoPa(id);
    if (!registro) { res.status(404).json({ erro: "Procuração PA não encontrada" }); return; }

    const buffer = gerarProcuracaoPa(registro as any);
    const arq = nomeArquivo(registro.nomeMenor);
    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="ProcuracaoPA_${arq}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    res.status(500).json({ erro: err instanceof Error ? err.message : "Erro desconhecido" });
  }
});

// ═══════════════════════════════════════════════════════════════════════════════
// PROCURAÇÃO WEBER E ANA LAURA (dois outorgados)
// ═══════════════════════════════════════════════════════════════════════════════

// Schema — mesmos campos do outorgante (sem dados de menor)
const ProcuracaoWeberAnaSchema = OutorganteSchema;

function gerarProcuracaoWeberAna(d: z.infer<typeof ProcuracaoWeberAnaSchema>): Buffer {
  const modeloPath = path.resolve(process.cwd(), "server", "modelo_procuracao_weber_ana.docx");
  if (!fs.existsSync(modeloPath)) throw new Error("Modelo de Procuração Weber e Ana Laura não encontrado.");

  const content = fs.readFileSync(modeloPath, "binary");
  const zip = new PizZip(content);
  let xml = zip.file("word/document.xml")!.asText();

  const nome = d.nome.trim().toUpperCase();
  const endereco = montarEndereco(d);

  const AO = '\u201c'; const AF = '\u201d';
  const q = (s: string) => `${AO}${s}${AF}`;

  const substituicoes: [string, string][] = [
    [q('Nome'), nome],
    [q('estado civil'), d.estadoCivil.trim()],
    [q('Profissão'), d.profissao.trim()],
    [q('xxx.xxx.xxx-xx'), d.cpf.trim()],
    [q('xxxxxxxxx'), d.rg.trim()],
    [q('cidade-UF'), d.naturalidade.trim()],
    [q('nome do pai'), d.nomePai.trim()],
    [q('nome da mãe'), d.nomeMae.trim()],
    [q('logradouro, quadra, lote, Setor, Cidade, Estado, CEP'), endereco],
    [q('data'), dataPorExtenso()],
    [q('nome'), nome],
  ];

  xml = substituirNoXml(xml, substituicoes);
  zip.file("word/document.xml", xml);

  return zip.generate({
    type: "nodebuffer",
    mimeType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    compression: "DEFLATE",
  });
}

documentosRouter.post("/procuracao-weber-ana", async (req: Request, res: Response) => {
  const parsed = ProcuracaoWeberAnaSchema.safeParse(req.body);
  if (!parsed.success) {
    const erros = parsed.error.issues.map((e: any) => ({ campo: e.path.join("."), mensagem: e.message }));
    res.status(400).json({ erro: "Dados inválidos", campos: erros });
    return;
  }

  try {
    const d = parsed.data;
    const downloadToken = randomUUID().replace(/-/g, "");

    const id = await salvarProcuracaoWeberAna({
      nome: d.nome.trim().toUpperCase(),
      genero: d.genero.trim(),
      estadoCivil: d.estadoCivil.trim(),
      profissao: d.profissao.trim(),
      cpf: d.cpf.trim(),
      rg: d.rg.trim(),
      naturalidade: d.naturalidade.trim(),
      nomePai: d.nomePai.trim(),
      nomeMae: d.nomeMae.trim(),
      rua: d.rua.trim(),
      quadra: d.quadra?.trim() ?? null,
      lote: d.lote?.trim() ?? null,
      setor: d.setor?.trim() ?? null,
      cidade: d.cidade.trim(),
      estado: d.estado?.trim() ?? null,
      cep: d.cep.trim(),
      downloadToken,
    });

    const origem = req.headers.origin || req.headers.referer?.replace(/\/$/, "") || "https://procuracao-9hxvmh7v.manus.space";
    const linkDownload = `${origem}/api/download-procuracao-weber-ana/${downloadToken}`;
    const linkPainel = `${origem}/admin`;

    notifyOwner({
      title: "Nova Procuração (Weber e Ana Laura) recebida",
      content: `Cliente: ${d.nome.trim().toUpperCase()}\nCPF: ${d.cpf.trim()}\nCidade: ${d.cidade.trim()}\n\n📥 BAIXAR PROCURAÇÃO:\n${linkDownload}\n\nPainel:\n${linkPainel}`,
    }).catch((err) => console.warn("[Notificação] Falha:", err));

    res.status(200).json({ sucesso: true, mensagem: "Dados recebidos com sucesso.", id });
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Erro desconhecido";
    res.status(500).json({ erro: msg });
  }
});

documentosRouter.get("/download-procuracao-weber-ana/:token", async (req: Request, res: Response) => {
  const { token } = req.params;
  if (!token || token.length < 20) { res.status(400).json({ erro: "Token inválido" }); return; }
  try {
    const registro = await buscarProcuracaoWeberAnaPorToken(token);
    if (!registro) {
      res.status(404).send(`<!DOCTYPE html><html lang="pt-BR"><head><meta charset="UTF-8"><title>Link inválido</title></head><body style="font-family:sans-serif;text-align:center;padding:60px;"><h2>Link inválido ou expirado</h2><p>Verifique o e-mail de notificação.</p></body></html>`);
      return;
    }
    const buffer = gerarProcuracaoWeberAna(registro as any);
    const arq = nomeArquivo(registro.nome);
    marcarProcuracaoWeberAnaGerada(registro.id).catch(() => {});
    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="ProcuracaoWeberAna_${arq}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    res.status(500).json({ erro: err instanceof Error ? err.message : "Erro desconhecido" });
  }
});

documentosRouter.get("/procuracao-weber-ana-por-id/:id", requireAdmin, async (req: Request, res: Response) => {
  const id = parseInt(req.params.id, 10);
  if (isNaN(id) || id <= 0) { res.status(400).json({ erro: "ID inválido" }); return; }
  try {
    const registro = await buscarProcuracaoWeberAna(id);
    if (!registro) { res.status(404).json({ erro: "Procuração não encontrada" }); return; }
    const buffer = gerarProcuracaoWeberAna(registro as any);
    const arq = nomeArquivo(registro.nome);
    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="ProcuracaoWeberAna_${arq}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    res.status(500).json({ erro: err instanceof Error ? err.message : "Erro desconhecido" });
  }
});
