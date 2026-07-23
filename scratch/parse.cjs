const fs = require('fs');
const content = fs.readFileSync('acompprocess_dump_completo.sql', 'utf8');
const regex = /\((\d+),\s*(\d+),\s*'([^']+)',\s*'([^']+)',\s*(\d+),\s*'([^']+)',\s*'([^']+)',\s*(NULL|'[^']*'),\s*(NULL|'[^']*'),\s*(NULL|'[^']*'),\s*(NULL|'[^']*'),\s*(NULL|'[^']*'),\s*(NULL|'[^']*')\)/g;
const items = [];
let match;
while ((match = regex.exec(content)) !== null) {
  items.push({
    id: parseInt(match[1]),
    userId: parseInt(match[2]),
    numeroCnj: match[3],
    tribunal: match[4],
    ativo: match[5] === '1',
    createdAt: match[6],
    updatedAt: match[7],
    dataLimite: match[8] === 'NULL' ? null : match[8].replace(/'/g, ''),
    tipoManifestacao: match[9] === 'NULL' ? null : match[9].replace(/'/g, ''),
    cliente: match[10] === 'NULL' ? null : match[10].replace(/'/g, ''),
    anotacao: match[11] === 'NULL' ? null : match[11].replace(/'/g, ''),
    horario: match[12] === 'NULL' ? null : match[12].replace(/'/g, ''),
    dataIntimacao: match[13] === 'NULL' ? null : match[13].replace(/'/g, '')
  });
}
fs.writeFileSync('scratch/processos_clean.json', JSON.stringify(items, null, 2));
console.log('Successfully extracted processes count:', items.length);
