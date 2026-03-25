#!/bin/bash
# ============================================================
# Backup dati Knowledge Assistant (macOS)
# Esporta il volume Docker open-webui in un file compresso
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$(dirname "$SCRIPT_DIR")"

echo ""
echo "============================================================"
echo "   KNOWLEDGE ASSISTANT - Backup Dati"
echo "============================================================"
echo ""

# Step 1: Crea cartella backups
echo "[1/3] Preparo la cartella di backup..."
mkdir -p backups
echo "       Cartella 'backups' pronta."
echo ""

# Step 2: Genera timestamp YYYYMMDD
echo "[2/3] Genero il timestamp del backup..."
DATESTR=$(date +%Y%m%d)
BACKUP_FILE="openwebui-backup-${DATESTR}.tar.gz"

echo "       Data: $DATESTR"
echo "       File: $BACKUP_FILE"
echo ""

# Step 3: Esporta il volume
echo "[3/3] Eseguo il backup del volume..."
echo "       Questo potrebbe richiedere un po' di tempo..."
echo ""

docker run --rm \
    -v open-webui:/data \
    -v "$(pwd)/backups":/backup \
    alpine tar czf "/backup/$BACKUP_FILE" /data

if [ $? -ne 0 ]; then
    echo ""
    echo "  [ERRORE] Il backup è fallito!"
    echo ""
    echo "  Possibili cause:"
    echo "    - Docker non è in esecuzione"
    echo "    - Il volume 'open-webui' non esiste"
    echo ""
    echo "  Verifica lo stato con: ./scripts/status.sh"
    echo ""
    exit 1
fi

echo ""
echo "============================================================"
echo "   ✓ BACKUP COMPLETATO CON SUCCESSO!"
echo "============================================================"
echo ""
echo "  Backup salvato in: backups/$BACKUP_FILE"
echo ""

# Mostra dimensione
if [ -f "backups/$BACKUP_FILE" ]; then
    SIZE=$(du -sh "backups/$BACKUP_FILE" | cut -f1)
    echo "  Dimensione: $SIZE"
fi

echo ""
echo "  Suggerimenti:"
echo "    - Copia il file in una cartella esterna per sicurezza"
echo "    - Mantieni più backup recenti per proteggerti da errori"
echo ""
