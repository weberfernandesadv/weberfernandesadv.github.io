import { useState, useCallback } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { FileText, Scale, AlertCircle, CheckCircle2, Loader2, Send, Baby } from "lucide-react";
import { toast } from "sonner";

const schema = z.object({
  // Dados do menor
  nomeMenor: z.string().min(3, "Informe o nome completo do menor"),
  cpfMenor: z.string().regex(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/, "CPF do menor inválido — use xxx.xxx.xxx-xx"),
  dataNascimento: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/, "Data de nascimento inválida — use DD/MM/AAAA"),
  // Dados da genitora/representante
  nome: z.string().min(3, "Informe o nome completo da genitora/representante"),
  genero: z.string().min(1, "Selecione o gênero"),
  estadoCivil: z.string().min(1, "Selecione o estado civil"),
  profissao: z.string().min(2, "Informe a profissão"),
  cpf: z.string().regex(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/, "CPF inválido — use xxx.xxx.xxx-xx"),
  rg: z.string().min(3, "Informe o RG"),
  naturalidadeCidade: z.string().min(2, "Informe a cidade de naturalidade"),
  naturalidadeUF: z.string().min(2, "Informe a UF (ex.: GO)"),
  nomePai: z.string().min(2, "Informe o nome do pai"),
  nomeMae: z.string().min(2, "Informe o nome da mãe"),
  rua: z.string().min(3, "Informe a rua ou avenida"),
  quadra: z.string().optional(),
  lote: z.string().optional(),
  setor: z.string().optional(),
  cidade: z.string().min(2, "Informe a cidade"),
  estado: z.string().optional(),
  cep: z.string().regex(/^\d{5}-\d{3}$/, "CEP inválido — use xxxxx-xxx"),
});

type FormData = z.infer<typeof schema>;

function maskCPF(v: string) {
  return v.replace(/\D/g, "").slice(0, 11).replace(/(\d{3})(\d)/, "$1.$2").replace(/(\d{3})(\d)/, "$1.$2").replace(/(\d{3})(\d{1,2})$/, "$1-$2");
}
function maskCEP(v: string) {
  return v.replace(/\D/g, "").slice(0, 8).replace(/(\d{5})(\d)/, "$1-$2");
}
function maskDate(v: string) {
  return v.replace(/\D/g, "").slice(0, 8).replace(/(\d{2})(\d)/, "$1/$2").replace(/(\d{2})(\d)/, "$1/$2");
}

interface FieldProps { label: string; error?: string; required?: boolean; children: React.ReactNode; hint?: string; }
function Field({ label, error, required, children, hint }: FieldProps) {
  return (
    <div className="flex flex-col gap-1.5">
      <label className="text-sm font-semibold text-[#1a2744] tracking-wide uppercase" style={{ fontSize: "0.7rem", letterSpacing: "0.08em" }}>
        {label}{required && <span className="text-amber-600 ml-1">*</span>}
      </label>
      {children}
      {hint && !error && <p className="text-xs text-slate-400 italic">{hint}</p>}
      {error && <p className="flex items-center gap-1 text-xs text-red-600 font-medium"><AlertCircle size={12} />{error}</p>}
    </div>
  );
}
function SectionTitle({ children, icon }: { children: React.ReactNode; icon?: React.ReactNode }) {
  return (
    <div className="flex items-center gap-2 mb-5 mt-2">
      <div className="h-px flex-1 bg-slate-200" />
      <span className="flex items-center gap-1 text-xs font-semibold text-slate-400 uppercase tracking-widest px-2">
        {icon}{children}
      </span>
      <div className="h-px flex-1 bg-slate-200" />
    </div>
  );
}

