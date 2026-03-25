#!/bin/bash
# ============================================================
# Avvia Knowledge Assistant - Modalità Full Docker (macOS)
# Ollama + Open WebUI entrambi in Docker
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$(dirname "$SCRIPT_DIR")"

echo ""
echo "============================================================"
echo "   KNOWLEDGE ASSISTANT - Avvio Full Docker"
echo "============================================================"
echo ""
echo "  Avvio dei container in corso..."
echo ""

docker compose -f docker-compose.full.yml up -d
if [ $? -ne 0 ]; then
    echo ""
    echo "  [ERRORE] Avvio fallito!"
    echo "  Controlla che Docker Desktop sia in esecuzione."
    echo ""
    exit 1
fi

echo ""
echo "============================================================"
echo "   Avviato! Apri http://localhost:3000"
echo "============================================================"
echo ""
