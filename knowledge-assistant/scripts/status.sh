#!/bin/bash
# ============================================================
# Controlla lo stato dei container Knowledge Assistant (macOS)
# ============================================================

echo ""
echo "============================================================"
echo "   KNOWLEDGE ASSISTANT - Stato Servizi"
echo "============================================================"
echo ""

docker ps --filter "name=ollama" --filter "name=open-webui" \
    --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""

# Verifica se ci sono container attivi
if ! docker ps --filter "name=ollama" --filter "name=open-webui" --format "{{.Names}}" | grep -q .; then
    echo "  Nessun container attivo."
    echo ""
    echo "  Avvia i servizi con:"
    echo "    ./scripts/start-full.sh    (modalità Full Docker)"
    echo "    ./scripts/start-hybrid.sh  (modalità Ibrida)"
fi

echo ""
