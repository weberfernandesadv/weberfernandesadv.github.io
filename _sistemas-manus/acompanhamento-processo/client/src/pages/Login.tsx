import { useState } from "react";
import { useLocation } from "wouter";
import { trpc } from "@/lib/trpc";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Scale, Lock, User, AlertCircle } from "lucide-react";
import { toast } from "sonner";

export default function Login() {
  const [, navigate] = useLocation();
  const [login, setLogin] = useState("");
  const [password, setPassword] = useState("");
  const [errorMsg, setErrorMsg] = useState("");

  const utils = trpc.useUtils();
  const loginMutation = trpc.auth.login.useMutation({
    onSuccess: (data) => {
      toast.success("Login realizado com sucesso!");
      utils.auth.me.setData(undefined, data.user as any);
      setTimeout(() => {
        const params = new URLSearchParams(window.location.search);
        const returnPath = params.get("returnPath") || "/dashboard";
        navigate(returnPath === "/login" ? "/dashboard" : returnPath);
      }, 500);
    },
    onError: (err) => {
      setErrorMsg(err.message || "Erro ao realizar login");
      toast.error(err.message || "Erro ao realizar login");
    },
  });

  const handleLoginChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = e.target.value;
    // If input starts with a number, apply CPF formatting mask
    if (/^\d/.test(value.trim())) {
      const raw = value.replace(/\D/g, "");
      let formatted = raw;
      if (raw.length > 3) formatted = raw.substring(0, 3) + "." + raw.substring(3);
      if (raw.length > 6) formatted = formatted.substring(0, 7) + "." + raw.substring(6);
      if (raw.length > 9) formatted = formatted.substring(0, 11) + "-" + raw.substring(9);
      setLogin(formatted.substring(0, 14));
    } else {
      setLogin(value);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg("");
    if (!login || !password) {
      setErrorMsg("Preencha todos os campos.");
      return;
    }
    loginMutation.mutate({ login, password });
  };

  return (
    <div className="min-h-screen bg-[#0f1a2e] flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-md text-center space-y-4">
        <div className="flex justify-center">
          <div className="w-16 h-16 rounded-xl bg-amber-500/10 border border-amber-500/20 flex items-center justify-center">
            <Scale size={32} className="text-amber-400" />
          </div>
        </div>
        <div>
          <h2 className="text-3xl font-extrabold text-white tracking-tight">
            Weber F. Pereira
          </h2>
          <p className="mt-2 text-sm text-white/50">
            Advogados Associados · Login do Sistema
          </p>
        </div>
      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <div className="bg-white/5 border border-white/10 py-8 px-4 shadow sm:rounded-lg sm:px-10 backdrop-blur-md relative overflow-hidden">
          {/* Decorative Golden Line */}
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-amber-600 via-yellow-500 to-amber-600" />

          <form className="space-y-6" onSubmit={handleSubmit}>
            {errorMsg && (
              <div className="rounded-md bg-destructive/10 p-3 flex items-start gap-2 border border-destructive/20 text-destructive text-sm">
                <AlertCircle className="w-4 h-4 mt-0.5 flex-shrink-0" />
                <span>{errorMsg}</span>
              </div>
            )}

            <div>
              <Label htmlFor="login" className="block text-sm font-medium text-white/80">
                Endereço de E-mail ou CPF
              </Label>
              <div className="mt-1 relative rounded-md shadow-sm">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-white/40">
                  <User size={16} />
                </div>
                <Input
                  id="login"
                  name="login"
                  type="text"
                  required
                  value={login}
                  onChange={handleLoginChange}
                  className="pl-10 bg-white/5 border-white/10 text-white placeholder-white/35 focus:border-amber-500 focus:ring-amber-500 h-10 w-full"
                  placeholder="e-mail ou CPF do cliente"
                />
              </div>
            </div>

            <div>
              <Label htmlFor="password" className="block text-sm font-medium text-white/80">
                Senha de Acesso
              </Label>
              <div className="mt-1 relative rounded-md shadow-sm">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-white/40">
                  <Lock size={16} />
                </div>
                <Input
                  id="password"
                  name="password"
                  type="password"
                  autoComplete="current-password"
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="pl-10 bg-white/5 border-white/10 text-white placeholder-white/35 focus:border-amber-500 focus:ring-amber-500 h-10 w-full"
                  placeholder="••••••••"
                />
              </div>
            </div>

            <div>
              <Button
                type="submit"
                className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-semibold text-[#0f1a2e] bg-amber-500 hover:bg-amber-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500 h-10"
                disabled={loginMutation.isPending}
              >
                {loginMutation.isPending ? "Autenticando..." : "Entrar no Painel"}
              </Button>
            </div>
          </form>

          <div className="mt-6 text-center border-t border-white/5 pt-4">
            <button
              type="button"
              onClick={() => navigate("/cadastro-cliente")}
              className="text-xs text-amber-500 hover:text-amber-400 hover:underline transition-colors focus:outline-none"
            >
              Primeiro acesso? Cadastre sua senha de cliente
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
