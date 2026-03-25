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

:: REM --- Continua con CHECK 4 e 5 ---
