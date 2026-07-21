# Gerador de Procuração — TODO

## Backend
- [x] Instalar dependência `docxtemplater` e `pizzip` para geração do Word no servidor
- [x] Fazer upload do modelo de procuração para storage e salvar URL
- [x] Criar rota REST POST `/api/gerar-procuracao` que recebe dados do formulário e retorna o .docx
- [x] Substituir marcadores no modelo: {{NOME}}, {{GENERO}}, {{ESTADO_CIVIL}}, {{PROFISSAO}}, {{CPF}}, {{NATURALIDADE}}, {{FILIACAO}}, {{ENDERECO}}, {{DATA}}
- [x] Nome em MAIÚsCULAS e negrito em todos os locais do documento
- [x] Data gerada automaticamente por extenso (ex.: 14 de maio de 2026)
- [x] Repetir nome na linha de assinatura do outorgante

## Frontend
- [x] Design com identidade jurídica/formal (cores sóbrias, tipografia elegante)
- [x] Formulário responsívo (desktop e mobile)
- [x] Campos: Nome, Gênero, Estado Civil, Profissão, CPF, Naturalidade, Filiação, Rua/Avenida, Quadra, Lote, Cidade, CEP
- [x] Máscara de CPF (xxx.xxx.xxx-xx)
- [x] Validação de todos os campos obrigatórios com mensagens claras
- [x] Botão "Gerar Procuração" que dispara geração e download do .docx
- [x] Feedback visual durante geração (loading state)
- [x] Mensagens de erro por campo

## Testes
- [x] Vitest para a rota de geração do documento

## Banco de Dados — Histórico de Procurações

- [x] Criar tabela `procuracoes` no schema Drizzle
- [x] Gerar e aplicar migração SQL
- [x] Salvar registro no banco a cada geração de procuração
- [x] Endpoint tRPC `procuracao.listar` para retornar histórico
- [x] Endpoint tRPC `procuracao.deletar` para remover registro
- [x] Página de histórico no frontend com tabela de registros
- [x] Re-download de procuração a partir do histórico
- [x] Testes Vitest para os novos endpoints

## Área Restrita do Advogado (Opção 1)

### Backend
- [x] Modificar rota POST `/api/gerar-procuracao`: apenas salvar no banco, retornar JSON de confirmação (sem download)
- [x] Proteger rota GET `/api/gerar-procuracao-por-id/:id` com autenticação de sessão (apenas admin)
- [x] Proteger tRPC `procuracao.listar`, `procuracao.buscar` e `procuracao.deletar` com `adminProcedure`
- [x] Notificar o dono via `notifyOwner` quando novo formulário for enviado

### Frontend — Formulário Público
- [x] Remover lógica de download do `onSubmit` em Home.tsx
- [x] Alterar botão para "Enviar Dados"
- [x] Exibir tela de confirmação ao cliente após envio bem-sucedido
- [x] Remover botão "Histórico" do header público

### Frontend — Painel Admin
- [x] Criar página `/admin` usando `DashboardLayout`
- [x] Listar todos os formulários enviados com tabela (nome, CPF, data, ações)
- [x] Botão "Gerar e Baixar Procuração" por registro (chama `/api/gerar-procuracao-por-id/:id`)
- [x] Botão "Excluir" por registro com confirmação
- [x] Verificar role `admin` no frontend — redirecionar não-admin para página de acesso negado
- [x] Registrar rota `/admin` no App.tsx

### Banco de Dados
- [x] Promover usuário owner para role `admin` via SQL (automático no primeiro login via db.ts)

### Testes
- [x] Atualizar testes para refletir que POST `/api/gerar-procuracao` retorna JSON (não .docx)
- [x] Adicionar teste de proteção da rota GET por ID (sem sessão deve retornar 401)

### Melhorias Identificadas
- [x] Adicionar teste de integração para POST `/api/gerar-procuracao` retornando JSON (não .docx)
- [x] Adicionar teste de integração para GET `/api/gerar-procuracao-por-id/:id` retornando 401/403 sem sessão admin

### Acesso Fácil ao Painel
- [x] Incluir link direto para /admin no corpo do e-mail de notificação
- [x] Adicionar link discreto "Painel do Advogado" no rodapé do formulário público

### Correção do Fluxo OAuth
- [x] Atualizar getLoginUrl() para aceitar returnPath e codificar origin+returnPath no state
- [x] Atualizar oauth.ts callback para extrair origin do state e redirecionar para returnPath após login
- [x] Atualizar DashboardLayout para passar returnPath=/admin ao getLoginUrl

### Status da Procuração
- [x] Adicionar coluna status (pendente/gerada) na tabela procuracoes no banco
- [x] Atualizar schema Drizzle e db.ts com campo status
- [x] Criar procedure tRPC procuracao.marcarGerada (adminProcedure)
- [x] Marcar automaticamente como gerada após download bem-sucedido no Admin.tsx
- [x] Exibir badge colorido (pendente=amarelo, gerada=verde) na tabela do painel

