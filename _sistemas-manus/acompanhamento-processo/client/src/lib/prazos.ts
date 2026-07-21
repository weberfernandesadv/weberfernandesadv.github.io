/**
 * Utilitário de cálculo de prazos processuais em dias úteis
 * Calendários oficiais: TJGO e TRT18 (2025 e 2026)
 * CPC: arts. 219-220 | CLT: art. 775
 */

// ─── Feriados TJGO 2025 ──────────────────────────────────────────────────────
const FERIADOS_TJGO_2025: string[] = [
  "2025-01-01", // Ano Novo
  "2025-03-03", // Carnaval
  "2025-03-04", // Carnaval
  "2025-03-05", // Carnaval (até 12h — conta como feriado para prazos)
  "2025-04-16", // Semana Santa
  "2025-04-17", // Semana Santa
  "2025-04-18", // Semana Santa
  "2025-04-21", // Tiradentes
  "2025-05-01", // Dia do Trabalho
  "2025-05-02", // Ponto Facultativo TJGO
  "2025-06-19", // Corpus Christi
  "2025-06-20", // Ponto Facultativo TJGO
  "2025-09-07", // Independência
  "2025-10-12", // N. Sra. Aparecida
  "2025-10-24", // Aniversário de Goiânia
  "2025-10-27", // Ponto Facultativo TJGO
  "2025-10-28", // Dia do Servidor Público
  "2025-11-02", // Finados
  "2025-11-15", // Proclamação da República
  "2025-11-20", // Consciência Negra
  "2025-11-21", // Ponto Facultativo TJGO
  "2025-12-08", // Dia da Justiça
  "2025-12-20", // Recesso Forense início
  "2025-12-21",
  "2025-12-22",
  "2025-12-23",
  "2025-12-24",
  "2025-12-25", // Natal
  "2025-12-26",
  "2025-12-27",
  "2025-12-28",
  "2025-12-29",
  "2025-12-30",
  "2025-12-31",
];

// ─── Feriados TJGO 2026 ──────────────────────────────────────────────────────
const FERIADOS_TJGO_2026: string[] = [
  "2026-01-01", // Ano Novo
  "2026-01-02", // Recesso Forense (continua de 2025)
  "2026-01-03",
  "2026-01-04",
  "2026-01-05",
  "2026-01-06", // Fim do Recesso Forense
  "2026-02-16", // Carnaval
  "2026-02-17", // Carnaval
  "2026-02-18", // Carnaval (até 12h)
  "2026-04-01", // Semana Santa
  "2026-04-02", // Semana Santa
  "2026-04-03", // Semana Santa
  "2026-04-20", // Ponto Facultativo TJGO
  "2026-04-21", // Tiradentes
  "2026-05-01", // Dia do Trabalho
  "2026-06-04", // Corpus Christi
  "2026-06-05", // Ponto Facultativo TJGO
  "2026-09-07", // Independência
  "2026-10-12", // N. Sra. Aparecida
  "2026-10-28", // Dia do Servidor Público
  "2026-11-02", // Finados
  "2026-11-15", // Proclamação da República
  "2026-11-20", // Consciência Negra
  "2026-12-08", // Dia da Justiça
  "2026-12-20", // Recesso Forense início
  "2026-12-21",
  "2026-12-22",
  "2026-12-23",
  "2026-12-24",
  "2026-12-25", // Natal
  "2026-12-26",
  "2026-12-27",
  "2026-12-28",
  "2026-12-29",
  "2026-12-30",
  "2026-12-31",
];

