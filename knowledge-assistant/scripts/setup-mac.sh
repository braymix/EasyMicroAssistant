#!/bin/bash
# ============================================================
# Setup automatico Knowledge Assistant per macOS
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
PASS=0

echo ""
echo "============================================================"
echo "   KNOWLEDGE ASSISTANT - Setup Automatico (macOS)"
echo "============================================================"
echo ""

# ----------------------------------------
# Step 1: Verifica Docker installato
# ----------------------------------------
echo "[1/6] Verifica installazione Docker..."
if ! command -v docker &>/dev/null; then
    echo ""
    echo "  [ERRORE] Docker non trovato!"
    echo ""
    echo "  Scaricalo da: https://www.docker.com/products/docker-desktop/"
    echo "  Oppure via Homebrew: brew install --cask docker"
    echo ""
    exit 1
fi
echo "       Docker trovato."

# ----------------------------------------
# Step 2: Verifica Docker in esecuzione
# ----------------------------------------
echo "[2/6] Verifica che Docker Desktop sia in esecuzione..."
if ! docker info &>/dev/null; then
    echo ""
    echo "  [ERRORE] Docker Desktop non è in esecuzione!"
    echo ""
    echo "  Avvia Docker Desktop dal Launchpad o da /Applications/Docker.app"
    echo "  Attendi che l'icona nella menu bar smetta di animarsi."
    echo ""
    exit 1
fi
echo "       Docker Desktop in esecuzione."

# ----------------------------------------
# Step 3: Copia .env.example → .env
# ----------------------------------------
echo "[3/6] Configurazione variabili d'ambiente..."
cd "$PROJECT_DIR"

if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo "       File .env creato da .env.example"
    else
        echo "  [ATTENZIONE] .env.example non trovato, si usano valori di default."
    fi
else
    echo "       File .env già presente, nessuna modifica."
fi

# ----------------------------------------
# Step 4: Scelta modalità
# ----------------------------------------
echo ""
echo "[4/6] Scegli la modalità di installazione:"
echo ""
echo "  [1] Tutto in Docker (consigliato)"
echo "      Installa sia Ollama che Open WebUI in Docker."
echo ""
echo "  [2] Modalità ibrida"
echo "      Solo Open WebUI in Docker, Ollama nativo."
echo ""
read -rp "Inserisci la tua scelta (1 o 2): " scelta

case "$scelta" in
    1)
        COMPOSE_FILE="docker-compose.full.yml"
        MODALITA="Full Docker"
        ;;
    2)
        COMPOSE_FILE="docker-compose.hybrid.yml"
        MODALITA="Ibrida"
        ;;
    *)
        echo ""
        echo "  [ERRORE] Scelta non valida. Inserisci 1 o 2."
        echo ""
        exit 1
        ;;
esac

echo ""
echo "       Modalità selezionata: $MODALITA"

# ----------------------------------------
# Step 5: Avvio container
# ----------------------------------------
echo "[5/6] Avvio dei container Docker..."
echo ""
docker compose -f "$COMPOSE_FILE" up -d
if [ $? -ne 0 ]; then
    echo ""
    echo "  [ERRORE] Avvio dei container fallito!"
    echo "  Controlla i log con: docker compose -f $COMPOSE_FILE logs"
    echo ""
    exit 1
fi

echo ""
echo "       Attendo 15 secondi per l'avvio dei servizi..."
sleep 15

# ----------------------------------------
# Step 6: Verifica stato
# ----------------------------------------
echo "[6/6] Verifica stato dei container..."
echo ""
docker compose -f "$COMPOSE_FILE" ps

if ! docker ps --filter "name=open-webui" --format "{{.Status}}" | grep -qi "up"; then
    echo ""
    echo "  [ERRORE] Il container open-webui non sembra attivo."
    echo "  Controlla: docker compose -f $COMPOSE_FILE logs open-webui"
    echo ""
    exit 1
fi

# ----------------------------------------
# Setup completato
# ----------------------------------------
echo ""
echo "============================================================"
echo "   SETUP COMPLETATO CON SUCCESSO!"
echo "============================================================"
echo ""
echo "  Apri il browser su: http://localhost:3000"
echo ""
echo "  Al primo accesso, crea il tuo account admin."
echo ""

# Pull modello di default (solo modalità full)
if [ "$scelta" = "1" ]; then
    echo "============================================================"
    echo "   DOWNLOAD MODELLO AI"
    echo "============================================================"
    echo ""
    echo "  Scaricamento modello: llama3.2:3b (~2GB)"
    echo "  Non chiudere questo terminale fino al completamento."
    echo ""
    docker exec ollama ollama pull llama3.2:3b
    if [ $? -eq 0 ]; then
        echo ""
        echo "  Modello scaricato. Puoi iniziare su http://localhost:3000"
    else
        echo ""
        echo "  [ATTENZIONE] Download fallito. Riprova con:"
        echo "    ./scripts/pull-model.sh"
    fi
    echo ""
fi