### Filtros no Painel
- [x] Adicionar botões de filtro (Todos / Pendentes / Geradas) no painel Admin

### Busca no Painel
- [x] Adicionar campo de busca por nome ou CPF no painel Admin (combinado com filtros de status)

### Procuração por E-mail
- [x] Link de download direto no e-mail (sem necessidade de login)

### Link de Download por Token (sem login)
- [x] Adicionar coluna download_token na tabela procuracoes
- [x] Gerar token UUID ao salvar procuração no banco
- [x] Criar rota pública GET /api/download/:token que gera e retorna o .docx
- [x] Atualizar e-mail de notificação com link direto de download por token

### Expansão: Múltiplos Documentos e Painel de Links
- [x] Analisar modelos .docx enviados e mapear placeholders
- [x] Criar modelo Contrato com placeholders padronizados
- [x] Criar modelo Declaração de Hipossuficiência com placeholders
- [x] Criar modelo Procuração PA com placeholders
- [x] Ajustar Procuração Ad Judicia: subir espaço de assinatura para caber em uma folha
- [x] Adicionar coluna observacoes na tabela procuracoes (e demais tabelas)
- [x] Criar tabela contratos no banco
- [x] Criar tabela declaracoes no banco
- [x] Criar tabela procuracoes_pa no banco
- [x] Backend: rotas e procedures para Contrato (salvar, listar, buscar, deletar, download por token)
- [x] Backend: rotas e procedures para Declaração (salvar, listar, buscar, deletar, download por token)
- [x] Backend: rotas e procedures para Procuração PA (salvar, listar, buscar, deletar, download por token)
- [x] Frontend: formulário público /contrato
- [x] Frontend: formulário público /declaracao
- [x] Frontend: formulário público /procuracao-pa
- [x] Frontend: campo de observações no painel admin (edição inline por registro)
- [x] Frontend: painel do advogado com seleção e cópia de links de formulários
- [x] Atualizar App.tsx com novas rotas
- [x] Testes para novos documentos (cobertos pelos testes existentes)

### Reformulação da Interface — Foco no Advogado
- [x] Transformar Home.tsx (/) na tela de login/entrada do advogado
- [x] Após login, redirecionar para /admin (painel principal do advogado)
- [x] Painel /admin: aba "Links" como tela principal com cards de cada documento + link para copiar
- [x] Remover link "Painel do Advogado" discreto do rodapé dos formulários públicos
- [x] Formulários públicos sem link de volta ao painel (apenas confirmação ao cliente)
- [x] Ajustar App.tsx com nova rota /procuracao e Home.tsx como tela de login

### Procuração Weber e Ana Laura (dois outorgados)
- [x] Criar tabela procuracoes_weber_ana no banco de dados
- [x] Adicionar helpers db.ts para procuracoes_weber_ana
- [x] Criar rota Express POST/GET para /api/procuracao-weber-ana
- [x] Adicionar procedures tRPC (listar, buscar, deletar, marcarGerada, salvarObservacoes)
- [x] Criar formulário público /procuracao-weber-ana
- [x] Adicionar link no painel "Enviar Link ao Cliente"
- [x] Adicionar aba no Admin para Procuração Weber e Ana Laura
- [x] Registrar rota no App.tsx

## Sistema de Modelos Dinâmicos (Upload pelo Admin)

- [ ] Criar tabela `modelos_dinamicos` no banco (id, nome, slug, descricao, fileKey, ativo, criadoEm)
- [ ] Criar tabela `submissoes_modelo` no banco (id, modeloId, nome, genero, estadoCivil, profissao, cpf, naturalidadeCidade, naturalidadeUF, filiacao, rua, quadra, lote, cidade, estado, cep, dataAssinatura, token, criadoEm)
- [ ] Adicionar helpers db.ts: salvarModeloDinamico, listarModelosDinamicos, buscarModeloPorSlug, toggleModeloAtivo, salvarSubmissaoModelo, listarSubmissoesPorModelo, buscarSubmissaoPorToken
- [ ] Criar rota POST /api/admin/modelos (upload .docx → S3, salva no banco)
- [ ] Criar rota GET /api/admin/modelos (lista modelos)
- [ ] Criar rota PATCH /api/admin/modelos/:id/toggle (ativar/desativar)
- [ ] Criar rota DELETE /api/admin/modelos/:id (excluir modelo)
- [ ] Criar rota POST /api/modelo/:slug (cliente envia dados → salva submissão, gera doc, notifica admin)
- [ ] Criar rota GET /api/modelo/:slug/download/:token (download do documento gerado)
- [ ] Criar aba "Modelos" no painel Admin com upload, listagem, link público e gerenciamento
- [ ] Criar aba "Submissões" por modelo no painel Admin com listagem e download
- [ ] Criar página pública /modelo/:slug com formulário padrão (mesmos campos da Procuração Ad Judicia)
- [ ] Registrar rota /modelo/:slug no App.tsx
