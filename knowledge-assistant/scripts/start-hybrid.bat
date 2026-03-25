@echo off
chcp 65001 >nul 2>&1

:: ============================================================
:: Avvia Knowledge Assistant - Modalita' Ibrida
:: (Solo Open WebUI in Docker, Ollama nativo sull'host)
:: ============================================================

echo.
echo ============================================================
echo    KNOWLEDGE ASSISTANT - Avvio Modalita' Ibrida
echo ============================================================
echo.

:: Risali alla cartella root del progetto
pushd "%~dp0.."

:: Verifica che Ollama sia raggiungibile sull'host
echo  Verifica connessione a Ollama su localhost:11434...
echo.

powershell -Command "try { $r = Invoke-WebRequest -Uri 'http://localhost:11434' -UseBasicParsing -TimeoutSec 5; exit 0 } catch { exit 1 }" >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERRORE] Ollama non raggiungibile su localhost:11434!
    echo.
    echo  Avvia Ollama prima di procedere!
    echo.
    echo  Se non lo hai installato, scaricalo da: https://ollama.com/download
    echo  Dopo l'installazione, avvialo e rilancia questo script.
    echo.
    popd
    goto :fine
)

echo        Ollama raggiungibile.
echo.
echo  Avvio di Open WebUI in corso...
echo.

docker compose -f docker-compose.hybrid.yml up -d
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
