@echo off
title Quiniela Mundial 2026
color 0A

echo.
echo  ==========================================
echo   QUINIELA MUNDIAL 2026 - Iniciando...
echo  ==========================================
echo.

:: Verificar si node está instalado
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo  ERROR: Node.js no esta instalado.
    echo  Descargalo en: https://nodejs.org
    pause
    exit
)

:: Matar proceso previo en puerto 5177
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5177 2^>nul') do (
    taskkill /PID %%a /F >nul 2>nul
)

:: Iniciar servidor en background
echo  Iniciando servidor...
start /B node "%~dp0server.js"
timeout /t 2 /nobreak >nul

:: Intentar abrir Chrome, Edge o Firefox en ese orden
echo  Abriendo la app...

if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" "http://127.0.0.1:5177"
    goto RUNNING
)
if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://127.0.0.1:5177"
    goto RUNNING
)
if exist "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" (
    start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "http://127.0.0.1:5177"
    goto RUNNING
)
:: Fallback al navegador por defecto
start "" "http://127.0.0.1:5177"

:RUNNING
echo.
echo  ==========================================
echo   App corriendo en http://127.0.0.1:5177
echo   Cerra esta ventana para detener el server
echo  ==========================================
echo.

:: Mantener el servidor corriendo
node "%~dp0server.js"
