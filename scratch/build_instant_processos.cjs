const fs = require('fs');
const path = require('path');
const processos = JSON.parse(fs.readFileSync('scratch/processos_clean.json', 'utf8'));

const htmlContent = `<!doctype html>
<html lang="pt-BR" class="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Acompanhamento de Processos - Weber F. Pereira Advogados</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    body { background-color: #0b0f17; color: #f3f4f6; font-family: system-ui, -apple-system, sans-serif; }
    .glass-card { background: rgba(17, 24, 39, 0.7); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.08); }
    .badge-gold { background: rgba(217, 119, 6, 0.15); color: #fbbf24; border: 1px solid rgba(217, 119, 6, 0.3); }
    .badge-blue { background: rgba(37, 99, 235, 0.15); color: #60a5fa; border: 1px solid rgba(37, 99, 235, 0.3); }
  </style>
</head>
<body class="min-h-screen flex flex-col md:flex-row">
  <!-- Sidebar -->
  <aside class="w-full md:w-64 bg-slate-900/90 border-b md:border-b-0 md:border-r border-slate-800 p-5 flex flex-col justify-between shrink-0">
    <div>
      <div class="flex items-center gap-3 mb-8">
        <div class="w-10 h-10 rounded-xl bg-amber-500/20 text-amber-400 flex items-center justify-center font-bold text-xl border border-amber-500/30">
          <i class="fa-solid font-bold fa-scale-balanced"></i>
        </div>
        <div>
          <h1 class="font-bold text-lg text-white leading-tight">Processos</h1>
          <p class="text-xs text-amber-400 font-medium">Escritório Weber Advocacia</p>
        </div>
      </div>

      <nav class="space-y-2">
        <a href="#processos" class="flex items-center gap-3 px-4 py-3 rounded-xl bg-amber-500/10 text-amber-400 border border-amber-500/20 font-medium">
          <i class="fa-solid fa-folder-open"></i> Meus Processos
        </a>
        <a href="#novidades" class="flex items-center justify-between px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800/60 hover:text-white transition">
          <span class="flex items-center gap-3"><i class="fa-solid fa-bell"></i> Novidades</span>
          <span class="bg-amber-500 text-slate-950 text-xs font-bold px-2 py-0.5 rounded-full">3</span>
        </a>
        <a href="https://advweber.com/controle-pagamentos/" class="flex items-center gap-3 px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800/60 hover:text-white transition">
          <i class="fa-solid fa-credit-card"></i> Pagamentos
        </a>
        <a href="https://advweber.com/procuracao/" class="flex items-center gap-3 px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800/60 hover:text-white transition">
          <i class="fa-solid fa-file-signature"></i> Procurações
        </a>
      </nav>
    </div>

    <div class="pt-6 mt-6 border-t border-slate-800/80 flex items-center gap-3">
      <div class="w-10 h-10 rounded-full bg-slate-800 text-amber-400 flex items-center justify-center font-bold text-base border border-slate-700">
        W
      </div>
      <div class="overflow-hidden">
        <h4 class="font-semibold text-sm text-white truncate">Weber Fernandes Pereira</h4>
        <p class="text-xs text-slate-400 font-mono">CPF: 111.111.111-11</p>
      </div>
    </div>
  </aside>

  <!-- Main Content -->
  <main class="flex-1 p-6 md:p-10 overflow-y-auto">
    <header class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
      <div>
        <h2 class="text-2xl md:text-3xl font-bold text-white tracking-tight">Meus Processos</h2>
        <p class="text-sm text-slate-400 mt-1" id="process-count-text">Carregando processos...</p>
      </div>
      <div class="flex items-center gap-3">
        <div class="relative flex-1 md:w-80">
          <i class="fa-solid fa-magnifying-glass absolute left-3.5 top-3 text-slate-400"></i>
          <input type="text" id="search-input" placeholder="Buscar por cliente ou nº CNJ..." 
                 class="w-full pl-10 pr-4 py-2.5 bg-slate-900/80 border border-slate-800 rounded-xl text-sm text-white focus:outline-none focus:border-amber-500/50 transition" />
        </div>
      </div>
    </header>

    <div id="processos-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
      <!-- Process Cards Rendered via JS -->
    </div>
  </main>

  <script>
    const staticProcessos = ;

    function renderProcessos(list) {
      const grid = document.getElementById('processos-grid');
      const countText = document.getElementById('process-count-text');
      countText.textContent = list.length + ' processos monitorados';
      
      if (!list || list.length === 0) {
        grid.innerHTML = '<div class="col-span-full py-16 text-center text-slate-500">Nenhum processo encontrado.</div>';
        return;
      }

      grid.innerHTML = list.map(p => 
        <div class="glass-card rounded-2xl p-5 hover:border-amber-500/30 transition shadow-lg flex flex-col justify-between">
          <div>
            <div class="flex items-center justify-between gap-2 mb-3">
              <span class="badge-blue text-xs font-semibold px-2.5 py-1 rounded-lg flex items-center gap-1.5">
                <i class="fa-solid fa-gavel text-[10px]"></i> \
              </span>
              <span class="text-xs text-slate-400 font-medium">
                \
              </span>
            </div>
            
            <h3 class="font-mono text-sm font-semibold text-amber-400 select-all mb-2 tracking-wide">
              \
            </h3>
            
            \
            \
          </div>

          <div class="pt-3 mt-3 border-t border-slate-800/60 flex items-center justify-between text-xs text-slate-400">
            <span>\</span>
            <button onclick="navigator.clipboard.writeText('\'); alert('CNJ Copiado!')" class="text-slate-400 hover:text-amber-400 transition" title="Copiar CNJ">
              <i class="fa-regular fa-copy"></i>
            </button>
          </div>
        </div>
      ).join('');
    }

    // Try fetching from backend API first
    fetch('/api/trpc/processos.list')
      .then(res => res.json())
      .then(data => {
        const remote = data?.result?.data?.json;
        if (Array.isArray(remote) && remote.length > 0) {
          renderProcessos(remote);
        } else {
          renderProcessos(staticProcessos);
        }
      })
      .catch(() => {
        renderProcessos(staticProcessos);
      });

    // Search filter
    document.getElementById('search-input').addEventListener('input', (e) => {
      const q = e.target.value.toLowerCase().trim();
      const filtered = staticProcessos.filter(p => 
        (p.numeroCnj && p.numeroCnj.toLowerCase().includes(q)) ||
        (p.cliente && p.cliente.toLowerCase().includes(q)) ||
        (p.tribunal && p.tribunal.toLowerCase().includes(q))
      );
      renderProcessos(filtered);
    });

    renderProcessos(staticProcessos);
  </script>
</body>
</html>`;

fs.writeFileSync('dist/acompanhamento-processo/index.html', htmlContent, 'utf8');
console.log('Successfully generated instant dist/acompanhamento-processo/index.html');
