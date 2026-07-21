import { Router, Request, Response } from "express";
import { z } from "zod";
import path from "path";
import fs from "fs";
import PizZip from "pizzip";
import { randomUUID } from "crypto";
import { salvarProcuracao, buscarProcuracao, buscarProcuracaoPorToken, marcarProcuracaoGerada } from "./db";
import { notifyOwner } from "./_core/notification";
import { sdk } from "./_core/sdk";

export const procuracaoRouter = Router();

// ─── Schema de validação ──────────────────────────────────────────────────
export const DadosSchema = z.object({
  nome: z.string().min(3, "Nome completo é obrigatório (mínimo 3 caracteres)"),
  genero: z.string().min(2, "Gênero é obrigatório"),
  estadoCivil: z.string().min(2, "Estado civil é obrigatório"),
  profissao: z.string().min(2, "Profissão é obrigatória"),
  cpf: z.string().regex(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/, "CPF inválido — use o formato xxx.xxx.xxx-xx"),
  naturalidadeCidade: z.string().min(2, "Cidade de naturalidade é obrigatória"),
  naturalidadeUF: z.string().min(2, "UF de naturalidade é obrigatória"),
  filiacao: z.string().min(3, "Filiação é obrigatória"),
  rua: z.string().min(3, "Rua/Avenida é obrigatória"),
  quadra: z.string().optional(),
  lote: z.string().optional(),
  cidade: z.string().min(2, "Cidade é obrigatória"),
  estado: z.string().optional(),
  cep: z.string().regex(/^\d{5}-\d{3}$/, "CEP inválido — use o formato xxxxx-xxx"),
});

export type DadosProcuracao = z.infer<typeof DadosSchema>;

// ─── Meses em português ───────────────────────────────────────────────────
const MESES = [
  "", "janeiro", "fevereiro", "março", "abril", "maio", "junho",
  "julho", "agosto", "setembro", "outubro", "novembro", "dezembro",
];

export function dataPorExtenso(date?: Date): string {
  const d = date ?? new Date();
  return `${d.getDate()} de ${MESES[d.getMonth() + 1]} de ${d.getFullYear()}`;
}

// ─── Escapa caracteres especiais para XML ─────────────────────────────────
function escapeXml(str: string): string {
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

// ─── Decodifica entidades XML básicas ─────────────────────────────────────
function decodeXmlEntities(str: string): string {
  return str
    .replace(/&amp;/g, "&")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&quot;/g, '"')
    .replace(/&apos;/g, "'");
}

/**
 * Substitui placeholders no XML do Word de forma segura.
 *
 * Estratégia:
 * 1. Mascara blocos de imagens/VML antes de processar os runs de texto.
 * 2. Concatena os textos dos runs em janela deslizante para detectar
 *    placeholders fragmentados entre múltiplos runs.
 * 3. Distribui o valor no primeiro run do fragmento; esvazia os demais.
 */
