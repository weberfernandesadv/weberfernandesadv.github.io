/**
 * Utilitário para trabalhar com números CNJ de processos judiciais.
 * Formato CNJ: NNNNNNN-DD.AAAA.J.TT.OOOO
 * Posição J = Justiça (1=STF, 2=CNJ, 3=STJ, 4=JF, 5=TRT, 6=TRE, 7=TRM, 8=TJDFT, 9=TJ)
 * Posição TT = Tribunal (código do tribunal)
 */

export interface TribunalInfo {
  sigla: string;
  nome: string;
}

// Mapa de J.TT → sigla do tribunal
const TRIBUNAL_MAP: Record<string, TribunalInfo> = {
  // Supremo Tribunal Federal
  "1.00": { sigla: "STF", nome: "Supremo Tribunal Federal" },
  // Conselho Nacional de Justiça
  "2.00": { sigla: "CNJ", nome: "Conselho Nacional de Justiça" },
  // Superior Tribunal de Justiça
  "3.00": { sigla: "STJ", nome: "Superior Tribunal de Justiça" },
  // Justiça Federal - TRFs
  "4.01": { sigla: "TRF1", nome: "Tribunal Regional Federal da 1ª Região" },
  "4.02": { sigla: "TRF2", nome: "Tribunal Regional Federal da 2ª Região" },
  "4.03": { sigla: "TRF3", nome: "Tribunal Regional Federal da 3ª Região" },
  "4.04": { sigla: "TRF4", nome: "Tribunal Regional Federal da 4ª Região" },
  "4.05": { sigla: "TRF5", nome: "Tribunal Regional Federal da 5ª Região" },
  "4.06": { sigla: "TRF6", nome: "Tribunal Regional Federal da 6ª Região" },
  // Justiça do Trabalho - TRTs
  "5.01": { sigla: "TRT1", nome: "Tribunal Regional do Trabalho da 1ª Região" },
  "5.02": { sigla: "TRT2", nome: "Tribunal Regional do Trabalho da 2ª Região" },
  "5.03": { sigla: "TRT3", nome: "Tribunal Regional do Trabalho da 3ª Região" },
  "5.04": { sigla: "TRT4", nome: "Tribunal Regional do Trabalho da 4ª Região" },
  "5.05": { sigla: "TRT5", nome: "Tribunal Regional do Trabalho da 5ª Região" },
  "5.06": { sigla: "TRT6", nome: "Tribunal Regional do Trabalho da 6ª Região" },
  "5.07": { sigla: "TRT7", nome: "Tribunal Regional do Trabalho da 7ª Região" },
  "5.08": { sigla: "TRT8", nome: "Tribunal Regional do Trabalho da 8ª Região" },
  "5.09": { sigla: "TRT9", nome: "Tribunal Regional do Trabalho da 9ª Região" },
  "5.10": { sigla: "TRT10", nome: "Tribunal Regional do Trabalho da 10ª Região" },
  "5.11": { sigla: "TRT11", nome: "Tribunal Regional do Trabalho da 11ª Região" },
  "5.12": { sigla: "TRT12", nome: "Tribunal Regional do Trabalho da 12ª Região" },
  "5.13": { sigla: "TRT13", nome: "Tribunal Regional do Trabalho da 13ª Região" },
  "5.14": { sigla: "TRT14", nome: "Tribunal Regional do Trabalho da 14ª Região" },
  "5.15": { sigla: "TRT15", nome: "Tribunal Regional do Trabalho da 15ª Região" },
  "5.16": { sigla: "TRT16", nome: "Tribunal Regional do Trabalho da 16ª Região" },
  "5.17": { sigla: "TRT17", nome: "Tribunal Regional do Trabalho da 17ª Região" },
  "5.18": { sigla: "TRT18", nome: "Tribunal Regional do Trabalho da 18ª Região" },
  "5.19": { sigla: "TRT19", nome: "Tribunal Regional do Trabalho da 19ª Região" },
  "5.20": { sigla: "TRT20", nome: "Tribunal Regional do Trabalho da 20ª Região" },
  "5.21": { sigla: "TRT21", nome: "Tribunal Regional do Trabalho da 21ª Região" },
  "5.22": { sigla: "TRT22", nome: "Tribunal Regional do Trabalho da 22ª Região" },
  "5.23": { sigla: "TRT23", nome: "Tribunal Regional do Trabalho da 23ª Região" },
  "5.24": { sigla: "TRT24", nome: "Tribunal Regional do Trabalho da 24ª Região" },
  // Justiça Eleitoral - TREs
  "6.01": { sigla: "TRE-AC", nome: "Tribunal Regional Eleitoral do Acre" },
  "6.02": { sigla: "TRE-AL", nome: "Tribunal Regional Eleitoral de Alagoas" },
  "6.03": { sigla: "TRE-AP", nome: "Tribunal Regional Eleitoral do Amapá" },
  "6.04": { sigla: "TRE-AM", nome: "Tribunal Regional Eleitoral do Amazonas" },
  "6.05": { sigla: "TRE-BA", nome: "Tribunal Regional Eleitoral da Bahia" },
  "6.06": { sigla: "TRE-CE", nome: "Tribunal Regional Eleitoral do Ceará" },
  "6.07": { sigla: "TRE-DF", nome: "Tribunal Regional Eleitoral do Distrito Federal" },
  "6.08": { sigla: "TRE-ES", nome: "Tribunal Regional Eleitoral do Espírito Santo" },
  "6.09": { sigla: "TRE-GO", nome: "Tribunal Regional Eleitoral de Goiás" },
  "6.10": { sigla: "TRE-MA", nome: "Tribunal Regional Eleitoral do Maranhão" },
  "6.11": { sigla: "TRE-MT", nome: "Tribunal Regional Eleitoral do Mato Grosso" },
  "6.12": { sigla: "TRE-MS", nome: "Tribunal Regional Eleitoral do Mato Grosso do Sul" },
  "6.13": { sigla: "TRE-MG", nome: "Tribunal Regional Eleitoral de Minas Gerais" },
  "6.14": { sigla: "TRE-PA", nome: "Tribunal Regional Eleitoral do Pará" },
  "6.15": { sigla: "TRE-PB", nome: "Tribunal Regional Eleitoral da Paraíba" },
  "6.16": { sigla: "TRE-PR", nome: "Tribunal Regional Eleitoral do Paraná" },
  "6.17": { sigla: "TRE-PE", nome: "Tribunal Regional Eleitoral de Pernambuco" },
  "6.18": { sigla: "TRE-PI", nome: "Tribunal Regional Eleitoral do Piauí" },
  "6.19": { sigla: "TRE-RJ", nome: "Tribunal Regional Eleitoral do Rio de Janeiro" },
  "6.20": { sigla: "TRE-RN", nome: "Tribunal Regional Eleitoral do Rio Grande do Norte" },
  "6.21": { sigla: "TRE-RS", nome: "Tribunal Regional Eleitoral do Rio Grande do Sul" },
  "6.22": { sigla: "TRE-RO", nome: "Tribunal Regional Eleitoral de Rondônia" },
  "6.23": { sigla: "TRE-RR", nome: "Tribunal Regional Eleitoral de Roraima" },
  "6.24": { sigla: "TRE-SC", nome: "Tribunal Regional Eleitoral de Santa Catarina" },
  "6.25": { sigla: "TRE-SP", nome: "Tribunal Regional Eleitoral de São Paulo" },
  "6.26": { sigla: "TRE-SE", nome: "Tribunal Regional Eleitoral de Sergipe" },
  "6.27": { sigla: "TRE-TO", nome: "Tribunal Regional Eleitoral do Tocantins" },
  // Tribunal Superior Eleitoral
  "6.00": { sigla: "TSE", nome: "Tribunal Superior Eleitoral" },
  // Tribunal Superior do Trabalho
  "5.00": { sigla: "TST", nome: "Tribunal Superior do Trabalho" },
  // Justiça Estadual - TJs (J=9 padrão atual)
  "8.00": { sigla: "TJDFT", nome: "Tribunal de Justiça do Distrito Federal e Territórios" },
  // Justiça Estadual - TJs com J=8 (processos antigos pré-2010 e variações de autuação)
  "8.01": { sigla: "TJAC", nome: "Tribunal de Justiça do Acre" },
  "8.02": { sigla: "TJAL", nome: "Tribunal de Justiça de Alagoas" },
  "8.03": { sigla: "TJAP", nome: "Tribunal de Justiça do Amapá" },
  "8.04": { sigla: "TJAM", nome: "Tribunal de Justiça do Amazonas" },
  "8.05": { sigla: "TJBA", nome: "Tribunal de Justiça da Bahia" },
  "8.06": { sigla: "TJCE", nome: "Tribunal de Justiça do Ceará" },
  "8.07": { sigla: "TJDF", nome: "Tribunal de Justiça do Distrito Federal" },
  "8.08": { sigla: "TJES", nome: "Tribunal de Justiça do Espírito Santo" },
  "8.09": { sigla: "TJGO", nome: "Tribunal de Justiça de Goiás" },
  "8.10": { sigla: "TJMA", nome: "Tribunal de Justiça do Maranhão" },
  "8.11": { sigla: "TJMT", nome: "Tribunal de Justiça do Mato Grosso" },
  "8.12": { sigla: "TJMS", nome: "Tribunal de Justiça do Mato Grosso do Sul" },
  "8.13": { sigla: "TJMG", nome: "Tribunal de Justiça de Minas Gerais" },
  "8.14": { sigla: "TJPA", nome: "Tribunal de Justiça do Pará" },
  "8.15": { sigla: "TJPB", nome: "Tribunal de Justiça da Paraíba" },
  "8.16": { sigla: "TJPR", nome: "Tribunal de Justiça do Paraná" },
  "8.17": { sigla: "TJPE", nome: "Tribunal de Justiça de Pernambuco" },
  "8.18": { sigla: "TJPI", nome: "Tribunal de Justiça do Piauí" },
  "8.19": { sigla: "TJRJ", nome: "Tribunal de Justiça do Rio de Janeiro" },
  "8.20": { sigla: "TJRN", nome: "Tribunal de Justiça do Rio Grande do Norte" },
  "8.21": { sigla: "TJRS", nome: "Tribunal de Justiça do Rio Grande do Sul" },
  "8.22": { sigla: "TJRO", nome: "Tribunal de Justiça de Rondônia" },
  "8.23": { sigla: "TJRR", nome: "Tribunal de Justiça de Roraima" },
  "8.24": { sigla: "TJSC", nome: "Tribunal de Justiça de Santa Catarina" },
  "8.25": { sigla: "TJSP", nome: "Tribunal de Justiça de São Paulo" },
  "8.26": { sigla: "TJSE", nome: "Tribunal de Justiça de Sergipe" },
  "8.27": { sigla: "TJTO", nome: "Tribunal de Justiça do Tocantins" },
  "9.01": { sigla: "TJAC", nome: "Tribunal de Justiça do Acre" },
  "9.02": { sigla: "TJAL", nome: "Tribunal de Justiça de Alagoas" },
  "9.03": { sigla: "TJAP", nome: "Tribunal de Justiça do Amapá" },
  "9.04": { sigla: "TJAM", nome: "Tribunal de Justiça do Amazonas" },
  "9.05": { sigla: "TJBA", nome: "Tribunal de Justiça da Bahia" },
  "9.06": { sigla: "TJCE", nome: "Tribunal de Justiça do Ceará" },
  "9.07": { sigla: "TJDF", nome: "Tribunal de Justiça do Distrito Federal" },
  "9.08": { sigla: "TJES", nome: "Tribunal de Justiça do Espírito Santo" },
  "9.09": { sigla: "TJGO", nome: "Tribunal de Justiça de Goiás" },
  "9.10": { sigla: "TJMA", nome: "Tribunal de Justiça do Maranhão" },
  "9.11": { sigla: "TJMT", nome: "Tribunal de Justiça do Mato Grosso" },
  "9.12": { sigla: "TJMS", nome: "Tribunal de Justiça do Mato Grosso do Sul" },
  "9.13": { sigla: "TJMG", nome: "Tribunal de Justiça de Minas Gerais" },
  "9.14": { sigla: "TJPA", nome: "Tribunal de Justiça do Pará" },
  "9.15": { sigla: "TJPB", nome: "Tribunal de Justiça da Paraíba" },
  "9.16": { sigla: "TJPR", nome: "Tribunal de Justiça do Paraná" },
  "9.17": { sigla: "TJPE", nome: "Tribunal de Justiça de Pernambuco" },
  "9.18": { sigla: "TJPI", nome: "Tribunal de Justiça do Piauí" },
  "9.19": { sigla: "TJRJ", nome: "Tribunal de Justiça do Rio de Janeiro" },
  "9.20": { sigla: "TJRN", nome: "Tribunal de Justiça do Rio Grande do Norte" },
  "9.21": { sigla: "TJRS", nome: "Tribunal de Justiça do Rio Grande do Sul" },
  "9.22": { sigla: "TJRO", nome: "Tribunal de Justiça de Rondônia" },
  "9.23": { sigla: "TJRR", nome: "Tribunal de Justiça de Roraima" },
  "9.24": { sigla: "TJSC", nome: "Tribunal de Justiça de Santa Catarina" },
  "9.25": { sigla: "TJSP", nome: "Tribunal de Justiça de São Paulo" },
  "9.26": { sigla: "TJSE", nome: "Tribunal de Justiça de Sergipe" },
  "9.27": { sigla: "TJTO", nome: "Tribunal de Justiça do Tocantins" },
};

