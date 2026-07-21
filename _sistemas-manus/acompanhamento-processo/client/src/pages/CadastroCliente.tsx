import { useState } from "react";
import { trpc } from "@/lib/trpc";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { toast } from "sonner";
import { Scale, ShieldAlert, ArrowLeft, Loader2, CheckCircle2 } from "lucide-react";
import { formatarCpf, validarCpf } from "@/lib/cpf"; // We will make a helper for this or inline it

export default function CadastroCliente() {
  const [cpf, setCpf] = useState("");
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [step, setStep] = useState<"check" | "register" | "success">("check");
  const [checking, setChecking] = useState(false);
  const [role, setRole] = useState<"cliente" | "admin">("cliente");

  const utils = trpc.useUtils();

  function handleCpfChange(e: React.ChangeEvent<HTMLInputElement>) {
    // Format CPF: 000.000.000-00
    const raw = e.target.value.replace(/\D/g, "");
    let formatted = raw;
    if (raw.length > 3) formatted = raw.substring(0, 3) + "." + raw.substring(3);
    if (raw.length > 6) formatted = formatted.substring(0, 7) + "." + raw.substring(6);
    if (raw.length > 9) formatted = formatted.substring(0, 11) + "-" + raw.substring(9);
    setCpf(formatted.substring(0, 14));
  }

  // trpc mutations/queries
  const checkCpfQuery = trpc.auth.checkCpfRegistration.useQuery(
    { cpf },
    { enabled: false, retry: false }
  );

  const registerMutation = trpc.auth.registerClient.useMutation({
    onSuccess: () => {
      setStep("success");
      toast.success("Senha cadastrada com sucesso!");
    },
    onError: (err) => {
      toast.error("Erro ao cadastrar: " + err.message);
    }
  });

  async function handleVerifyCpf(e: React.FormEvent) {
    e.preventDefault();
    const cleanCpf = cpf.replace(/\D/g, "");
    if (cleanCpf.length !== 11) {
      toast.error("CPF deve conter 11 dígitos.");
      return;
    }

    setChecking(true);
    try {
      const res = await checkCpfQuery.refetch();
      if (res.data?.allowed) {
        setStep("register");
      } else {
        toast.error("CPF não autorizado para cadastro (sem processos ativos vinculados).");
      }
    } catch (err) {
      toast.error("Erro ao verificar CPF.");
    } finally {
      setChecking(false);
    }
  }

  function handleRegister(e: React.FormEvent) {
    e.preventDefault();
    if (name.trim().length < 2) {
      toast.error("Preencha seu nome completo.");
      return;
    }
    if (password.length < 6) {
      toast.error("A senha deve ter pelo menos 6 caracteres.");
      return;
    }
    if (password !== confirmPassword) {
      toast.error("As senhas não coincidem.");
      return;
    }

    registerMutation.mutate({
      name,
      cpf,
      password,
      role
    });
  }

  return (
    <div className="flex items-center justify-center min-h-screen bg-[#0f1a2e] px-4">
      <div className="max-w-md w-full p-8 bg-white/5 border border-white/10 rounded-2xl backdrop-blur-md relative overflow-hidden">
        {/* Decorative Golden Line */}
        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-amber-600 via-yellow-500 to-amber-600" />

        <div className="flex flex-col items-center gap-6 text-center">
          <div className="w-12 h-12 rounded-xl bg-amber-500/10 border border-amber-500/20 flex items-center justify-center">
            <Scale className="w-6 h-6 text-amber-400" />
          </div>

          {step === "check" && (
            <>
              <div className="flex flex-col gap-2">
                <h1 className="text-xl font-bold text-white">Primeiro Acesso do Cliente</h1>
                <p className="text-xs text-white/60">
                  Insira seu CPF para verificar se você já tem processos cadastrados no escritório.
                </p>
              </div>

              <form onSubmit={handleVerifyCpf} className="w-full space-y-4 text-left">
                <div className="space-y-1.5">
                  <label className="text-xs font-semibold text-white/80">Número do CPF</label>
                  <Input
                    className="bg-white/5 border-white/10 text-white placeholder-white/30 h-10 text-sm focus-visible:ring-amber-500"
                    placeholder="000.000.000-00"
                    value={cpf}
                    onChange={handleCpfChange}
                    maxLength={14}
                    required
                  />
                </div>

                <Button
                  type="submit"
                  className="w-full bg-amber-500 hover:bg-amber-400 text-[#0f1a2e] font-semibold h-10 transition-colors"
                  disabled={checking}
                >
                  {checking ? <><Loader2 className="w-4 h-4 animate-spin mr-2" />Verificando...</> : "Verificar CPF"}
                </Button>

                <button
                  type="button"
                  onClick={() => { window.location.href = "/"; }}
                  className="w-full flex items-center justify-center gap-2 text-xs text-white/50 hover:text-white transition-colors pt-2"
                >
                  <ArrowLeft className="w-3.5 h-3.5" />
                  Voltar para o Login
                </button>
              </form>
            </>
          )}

          {step === "register" && (
            <>
              <div className="flex flex-col gap-2">
                <h1 className="text-xl font-bold text-white">Criar Senha de Acesso</h1>
                <p className="text-xs text-white/60">
                  CPF verificado com sucesso! Preencha seu nome e defina sua senha de acesso.
                </p>
              </div>

              <form onSubmit={handleRegister} className="w-full space-y-4 text-left">
                <div className="space-y-1.5">
                  <label className="text-xs font-semibold text-white/80">Nome Completo</label>
                  <Input
                    className="bg-white/5 border-white/10 text-white placeholder-white/30 h-10 text-sm focus-visible:ring-amber-500"
                    placeholder="Seu nome"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    required
                  />
                </div>

                <div className="space-y-1.5">
                  <label className="text-xs font-semibold text-white/80">Tipo de Acesso</label>
                  <select
                    className="flex w-full rounded-md border border-white/10 bg-white/10 h-10 px-3 py-2 text-sm text-white placeholder-white/30 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-amber-500 focus-visible:ring-offset-2"
                    value={role}
                    onChange={(e) => setRole(e.target.value as "cliente" | "admin")}
                  >
                    <option className="bg-[#0f1a2e]" value="cliente">Cliente (Apenas Acompanhamento de Processos)</option>
                    <option className="bg-[#0f1a2e]" value="admin">Administrador (Acesso a todos os 3 sistemas)</option>
                  </select>
                </div>

                <div className="space-y-1.5">
                  <label className="text-xs font-semibold text-white/80">Nova Senha</label>
                  <Input
                    type="password"
                    className="bg-white/5 border-white/10 text-white placeholder-white/30 h-10 text-sm focus-visible:ring-amber-500"
                    placeholder="Mínimo 6 caracteres"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                  />
                </div>

                <div className="space-y-1.5">
                  <label className="text-xs font-semibold text-white/80">Confirmar Senha</label>
                  <Input
                    type="password"
                    className="bg-white/5 border-white/10 text-white placeholder-white/30 h-10 text-sm focus-visible:ring-amber-500"
                    placeholder="Confirme sua senha"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    required
                  />
                </div>

                <Button
                  type="submit"
                  className="w-full bg-amber-500 hover:bg-amber-400 text-[#0f1a2e] font-semibold h-10 transition-colors"
                  disabled={registerMutation.isPending}
                >
                  {registerMutation.isPending ? <><Loader2 className="w-4 h-4 animate-spin mr-2" />Cadastrando...</> : "Cadastrar Senha"}
                </Button>

                <button
                  type="button"
                  onClick={() => setStep("check")}
                  className="w-full flex items-center justify-center gap-2 text-xs text-white/50 hover:text-white transition-colors pt-2"
                >
                  <ArrowLeft className="w-3.5 h-3.5" />
                  Voltar
                </button>
              </form>
            </>
          )}

          {step === "success" && (
            <div className="w-full py-4 space-y-6">
              <div className="flex justify-center">
                <CheckCircle2 className="w-16 h-16 text-emerald-400" />
              </div>
              <div className="flex flex-col gap-2">
                <h1 className="text-xl font-bold text-white">Tudo Pronto!</h1>
                <p className="text-xs text-white/60">
                  Sua senha foi cadastrada com sucesso. Agora você já pode acessar o Portal do Cliente.
                </p>
              </div>

              <Button
                onClick={() => { window.location.href = "/"; }}
                className="w-full bg-amber-500 hover:bg-amber-400 text-[#0f1a2e] font-semibold h-10 transition-colors"
              >
                Ir para o Login
              </Button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
