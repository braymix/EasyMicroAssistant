@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: ============================================================
:: Script di Backup - Knowledge Assistant
:: Esporta il volume Docker open-webui in un file compresso
:: ============================================================

echo.
echo ============================================================
echo    KNOWLEDGE ASSISTANT - Backup Dati
echo ============================================================
echo.

:: Risali alla cartella root del progetto (da scripts/ a knowledge-assistant/)
pushd "%~dp0.."

:: ============================================================
:: Step 1: Crea la cartella "backups" se non esiste
:: ============================================================
echo [1/3] Preparo la cartella di backup...

if not exist "backups" (
    mkdir "backups"
    echo        Cartella "backups" creata
) else (
    echo        Cartella "backups" gia' presente
)

echo.

:: ============================================================
:: Step 2: Genera la data nel formato YYYYMMDD
:: ============================================================
echo [2/3] Genero il timestamp del backup...

for /f %%a in ('wmic os get localdatetime ^| find "2"') do set dt=%%a
set DATESTR=%dt:~0,8%

if "%DATESTR%"=="" (
    echo [ERRORE] Non riesco a generare la data
    echo Usa manualmente: openwebui-backup-YYYYMMDD.tar.gz
    popd
    goto :fine
)

set BACKUP_FILE=openwebui-backup-!DATESTR!.tar.gz

echo        Data: !DATESTR!
echo        File: !BACKUP_FILE!

echo.

:: ============================================================
:: Step 3: Esegui il backup del volume Docker
:: ============================================================
echo [3/3] Eseguo il backup del volume...
echo        Questo potrebbe richiedere un po' di tempo...
echo.

docker run --rm -v open-webui:/data -v "%CD%\backups":/backup alpine tar czf /backup/!BACKUP_FILE! /data

if %errorlevel% neq 0 (
    echo.
    echo [ERRORE] Il backup e' fallito!
    echo.
    echo Possibili cause:
    echo   - Docker non e' in esecuzione (avvia Docker Desktop)
    echo   - Il volume "open-webui" non esiste
    echo   - Errore di permessi
    echo.
    echo Prova a controllare con: scripts\status.bat
    echo.
    popd
    goto :fine
)

echo.
echo ============================================================
echo    ✓ BACKUP COMPLETATO CON SUCCESSO!
echo ============================================================
echo.

:: ============================================================
:: Step 4: Mostra la dimensione del backup
:: ============================================================
echo Backup salvato in: backups\!BACKUP_FILE!
echo.

if exist "backups\!BACKUP_FILE!" (
    for %%A in ("backups\!BACKUP_FILE!") do (
        set SIZE=%%~zA
        if !SIZE! geq 1073741824 (
            for /f %%B in ('powershell -Command "[math]::Round(%%~zA / 1GB, 2)"') do (
                echo Dimensione: %%B GB
            )
        ) else if !SIZE! geq 1048576 (
            for /f %%B in ('powershell -Command "[math]::Round(%%~zA / 1MB, 2)"') do (
                echo Dimensione: %%B MB
            )
        ) else (
            echo Dimensione: !SIZE! byte
        )
    )
) else (
    echo [ATTENZIONE] File di backup non trovato!
)

echo.
echo Suggerimenti:
echo   - Copia questo file in una cartella esterna per sicurezza
echo   - Mantieni piu' backup recenti per proteggerti da errori
echo   - Per ripristinare: copia il file backup esterno e estrai
echo.

popd

:fine
pause