/**
 * Formata o número CNJ enquanto o usuário digita.
 * Formato: NNNNNNN-DD.AAAA.J.TT.OOOO
 */
export function formatarNumeroCnj(valor: string): string {
  // Remove tudo que não é dígito
  const digits = valor.replace(/\D/g, "");

  if (digits.length === 0) return "";
  if (digits.length <= 7) return digits;
  if (digits.length <= 9) return `${digits.slice(0, 7)}-${digits.slice(7)}`;
  if (digits.length <= 13) return `${digits.slice(0, 7)}-${digits.slice(7, 9)}.${digits.slice(9)}`;
  if (digits.length <= 14) return `${digits.slice(0, 7)}-${digits.slice(7, 9)}.${digits.slice(9, 13)}.${digits.slice(13)}`;
  if (digits.length <= 16) return `${digits.slice(0, 7)}-${digits.slice(7, 9)}.${digits.slice(9, 13)}.${digits.slice(13, 14)}.${digits.slice(14)}`;
  return `${digits.slice(0, 7)}-${digits.slice(7, 9)}.${digits.slice(9, 13)}.${digits.slice(13, 14)}.${digits.slice(14, 16)}.${digits.slice(16, 20)}`;
}

/**
 * Extrai o tribunal a partir do número CNJ.
 * Retorna a sigla do tribunal ou null se não reconhecido.
 */
export function extrairTribunalDoCnj(numeroCnj: string): TribunalInfo | null {
  // Remove formatação e extrai apenas dígitos
  const digits = numeroCnj.replace(/\D/g, "");

  // Precisa de pelo menos 16 dígitos para ter J e TT
  if (digits.length < 16) return null;

  // Formato: NNNNNNN DD AAAA J TT OOOO
  // Posições: 0-6    7-8 9-12 13 14-15 16-19
  const j = digits.slice(13, 14);   // Código da Justiça
  const tt = digits.slice(14, 16);  // Código do Tribunal

  // Formata a chave como "J.TT" (sem zero à esquerda no TT)
  const ttNum = parseInt(tt, 10);
  const chave = `${j}.${ttNum.toString().padStart(2, "0")}`;

  return TRIBUNAL_MAP[chave] ?? null;
}

/**
 * Valida se o número CNJ tem o formato correto (20 dígitos).
 */
export function validarNumeroCnj(numeroCnj: string): boolean {
  const digits = numeroCnj.replace(/\D/g, "");
  return digits.length === 20;
}
