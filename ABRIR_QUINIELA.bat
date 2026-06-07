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
    echo  ERROR: Node.js no está instalado.
    echo  Descargalo en: https://nodejs.org
    echo.
    pause
    exit
)

:: Matar cualquier proceso previo en el puerto 5177
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5177 2^>nul') do (
    taskkill /PID %%a /F >nul 2>nul
)

:: Iniciar el servidor en background
echo  Iniciando servidor...
start /B node "%~dp0server.js"

:: Esperar 2 segundos para que arranque
timeout /t 2 /nobreak >nul

:: Abrir Chrome con el link
echo  Abriendo la app...
start "" "http://127.0.0.1:5177"

echo.
echo  ==========================================
echo   App corriendo en http://127.0.0.1:5177
echo   Cerrá esta ventana para detener el server
echo  ==========================================
echo.

:: Mantener el servidor corriendo
node "%~dp0server.js"