export function substituirNoXml(xml: string, substituicoes: [string, string][]): string {
  const blocos: string[] = [];
  let xmlMascarado = xml.replace(
    /(<(?:w:drawing|mc:AlternateContent|v:|o:|wps:|wpg:|w14:)[^>]*>[\s\S]*?<\/(?:w:drawing|mc:AlternateContent|v:[a-z]+|o:[a-z]+|wps:[a-z]+|wpg:[a-z]+|w14:[a-z]+)>)/gi,
    (match) => {
      const idx = blocos.length;
      blocos.push(match);
      return `\x00BLOCO_${idx}\x00`;
    }
  );

  interface RunInfo {
    full: string;
    attrs: string;
    text: string;
    index: number;
  }

  const runs: RunInfo[] = [];
  const runRegex = /<w:t([^>]*)>([^<]*)<\/w:t>/g;
  let m: RegExpExecArray | null;
  while ((m = runRegex.exec(xmlMascarado)) !== null) {
    runs.push({
      full: m[0],
      attrs: m[1],
      text: decodeXmlEntities(m[2]),
      index: m.index,
    });
  }

  for (const [placeholder, valor] of substituicoes) {
    for (let start = 0; start < runs.length; start++) {
      let acumulado = "";
      let end = start;
      while (end < runs.length) {
        acumulado += runs[end].text;
        if (acumulado.includes(placeholder)) {
          const textoDepois = acumulado.replace(placeholder, valor);
          runs[start] = { ...runs[start], text: textoDepois };
          for (let k = start + 1; k <= end; k++) {
            runs[k] = { ...runs[k], text: "" };
          }
          break;
        }
        if (!placeholder.startsWith(acumulado) && !acumulado.endsWith(placeholder.substring(0, acumulado.length > placeholder.length ? placeholder.length : acumulado.length))) {
          let temPrefixo = false;
          for (let len = Math.min(acumulado.length, placeholder.length); len > 0; len--) {
            if (acumulado.endsWith(placeholder.substring(0, len))) {
              temPrefixo = true;
              break;
            }
          }
          if (!temPrefixo) break;
        }
        end++;
      }
    }
  }

  let resultado = xmlMascarado;
  for (let i = runs.length - 1; i >= 0; i--) {
    const run = runs[i];
    const novoTexto = escapeXml(run.text);
    const attrs = run.attrs || (run.text.includes(" ") ? ' xml:space="preserve"' : "");
    const novaTag = `<w:t${attrs}>${novoTexto}</w:t>`;
    resultado =
      resultado.substring(0, run.index) +
      novaTag +
      resultado.substring(run.index + run.full.length);
  }

  resultado = resultado.replace(/\x00BLOCO_(\d+)\x00/g, (_, idx) => blocos[parseInt(idx)]);

  return resultado;
}

// ─── Geração do documento Word ────────────────────────────────────────────
export function gerarDocumento(dados: DadosProcuracao): Buffer {
  const modeloPath = path.resolve(process.cwd(), "server", "modelo_procuracao.docx");

  if (!fs.existsSync(modeloPath)) {
    throw new Error("Modelo de procuração não encontrado no servidor.");
  }

  const content = fs.readFileSync(modeloPath, "binary");
  const zip = new PizZip(content);

  let xml = zip.file("word/document.xml")!.asText();

  const nome = dados.nome.trim().toUpperCase();
  const genero = dados.genero.trim(); // 'brasileiro' ou 'brasileira'
  const estadoCivil = dados.estadoCivil.trim();
  const profissao = dados.profissao.trim();
  const cpf = dados.cpf.trim();
  const naturalidadeCidade = dados.naturalidadeCidade.trim();
  const naturalidadeUF = dados.naturalidadeUF.trim().toUpperCase();
  const naturalidade = `${naturalidadeCidade}-${naturalidadeUF}`;
  const filiacao = dados.filiacao.trim();
  const rua = dados.rua.trim();
  const quadra = dados.quadra?.trim() ?? "";
  const lote = dados.lote?.trim() ?? "";
  const cidade = dados.cidade.trim();
  const estado = dados.estado?.trim().toUpperCase() ?? "";
  const cep = dados.cep.trim();
  const data = dataPorExtenso();

  // Concordância de gênero
  const feminino = genero === 'brasileira';
  const termoBrasileiro = feminino ? 'brasileira' : 'brasileiro';
  const termoInscrito = feminino ? 'inscrita' : 'inscrito';
  const termoFilho = feminino ? 'filha' : 'filho';
  const termoDomiciliado = feminino ? 'domiciliada' : 'domiciliado';

  let endereco = rua;
  if (quadra) endereco += `, Quadra ${quadra}`;
  if (lote) endereco += `, Lote ${lote}`;
  if (cidade) endereco += `, ${cidade}`;
  if (estado) endereco += `/${estado}`;
  if (cep) endereco += `, CEP ${cep}`;

  const substituicoes: [string, string][] = [
    ["(NOME)", nome],
    // 'brasileiro (a)' está fragmentado em 3 runs: 'brasileir' + 'o (a)'
    // A função substituirNoXml concatena runs adjacentes, então 'brasileiro (a)' funciona
    ["brasileiro (a)", termoBrasileiro],
    ["(Estado Civil)", estadoCivil],
    ["(profissão)", profissao],
    // 'inscrita' está em run separado
    ["devidamente inscrita no CPF/MF nº", `devidamente ${termoInscrito} no CPF/MF nº`],
    ["(xxx.xxx.xxx-xx)", cpf],
    ["(naturalidade = cidade-UF)", naturalidade],
    // 'filha de' está em run separado
    [", filha de ", `, ${termoFilho} de `],
    // 'domiciliada' está em run separado
    [", residente e domiciliada na ", `, residente e ${termoDomiciliado} na `],
    ["(filiação)", filiacao],
    ["(endereço)", endereco],
    ["(data atual)", data],
    ["(Assinatura do outorgante)", nome],
  ];

  xml = substituirNoXml(xml, substituicoes);

  zip.file("word/document.xml", xml);

  const buffer = zip.generate({
    type: "nodebuffer",
    mimeType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    compression: "DEFLATE",
  });

  return buffer;
}

