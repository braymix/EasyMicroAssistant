#!/bin/bash
# ============================================================
# Avvia Knowledge Assistant - Modalità Ibrida (macOS)
# Solo Open WebUI in Docker, Ollama nativo sull'host
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$(dirname "$SCRIPT_DIR")"

echo ""
echo "============================================================"
echo "   KNOWLEDGE ASSISTANT - Avvio Modalità Ibrida"
echo "============================================================"
echo ""

# Verifica che Ollama nativo sia raggiungibile
echo "  Verifica connessione a Ollama su localhost:11434..."
echo ""

if ! curl -s --max-time 5 http://localhost:11434 &>/dev/null; then
    echo "  [ERRORE] Ollama non raggiungibile su localhost:11434!"
    echo ""
    echo "  Avvia Ollama prima di procedere:"
    echo "    - Apri Ollama dal Launchpad"
    echo "    - Oppure da terminale: ollama serve"
    echo "    - Se non lo hai: https://ollama.com/download"
    echo ""
    exit 1
fi

echo "       Ollama raggiungibile."
echo ""
echo "  Avvio di Open WebUI in corso..."
echo ""

docker compose -f docker-compose.hybrid.yml up -d
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
