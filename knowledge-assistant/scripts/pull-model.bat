@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: ============================================================
:: Scarica un modello AI per Ollama
:: ============================================================

echo.
echo ============================================================
echo    KNOWLEDGE ASSISTANT - Download Modello
echo ============================================================
echo.
echo  Modelli consigliati:
echo    - llama3.2:3b        (leggero, ~2GB, buono per iniziare)
echo    - mistral             (bilanciato, ~4GB)
echo    - qwen2.5-coder:7b   (ottimo per il codice, ~4.5GB)
echo    - llama3.2:8b         (piu' potente, ~4.7GB)
echo.
echo  Lista completa: https://ollama.com/library
echo.

set /p "modello=Inserisci il nome del modello da scaricare: "

if "%modello%"=="" (
    echo.
    echo  [ERRORE] Nessun modello specificato!
    echo.
    goto :fine
)

echo.
echo  Scaricamento di "%modello%" in corso...
echo  Potrebbe richiedere qualche minuto a seconda della dimensione.
echo.

:: Prova prima tramite il container Docker (modalita' full)
docker ps --filter "name=ollama" --format "{{.Names}}" 2>nul | findstr /i "ollama" >nul 2>&1
if %errorlevel% equ 0 (
    echo  Rilevato container Ollama, uso Docker...
    echo.
    docker exec ollama ollama pull %modello%
) else (
    echo  Container Ollama non trovato, uso Ollama nativo...
    echo.
    where ollama >nul 2>&1
    if %errorlevel% neq 0 (
        echo  [ERRORE] Ollama non trovato ne' in Docker ne' installato!
        echo  Avvia i container con start-full.bat oppure installa Ollama.
        echo.
        goto :fine
    )
    ollama pull %modello%
)

if %errorlevel% equ 0 (
    echo.
    echo  Modello "%modello%" scaricato con successo!
    echo  Puoi selezionarlo nell'interfaccia di Open WebUI.
) else (
    echo.
    echo  [ERRORE] Download del modello fallito.
    echo  Verifica il nome del modello e riprova.
)

echo.

:fine
pause
