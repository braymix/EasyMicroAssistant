# Quick Start — Knowledge Assistant

**Tempo stimato: 20-30 minuti al primo avvio**

---

## Cosa Ti Serve

- Windows 10/11 oppure macOS 12+ · Minimo 8 GB RAM · 15 GB disco libero
- Connessione internet (solo per il download iniziale)

---

## Avvio in 5 Step

**Step 1 — Installa Docker Desktop**
1. Vai su **https://www.docker.com/products/docker-desktop/**
2. Scarica la versione per il tuo sistema operativo
3. **Windows:** installa il `.exe` — se compare "Use WSL 2" → spunta ✅ — poi **riavvia il PC**
4. **macOS:** trascina Docker in Applicazioni, aprilo e accetta i permessi
5. Aspetta che l'icona della balena 🐳 (Windows: system tray / macOS: menu bar) diventi verde

**Step 2 — Scarica il Progetto**
- Estrai lo ZIP ricevuto in una cartella (es. `C:\Progetti\knowledge-assistant` o `~/Progetti/knowledge-assistant`)
- Oppure via Git: `git clone -b main https://github.com/braymix/easymicroassistant.git`

**Step 3 — Avvia il Setup**

🪟 **Windows:** nella cartella `scripts`, doppio click su **`setup-windows.bat`**

🍎 **macOS:** apri il Terminale nella cartella del progetto e lancia:
```bash
chmod +x scripts/*.sh && ./scripts/setup-mac.sh
```

Quando chiede la modalità → digita `1` e premi Invio. Aspetta 10-15 minuti.

Vedrai: **"SETUP COMPLETATO!"** ✅

**Step 4 — Apri l'Interfaccia**
1. Apri il browser
2. Vai su: **http://localhost:3000**
3. Clicca **"Sign Up"** e crea il tuo account
   > ⚠️ Il primo account diventa admin. I dati restano sul tuo PC.

**Step 5 — Scarica un Modello AI (se non fatto automaticamente)**
1. In alto a sinistra clicca **"Select a model"**
2. Scrivi `llama3.2:3b` e clicca **"Pull"**
3. Aspetta il download (~2 GB)

---

## Usare la Knowledge Base

1. **Crea la KB:** Workspace → Knowledge → `+` → dai un nome (es. "Byblos") → Create
2. **Carica documenti:** Clicca `+` dentro la KB → Upload Files → scegli PDF/TXT/MD
3. **Usa in chat:** Scrivi `#` nel campo messaggio → seleziona la KB → fai la domanda

---

## Comandi Rapidi

| Azione | Windows | macOS |
|--------|---------|-------|
| Avviare il sistema | `scripts\start-full.bat` | `./scripts/start-full.sh` |
| Fermare il sistema | `scripts\stop.bat` | `./scripts/stop.sh` |
| Verificare stato | `scripts\status.bat` | `./scripts/status.sh` |
| Scaricare un modello | `scripts\pull-model.bat` | `./scripts/pull-model.sh` |
| Fare un backup | `scripts\backup.bat` | `./scripts/backup.sh` |
| Diagnostica errori | `scripts\test-setup.bat` | `./scripts/test-setup.sh` |

---

## Problemi Frequenti

| Problema | Soluzione |
|---------|-----------|
| Pagina non si apre | Avvia Docker Desktop, aspetta balena verde 🐳, poi lancia `start-full` |
| Nessun modello | Esegui `pull-model` → scrivi `llama3.2:3b` |
| Risposte lente | Usa modello più piccolo (`3b` invece di `8b`) |
| KB non trova info | Verifica spunta ✅ sul file in Workspace → Knowledge |
| macOS: "permesso negato" sullo script | Lancia: `chmod +x scripts/*.sh` |

---

> **Guide complete:** `docs/GUIDA-UTENTI.md` · **Architettura tecnica:** `README.md`
