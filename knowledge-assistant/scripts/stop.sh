#!/bin/bash
# ============================================================
# Ferma tutti i servizi Knowledge Assistant (macOS)
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$(dirname "$SCRIPT_DIR")"

echo ""
echo "============================================================"
echo "   KNOWLEDGE ASSISTANT - Arresto Servizi"
echo "============================================================"
echo ""

echo "  Arresto configurazione Full Docker..."
docker compose -f docker-compose.full.yml down 2>/dev/null

echo ""
echo "  Arresto configurazione Ibrida..."
docker compose -f docker-compose.hybrid.yml down 2>/dev/null

echo ""
echo "============================================================"
echo "   Tutti i servizi fermati."
echo "============================================================"
echo ""
