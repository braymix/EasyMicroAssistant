@echo off
chcp 65001 >nul 2>&1

:: ============================================================
:: Avvia Knowledge Assistant - Modalita' Full Docker
:: (Ollama + Open WebUI entrambi in Docker)
:: ============================================================

echo.
echo ============================================================
echo    KNOWLEDGE ASSISTANT - Avvio Full Docker
echo ============================================================
echo.

:: Risali alla cartella root del progetto
pushd "%~dp0.."

echo  Avvio dei container in corso...
echo.

docker compose -f docker-compose.full.yml up -d
if %errorlevel% neq 0 (
    echo.
    echo  [ERRORE] Avvio fallito!
    echo  Controlla che Docker Desktop sia in esecuzione.
    echo.
    popd
    goto :fine
)

echo.
echo ============================================================
echo    Avviato! Apri http://localhost:3000
echo ============================================================
echo.

popd

:fine
pause
