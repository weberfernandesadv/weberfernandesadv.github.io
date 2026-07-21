const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 4321;
const PUBLIC_DIR = path.join(__dirname, 'dist');

const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2'
};

const server = http.createServer((req, res) => {
  // Decode URL to handle spaces/accents
  let decodedUrl = decodeURIComponent(req.url);
  
  // Clean query params or hashes
  const cleanUrl = decodedUrl.split('?')[0].split('#')[0];
  
  let filePath = path.join(PUBLIC_DIR, cleanUrl === '/' ? 'index.html' : cleanUrl);
  
  // Clean path to prevent directory traversal
  if (!filePath.startsWith(PUBLIC_DIR)) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  // Check if directory or file exists, and manage extensions
  let ext = path.extname(filePath);
  if (!ext) {
    if (fs.existsSync(filePath + '.html')) {
      filePath += '.html';
    } else if (fs.existsSync(path.join(filePath, 'index.html'))) {
      filePath = path.join(filePath, 'index.html');
    }
  }

  const fileExt = path.extname(filePath);
  const contentType = MIME_TYPES[fileExt] || 'application/octet-stream';

  fs.readFile(filePath, (err, content) => {
    if (err) {
      if (err.code === 'ENOENT') {
        // Serve 404 page if it exists
        const path404 = path.join(PUBLIC_DIR, '404.html');
        if (fs.existsSync(path404)) {
          fs.readFile(path404, (err404, content404) => {
            res.writeHead(404, { 'Content-Type': 'text/html; charset=utf-8' });
            res.end(content404 || '<h1>404 Not Found</h1>');
          });
        } else {
          res.writeHead(404, { 'Content-Type': 'text/html; charset=utf-8' });
          res.end('<h1>404 Not Found</h1>');
        }
      } else {
        res.writeHead(500);
        res.end(`Server Error: ${err.code}`);
      }
    } else {
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content);
    }
  });
});

server.listen(PORT, '127.0.0.1', () => {
  console.log(`  Local:   http://localhost:${PORT}/`);
});
