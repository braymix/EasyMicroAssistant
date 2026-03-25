@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM Avvia la Dashboard di Knowledge Assistant (Windows)
REM ============================================================

cd /d "%~dp0.."

echo.
echo ============================================================
echo    KNOWLEDGE ASSISTANT - Dashboard
echo ============================================================
echo.

REM Controlla che Python sia installato
python --version >nul 2>&1
if errorlevel 1 (
    py --version >nul 2>&1
    if errorlevel 1 (
        echo   [ERRORE] Python non trovato.
        echo.
        echo   Installa Python da: https://www.python.org/downloads/
        echo   Oppure via winget:
        echo     winget install Python.Python.3
        echo.
        echo   Assicurati di spuntare "Add Python to PATH" durante l'installazione.
        echo.
        pause
        exit /b 1
    )
    set PYTHON_CMD=py
) else (
    set PYTHON_CMD=python
)

REM Mostra versione Python
for /f "tokens=*" %%i in ('!PYTHON_CMD! --version 2^>^&1') do echo   %%i trovato.
echo.

REM Controlla se la porta 8765 e' gia' in uso
netstat -an | findstr ":8765" | findstr "LISTEN" >nul 2>&1
if not errorlevel 1 (
    echo   La dashboard e' gia' in esecuzione su http://localhost:8765
    echo.
    start http://localhost:8765
    exit /b 0
)

echo   Avvio del server su http://localhost:8765 ...
echo   (Chiudi questa finestra o premi Ctrl+C per fermare)
echo.

REM Apri il browser dopo 2 secondi (in background)
start "" cmd /c "timeout /t 2 /nobreak >nul && start http://localhost:8765"

REM Avvia il server (in primo piano, Ctrl+C per fermare)
!PYTHON_CMD! dashboard\server.py

echo.
echo   Server fermato.
pause
