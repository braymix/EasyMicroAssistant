# Quick Start — Knowledge Assistant

**Tempo stimato: 20-30 minuti al primo avvio**

---

## Cosa Ti Serve

- Windows 10/11 · Minimo 8 GB RAM · 15 GB disco libero
- Connessione internet (solo per il download iniziale)

---

## Avvio in 5 Step

**Step 1 — Installa Docker Desktop**
1. Vai su **https://www.docker.com/products/docker-desktop/**
2. Scarica e installa per Windows
3. Se compare "Use WSL 2" → metti la spunta ✅
4. **Riavvia il PC**
5. Aspetta che l'icona della balena 🐳 nel system tray diventi verde

**Step 2 — Scarica il Progetto**
- Estrai lo ZIP ricevuto in una cartella (es. `C:\Progetti\knowledge-assistant`)
- Oppure via Git: `git clone -b master https://github.com/braymix/easymicroassistant.git`

**Step 3 — Avvia il Setup**
1. Apri la cartella `scripts`
2. Doppio click su **`setup-windows.bat`**
3. Quando chiede la modalità → digita `1` e premi Invio
4. Aspetta 10-15 minuti (download immagini + modello AI)
5. Vedrai: **"SETUP COMPLETATO!"** ✅

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

| Cosa fare | Script |
|-----------|--------|
| Avviare il sistema | `scripts\start-full.bat` |
| Fermare il sistema | `scripts\stop.bat` |
| Verificare stato | `scripts\status.bat` |
| Scaricare un modello | `scripts\pull-model.bat` |
| Fare un backup | `scripts\backup.bat` |
| Diagnostica errori | `scripts\test-setup.bat` |

---

## Problemi Frequenti

| Problema | Soluzione |
|---------|-----------|
| Pagina non si apre | Avvia Docker Desktop, aspetta balena verde, poi `start-full.bat` |
| Nessun modello | Esegui `pull-model.bat` → `llama3.2:3b` |
| Risposte lente | Usa modello più piccolo (`3b` invece di `8b`) |
| KB non trova info | Verifica spunta ✅ sul file in Workspace → Knowledge |

---

> **Guide complete:** `docs/GUIDA-UTENTI.md` · **Architettura tecnica:** `README.md`
