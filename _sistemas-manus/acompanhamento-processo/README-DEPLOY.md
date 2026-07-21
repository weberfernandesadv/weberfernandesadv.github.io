# Acompanhamento de Processos — Guia de Instalação

## Stack

- **Frontend:** React 19 + Tailwind 4 + Vite
- **Backend:** Node.js + Express 4 + tRPC 11
- **ORM:** Drizzle ORM
- **Banco de dados:** MySQL 8+ ou TiDB
- **Autenticação:** Manus OAuth

---

## Pré-requisitos

- Node.js 20+
- pnpm (`npm install -g pnpm`)
- MySQL 8+ ou TiDB

---

## Instalação

```bash
# 1. Instalar dependências
pnpm install

# 2. Configurar variáveis de ambiente
cp .env.example .env
# Editar .env com suas credenciais
```

---

## Variáveis de Ambiente (`.env`)

```env
# Banco de dados MySQL
DATABASE_URL=mysql://usuario:senha@localhost:3306/acompprocess

# Autenticação JWT (qualquer string aleatória segura)
JWT_SECRET=sua_chave_secreta_aqui

# Manus OAuth (necessário para autenticação)
VITE_APP_ID=seu_app_id
OAUTH_SERVER_URL=https://api.manus.im
VITE_OAUTH_PORTAL_URL=https://manus.im

# APIs internas Manus (opcionais — para notificações ao dono)
BUILT_IN_FORGE_API_URL=
BUILT_IN_FORGE_API_KEY=
VITE_FRONTEND_FORGE_API_KEY=
VITE_FRONTEND_FORGE_API_URL=

# Informações do dono (para notificações)
OWNER_OPEN_ID=
OWNER_NAME=
```

---

## Banco de Dados

```bash
# Criar o banco de dados
mysql -u root -p -e "CREATE DATABASE acompprocess CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Aplicar as migrations em ordem
mysql -u usuario -p acompprocess < drizzle/0000_normal_hiroim.sql
mysql -u usuario -p acompprocess < drizzle/0001_mysterious_sprite.sql
mysql -u usuario -p acompprocess < drizzle/0002_high_harpoon.sql
mysql -u usuario -p acompprocess < drizzle/0003_aromatic_titania.sql
mysql -u usuario -p acompprocess < drizzle/0004_secret_multiple_man.sql
```

---

## Executar em Desenvolvimento

```bash
pnpm dev
# Acesse: http://localhost:3000
```

## Build para Produção

```bash
pnpm build
pnpm start
```

---

## Estrutura do Projeto

```
client/
  src/
    pages/
      Dashboard.tsx     ← Painel principal de processos
      Novidades.tsx     ← Aba de notificações
      Home.tsx          ← Landing page
    lib/
      prazos.ts         ← Cálculo de prazos em dias úteis (TJGO/TRT18)
      cnj.ts            ← Identificação de tribunal pelo número CNJ
drizzle/
  schema.ts             ← Schema do banco de dados
  *.sql                 ← Migrations (aplicar em ordem 0000→0004)
server/
  routers.ts            ← Rotas tRPC
  db.ts                 ← Helpers de banco de dados
```

---

## Funcionalidades

- Busca de processos por número CNJ ou nome do cliente
- Identificação automática do tribunal pelo número CNJ (suporte a J=8 e J=9)
- Cálculo automático de prazo em dias úteis (CPC e CLT)
  - Feriados oficiais TJGO e TRT18 (2025 e 2026)
- Destaque visual: vermelho (vencido), amarelo (≤7 dias corridos), vermelho intenso (≤3 dias úteis)
- Tipos de manifestação: Recurso, Resposta, Apelação, Embargos de declaração, Contestação, Impugnação, Autos conclusos, Conciliação, Audiência, Outro
- Campo de horário para Audiência e Conciliação
- Exportação em PDF (jsPDF + jspdf-autotable)
- Aba "Novidades" para notificações
- Tema dark (azul-marinho + dourado), fontes Inter + Playfair Display
- Fuso horário UTC-3 (Brasília) em todos os cálculos e exibições
