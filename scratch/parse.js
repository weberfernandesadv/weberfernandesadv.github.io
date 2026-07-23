const fs = require('fs');
const sql = fs.readFileSync('acompprocess_dump_completo.sql', 'utf8');
const lines = sql.split('\n');
const insertLines = lines.filter(l => l.trim().startsWith('(1,') || l.trim().startsWith('(2,') || l.trim().startsWith('('));
const processos = [];
for (const line of lines) {
  if (line.trim().startsWith('(') && line.includes('TJGO')) {
    const parts = line.trim().replace(/^\\(/, '').replace(/\\),?$/, '').split(',');
    if (parts.length >= 4) {
      processos.push(line.trim());
    }
  }
}
fs.writeFileSync('scratch/processos_parsed.json', JSON.stringify(processos, null, 2));
console.log('Parsed processes:', processos.length);
