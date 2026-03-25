@echo off
chcp 65001 >nul 2>&1

:: ============================================================
:: Ferma tutti i servizi Knowledge Assistant
:: ============================================================

echo.
echo ============================================================
echo    KNOWLEDGE ASSISTANT - Arresto Servizi
echo ============================================================
echo.

:: Risali alla cartella root del progetto
pushd "%~dp0.."

echo  Arresto configurazione Full Docker...
docker compose -f docker-compose.full.yml down 2>nul

echo.
echo  Arresto configurazione Ibrida...
docker compose -f docker-compose.hybrid.yml down 2>nul

echo.
echo ============================================================
echo    Tutti i servizi fermati.
echo ============================================================
echo.

popd

pause
