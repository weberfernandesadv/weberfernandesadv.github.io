@echo off
chcp 65001 > nul
echo =======================================================
echo   Iniciando os Sistemas do Escritório Weber Advocacia
echo =======================================================
echo.
echo [ATENÇÃO] Certifique-se de que o XAMPP (Apache e MySQL) esteja ATIVO!
echo.
echo [1/4] Iniciando Site Principal (Porta 4321)...
start "Site Principal" /min cmd.exe /c "node serve.cjs"

echo [2/4] Iniciando Sistema de Procurações (Porta 3001)...
cd _sistemas-manus\procuracao
start "Procuracoes" /min cmd.exe /c "set NODE_ENV=development&& npx tsx server/_core/index.ts"

echo [3/4] Iniciando Sistema de Processos (Porta 3002)...
cd ..\acompanhamento-processo
start "Processos" /min cmd.exe /c "set NODE_ENV=development&& npx tsx server/_core/index.ts"

echo [4/4] Iniciando Sistema de Pagamentos (Porta 3003)...
cd ..\controle-pagamentos
start "Pagamentos" /min cmd.exe /c "set NODE_ENV=development&& npx tsx server/_core/index.ts"

echo.
echo =======================================================
echo   Todos os sistemas foram iniciados em segundo plano!
echo.
echo   - Site Principal: http://localhost:4321
echo   - Procuração:     http://localhost:3001
echo   - Processos:      http://localhost:3002
echo   - Pagamentos:     http://localhost:3003
echo =======================================================
echo.
pause
