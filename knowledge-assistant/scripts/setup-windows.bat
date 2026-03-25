@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: ============================================================
:: Setup automatico Knowledge Assistant per Windows
:: ============================================================

echo.
echo ============================================================
echo    KNOWLEDGE ASSISTANT - Setup Automatico
echo ============================================================
echo.

:: ------------------------------------------------------------
:: Step 1: Verifica che Docker sia installato
:: ------------------------------------------------------------
echo [1/6] Verifica installazione Docker...
where docker >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  [ERRORE] Docker non trovato!
    echo.
    echo  Docker Desktop non sembra essere installato sul tuo PC.
    echo  Scaricalo e installalo da questo link:
    echo.
    echo    https://www.docker.com/products/docker-desktop/
    echo.
    echo  Dopo l'installazione, riavvia il PC e rilancia questo script.
    echo.
    goto :fine
)
echo        Docker trovato.

:: ------------------------------------------------------------
:: Step 2: Verifica che Docker Desktop sia in esecuzione
:: ------------------------------------------------------------
echo [2/6] Verifica che Docker Desktop sia in esecuzione...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  [ERRORE] Docker Desktop non e' in esecuzione!
    echo.
    echo  Avvia Docker Desktop e riprova.
    echo  Lo trovi nel menu Start oppure nella system tray (icona della balena).
    echo  Attendi che l'icona smetta di animarsi prima di rilanciare lo script.
    echo.
    goto :fine
)
echo        Docker Desktop in esecuzione.

:: ------------------------------------------------------------
:: Step 3: Copia .env.example in .env se non esiste
:: ------------------------------------------------------------
echo [3/6] Configurazione variabili d'ambiente...

:: Risali alla cartella root del progetto (da scripts/ a knowledge-assistant/)
pushd "%~dp0.."

if not exist ".env" (
    if exist ".env.example" (
        copy ".env.example" ".env" >nul
        echo        File .env creato da .env.example
        echo        Puoi personalizzarlo in seguito modificando il file .env
    ) else (
        echo.
        echo  [ATTENZIONE] File .env.example non trovato!
        echo  Continuazione senza file .env, verranno usati i valori di default.
        echo.
    )
) else (
    echo        File .env gia' presente, nessuna modifica.
)

:: ------------------------------------------------------------
:: Step 4: Scelta della modalita'
:: ------------------------------------------------------------
echo.
echo [4/6] Scegli la modalita' di installazione:
echo.
echo   [1] Tutto in Docker (consigliato)
echo       Installa sia Ollama che Open WebUI in Docker.
echo       Scegli questa opzione se NON hai Ollama installato.
echo.
echo   [2] Modalita' ibrida
echo       Installa solo Open WebUI in Docker.
echo       Scegli questa opzione se hai GIA' Ollama installato sul PC.
echo.

set /p "scelta=Inserisci la tua scelta (1 o 2): "

if "%scelta%"=="1" (
    set "COMPOSE_FILE=docker-compose.full.yml"
    set "MODALITA=Full Docker"
) else if "%scelta%"=="2" (
    set "COMPOSE_FILE=docker-compose.hybrid.yml"
    set "MODALITA=Ibrida"
) else (
    echo.
    echo  [ERRORE] Scelta non valida! Inserisci 1 o 2.
    echo.
    popd
    goto :fine
)

echo.
echo        Modalita' selezionata: !MODALITA!

:: ------------------------------------------------------------
:: Step 5: Avvio dei container
:: ------------------------------------------------------------
echo [5/6] Avvio dei container Docker...
echo        File compose: !COMPOSE_FILE!
echo.

docker compose -f "!COMPOSE_FILE!" up -d
if %errorlevel% neq 0 (
    echo.
    echo  [ERRORE] Avvio dei container fallito!
    echo.
    echo  Possibili cause:
    echo    - Le porte 3000 o 11434 sono gia' in uso
    echo    - Docker Desktop non ha abbastanza risorse
    echo    - Problemi di rete nel download delle immagini
    echo.
    echo  Prova a controllare con: docker compose -f !COMPOSE_FILE! logs
    echo.
    popd
    goto :fine
)

:: Attendi che i container si avviino
echo.
echo        Attendo 15 secondi per l'avvio dei servizi...
timeout /t 15 /nobreak >nul

:: ------------------------------------------------------------
:: Step 6: Verifica stato dei container
:: ------------------------------------------------------------
echo [6/6] Verifica stato dei container...
echo.

docker compose -f "!COMPOSE_FILE!" ps

:: Verifica che open-webui sia attivo
docker ps --filter "name=open-webui" --format "{{.Status}}" | findstr /i "Up" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  [ERRORE] Il container open-webui non sembra attivo.
    echo.
    echo  Controlla i log con:
    echo    docker compose -f !COMPOSE_FILE! logs open-webui
    echo.
    popd
    goto :fine
)

:: ------------------------------------------------------------
:: Setup completato
:: ------------------------------------------------------------
echo.
echo ============================================================
echo    SETUP COMPLETATO CON SUCCESSO!
echo ============================================================
echo.
echo  Apri il browser su: http://localhost:3000
echo.
echo  Al primo accesso, crea il tuo account admin.
echo  Il primo utente registrato diventa automaticamente
echo  amministratore della piattaforma.
echo.

:: Se modalita' full, scarica il modello di default
if "%scelta%"=="1" (
    echo ============================================================
    echo    DOWNLOAD MODELLO AI
    echo ============================================================
    echo.
    echo  Scaricamento modello in corso... potrebbe richiedere qualche minuto.
    echo  Modello: llama3.2:3b (~2GB)
    echo.
    echo  Non chiudere questa finestra fino al completamento!
    echo.
    docker exec ollama ollama pull llama3.2:3b
    if %errorlevel% equ 0 (
        echo.
        echo  Modello scaricato con successo!
        echo  Puoi iniziare a chattare su http://localhost:3000
    ) else (
        echo.
        echo  [ATTENZIONE] Download del modello fallito.
        echo  Puoi scaricarlo manualmente in seguito con:
        echo    docker exec ollama ollama pull llama3.2:3b
    )
    echo.
)

popd

:fine
echo.
pause