// ─── Feriados TRT18 2025 ─────────────────────────────────────────────────────
// TRT18 segue feriados nacionais + suspensões específicas da portaria
const FERIADOS_TRT18_2025: string[] = [
  "2025-01-01", // Ano Novo
  "2025-03-03", // Carnaval
  "2025-03-04", // Carnaval
  "2025-03-05", // Quarta de Cinzas (funcionamento parcial — conta como feriado)
  "2025-04-18", // Sexta-feira Santa
  "2025-04-21", // Tiradentes
  "2025-05-01", // Dia do Trabalho
  "2025-05-02", // Suspensão TRT18
  "2025-06-19", // Corpus Christi
  "2025-06-20", // Suspensão TRT18
  "2025-09-07", // Independência
  "2025-10-12", // N. Sra. Aparecida
  "2025-10-27", // Suspensão TRT18
  "2025-10-28", // Dia do Servidor Público
  "2025-11-02", // Finados
  "2025-11-15", // Proclamação da República
  "2025-11-20", // Consciência Negra
  "2025-11-21", // Suspensão TRT18
  "2025-12-25", // Natal
  // Recesso TRT18 (normalmente 20/12 a 06/01)
  "2025-12-20",
  "2025-12-21",
  "2025-12-22",
  "2025-12-23",
  "2025-12-24",
  "2025-12-26",
  "2025-12-27",
  "2025-12-28",
  "2025-12-29",
  "2025-12-30",
  "2025-12-31",
];

// ─── Feriados TRT18 2026 ─────────────────────────────────────────────────────
const FERIADOS_TRT18_2026: string[] = [
  "2026-01-01", // Ano Novo
  "2026-01-02", // Recesso
  "2026-01-03",
  "2026-01-04",
  "2026-01-05",
  "2026-01-06",
  "2026-02-16", // Carnaval
  "2026-02-17", // Carnaval
  "2026-02-18", // Quarta de Cinzas
  "2026-04-03", // Sexta-feira Santa
  "2026-04-20", // Suspensão TRT18
  "2026-04-21", // Tiradentes
  "2026-05-01", // Dia do Trabalho
  "2026-06-04", // Corpus Christi
  "2026-06-05", // Suspensão TRT18
  "2026-08-10", // Suspensão TRT18 (véspera do Dia do Magistrado/Advogado - 11/08)
  "2026-09-07", // Independência
  "2026-10-12", // N. Sra. Aparecida
  "2026-10-28", // Dia do Servidor Público
  "2026-11-02", // Finados
  "2026-11-15", // Proclamação da República
  "2026-11-20", // Consciência Negra
  "2026-12-07", // Suspensão TRT18 (véspera do Dia da Justiça)
  "2026-12-08", // Dia da Justiça
  "2026-12-25", // Natal
  "2026-12-20", // Recesso
  "2026-12-21",
  "2026-12-22",
  "2026-12-23",
  "2026-12-24",
  "2026-12-26",
  "2026-12-27",
  "2026-12-28",
  "2026-12-29",
  "2026-12-30",
  "2026-12-31",
];

// ─── Prazos por tipo de manifestação ─────────────────────────────────────────
export type TipoManifestacao =
  | "Recurso"
  | "Resposta"
  | "Apelação"
  | "Embargos de declaração"
  | "Contestação"
  | "Impugnação"
  | "Autos conclusos"
  | "Conciliação"
  | "Audiência"
  | "Outro";

export type TipoTribunal = "TJGO" | "TRT18" | "outro";

/** Retorna o número de dias úteis do prazo para cada tipo de manifestação */
export function getPrazoDias(
  tipo: TipoManifestacao,
  tribunalSigla: string
): number | null {
  const isTRT = tribunalSigla.toUpperCase().includes("TRT");

  if (isTRT) {
    // Prazos CLT
    switch (tipo) {
      case "Contestação": return 5;
      case "Resposta": return 5;
      case "Recurso": return 8;
      case "Apelação": return 8; // Recurso Ordinário na CLT
      case "Embargos de declaração": return 5;
      case "Impugnação": return 5;
      default: return null; // Audiência, Conciliação, Autos conclusos, Outro
    }
  } else {
    // Prazos CPC (TJGO e demais)
    switch (tipo) {
      case "Contestação": return 15;
      case "Resposta": return 15;
      case "Recurso": return 15;
      case "Apelação": return 15;
      case "Embargos de declaração": return 5;
      case "Impugnação": return 15;
      default: return null;
    }
  }
}