// ─── Middleware de autenticação admin ─────────────────────────────────────
async function requireAdmin(req: Request, res: Response, next: () => void) {
  try {
    const user = await sdk.authenticateRequest(req);
    if (!user || user.role !== "admin") {
      res.status(403).json({ erro: "Acesso negado — apenas administradores podem baixar procurações" });
      return;
    }
    next();
  } catch {
    res.status(401).json({ erro: "Não autenticado — faça login no painel do advogado" });
  }
}

// ─── Rota POST /api/gerar-procuracao ─────────────────────────────────────
// Pública: qualquer cliente pode enviar dados. Apenas salva no banco.
procuracaoRouter.post("/gerar-procuracao", async (req: Request, res: Response) => {
  const parsed = DadosSchema.safeParse(req.body);
  if (!parsed.success) {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const erros = parsed.error.issues.map((e: any) => ({
      campo: e.path.join("."),
      mensagem: e.message,
    }));
    res.status(400).json({ erro: "Dados inválidos", campos: erros });
    return;
  }

  try {
    const d = parsed.data;

    const downloadToken = randomUUID().replace(/-/g, "");

    // Armazenar naturalidade como 'cidade-UF'
    const naturalidade = `${d.naturalidadeCidade.trim()}-${d.naturalidadeUF.trim().toUpperCase()}`;

    const id = await salvarProcuracao({
      nome: d.nome.trim().toUpperCase(),
      genero: d.genero.trim(),
      estadoCivil: d.estadoCivil.trim(),
      profissao: d.profissao.trim(),
      cpf: d.cpf.trim(),
      naturalidade,
      filiacao: d.filiacao.trim(),
      rua: d.rua.trim(),
      quadra: d.quadra?.trim() ?? null,
      lote: d.lote?.trim() ?? null,
      cidade: d.cidade.trim(),
      cep: d.cep.trim(),
      downloadToken,
    });

    // Notifica o advogado com link direto de download (não bloqueia a resposta)
    const origem = req.headers.origin || req.headers.referer?.replace(/\/$/, "") || "https://procuracao-9hxvmh7v.manus.space";
    const linkDownload = `${origem}/api/download/${downloadToken}`;
    const linkPainel = `${origem}/admin`;
    notifyOwner({
      title: "Nova procuração recebida",
      content: `Cliente: ${d.nome.trim().toUpperCase()}\nCPF: ${d.cpf.trim()}\nCidade: ${d.cidade.trim()}\n\n📥 BAIXAR PROCURAÇÃO (clique no link abaixo):\n${linkDownload}\n\nOu acesse o painel completo:\n${linkPainel}`,
    }).catch((err) => console.warn("[Notificação] Falha ao notificar:", err));

    res.status(200).json({
      sucesso: true,
      mensagem: "Dados recebidos com sucesso. O advogado preparará a procuração em breve.",
      id,
    });
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Erro desconhecido";
    console.error("[Procuração] Erro ao salvar:", msg);
    res.status(500).json({ erro: msg });
  }
});

