@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: ============================================================
:: === Test Setup Knowledge Assistant ===
:: Script per verificare che tutto sia configurato correttamente
:: ============================================================

echo.
echo ============================================================
echo    === Test Setup Knowledge Assistant ===
echo ============================================================
echo.

:: Inizializza i contatori
set PASS=0
set TOTAL=5

echo Eseguo i controlli di sistema...
echo.

:: ============================================================
:: CHECK 1: Docker Installato?
:: ============================================================
echo [CHECK 1/5] Verifica installazione Docker...

docker --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Docker installato
    set /a PASS+=1
) else (
    echo [ERRORE] Docker non installato
    echo.
    echo Scaricalo da: https://www.docker.com/products/docker-desktop/
    echo Dopo l'installazione, riavvia il PC e rilancia questo script.
    echo.
)

:: ============================================================
:: CHECK 2: Docker Desktop in Esecuzione?
:: ============================================================
echo [CHECK 2/5] Verifica che Docker Desktop sia in esecuzione...

docker info >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Docker Desktop in esecuzione
    set /a PASS+=1
) else (
    echo [ERRORE] Docker Desktop non in esecuzione
    echo.
    echo Avvia Docker Desktop:
    echo   - Menu Start ^> Cerca "Docker Desktop"
    echo   - Clicca per avviarlo
    echo   - Aspetta che l'icona della balena nel system tray diventi verde
    echo   - Poi rilancia questo script
    echo.
)

:: ============================================================
:: CHECK 3: Container Open WebUI Attivo?
:: ============================================================
echo [CHECK 3/5] Verifica che il container Open WebUI sia attivo...

docker ps --filter name=open-webui --format "{{.Names}}" 2>nul | findstr "open-webui" >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Container Open WebUI attivo
    set /a PASS+=1
) else (
    echo [ERRORE] Container Open WebUI non attivo
    echo.
    echo Prova a avviare i servizi:
    echo   - Doppio click su: scripts\start-full.bat
    echo   - O se usi modalita' ibrida: scripts\start-hybrid.bat
    echo   - Aspetta 20-30 secondi che i container si avviino
    echo   - Poi rilancia questo script
    echo.
)

echo.

:: ============================================================
:: CHECK 4: Ollama Raggiungibile?
:: ============================================================
echo [CHECK 4/5] Verifica che Ollama sia raggiungibile...

:: Prima prova: cerca il container Docker Ollama
docker ps --filter name=ollama --format "{{.Names}}" 2>nul | findstr "ollama" >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Ollama attivo (container Docker)
    set /a PASS+=1
) else (
    :: Se non c'è il container Docker, prova la modalita' nativa
    powershell -Command "try { Invoke-WebRequest -Uri http://localhost:11434 -UseBasicParsing -TimeoutSec 5 | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OK] Ollama attivo (installazione nativa)
        set /a PASS+=1
    ) else (
        echo [ERRORE] Ollama non raggiungibile
        echo.
        echo Prova uno di questi:
        echo   - Avvia Ollama dal menu Start (se installato nativamente)
        echo   - O avvia i container Docker: scripts\start-full.bat
        echo   - Aspetta 20-30 secondi che tutto si carichi
        echo   - Poi rilancia questo script
        echo.
    )
)

:: ============================================================
:: CHECK 5: Modelli Disponibili?
:: ============================================================
echo [CHECK 5/5] Verifica che almeno un modello sia scaricato...

:: Prima prova: lista modelli da container Docker
docker exec ollama ollama list 2>nul | findstr /v "^$" >nul 2>&1
if !errorlevel! equ 0 (
    :: Conta le linee (escludendo la linea vuota) per verificare che ci sia almeno un modello
    for /f %%a in ('docker exec ollama ollama list 2^>nul ^| find /v /c ""') do (
        if %%a gtr 1 (
            echo [OK] Modelli disponibili (Docker)
            echo.
            docker exec ollama ollama list 2>nul
            echo.
            set /a PASS+=1
            goto :CHECK5_DONE
        )
    )
)

:: Se non funziona Docker, prova Ollama nativo
ollama list 2>nul | findstr /v "^$" >nul 2>&1
if !errorlevel! equ 0 (
    for /f %%a in ('ollama list 2^>nul ^| find /v /c ""') do (
        if %%a gtr 1 (
            echo [OK] Modelli disponibili (nativo)
            echo.
            ollama list 2>nul
            echo.
            set /a PASS+=1
            goto :CHECK5_DONE
        )
    )
)

:: Se arriviamo qui, nessun modello trovato
echo [ERRORE] Nessun modello scaricato
echo.
echo Scarica un modello:
echo   - Doppio click su: scripts\pull-model.bat
echo   - O dalla UI: Open WebUI > Selettore modello > digita il nome ^> Pull
echo   - Modello consigliato per iniziare: llama3.2:3b
echo.

:CHECK5_DONE

echo.
echo ============================================================
echo    === Riepilogo ===
echo ============================================================
echo.
echo %PASS%/%TOTAL% controlli superati
echo.

if %PASS% equ %TOTAL% (
    echo ✓ Tutto funziona perfettamente!
    echo.
    echo Apri il browser su: http://localhost:3000
    echo E inizia a usare il tuo assistente AI locale! 🚀
) else (
    echo ✗ Ci sono problemi da risolvere.
    echo.
    echo Leggi gli errori sopra e segui i suggerimenti.
    echo Se il problema persiste, contatta il team.
)

echo.

pause
