import { describe, it, expect } from "vitest";
import { DadosSchema, gerarDocumento, DadosProcuracao } from "./procuracao";
import PizZip from "pizzip";

const dadosValidos: DadosProcuracao = {
  nome: "Maria da Silva Souza",
  genero: "brasileira",
  estadoCivil: "solteira",
  profissao: "Professora",
  cpf: "123.456.789-00",
  naturalidadeCidade: "Goiânia",
  naturalidadeUF: "GO",
  filiacao: "José da Silva e Ana Souza",
  rua: "Rua das Flores, nº 10",
  quadra: "5",
  lote: "2",
  cidade: "Goiânia",
  estado: "GO",
  cep: "74000-000",
};

// ─── Validação do schema ──────────────────────────────────────────────────
describe("DadosSchema — validação", () => {
  it("aceita dados válidos completos", () => {
    expect(DadosSchema.safeParse(dadosValidos).success).toBe(true);
  });

  it("aceita dados sem quadra e lote (campos opcionais)", () => {
    const { quadra, lote, ...semOpcional } = dadosValidos;
    expect(DadosSchema.safeParse(semOpcional).success).toBe(true);
  });

  it("rejeita nome com menos de 3 caracteres", () => {
    const r = DadosSchema.safeParse({ ...dadosValidos, nome: "AB" });
    expect(r.success).toBe(false);
    if (!r.success) {
      expect(r.error.issues.map((e) => e.path[0])).toContain("nome");
    }
  });

  it("rejeita CPF sem formatação correta (sem pontos e traço)", () => {
    const r = DadosSchema.safeParse({ ...dadosValidos, cpf: "12345678900" });
    expect(r.success).toBe(false);
  });

  it("aceita CPF no formato correto xxx.xxx.xxx-xx", () => {
    expect(DadosSchema.safeParse({ ...dadosValidos, cpf: "999.888.777-66" }).success).toBe(true);
  });

  it("rejeita CEP sem traço", () => {
    const r = DadosSchema.safeParse({ ...dadosValidos, cep: "74000000" });
    expect(r.success).toBe(false);
  });

  it("aceita CEP no formato xxxxx-xxx", () => {
    expect(DadosSchema.safeParse({ ...dadosValidos, cep: "74000-000" }).success).toBe(true);
  });

  it("rejeita dados com campos obrigatórios ausentes", () => {
    const r = DadosSchema.safeParse({ nome: "Maria Silva" });
    expect(r.success).toBe(false);
    if (!r.success) expect(r.error.issues.length).toBeGreaterThan(5);
  });
});

// ─── Geração do documento ─────────────────────────────────────────────────
describe("gerarDocumento — substituição de campos", () => {
  it("retorna um Buffer com conteúdo .docx válido", () => {
    const buf = gerarDocumento(dadosValidos);
    expect(Buffer.isBuffer(buf)).toBe(true);
    expect(buf.length).toBeGreaterThan(1000);
    // Verifica assinatura PK (ZIP/DOCX)
    expect(buf[0]).toBe(0x50); // 'P'
    expect(buf[1]).toBe(0x4b); // 'K'
  });

  it("substitui o nome em MAIÚSCULAS no documento", () => {
    const buf = gerarDocumento(dadosValidos);
    const zip = new PizZip(buf.toString("binary"));
    const xml = zip.file("word/document.xml")!.asText();
    expect(xml).toContain("MARIA DA SILVA SOUZA");
    expect(xml).not.toContain("(NOME)");
  });

  it("substitui o CPF no documento", () => {
    const buf = gerarDocumento(dadosValidos);
    const zip = new PizZip(buf.toString("binary"));
    const xml = zip.file("word/document.xml")!.asText();
    expect(xml).toContain("123.456.789-00");
    expect(xml).not.toContain("(xxx.xxx.xxx-xx)");
  });

  it("substitui a naturalidade no documento", () => {
    const buf = gerarDocumento(dadosValidos);
    const zip = new PizZip(buf.toString("binary"));
    const xml = zip.file("word/document.xml")!.asText();
    expect(xml).toContain("Goi");
    expect(xml).not.toContain("(naturalidade = cidade-UF)");
  });

  it("substitui o gênero no documento", () => {
    const buf = gerarDocumento(dadosValidos);
    const zip = new PizZip(buf.toString("binary"));
    const xml = zip.file("word/document.xml")!.asText();
    expect(xml).toContain("brasileira");
    expect(xml).not.toContain("brasileiro (a)");
  });

  it("monta endereço com quadra e lote", () => {
    const buf = gerarDocumento(dadosValidos);
    const zip = new PizZip(buf.toString("binary"));
    const xml = zip.file("word/document.xml")!.asText();
    expect(xml).toContain("Quadra 5");
    expect(xml).toContain("Lote 2");
  });

  it("monta endereço sem quadra e lote quando omitidos", () => {
    const { quadra, lote, ...semOpcional } = dadosValidos;
    const buf = gerarDocumento(semOpcional);
    const zip = new PizZip(buf.toString("binary"));
    const xml = zip.file("word/document.xml")!.asText();
    expect(xml).not.toContain("Quadra");
    expect(xml).not.toContain("Lote");
  });

  it("repete o nome na linha de assinatura", () => {
    const buf = gerarDocumento(dadosValidos);
    const zip = new PizZip(buf.toString("binary"));
    const xml = zip.file("word/document.xml")!.asText();
    // O nome deve aparecer pelo menos 2 vezes (qualificação + assinatura)
    const count = (xml.match(/MARIA DA SILVA SOUZA/g) || []).length;
    expect(count).toBeGreaterThanOrEqual(2);
  });
});