const inputClass = "w-full px-3.5 py-2.5 rounded border border-slate-200 bg-white text-slate-800 text-sm focus:outline-none focus:ring-2 focus:ring-[#1a2744]/20 focus:border-[#1a2744] transition-all duration-150 placeholder:text-slate-300 hover:border-slate-300";
const inputErrorClass = "w-full px-3.5 py-2.5 rounded border border-red-300 bg-red-50/30 text-slate-800 text-sm focus:outline-none focus:ring-2 focus:ring-red-300/40 focus:border-red-400 transition-all duration-150 placeholder:text-slate-300";
const selectClass = "w-full px-3.5 py-2.5 rounded border border-slate-200 bg-white text-slate-800 text-sm focus:outline-none focus:ring-2 focus:ring-[#1a2744]/20 focus:border-[#1a2744] transition-all duration-150 appearance-none cursor-pointer hover:border-slate-300";

function TelaConfirmacao({ nome, onNovo }: { nome: string; onNovo: () => void }) {
  return (
    <div className="flex flex-col items-center justify-center py-16 px-6 text-center">
      <div className="w-20 h-20 rounded-full bg-emerald-100 flex items-center justify-center mb-6">
        <CheckCircle2 size={40} className="text-emerald-600" />
      </div>
      <h3 className="font-serif text-[#1a2744] text-2xl font-semibold mb-3">Dados enviados com sucesso!</h3>
      <p className="text-slate-600 text-sm leading-relaxed max-w-sm mb-2">Seus dados foram recebidos. O advogado preparará a procuração e entrará em contato.</p>
      <p className="text-slate-500 text-xs leading-relaxed max-w-sm mb-8">Nome registrado: <strong>{nome.toUpperCase()}</strong></p>
      <button onClick={onNovo} className="px-6 py-2.5 rounded-lg border border-[#1a2744]/30 text-[#1a2744] text-sm font-medium hover:bg-[#1a2744]/5 transition-all duration-150">
        Preencher novo formulário
      </button>
    </div>
  );
}