/**
 * Gera feriados nacionais fixos para qualquer ano (fallback para anos sem calendário específico)
 * Inclui os feriados nacionais estáticos do Brasil
 */
function getFeriadosNacionaisFixos(ano: number): string[] {
  return [
    `${ano}-01-01`, // Ano Novo
    `${ano}-04-21`, // Tiradentes
    `${ano}-05-01`, // Dia do Trabalho
    `${ano}-09-07`, // Independência
    `${ano}-10-12`, // N. Sra. Aparecida
    `${ano}-11-02`, // Finados
    `${ano}-11-15`, // Proclamação da República
    `${ano}-11-20`, // Consciência Negra
    `${ano}-12-25`, // Natal
    // Recesso forense padrão (20/12 a 06/01 do ano seguinte)
    `${ano}-12-20`, `${ano}-12-21`, `${ano}-12-22`, `${ano}-12-23`,
    `${ano}-12-24`, `${ano}-12-26`, `${ano}-12-27`, `${ano}-12-28`,
    `${ano}-12-29`, `${ano}-12-30`, `${ano}-12-31`,
    `${ano}-01-02`, `${ano}-01-03`, `${ano}-01-04`, `${ano}-01-05`, `${ano}-01-06`,
  ];
}

/** Retorna o conjunto de feriados para o tribunal e ano informados */
function getFeriados(tribunalSigla: string, ano: number): Set<string> {
  const isTRT = tribunalSigla.toUpperCase().includes("TRT");
  let lista: string[] = [];

  if (isTRT) {
    if (ano === 2025) lista = FERIADOS_TRT18_2025;
    else if (ano === 2026) lista = FERIADOS_TRT18_2026;
    else lista = getFeriadosNacionaisFixos(ano); // fallback para outros anos
  } else {
    if (ano === 2025) lista = FERIADOS_TJGO_2025;
    else if (ano === 2026) lista = FERIADOS_TJGO_2026;
    else lista = getFeriadosNacionaisFixos(ano); // fallback para outros anos
  }

  return new Set(lista);
}

/** Verifica se uma data é dia útil (não é sábado, domingo ou feriado) */
function isDiaUtil(data: Date, feriados: Set<string>): boolean {
  // Usar getUTCDay para evitar deslocamento de fuso ao verificar dia da semana
  const diaSemana = data.getUTCDay();
  if (diaSemana === 0 || diaSemana === 6) return false; // domingo ou sábado
  const iso = data.toISOString().split("T")[0];
  return !feriados.has(iso);
}

/**
 * Calcula a data limite adicionando `diasUteis` dias úteis a partir de `dataInicio`
 * Busca feriados para o tribunal informado (suporta 2025 e 2026)
 */
export function calcularDataLimite(
  dataInicio: Date,
  diasUteis: number,
  tribunalSigla: string
): Date {
  // Trabalhar sempre em UTC para evitar deslocamento de fuso (UTC-3 no Brasil)
  // dataInicio deve ser criado como new Date("YYYY-MM-DDT12:00:00Z") pelo chamador
  const dataEstimada = new Date(dataInicio);
  dataEstimada.setUTCDate(dataEstimada.getUTCDate() + diasUteis * 2); // estimativa
  const anos = [dataInicio.getUTCFullYear(), dataEstimada.getUTCFullYear()].filter(
    (v, i, a) => a.indexOf(v) === i
  );

  const feriados = new Set<string>();
  anos.forEach((ano) => {
    const f = getFeriados(tribunalSigla, ano);
    f.forEach((d) => feriados.add(d));
  });

  // Avança dia a dia contando apenas dias úteis
  let diasContados = 0;
  let dataAtual = new Date(dataInicio);

  // O prazo começa a contar no dia SEGUINTE à intimação (CPC art. 224 / CLT art. 775)
  dataAtual.setUTCDate(dataAtual.getUTCDate() + 1);

  while (diasContados < diasUteis) {
    if (isDiaUtil(dataAtual, feriados)) {
      diasContados++;
    }
    if (diasContados < diasUteis) {
      dataAtual.setUTCDate(dataAtual.getUTCDate() + 1);
    }
  }

  // Se o último dia cair em não-útil, prorroga para o próximo dia útil
  while (!isDiaUtil(dataAtual, feriados)) {
    dataAtual.setUTCDate(dataAtual.getUTCDate() + 1);
  }

  return dataAtual;
}

