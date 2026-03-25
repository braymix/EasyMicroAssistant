#!/bin/bash
# ============================================================
# Avvia la Dashboard di Knowledge Assistant (macOS / Linux)
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo ""
echo "============================================================"
echo "   KNOWLEDGE ASSISTANT - Dashboard"
echo "============================================================"
echo ""

# Controlla che Python 3 sia installato
if ! command -v python3 &>/dev/null; then
    echo "  [ERRORE] Python 3 non trovato."
    echo ""
    echo "  macOS: Python 3 è preinstallato da macOS 12+."
    echo "  Se manca, installa Xcode Command Line Tools:"
    echo "    xcode-select --install"
    echo ""
    exit 1
fi

PY_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
echo "  Python $PY_VER trovato."
echo ""

# Controlla se la porta 8765 è già in uso
if lsof -i :8765 -t &>/dev/null 2>&1; then
    echo "  La dashboard è già in esecuzione su http://localhost:8765"
    echo ""
    # Prova ad aprire il browser comunque
    if command -v open &>/dev/null; then
        open http://localhost:8765
    fi
    exit 0
fi

echo "  Avvio del server su http://localhost:8765 ..."
echo "  (Premi Ctrl+C per fermare)"
echo ""

# Avvia il server in background e apri il browser
cd "$PROJECT_DIR"
python3 dashboard/server.py &
SERVER_PID=$!

# Aspetta che il server sia pronto (max 5 secondi)
for i in 1 2 3 4 5; do
    sleep 1
    if curl -s http://localhost:8765 &>/dev/null; then
        break
    fi
done

# Apri il browser
if command -v open &>/dev/null; then
    open http://localhost:8765
elif command -v xdg-open &>/dev/null; then
    xdg-open http://localhost:8765
fi

echo "  Dashboard aperta su http://localhost:8765"
echo "  PID server: $SERVER_PID"
echo ""
echo "  Per fermare: kill $SERVER_PID  oppure  Ctrl+C"
echo ""

# Tieni lo script in esecuzione per gestire Ctrl+C
wait $SERVER_PID
