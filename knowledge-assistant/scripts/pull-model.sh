#!/bin/bash
# ============================================================
# Scarica un modello AI per Ollama (macOS)
# ============================================================

echo ""
echo "============================================================"
echo "   KNOWLEDGE ASSISTANT - Download Modello"
echo "============================================================"
echo ""
echo "  Modelli consigliati:"
echo "    - llama3.2:3b        (leggero, ~2GB, buono per iniziare)"
echo "    - mistral             (bilanciato, ~4GB)"
echo "    - qwen2.5-coder:7b   (ottimo per il codice, ~4.5GB)"
echo "    - llama3.2:8b         (più potente, ~4.7GB)"
echo ""
echo "  Lista completa: https://ollama.com/library"
echo ""

read -rp "Inserisci il nome del modello da scaricare: " modello

if [ -z "$modello" ]; then
    echo ""
    echo "  [ERRORE] Nessun modello specificato."
    echo ""
    exit 1
fi

echo ""
echo "  Scaricamento di '$modello' in corso..."
echo "  Potrebbe richiedere qualche minuto."
echo ""

# Prova prima tramite container Docker
if docker ps --filter "name=ollama" --format "{{.Names}}" 2>/dev/null | grep -q "ollama"; then
    echo "  Rilevato container Ollama, uso Docker..."
    echo ""
    docker exec ollama ollama pull "$modello"
else
    # Fallback: Ollama nativo
    echo "  Container Ollama non trovato, uso Ollama nativo..."
    echo ""
    if ! command -v ollama &>/dev/null; then
        echo "  [ERRORE] Ollama non trovato né in Docker né installato."
        echo "  Avvia i container con ./scripts/start-full.sh"
        echo "  Oppure installa Ollama da: https://ollama.com/download"
        echo ""
        exit 1
    fi
    ollama pull "$modello"
fi

if [ $? -eq 0 ]; then
    echo ""
    echo "  Modello '$modello' scaricato con successo!"
    echo "  Puoi selezionarlo nell'interfaccia su http://localhost:3000"
else
    echo ""
    echo "  [ERRORE] Download fallito."
    echo "  Verifica il nome del modello e riprova."
fi
echo ""