/**
 * Dado um tipo de manifestação, tribunal e data de intimação,
 * retorna a data limite calculada (ou null se não aplicável)
 */
export function calcularPrazo(
  tipo: TipoManifestacao,
  tribunalSigla: string,
  dataIntimacao: Date
): Date | null {
  const dias = getPrazoDias(tipo, tribunalSigla);
  if (dias === null) return null;
  return calcularDataLimite(dataIntimacao, dias, tribunalSigla);
}

/**
 * Retorna a data atual no fuso horário de Brasília (UTC-3) como string YYYY-MM-DD.
 * Evita o problema de `new Date().toISOString()` que usa UTC e pode retornar o dia anterior.
 */
export function hojeBrasilia(): string {
  const agora = new Date();
  // UTC-3: subtrair 3 horas em milissegundos
  const brasilia = new Date(agora.getTime() - 3 * 60 * 60 * 1000);
  return brasilia.toISOString().split("T")[0];
}

/** Formata uma Date para string YYYY-MM-DD no fuso UTC-3 (Brasília) */
export function dateToInputValue(date: Date): string {
  // Ajusta para UTC-3 antes de extrair a data
  const brasilia = new Date(date.getTime() - 3 * 60 * 60 * 1000);
  return brasilia.toISOString().split("T")[0];
}

/**
 * Verifica se uma data limite está dentro dos próximos `diasUteis` dias úteis a partir de hoje.
 * Usa o calendário do tribunal informado para descontar feriados.
 * Retorna false se a data já estiver vencida.
 */
export function isProximosDiasUteis(
  dataLimite: Date | string | null | undefined,
  tribunalSigla: string,
  diasUteis: number = 3
): boolean {
  if (!dataLimite) return false;

  const hojeStr = hojeBrasilia();
  const dataStr = typeof dataLimite === "string" ? dataLimite.substring(0, 10) : dateToInputValue(dataLimite);

  // Se já venceu, não é "próximo"
  if (dataStr < hojeStr) return false;

  // Calcula a data que representa hoje + diasUteis dias úteis
  const [anoAtual] = hojeStr.split("-").map(Number);
  const anos = [anoAtual, anoAtual + 1];
  const feriados = new Set<string>();
  anos.forEach((ano) => {
    const f = getFeriados(tribunalSigla, ano);
    f.forEach((d) => feriados.add(d));
  });

  let contagem = 0;
  // Cria cursor a partir da string de hoje em UTC para evitar deslocamento
  let cursor = new Date(hojeStr + "T12:00:00Z");
  cursor.setUTCDate(cursor.getUTCDate() + 1); // começa no dia seguinte

  while (contagem < diasUteis) {
    if (isDiaUtil(cursor, feriados)) contagem++;
    if (contagem < diasUteis) cursor.setUTCDate(cursor.getUTCDate() + 1);
  }

  // Avança até o próximo dia útil se necessário
  while (!isDiaUtil(cursor, feriados)) {
    cursor.setUTCDate(cursor.getUTCDate() + 1);
  }

  const limiteStr = cursor.toISOString().split("T")[0];
  return dataStr <= limiteStr;
}
