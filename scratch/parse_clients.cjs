const fs = require('fs');
const content = fs.readFileSync('pagamentos_dump.sql', 'utf8');
const clients = [];
const clientRegex = /\((\d+),\s*'([^']+)',\s*'([^']+)',\s*(\d+),\s*'([^']+)',\s*(\d+),\s*(NULL|'[^']*'),\s*(NULL|'[^']*'),\s*'([^']+)',\s*'([^']+)'\)/g;
let cMatch;
while ((cMatch = clientRegex.exec(content)) !== null) {
  clients.push({
    id: parseInt(cMatch[1]),
    name: cMatch[2],
    totalFees: cMatch[3],
    installmentCount: parseInt(cMatch[4]),
    installmentValue: cMatch[5],
    startDate: parseInt(cMatch[6]),
    settledAt: cMatch[7] === 'NULL' ? null : parseInt(cMatch[7].replace(/'/g, '')),
    notes: cMatch[8] === 'NULL' ? null : cMatch[8].replace(/'/g, ''),
    createdAt: cMatch[9],
    updatedAt: cMatch[10]
  });
}
fs.writeFileSync('scratch/clients_clean.json', JSON.stringify(clients, null, 2));
console.log('Successfully extracted clients count:', clients.length);
