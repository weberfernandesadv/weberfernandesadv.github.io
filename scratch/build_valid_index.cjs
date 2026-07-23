const fs = require('fs');
const processos = JSON.parse(fs.readFileSync('scratch/processos_clean.json', 'utf8'));

const jsonString = JSON.stringify(processos);

const htmlContent = '<!doctype html>\n' +
'<html lang="pt-BR" class="dark">\n' +
'<head>\n' +
'  <meta charset="UTF-8" />\n' +
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />\n' +
'  <title>Acompanhamento de Processos - Weber F. Pereira Advogados</title>\n' +
'  <script src="https://cdn.tailwindcss.com"></script>\n' +
'  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />\n' +
'  <style>\n' +
'    body { background-color: #0b0f17; color: #f3f4f6; font-family: system-ui, -apple-system, sans-serif; }\n' +
'    .glass-card { background: rgba(17, 24, 39, 0.75); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.08); }\n' +
'    .badge-gold { background: rgba(217, 119, 6, 0.15); color: #fbbf24; border: 1px solid rgba(217, 119, 6, 0.3); }\n' +
'    .badge-blue { background: rgba(37, 99, 235, 0.15); color: #60a5fa; border: 1px solid rgba(37, 99, 235, 0.3); }\n' +
'  </style>\n' +
'</head>\n' +
'<body class="min-h-screen flex flex-col md:flex-row">\n' +
'  <aside class="w-full md:w-64 bg-slate-900/90 border-b md:border-b-0 md:border-r border-slate-800 p-5 flex flex-col justify-between shrink-0">\n' +
'    <div>\n' +
'      <div class="flex items-center gap-3 mb-8">\n' +
'        <div class="w-10 h-10 rounded-xl bg-amber-500/20 text-amber-400 flex items-center justify-center font-bold text-xl border border-amber-500/30">\n' +
'          <i class="fa-solid fa-scale-balanced"></i>\n' +
'        </div>\n' +
'        <div>\n' +
'          <h1 class="font-bold text-lg text-white leading-tight">Processos</h1>\n' +
'          <p class="text-xs text-amber-400 font-medium">Escritório Weber Advocacia</p>\n' +
'        </div>\n' +
'      </div>\n' +
'      <nav class="space-y-2">\n' +
'        <a href="#processos" class="flex items-center gap-3 px-4 py-3 rounded-xl bg-amber-500/10 text-amber-400 border border-amber-500/20 font-medium">\n' +
'          <i class="fa-solid fa-folder-open"></i> Meus Processos\n' +
'        </a>\n' +
'        <a href="#novidades" class="flex items-center justify-between px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800/60 hover:text-white transition">\n' +
'          <span class="flex items-center gap-3"><i class="fa-solid fa-bell"></i> Novidades</span>\n' +
'          <span class="bg-amber-500 text-slate-950 text-xs font-bold px-2 py-0.5 rounded-full">3</span>\n' +
'        </a>\n' +
'        <a href="https://advweber.com/controle-pagamentos/" class="flex items-center gap-3 px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800/60 hover:text-white transition">\n' +
'          <i class="fa-solid fa-credit-card"></i> Pagamentos\n' +
'        </a>\n' +
'        <a href="https://advweber.com/procuracao/" class="flex items-center gap-3 px-4 py-3 rounded-xl text-slate-400 hover:bg-slate-800/60 hover:text-white transition">\n' +
'          <i class="fa-solid fa-file-signature"></i> Procurações\n' +
'        </a>\n' +
'      </nav>\n' +
'    </div>\n' +
'    <div class="pt-6 mt-6 border-t border-slate-800/80 flex items-center gap-3">\n' +
'      <div class="w-10 h-10 rounded-full bg-slate-800 text-amber-400 flex items-center justify-center font-bold text-base border border-slate-700">\n' +
'        W\n' +
'      </div>\n' +
'      <div class="overflow-hidden">\n' +
'        <h4 class="font-semibold text-sm text-white truncate">Weber Fernandes Pereira</h4>\n' +
'        <p class="text-xs text-slate-400 font-mono">CPF: 111.111.111-11</p>\n' +
'      </div>\n' +
'    </div>\n' +
'  </aside>\n' +
'  <main class="flex-1 p-6 md:p-10 overflow-y-auto">\n' +
'    <header class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">\n' +
'      <div>\n' +
'        <h2 class="text-2xl md:text-3xl font-bold text-white tracking-tight">Meus Processos</h2>\n' +
'        <p class="text-sm text-slate-400 mt-1" id="process-count-text">Carregando processos...</p>\n' +
'      </div>\n' +
'      <div class="flex items-center gap-3">\n' +
'        <div class="relative flex-1 md:w-80">\n' +
'          <i class="fa-solid fa-magnifying-glass absolute left-3.5 top-3.5 text-slate-400"></i>\n' +
'          <input type="text" id="search-input" placeholder="Buscar por cliente ou nº CNJ..." class="w-full pl-10 pr-4 py-2.5 bg-slate-900/80 border border-slate-800 rounded-xl text-sm text-white focus:outline-none focus:border-amber-500/50 transition" />\n' +
'        </div>\n' +
'      </div>\n' +
'    </header>\n' +
'    <div id="processos-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">\n' +
'    </div>\n' +
'  </main>\n' +
'  <script>\n' +
'    const staticProcessos = ' + jsonString + ';\n' +
'    function renderProcessos(list) {\n' +
'      const grid = document.getElementById("processos-grid");\n' +
'      const countText = document.getElementById("process-count-text");\n' +
'      if (!grid) return;\n' +
'      if (countText) countText.textContent = list.length + " processos monitorados";\n' +
'      if (!list || list.length === 0) {\n' +
'        grid.innerHTML = \'<div class="col-span-full py-16 text-center text-slate-500">Nenhum processo encontrado.</div>\';\n' +
'        return;\n' +
'      }\n' +
'      grid.innerHTML = list.map(p => \n' +
'        <div class="glass-card rounded-2xl p-5 hover:border-amber-500/30 transition shadow-lg flex flex-col justify-between">\n' +
'          <div>\n' +
'            <div class="flex items-center justify-between gap-2 mb-3">\n' +
'              <span class="badge-blue text-xs font-semibold px-2.5 py-1 rounded-lg flex items-center gap-1.5">\n' +
'                <i class="fa-solid fa-gavel text-[10px]"></i> \\n' +
'              </span>\n' +
'              <span class="text-xs text-slate-400 font-medium">\n' +
'                \\n' +
'              </span>\n' +
'            </div>\n' +
'            <h3 class="font-mono text-sm font-semibold text-amber-400 select-all mb-2 tracking-wide">\n' +
'              \\n' +
'            </h3>\n' +
'            \\n' +
'            \\n' +
'          </div>\n' +
'          <div class="pt-3 mt-3 border-t border-slate-800/60 flex items-center justify-between text-xs text-slate-400">\n' +
'            <span>\</span>\n' +
'            <button onclick="navigator.clipboard.writeText(\\\'\\\\'); alert(\\\'CNJ Copiado!\\\')" class="text-slate-400 hover:text-amber-400 transition" title="Copiar CNJ">\n' +
'              <i class="fa-regular fa-copy"></i>\n' +
'            </button>\n' +
'          </div>\n' +
'        </div>\n' +
'      ).join("");\n' +
'    }\n' +
'    function init() {\n' +
'      renderProcessos(staticProcessos);\n' +
'      const input = document.getElementById("search-input");\n' +
'      if (input) {\n' +
'        input.addEventListener("input", (e) => {\n' +
'          const q = e.target.value.toLowerCase().trim();\n' +
'          const filtered = staticProcessos.filter(p => \n' +
'            (p.numeroCnj && p.numeroCnj.toLowerCase().includes(q)) ||\n' +
'            (p.cliente && p.cliente.toLowerCase().includes(q)) ||\n' +
'            (p.tribunal && p.tribunal.toLowerCase().includes(q))\n' +
'          );\n' +
'          renderProcessos(filtered);\n' +
'        });\n' +
'      }\n' +
'    }\n' +
'    if (document.readyState === "loading") {\n' +
'      document.addEventListener("DOMContentLoaded", init);\n' +
'    } else {\n' +
'      init();\n' +
'    }\n' +
'  </script>\n' +
'</body>\n' +
'</html>';

fs.writeFileSync('dist/acompanhamento-processo/index.html', htmlContent, 'utf8');
console.log('Successfully built valid dist/acompanhamento-processo/index.html');
