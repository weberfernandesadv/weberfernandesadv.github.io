import { trpc } from "@/lib/trpc";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { MessageSquare, Calendar, User, Phone, Briefcase, Search, RefreshCw } from "lucide-react";
import { useState } from "react";

export default function Leads() {
  const { data: leads, isLoading, refetch, isRefetching } = trpc.leads.list.useQuery();
  const [searchQuery, setSearchQuery] = useState("");
  const [filterAdvogado, setFilterAdvogado] = useState("");

  const formatWhatsAppNumber = (num: string) => {
    // Remove non-digit characters
    const digits = num.replace(/\D/g, "");
    if (digits.length === 11) {
      return `(${digits.slice(2, 4)}) ${digits.slice(4, 5)} ${digits.slice(5, 9)}-${digits.slice(9)}`;
    }
    return num;
  };

  const filteredLeads = leads?.filter(lead => {
    const matchesSearch = 
      lead.nome.toLowerCase().includes(searchQuery.toLowerCase()) ||
      lead.telefone.includes(searchQuery);
    
    const matchesAdvogado = 
      !filterAdvogado || 
      lead.advogado.toLowerCase().includes(filterAdvogado.toLowerCase());

    return matchesSearch && matchesAdvogado;
  }) || [];

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white">Leads do Site</h1>
          <p className="text-sm text-white/60">
            Acompanhe os clientes que entraram em contato com os advogados associados através do site institucional.
          </p>
        </div>
        <Button 
          onClick={() => refetch()} 
          variant="outline" 
          size="sm" 
          disabled={isLoading || isRefetching}
          className="border-white/10 text-white hover:bg-white/5 shrink-0"
        >
          <RefreshCw className={`w-4 h-4 mr-2 ${isRefetching ? "animate-spin" : ""}`} />
          Atualizar
        </Button>
      </div>

      {/* Stats row */}
      <div className="grid gap-4 grid-cols-1 sm:grid-cols-3">
        <Card className="bg-white/5 border-white/10 text-white">
          <CardHeader className="pb-2">
            <CardDescription className="text-white/60 text-xs font-semibold uppercase tracking-wider">Total de Leads</CardDescription>
            <CardTitle className="text-3xl font-bold">{leads?.length || 0}</CardTitle>
          </CardHeader>
        </Card>
        
        <Card className="bg-white/5 border-white/10 text-white">
          <CardHeader className="pb-2">
            <CardDescription className="text-white/60 text-xs font-semibold uppercase tracking-wider">Dra. Ana Laura</CardDescription>
            <CardTitle className="text-3xl font-bold text-amber-400">
              {leads?.filter(l => l.advogado.toLowerCase().includes("ana laura")).length || 0}
            </CardTitle>
          </CardHeader>
        </Card>

        <Card className="bg-white/5 border-white/10 text-white">
          <CardHeader className="pb-2">
            <CardDescription className="text-white/60 text-xs font-semibold uppercase tracking-wider">Dr. Silneyr</CardDescription>
            <CardTitle className="text-3xl font-bold text-amber-400">
              {leads?.filter(l => l.advogado.toLowerCase().includes("silneyr")).length || 0}
            </CardTitle>
          </CardHeader>
        </Card>
      </div>

      <Card className="bg-white/5 border-white/10 text-white">
        <CardHeader>
          <CardTitle>Histórico de Cliques de Contato</CardTitle>
          <CardDescription className="text-white/60">
            Lista de usuários que preencheram o formulário de consentimento da LGPD e prosseguiram para o WhatsApp.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="flex flex-col gap-4 sm:flex-row mb-6">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-3 h-4 w-4 text-white/40" />
              <Input
                placeholder="Buscar por nome ou telefone..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="pl-9 bg-white/5 border-white/10 text-white placeholder-white/40 focus-visible:ring-amber-500"
              />
            </div>
            <select
              value={filterAdvogado}
              onChange={(e) => setFilterAdvogado(e.target.value)}
              className="px-3 py-2 bg-white/5 border border-white/10 rounded-md text-white/80 focus:outline-none focus:border-amber-500"
            >
              <option className="bg-[#0f1a2e] text-white" value="">Todos os Advogados</option>
              <option className="bg-[#0f1a2e] text-white" value="Weber">Dr. Weber Fernandes</option>
              <option className="bg-[#0f1a2e] text-white" value="Silneyr">Dr. Silneyr Deófanes</option>
              <option className="bg-[#0f1a2e] text-white" value="Ana Laura">Dra. Ana Laura Paiva</option>
            </select>
          </div>

          {isLoading ? (
            <div className="flex items-center justify-center py-12 text-white/60">
              <RefreshCw className="w-8 h-8 animate-spin mr-3 text-amber-500" />
              Carregando leads do site...
            </div>
          ) : filteredLeads.length === 0 ? (
            <div className="text-center py-12 text-white/40">
              Nenhum lead encontrado com os filtros selecionados.
            </div>
          ) : (
            <div className="overflow-x-auto">
              <Table>
                <TableHeader className="hover:bg-transparent border-white/10">
                  <TableRow className="border-white/10 hover:bg-transparent">
                    <TableHead className="text-white/60"><Calendar className="w-4 h-4 inline mr-2" />Data / Hora</TableHead>
                    <TableHead className="text-white/60"><User className="w-4 h-4 inline mr-2" />Nome do Lead</TableHead>
                    <TableHead className="text-white/60"><Phone className="w-4 h-4 inline mr-2" />WhatsApp</TableHead>
                    <TableHead className="text-white/60"><Briefcase className="w-4 h-4 inline mr-2" />Advogado Procurado</TableHead>
                    <TableHead className="text-white/60 text-right">Ação</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredLeads.map((lead) => {
                    // Prepare WhatsApp Link for the admin to call the lead
                    const cleanPhone = lead.telefone.replace(/\D/g, "");
                    const waLink = `https://wa.me/${cleanPhone.startsWith('55') ? cleanPhone : '55' + cleanPhone}`;

                    return (
                      <TableRow key={lead.id} className="border-white/10 hover:bg-white/5">
                        <TableCell className="font-medium text-white/90">
                          {new Date(lead.createdAt).toLocaleString("pt-BR")}
                        </TableCell>
                        <TableCell className="text-white/80">{lead.nome}</TableCell>
                        <TableCell className="text-white/80">
                          {formatWhatsAppNumber(lead.telefone)}
                        </TableCell>
                        <TableCell className="text-white/85">
                          <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-amber-500/10 text-amber-400 border border-amber-500/20">
                            {lead.advogado}
                          </span>
                        </TableCell>
                        <TableCell className="text-right">
                          <a 
                            href={waLink} 
                            target="_blank" 
                            rel="noopener noreferrer"
                          >
                            <Button 
                              size="sm" 
                              variant="ghost" 
                              className="text-emerald-400 hover:text-emerald-300 hover:bg-emerald-500/10 focus-visible:ring-emerald-500"
                            >
                              <MessageSquare className="w-4 h-4 mr-2" />
                              Falar no WhatsApp
                            </Button>
                          </a>
                        </TableCell>
                      </TableRow>
                    );
                  })}
                </TableBody>
              </Table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
