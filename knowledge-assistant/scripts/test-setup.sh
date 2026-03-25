#!/bin/bash
# ============================================================
# Test Setup Knowledge Assistant (macOS)
# Verifica che tutto sia configurato correttamente
# ============================================================

PASS=0
TOTAL=5

echo ""
echo "============================================================"
echo "   === Test Setup Knowledge Assistant ==="
echo "============================================================"
echo ""
echo "Eseguo i controlli di sistema..."
echo ""

# ----------------------------------------
# CHECK 1: Docker installato?
# ----------------------------------------
echo "[CHECK 1/5] Verifica installazione Docker..."
if command -v docker &>/dev/null; then
    echo "[OK] Docker installato ($(docker --version | cut -d' ' -f3 | tr -d ','))"
    PASS=$((PASS + 1))
else
    echo "[ERRORE] Docker non installato"
    echo ""
    echo "  Scaricalo da: https://www.docker.com/products/docker-desktop/"
    echo "  Oppure: brew install --cask docker"
    echo ""
fi

# ----------------------------------------
# CHECK 2: Docker in esecuzione?
# ----------------------------------------
echo "[CHECK 2/5] Verifica che Docker Desktop sia in esecuzione..."
if docker info &>/dev/null; then
    echo "[OK] Docker Desktop in esecuzione"
    PASS=$((PASS + 1))
else
    echo "[ERRORE] Docker Desktop non in esecuzione"
    echo ""
    echo "  Avvia Docker Desktop dal Launchpad o da Applicazioni."
    echo "  Attendi che l'icona nella menu bar smetta di animarsi."
    echo ""
fi

# ----------------------------------------
# CHECK 3: Container Open WebUI attivo?
# ----------------------------------------
echo "[CHECK 3/5] Verifica che il container Open WebUI sia attivo..."
if docker ps --filter "name=open-webui" --format "{{.Names}}" | grep -q "open-webui"; then
    echo "[OK] Container Open WebUI attivo"
    PASS=$((PASS + 1))
else
    echo "[ERRORE] Container Open WebUI non attivo"
    echo ""
    echo "  Avvia i servizi con:"
    echo "    ./scripts/start-full.sh"
    echo "    ./scripts/start-hybrid.sh"
    echo ""
fi

# ----------------------------------------
# CHECK 4: Ollama raggiungibile?
# ----------------------------------------
echo "[CHECK 4/5] Verifica che Ollama sia raggiungibile..."
if docker ps --filter "name=ollama" --format "{{.Names}}" | grep -q "ollama"; then
    echo "[OK] Ollama attivo (container Docker)"
    PASS=$((PASS + 1))
elif curl -s --max-time 5 http://localhost:11434 &>/dev/null; then
    echo "[OK] Ollama attivo (installazione nativa)"
    PASS=$((PASS + 1))
else
    echo "[ERRORE] Ollama non raggiungibile"
    echo ""
    echo "  Prova uno di questi:"
    echo "    - Avvia Ollama dal Launchpad (se installato)"
    echo "    - Oppure: ./scripts/start-full.sh"
    echo ""
fi

# ----------------------------------------
# CHECK 5: Almeno un modello disponibile?
# ----------------------------------------
echo "[CHECK 5/5] Verifica che almeno un modello sia scaricato..."

MODEL_FOUND=false

# Prova via Docker
if docker ps --filter "name=ollama" --format "{{.Names}}" | grep -q "ollama"; then
    COUNT=$(docker exec ollama ollama list 2>/dev/null | tail -n +2 | grep -c .)
    if [ "$COUNT" -gt 0 ]; then
        echo "[OK] Modelli disponibili (Docker)"
        echo ""
        docker exec ollama ollama list 2>/dev/null
        echo ""
        PASS=$((PASS + 1))
        MODEL_FOUND=true
    fi
fi

# Prova nativo
if [ "$MODEL_FOUND" = false ] && command -v ollama &>/dev/null; then
    COUNT=$(ollama list 2>/dev/null | tail -n +2 | grep -c .)
    if [ "$COUNT" -gt 0 ]; then
        echo "[OK] Modelli disponibili (nativo)"
        echo ""
        ollama list 2>/dev/null
        echo ""
        PASS=$((PASS + 1))
        MODEL_FOUND=true
    fi
fi

if [ "$MODEL_FOUND" = false ]; then
    echo "[ERRORE] Nessun modello scaricato"
    echo ""
    echo "  Scarica un modello:"
    echo "    ./scripts/pull-model.sh"
    echo "  Modello consigliato: llama3.2:3b"
    echo ""
fi

# ----------------------------------------
# Riepilogo
# ----------------------------------------
echo ""
echo "============================================================"
echo "   === Riepilogo ==="
echo "============================================================"
echo ""
echo "$PASS/$TOTAL controlli superati"
echo ""

if [ "$PASS" -eq "$TOTAL" ]; then
    echo "✓ Tutto funziona perfettamente!"
    echo ""
    echo "  Apri il browser su: http://localhost:3000"
else
    echo "✗ Ci sono problemi da risolvere."
    echo ""
    echo "  Leggi gli errori sopra e segui i suggerimenti."
    echo "  Se il problema persiste, contatta il team."
fi
echo ""
