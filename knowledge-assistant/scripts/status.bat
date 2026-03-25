@echo off
chcp 65001 >nul 2>&1

:: ============================================================
:: Controlla lo stato dei container Knowledge Assistant
:: ============================================================

echo.
echo ============================================================
echo    KNOWLEDGE ASSISTANT - Stato Servizi
echo ============================================================
echo.

docker ps --filter "name=ollama" --filter "name=open-webui" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

:: Controlla se ci sono container attivi
docker ps --filter "name=ollama" --filter "name=open-webui" --format "{{.Names}}" | findstr /r "." >nul 2>&1
if %errorlevel% neq 0 (
    echo  Nessun container attivo.
    echo.
    echo  Avvia i servizi con:
    echo    start-full.bat    (modalita' Full Docker)
    echo    start-hybrid.bat  (modalita' Ibrida)
)

echo.

pause
