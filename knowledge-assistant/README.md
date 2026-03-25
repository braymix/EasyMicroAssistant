# Knowledge Assistant - Setup Locale con AI

## Cos'è

Ambiente Docker per avere un assistente AI locale specializzato sui tuoi progetti.
Carichi documentazione, appunti, decisioni architetturali → lui risponde basandosi su quelli.

Niente cloud, niente account, niente limiti di token. Tutto in locale, tutto tuo.

**Stack:**
- **Ollama** - Motore per far girare modelli AI (llama, mistral, qwen, ecc.)
- **Open WebUI** - Interfaccia web per chattare con i modelli

Puoi scegliere tra due setup:
- **Full Docker** - Sia Ollama che Open WebUI girano in container
- **Ibrido** - Solo Open WebUI in Docker, Ollama nativo sul tuo PC

---

## Requisiti

- **Windows 10/11** (64-bit)
- **Docker Desktop** - [Scarica qui](https://www.docker.com/products/docker-desktop/)
  - Nota: dopo l'installazione, riavvia il PC
- **RAM libera** - Minimo 8 GB (16 GB consigliato per modelli più grandi)
- **Spazio su disco** - Minimo 10 GB (i modelli occupano 2-6 GB ciascuno)
- **Connessione internet** - Solo per il primo download delle immagini e dei modelli

---

## Setup Rapido

1. **Scarica e installa Docker Desktop**
   - Vai su https://www.docker.com/products/docker-desktop/
   - Scarica per Windows
   - Segui l'installazione guidata
   - **Riavvia il PC** quando finisce

2. **Clona o scarica questa cartella**
   - Via git: `git clone <repo>`
   - Oppure: scarica come ZIP e estrai

3. **Doppio click su `scripts/setup-windows.bat`**
   - Si apre una finestra nera
   - Ti chiede quale modalità preferisci (Full Docker o Ibrida)
   - Parte automaticamente il download e l'avvio dei servizi

4. **Segui le istruzioni a schermo**
   - Lo script controlla tutto da solo
   - Se Docker non è avviato, te lo dice
   - Se tutto ok, dice "Setup completato!"

5. **Apri il browser su http://localhost:3000**
   - Se vedi la pagina di login di Open WebUI → tutto funziona
   - Registrati: il primo utente diventa admin
   - Puoi usare email fittizia se vuoi (es. `admin@localhost`)

---

## Comandi Utili

Questi script sono nella cartella `scripts/`. Li puoi usare quando serve.

| Script | Cosa fa | Quando usarlo |
|--------|---------|---------------|
| **setup-windows.bat** | Setup automatico completo | Prima volta, al primo avvio |
| **start-full.bat** | Avvia Ollama + Open WebUI in Docker | Quando vuoi iniziare a lavorare (modalità Full) |
| **start-hybrid.bat** | Avvia solo Open WebUI, usa Ollama nativo | Quando vuoi iniziare a lavorare (modalità Ibrida) |
| **stop.bat** | Ferma tutti i servizi | Prima di spegnere il PC o quando non usi più |
| **pull-model.bat** | Scarica un nuovo modello AI | Quando vuoi aggiungere modelli (mistral, qwen, ecc.) |
| **status.bat** | Mostra lo stato dei container | Per verificare se tutto gira come deve |

**Comandi manuali** (da PowerShell/CMD se preferisci):
```bash
# Avvio
docker compose -f docker-compose.full.yml up -d

# Arresto
docker compose -f docker-compose.full.yml down

# Scarica un modello
docker exec ollama ollama pull llama3.2:8b

# Vedi i log
docker compose -f docker-compose.full.yml logs open-webui
```

---

## Aggiornamento

### Aggiornare Open WebUI

1. **Ferma il servizio**
   - Esegui `scripts/stop.bat`

2. **Scarica l'ultima immagine**
   ```bash
   docker pull ghcr.io/open-webui/open-webui:main
   ```

3. **Riavvia**
   - Esegui `scripts/start-full.bat` (o `start-hybrid.bat` se usi la modalità ibrida)
   - I tuoi dati (chat, utenti, impostazioni) restano intatti

### Aggiornare Ollama

Se usi la **modalità Full Docker**:
1. Ferma con `scripts/stop.bat`
2. Scarica la nuova immagine: `docker pull ollama/ollama:latest`
3. Riavvia con `scripts/start-full.bat`

Se usi la **modalità Ibrida**:
1. Scarica Ollama da https://ollama.com/download
2. Installa e avvia normalmente (non c'è script, gira come programma Windows)

---

## FAQ / Problemi Comuni

| Problema | Causa | Soluzione |
|----------|-------|-----------|
| **"Non si apre la pagina http://localhost:3000"** | Docker Desktop non è avviato | Avvia Docker Desktop (icona della balena nel menu Start). Attendi che finisca l'avvio, poi riprova |
| **"Errore: Docker not found"** | Docker non è installato | Scarica e installa da https://www.docker.com/products/docker-desktop/. Riavvia il PC |
| **"Nessun modello disponibile nella chat"** | Non hai scaricato nessun modello | Esegui `scripts/pull-model.bat` e scarica almeno `llama3.2:3b` |
| **"Le risposte sono molto lente"** | Il modello è troppo grande per la tua RAM | Usa un modello più piccolo (3b invece di 8b). Vedi Comandi Utili |
| **"Connection error / Ollama non raggiungibile"** | Modalità ibrida, ma Ollama nativo non gira | Avvia Ollama dal menu Start come programma, oppure passa a Full Docker con `start-full.bat` |
| **"Le porte 3000 o 11434 sono già occupate"** | Un altro programma usa queste porte | Modifica la porta in `.env`: cambia `OPEN_WEBUI_PORT=3001` (o quella che vuoi) |
| **"Errore di storage / disco pieno"** | I modelli occupano troppo spazio | Elimina modelli inutili con `docker exec ollama ollama rm <nome>`, oppure libera spazio su disco |
| **"Primo login molto lento"** | Scaricamento modello in background | Aspetta qualche minuto. Puoi controllare i log con `scripts/status.bat` |

**Altre domande?**
- Apri una issue su GitHub
- O controlla i log: `docker compose logs -f`

---

Pronto? Passa al prossimo step! 🚀

---

## Come Caricare Documenti nella Knowledge Base

Una Knowledge Base è una raccolta di documenti su cui il modello può fare ricerche per rispondere alle tue domande in modo più accurato e specifico per i tuoi progetti.

### Creazione di una Knowledge Base

1. **Apri il menu "Workspace"**
   - Nella barra laterale sinistra, clicca su **"Workspace"**

2. **Vai alla tab "Knowledge"**
   - In alto nella pagina, clicca sulla tab **"Knowledge"**

3. **Crea una nuova Knowledge Base**
   - Clicca il **"+"** in alto a destra
   - Inserisci un **nome** (es. "Byblos", "Architettura", "Guide API")
   - Inserisci una **descrizione** (opzionale, ma utile per ricordare cosa contiene)
   - Clicca **"Create Knowledge"**

4. **Aggiungi documenti**
   - Entra nella pagina della Knowledge Base appena creata
   - Clicca il **"+"** vicino alla barra di ricerca in alto
   - Scegli un'opzione:
     - **"Upload Files"** - Carica file: PDF, TXT, MD, DOCX, XLSX, ecc.
     - **"Add Text Content"** - Scrivi testo direttamente nella chat (appunti, decisioni, ecc.)
   - Seleziona i file dal tuo PC
   - Attendi l'elaborazione (vedrai un indicatore di caricamento)

**Formati supportati:**
- PDF, TXT, Markdown (.md)
- Word (.docx), Excel (.xlsx)
- JSON, YAML, XML

### Come Usare la Knowledge Base in Chat

1. **Apri una nuova chat**
   - Clicca il **"+"** in alto a sinistra oppure clicca su "New Chat"

2. **Nella barra di testo, digita il cancelletto `#`**
   - Appare automaticamente una lista di Knowledge Base disponibili

3. **Seleziona la Knowledge Base** che ti serve
   - Ad es. clicca "Byblos"

4. **Digita la tua domanda**
   - Esempio: "Qual è l'ultimo update del progetto?"
   - Il modello cercherà la risposta dentro i documenti della KB

### Creare un Modello Personalizzato

Puoi creare un modello "custom" che usa automaticamente una Knowledge Base specifica, così non devi selezionarla ogni volta.

1. **Vai a Workspace > Models**
   - Clicca il **"+"** per aggiungere un nuovo modello

2. **Configura il modello**
   - **Nome**: es. "Byblos Assistant"
   - **Base Model**: scegli un modello (es. `llama3.2:8b`)
   - **System Prompt**: scrivi le istruzioni che vuoi (vedi esempio sotto)
   - **Knowledge Base**: seleziona la KB da usare

3. **Esempio di System Prompt per Byblos**
   ```
   Sei un assistente specializzato nel progetto Byblos.
   Rispondi sempre basandoti sulla documentazione del progetto caricata nella Knowledge Base.
   Se non trovi informazioni sufficienti, dillo chiaramente.
   Sii conciso e preciso.
   ```

4. **Salva e usa**
   - Il tuo modello custom appare nel selettore modelli in chat
   - Selezionalo e inizia a chattare

---

## Come Scaricare Nuovi Modelli

I modelli sono i "cervelli" del sistema. Più modelli hai, più scelte hai per diversi compiti.

### Metodo 1: Dalla Interfaccia Web (più facile)

1. In Open WebUI, clicca il **selettore modelli** (in alto a sinistra nella chat)
2. Digita il nome di un modello disponibile (es. `mistral`, `qwen2.5-coder:7b`)
3. Clicca sul modello dalla lista
4. Se non lo hai scaricato, vedrai un bottone **"Pull"** → cliccalo
5. Attendi il completamento (può durare minuti, dipende dalla dimensione)

### Metodo 2: Da Terminale

Esegui `scripts/pull-model.bat` da Windows e segui le istruzioni.

O manualmente:
```bash
docker exec ollama ollama pull mistral
```

### Modelli Consigliati

| Modello | Dimensione | Ideale per | RAM necessaria |
|---------|-----------|-----------|-----------------|
| **llama3.2:3b** | ~2 GB | Test, prototipazione, PC vecchi | 4 GB |
| **llama3.2:8b** | ~4.7 GB | Uso generale, buona qualità | 8 GB |
| **mistral** | ~4 GB | Coding, testo, bilanciato | 8 GB |
| **qwen2.5-coder:7b** | ~4.5 GB | Codice, spiegazioni tecniche | 8 GB |
| **gemma2:9b** | ~5.5 GB | Testo, italiano, conversazioni lunghe | 12 GB |

**Note:**
- Le dimensioni sono approssimative (dipendono dai quantizer usati)
- Servono almeno 2x la RAM della dimensione del modello (es. 8b → 16 GB di RAM totale)
- Se il tuo PC è lento, inizia con 3b e poi prova 8b quando sei sicuro

### Come Rimuovere un Modello (per liberare spazio)

Se un modello ti prende troppo spazio:

**Dalla UI:**
- Workspace > Models > clicca il modello → "Delete"

**Da terminale:**
```bash
docker exec ollama ollama rm llama3.2:3b
```

Questo **non cancella i tuoi dati** (chat, Knowledge Base), solo l'eseguibile del modello.