export default function ProcuracaoPa() {
  const [loading, setLoading] = useState(false);
  const [enviado, setEnviado] = useState(false);
  const [nomeEnviado, setNomeEnviado] = useState("");

  const { register, handleSubmit, setValue, watch, reset, formState: { errors } } = useForm<FormData>({
    resolver: zodResolver(schema), mode: "onBlur",
  });

  const cpfMenorValue = watch("cpfMenor") ?? "";
  const dataNascValue = watch("dataNascimento") ?? "";
  const cpfValue = watch("cpf") ?? "";
  const cepValue = watch("cep") ?? "";

  const handleCPFMenor = useCallback((e: React.ChangeEvent<HTMLInputElement>) => setValue("cpfMenor", maskCPF(e.target.value), { shouldValidate: true }), [setValue]);
  const handleDataNasc = useCallback((e: React.ChangeEvent<HTMLInputElement>) => setValue("dataNascimento", maskDate(e.target.value), { shouldValidate: true }), [setValue]);
  const handleCPF = useCallback((e: React.ChangeEvent<HTMLInputElement>) => setValue("cpf", maskCPF(e.target.value), { shouldValidate: true }), [setValue]);
  const handleCEP = useCallback((e: React.ChangeEvent<HTMLInputElement>) => setValue("cep", maskCEP(e.target.value), { shouldValidate: true }), [setValue]);

  const onSubmit = async (data: FormData) => {
    setLoading(true);
    try {
      const payload = {
        ...data,
        naturalidade: `${data.naturalidadeCidade.trim()}-${data.naturalidadeUF.trim().toUpperCase()}`,
      };
      const response = await fetch("/api/procuracao-pa", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      if (!response.ok) {
        const err = await response.json().catch(() => ({}));
        throw new Error(err?.erro || "Erro ao enviar os dados.");
      }
      setNomeEnviado(data.nomeMenor);
      setEnviado(true);
    } catch (err: unknown) {
      toast.error("Erro ao enviar os dados", { description: err instanceof Error ? err.message : "Erro desconhecido." });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen" style={{ background: "linear-gradient(160deg, #0f1e3d 0%, #1a2f5a 40%, #1e3a6e 100%)" }}>
      <header className="border-b border-white/10 backdrop-blur-sm bg-white/5">
        <div className="container py-4 flex items-center">
          <div className="flex items-center gap-3">
            <div className="flex items-center justify-center w-9 h-9 rounded-full bg-amber-500/20 border border-amber-400/30">
              <Scale size={18} className="text-amber-400" />
            </div>
            <div>
              <h1 className="font-serif text-white text-lg font-semibold leading-tight tracking-wide">Gerador de Documentos</h1>
              <p className="text-white/50 text-xs">Documento jurídico · Procuração PA (Menor)</p>
            </div>
          </div>
        </div>
      </header>

      <div className="container pt-10 pb-6">
        <div className="text-center max-w-xl mx-auto">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-amber-500/10 border border-amber-400/20 text-amber-300 text-xs font-medium mb-4 tracking-widest uppercase">
            <FileText size={12} />Procuração PA — Representação de Menor
          </div>
          <h2 className="font-serif text-white text-3xl md:text-4xl font-semibold leading-snug mb-3">
            Preencha os dados<br /><span className="text-amber-400">do menor e da genitora</span>
          </h2>
          <p className="text-white/60 text-sm leading-relaxed">
            Preencha o formulário abaixo. O advogado responsável preparará a procuração e entrará em contato.
          </p>
        </div>
      </div>

      <div className="container pb-16">
        <div className="max-w-3xl mx-auto rounded-2xl shadow-2xl overflow-hidden" style={{ background: "#f8f7f4", boxShadow: "0 32px 80px rgba(0,0,0,0.4)" }}>
          <div className="h-1.5 w-full" style={{ background: "linear-gradient(90deg, #b8860b, #d4a017, #b8860b)" }} />
          {enviado ? <TelaConfirmacao nome={nomeEnviado} onNovo={() => { reset(); setEnviado(false); setNomeEnviado(""); }} /> : (
            <div className="p-6 md:p-10">
              <div className="flex items-center gap-3 mb-8 pb-6 border-b border-slate-200">
                <div className="w-10 h-10 rounded-lg bg-[#1a2744] flex items-center justify-center flex-shrink-0">
                  <FileText size={18} className="text-amber-400" />
                </div>
                <div>
                  <h3 className="font-serif text-[#1a2744] text-xl font-semibold">Procuração PA — Representação de Menor</h3>
                  <p className="text-slate-400 text-xs mt-0.5">Todos os campos marcados com <span className="text-amber-600">*</span> são obrigatórios</p>
                </div>
              </div>

              <form onSubmit={handleSubmit(onSubmit)} noValidate autoComplete="off">
                {/* Seção: Dados do Menor */}
                <SectionTitle icon={<Baby size={12} />}>I — Dados do Menor</SectionTitle>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-5 mb-5">
                  <div className="md:col-span-2">
                    <Field label="Nome Completo do Menor" error={errors.nomeMenor?.message} required>
                      <input {...register("nomeMenor")} placeholder="Ex.: João da Silva Souza" className={errors.nomeMenor ? inputErrorClass : inputClass} />
                    </Field>
                  </div>
                  <Field label="CPF do Menor" error={errors.cpfMenor?.message} required hint="Formato: xxx.xxx.xxx-xx">
                    <input value={cpfMenorValue} onChange={handleCPFMenor} placeholder="000.000.000-00" className={errors.cpfMenor ? inputErrorClass : inputClass} inputMode="numeric" maxLength={14} />
                  </Field>
                  <Field label="Data de Nascimento do Menor" error={errors.dataNascimento?.message} required hint="Formato: DD/MM/AAAA">
                    <input value={dataNascValue} onChange={handleDataNasc} placeholder="Ex.: 15/03/2015" className={errors.dataNascimento ? inputErrorClass : inputClass} inputMode="numeric" maxLength={10} />
                  </Field>
                </div>

                {/* Seção: Dados da Genitora */}
                <SectionTitle>II — Dados da Genitora / Representante Legal</SectionTitle>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-5 mb-5">
                  <div className="md:col-span-2">
                    <Field label="Nome Completo da Genitora / Representante" error={errors.nome?.message} required>
                      <input {...register("nome")} placeholder="Ex.: Maria da Silva Souza" className={errors.nome ? inputErrorClass : inputClass} />
                    </Field>
                  </div>
                  <Field label="Gênero" error={errors.genero?.message} required>
                    <div className="relative">
                      <select {...register("genero")} className={errors.genero ? inputErrorClass + " pr-8" : selectClass + " pr-8"}>
                        <option value="">Selecione...</option>
                        <option value="brasileiro">Masculino — brasileiro</option>
                        <option value="brasileira">Feminino — brasileira</option>
                      </select>
                      <span className="pointer-events-none absolute right-3 top-1/2 -translate-y-1/2 text-slate-400">▾</span>
                    </div>
                  </Field>
                  <Field label="Estado Civil" error={errors.estadoCivil?.message} required>
                    <div className="relative">
                      <select {...register("estadoCivil")} className={errors.estadoCivil ? inputErrorClass + " pr-8" : selectClass + " pr-8"}>
                        <option value="">Selecione...</option>
                        <option value="solteiro(a)">Solteiro(a)</option>
                        <option value="casado(a)">Casado(a)</option>
                        <option value="divorciado(a)">Divorciado(a)</option>
                        <option value="viúvo(a)">Viúvo(a)</option>
                        <option value="separado(a) judicialmente">Separado(a) judicialmente</option>
                        <option value="união estável">União estável</option>
                      </select>
                      <span className="pointer-events-none absolute right-3 top-1/2 -translate-y-1/2 text-slate-400">▾</span>
                    </div>
                  </Field>
                  <Field label="Profissão" error={errors.profissao?.message} required>
                    <input {...register("profissao")} placeholder="Ex.: Comerciante" className={errors.profissao ? inputErrorClass : inputClass} />
                  </Field>
                  <Field label="CPF da Genitora" error={errors.cpf?.message} required hint="Formato: xxx.xxx.xxx-xx">
                    <input value={cpfValue} onChange={handleCPF} placeholder="000.000.000-00" className={errors.cpf ? inputErrorClass : inputClass} inputMode="numeric" maxLength={14} />
                  </Field>
                  <Field label="RG" error={errors.rg?.message} required>
                    <input {...register("rg")} placeholder="Ex.: 1234567" className={errors.rg ? inputErrorClass : inputClass} />
                  </Field>
                  <Field label="Naturalidade — Cidade" error={errors.naturalidadeCidade?.message} required hint="Cidade onde nasceu">
                    <input {...register("naturalidadeCidade")} placeholder="Ex.: Goiânia" className={errors.naturalidadeCidade ? inputErrorClass : inputClass} />
                  </Field>
                  <Field label="Naturalidade — UF" error={errors.naturalidadeUF?.message} required>
                    <div className="relative">
                      <select {...register("naturalidadeUF")} className={errors.naturalidadeUF ? inputErrorClass + " pr-8" : selectClass + " pr-8"}>
                        <option value="">Selecione...</option>
                        {["AC","AL","AP","AM","BA","CE","DF","ES","GO","MA","MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO"].map(uf => (
                          <option key={uf} value={uf}>{uf}</option>
                        ))}
                      </select>
                      <span className="pointer-events-none absolute right-3 top-1/2 -translate-y-1/2 text-slate-400">▾</span>
                    </div>
                  </Field>
                  <Field label="Nome do Pai" error={errors.nomePai?.message} required>
                    <input {...register("nomePai")} placeholder="Ex.: José da Silva" className={errors.nomePai ? inputErrorClass : inputClass} />
                  </Field>
                  <Field label="Nome da Mãe" error={errors.nomeMae?.message} required>
                    <input {...register("nomeMae")} placeholder="Ex.: Maria Souza" className={errors.nomeMae ? inputErrorClass : inputClass} />
                  </Field>
                </div>

                <SectionTitle>III — Endereço Residencial</SectionTitle>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-5 mb-8">
                  <div className="md:col-span-2">
                    <Field label="Rua / Avenida" error={errors.rua?.message} required>
                      <input {...register("rua")} placeholder="Ex.: Rua das Flores, nº 10" className={errors.rua ? inputErrorClass : inputClass} />
                    </Field>
                  </div>
                  <Field label="Quadra" hint="Opcional">
                    <input {...register("quadra")} placeholder="Ex.: 10" className={inputClass} />
                  </Field>
                  <Field label="Lote" hint="Opcional">
                    <input {...register("lote")} placeholder="Ex.: 5" className={inputClass} />
                  </Field>
                  <Field label="Setor / Bairro" hint="Opcional">
                    <input {...register("setor")} placeholder="Ex.: Setor Central" className={inputClass} />
                  </Field>
                  <Field label="Cidade" error={errors.cidade?.message} required>
                    <input {...register("cidade")} placeholder="Ex.: Goiânia" className={errors.cidade ? inputErrorClass : inputClass} />
                  </Field>
                  <Field label="Estado (UF)">
                    <div className="relative">
                      <select {...register("estado")} className={selectClass + " pr-8"}>
                        <option value="">Selecione...</option>
                        {["AC","AL","AP","AM","BA","CE","DF","ES","GO","MA","MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO"].map(uf => (
                          <option key={uf} value={uf}>{uf}</option>
                        ))}
                      </select>
                      <span className="pointer-events-none absolute right-3 top-1/2 -translate-y-1/2 text-slate-400">▾</span>
                    </div>
                  </Field>
                  <Field label="CEP" error={errors.cep?.message} required hint="Formato: xxxxx-xxx">
                    <input value={cepValue} onChange={handleCEP} placeholder="00000-000" className={errors.cep ? inputErrorClass : inputClass} inputMode="numeric" maxLength={9} />
                  </Field>
                </div>

                <div className="flex items-start gap-3 p-4 rounded-lg bg-blue-50 border border-blue-200 mb-8">
                  <AlertCircle size={16} className="text-blue-600 mt-0.5 flex-shrink-0" />
                  <p className="text-xs text-blue-800 leading-relaxed">Seus dados serão enviados com segurança ao advogado responsável.</p>
                </div>

                <button type="submit" disabled={loading} className={"w-full flex items-center justify-center gap-3 py-4 px-6 rounded-xl text-sm font-bold tracking-widest uppercase transition-all duration-200 " + (loading ? "bg-slate-300 text-slate-500 cursor-not-allowed" : "bg-[#1a2744] hover:bg-[#243660] text-white shadow-lg shadow-[#1a2744]/40 active:scale-[0.98]")}>
                  {loading ? <><Loader2 size={18} className="animate-spin" />Enviando dados...</> : <><Send size={18} />Enviar Dados</>}
                </button>
              </form>
            </div>
          )}
          {!enviado && (
            <div className="px-6 md:px-10 py-4 bg-slate-50 border-t border-slate-200 flex items-center justify-between flex-wrap gap-2">
              <p className="text-xs text-slate-400">Procuração PA · Representação de Menor</p>
              <p className="text-xs text-slate-400">Dados tratados com <strong>sigilo profissional</strong></p>
            </div>
          )}
        </div>
      </div>

      <footer className="border-t border-white/10 py-6">
        <div className="container text-center">
          <p className="text-white/30 text-xs">Procuração PA · Representação de Menor</p>
        </div>
      </footer>
    </div>
  );
}