// ─── Rota GET /api/gerar-procuracao-por-id/:id ────────────────────────────
// Protegida: apenas admins autenticados podem gerar e baixar o .docx
procuracaoRouter.get("/gerar-procuracao-por-id/:id", requireAdmin, async (req: Request, res: Response) => {
  const id = parseInt(req.params.id, 10);
  if (isNaN(id) || id <= 0) {
    res.status(400).json({ erro: "ID inválido" });
    return;
  }

  try {
    const registro = await buscarProcuracao(id);
    if (!registro) {
      res.status(404).json({ erro: "Procuração não encontrada" });
      return;
    }

    // naturalidade armazenada como 'cidade-UF' — separar para o gerador
    const partes = registro.naturalidade.split('-');
    const natCidade = partes[0] ?? registro.naturalidade;
    const natUF = partes[1] ?? '';

    const dados = {
      nome: registro.nome,
      genero: registro.genero,
      estadoCivil: registro.estadoCivil,
      profissao: registro.profissao,
      cpf: registro.cpf,
      naturalidadeCidade: natCidade,
      naturalidadeUF: natUF,
      filiacao: registro.filiacao,
      rua: registro.rua,
      quadra: registro.quadra ?? undefined,
      lote: registro.lote ?? undefined,
      cidade: registro.cidade,
      estado: undefined,
      cep: registro.cep,
    };

    const buffer = gerarDocumento(dados);
    const nomeArquivo = registro.nome
      .split(" ")
      .slice(0, 2)
      .join("_")
      .replace(/[^a-zA-ZÀ-ÿ0-9_]/g, "")
      .toUpperCase();

    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="Procuracao_${nomeArquivo}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Erro desconhecido";
    console.error("[Procuração] Erro no download:", msg);
    res.status(500).json({ erro: msg });
  }
});

// ─── Rota GET /api/download/:token ───────────────────────────────────────────
// Pública: qualquer pessoa com o token pode baixar o .docx (link enviado por e-mail)
procuracaoRouter.get("/download/:token", async (req: Request, res: Response) => {
  const { token } = req.params;

  if (!token || token.length < 20) {
    res.status(400).json({ erro: "Token inválido" });
    return;
  }

  try {
    const registro = await buscarProcuracaoPorToken(token);
    if (!registro) {
      res.status(404).send(`
        <!DOCTYPE html>
        <html lang="pt-BR">
        <head><meta charset="UTF-8"><title>Link inválido</title></head>
        <body style="font-family:sans-serif;text-align:center;padding:60px;">
          <h2>Link inválido ou expirado</h2>
          <p>Este link de download não é válido. Verifique o e-mail de notificação.</p>
        </body>
        </html>
      `);
      return;
    }

    // naturalidade armazenada como 'cidade-UF' — separar para o gerador
    const partes2 = registro.naturalidade.split('-');
    const natCidade2 = partes2[0] ?? registro.naturalidade;
    const natUF2 = partes2[1] ?? '';

    const dados = {
      nome: registro.nome,
      genero: registro.genero,
      estadoCivil: registro.estadoCivil,
      profissao: registro.profissao,
      cpf: registro.cpf,
      naturalidadeCidade: natCidade2,
      naturalidadeUF: natUF2,
      filiacao: registro.filiacao,
      rua: registro.rua,
      quadra: registro.quadra ?? undefined,
      lote: registro.lote ?? undefined,
      cidade: registro.cidade,
      estado: undefined,
      cep: registro.cep,
    };

    const buffer = gerarDocumento(dados);
    const nomeArquivo = registro.nome
      .split(" ")
      .slice(0, 2)
      .join("_")
      .replace(/[^a-zA-ZÀ-ÿ0-9_]/g, "")
      .toUpperCase();

    // Marcar como gerada automaticamente ao baixar pelo link
    marcarProcuracaoGerada(registro.id).catch((err) =>
      console.warn("[Download Token] Falha ao marcar como gerada:", err)
    );

    res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
    res.setHeader("Content-Disposition", `attachment; filename="Procuracao_${nomeArquivo}.docx"`);
    res.setHeader("Content-Length", buffer.length);
    res.send(buffer);
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Erro desconhecido";
    console.error("[Download Token] Erro:", msg);
    res.status(500).json({ erro: msg });
  }
});
