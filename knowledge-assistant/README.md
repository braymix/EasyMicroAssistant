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
   - Via git: `git clone -b main https://github.com/braymix/easymicroassistant.git`
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

---

## Architettura Tecnica — Dettaglio Componenti

Questa sezione è per chi vuole capire **COSA c'è sotto il cofano** e come tutto comunica insieme.

### Architettura Generale

Ecco il flusso dati nel sistema:

```
┌──────────────────────┐
│   Browser Utente     │
│  (http://localhost:  │
│        3000)         │
└──────────┬───────────┘
           │ HTTP/WebSocket
           ▼
┌──────────────────────────────────┐
│      Open WebUI (Frontend)       │
│  - UI Chat                       │
│  - File Upload                   │
│  - Workspace & Knowledge         │
│  (Port: 8080 interno)            │
└──────────┬───────────────────────┘
           │
           ├─────────────────────┐
           │                     │
           ▼                     ▼
      ┌──────────┐         ┌──────────────┐
      │ Backend  │         │ Vector DB    │
      │ FastAPI  │         │ (ChromaDB)   │
      │ SQLite   │         │ Embeddings   │
      └──┬───────┘         └──────────────┘
         │
         │ HTTP
         ▼
   ┌──────────────────────┐
   │    Ollama API        │
   │   (Port: 11434)      │
   │ - generate           │
   │ - chat               │
   │ - pull               │
   └──────────┬───────────┘
              │
              ▼
   ┌──────────────────────┐
   │  Modello LLM Attivo  │
   │  (in RAM/VRAM)       │
   │  es. llama3.2:8b     │
   └──────────────────────┘
```

**Flusso di una domanda:**
1. Utente scrive una domanda in Open WebUI
2. Open WebUI manda la domanda a Ollama via HTTP
3. Ollama carica il modello in RAM (se non già caricato)
4. Se usi RAG, Open WebUI cerca documenti correlati nel Vector DB
5. Ollama genera la risposta usando il modello
6. La risposta torna a Open WebUI → Browser

### Docker Compose — Cosa fa ogni riga

Prendendo il file `docker-compose.full.yml`, spieghiamo il significato:

#### Concetto Base: Services

```yaml
services:
  ollama:      # ← Questo è un "service" (un container che verrà creato)
  open-webui:  # ← Questo è un altro service
```

In Docker Compose, ogni `service` diventa un container. Il nome del service diventa il **hostname** interno (i container si vedono tra loro usando questo nome).

#### Service Ollama

```yaml
ollama:
  image: ollama/ollama:latest
```
**Cosa fa:** Scarica l'immagine preconfezionata `ollama/ollama` dal registro Docker Hub. L'immagine contiene:
- Applicazione Ollama
- Runtime Python
- Sistema operativo minimale (Linux)
- Tutto ciò che serve per far girare modelli LLM

```yaml
  container_name: ollama
```
**Cosa fa:** Assegna un nome fisso al container. Senza questo, Docker crea nomi random come `proj_ollama_1`.

```yaml
  volumes:
    - ollama_data:/root/.ollama
```
**Cosa fa:** Mappa un volume Docker al percorso interno del container.
- `ollama_data` = volume Docker (memoria persistente)
- `/root/.ollama` = cartella interna del container dove Ollama salva i modelli
- **Perché:** Se il container si ferma/riavvia, i modelli non si perdono

```yaml
  ports:
    - "11434:11434"
```
**Cosa fa:** Espone la porta.
- Porta sx (11434) = host (il tuo PC)
- Porta dx (11434) = container (Ollama interno)
- **Esempio:** Da fuori puoi raggiungere Ollama su `http://localhost:11434`

```yaml
  restart: unless-stopped
```
**Cosa fa:** Se il container crasha, Docker lo riavvia automaticamente (a meno che tu non lo fermi manualmente con `stop.bat`).

```yaml
  tty: true
```
**Cosa fa:** Alloca un terminale virtuale. Necessario per Ollama per funzionare correttamente.

#### Service Open WebUI

```yaml
open-webui:
  depends_on:
    - ollama
```
**Cosa fa:** Dice a Docker: "Non avviare open-webui finché ollama non è pronto". Garantisce l'ordine di avvio.

```yaml
  ports:
    - "${OPEN_WEBUI_PORT:-3000}:8080"
```
**Cosa fa:** Usa una variabile d'ambiente.
- `${OPEN_WEBUI_PORT:-3000}` = leggi la variabile da `.env`, se non esiste usa `3000` (il `-` è il default)
- Port 3000 (host) → 8080 (container)
- **Esempio:** Se in `.env` metti `OPEN_WEBUI_PORT=3001`, la pagina è su `http://localhost:3001`

```yaml
  environment:
    - OLLAMA_BASE_URL=http://ollama:11434
```
**Cosa fa:** Dice a Open WebUI dove trovare Ollama.
- `ollama` = il nome del service (Docker risolve il nome automaticamente)
- `11434` = porta API di Ollama
- **Senza questa:** Open WebUI non saprebbe dove trovare il modello

```yaml
    - WEBUI_SECRET_KEY=${WEBUI_SECRET_KEY:-}
```
**Cosa fa:** Chiave per crittografare le sessioni web.
- Se non impostata (vuota), Open WebUI genera una chiave random ad ogni riavvio
- **Conseguenza:** Ogni riavvio → sei collegato come "anonimo", non come utente
- **Soluzione:** Genera una chiave con `openssl rand -hex 32` e mettila in `.env`

```yaml
  extra_hosts:
    - "host.docker.internal:host-gateway"
```
**Cosa fa:** Permette al container di raggiungere il **tuo PC** (l'host).
- Dentro il container, `host.docker.internal` risolve all'indirizzo dell'host
- **Usecase:** Se Ollama è installato nativamente sull'host (modalità ibrida), il container lo raggiunge così

#### Differenza Full vs Hybrid

**docker-compose.full.yml:**
- Entrambi i servizi (ollama + open-webui) girano in Docker
- `OLLAMA_BASE_URL=http://ollama:11434` (usa il service Docker)
- Prende più RAM (due container attivi)

**docker-compose.hybrid.yml:**
- Solo open-webui in Docker
- Ollama gira come programma nativo sul tuo PC
- `OLLAMA_BASE_URL=http://host.docker.internal:11434` (raggiunge l'host)
- Prende meno RAM, ma devi avere Ollama installato

### Ollama — Come Funziona

#### Cos'è un LLM (Large Language Model)?

Un LLM è una rete neurale "grande" (milioni/miliardi di parametri) addestrata su montagne di testo. Impara a predire la parola successiva basandosi su quello che hai scritto. Non "capisce" veramente, ma è bravissimo a fare pattern matching statistico.

**Parametri:** Sono i "pesi" della rete neurale. Più parametri = più capacità, ma anche più RAM/GPU necessaria.
- 3B parameters = ~2 GB di dati (più veloce, meno preciso)
- 70B parameters = ~40 GB (più lento, più preciso)

#### Tag come :3b, :8b, :70b?

Questi indicano il numero di parametri (in miliardi):
- `llama3.2:3b` = LLaMA 3.2 con 3 miliardi di parametri
- `llama3.2:8b` = LLaMA 3.2 con 8 miliardi di parametri

Ollama offre anche tag con `quantizzazione`:
- `llama3.2:3b` = quantizzato (compresso, ~2 GB) - **Consigliato**
- `llama3.2:3b-fp16` = full precision (non compresso, ~6 GB) - Solo se hai GPU potente

#### Come Ollama Gestisce i Modelli

1. **Download:** Quando scarichi un modello, Ollama lo mette in `/root/.ollama/models/`
2. **Cache:** La cartella è un volume Docker (`ollama_data`) → persiste tra riavvii
3. **Caricamento:** Quando usi un modello, Ollama lo carica in RAM
   - Il modello rimane in RAM fintanto che usi il sistema
   - Se non lo usi per un po', Ollama lo scarica dalla RAM per far spazio
4. **GPU:** Se hai una GPU NVIDIA, Ollama la usa automaticamente (CUDA)

#### API REST di Ollama

Ollama offre endpoint HTTP che puoi chiamare direttamente (è quello che fa Open WebUI dietro le quinte):

```bash
# Lista i modelli disponibili
curl http://localhost:11434/api/tags

# Genera testo
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2:8b",
  "prompt": "Ciao, come stai?",
  "stream": false
}'

# Chat (come si usa in Open WebUI)
curl http://localhost:11434/api/chat -d '{
  "model": "llama3.2:8b",
  "messages": [
    {"role": "user", "content": "Che cos'è Docker?"}
  ],
  "stream": false
}'

# Scarica un modello
curl http://localhost:11434/api/pull -d '{"name": "mistral"}'
```

### Open WebUI — Come Funziona

#### Stack Tecnologico

- **Backend:** Python + FastAPI (framework web veloce)
  - Gestisce API, autenticazione, database
  - Gira sulla porta interna 8080
  - Comunica con Ollama via HTTP

- **Frontend:** JavaScript/Svelte (framework UI moderno)
  - Interfaccia che vedi nel browser
  - Comunica con il backend via API

- **Database:** SQLite interno
  - Salva utenti, chat, impostazioni
  - File: `/app/backend/data/webui.db`

#### Autenticazione

- **Primo utente:** Automaticamente diventa **admin**
- **Primi accessi:** Creano lo schema del database
- **Password:** Hashata (non salvata in chiaro)
- **Sessioni:** Gestite tramite `WEBUI_SECRET_KEY` (cookie firmato)

#### Dove Salva i Dati

Tutto dentro il volume `open-webui:/app/backend/data`:
- `webui.db` - Database SQLite (utenti, chat, impostazioni)
- `files/` - Documenti caricati
- `logs/` - Log applicazione

**Su Windows:** Il volume è fisicamente in:
```
%APPDATA%\Docker\volumes\knowledge-assistant_open-webui\_data\
```

Oppure se non trovi il path esatto:
```bash
docker volume inspect knowledge-assistant_open-webui
# Ti mostra il percorso esatto in "Mountpoint"
```

### RAG (Retrieval Augmented Generation) — Come Funziona

RAG è la magia che permette a Open WebUI di rispondere domande basandosi su **i tuoi documenti**, non solo su ciò che il modello conosce.

#### Il Processo (Passo dopo Passo)

**1. Caricamento di un Documento**
```
Carichi "relazione_progetto.pdf"
           ↓
Open WebUI lo divide in "chunk" (pezzi di ~300 token)
           ↓
Ogni chunk passa per un "embedding model"
(es. nomic-embed-text, piccolo e veloce)
           ↓
Ogni chunk diventa un vettore di 384 numeri
(es. [0.123, -0.456, 0.789, ...])
           ↓
I vettori vengono salvati in ChromaDB (vector database)
```

**2. Quando Fai una Domanda**
```
Scrivi: "Qual è il budget del progetto?"
           ↓
La domanda viene anch'essa convertita in embedding
(stesso embedding model)
           ↓
ChromaDB cerca i chunk più "simili" (distanza vettoriale)
(es. trova 5 chunk rilevanti)
           ↓
Questi chunk vengono aggiunti al prompt come "contesto"
           ↓
Il prompt diventa:
  "Usa questi documenti: [... chunk 1 ..., ... chunk 2 ...]
   Domanda dell'utente: Qual è il budget del progetto?"
           ↓
Il modello LLM genera la risposta basandosi sul contesto
```

#### Configurazione RAG

In Open WebUI, vai a **Admin > Settings > Documents** per regolare:

- **Chunk Size** (default: ~300 token)
  - Più grande = meno chunk, ricerca meno granulare
  - Più piccolo = più chunk, ricerca più precisa ma più lenta

- **Chunk Overlap** (default: ~50 token)
  - Evita di perdere informazioni tra chunk
  - Crea sovrapposizione tra pezzi consecutivi

- **Embedding Model**
  - Quale modello usi per convertire testo → vettori
  - Default: `nomic-embed-text` (piccolo, veloce, accettabile)
  - Alternative: `mxbai-embed-large` (più potente, più lento)

#### Full Context Mode

Alcuni modelli supportano "Full Context Mode":
- Anzicché cercare chunk, manda **tutto il documento** al modello
- Pro: Modello vede tutto il contesto, risposte più complete
- Contro: Più lento, usa più RAM, funziona solo con modelli capaci di lunghe sequenze

#### Differenza RAG vs Normal Prompt

**Senza RAG:**
```
Utente: "Che cosa dice il regolamento interno?"
Modello: "Non ho informazioni sul vostro regolamento specifico..."
```

**Con RAG:**
```
Utente: "Che cosa dice il regolamento interno?"
Contesto trovato: [... articoli dal PDF caricato ...]
Modello: "Secondo il regolamento caricato, articolo 3..."
```

### Rete Docker — Come Comunicano i Container

Quando avvii `docker compose up`, Docker crea una **rete interna** per i container definiti nel file.

#### Service Name = Hostname

```yaml
services:
  ollama:      # ← Hostname interno: "ollama"
  open-webui:  # ← Hostname interno: "open-webui"
```

Dentro il container `open-webui`, puoi raggiungere Ollama semplicemente con:
```
http://ollama:11434
```

Docker risolve automaticamente il nome al suo indirizzo IP interno.

#### Porte Esposte vs Interne

```yaml
ports:
  - "11434:11434"  # Porta sinistra = host, destra = container
```

- **Da host (tuo PC):** Raggiungi Ollama su `http://localhost:11434`
- **Da container:** I container non vedono le porte esposte! Usano nomi interni

**Esempio sbagliato:**
```yaml
open-webui:
  environment:
    - OLLAMA_BASE_URL=http://localhost:11434  # ❌ Sbagliato!
    # Perché localhost dentro il container = il container stesso, non Ollama
```

**Esempio corretto:**
```yaml
open-webui:
  environment:
    - OLLAMA_BASE_URL=http://ollama:11434  # ✅ Corretto!
```

### Volumi Docker — Persistenza dei Dati

Senza volumi, quando fermi un container, tutti i dati si perdono. I volumi mantengono i dati tra riavvii.

#### Named Volume vs Bind Mount

**Named Volume** (quello che usiamo):
```yaml
volumes:
  - ollama_data:/root/.ollama  # Named volume
```
- Creato e gestito da Docker
- Posizione fisica: dipende da Docker (Windows: in una cartella gestita)
- Pro: Portabile, funziona ovunque, backup facile
- Cons: Non vedi direttamente i file

**Bind Mount:**
```yaml
volumes:
  - C:/Users/tuoutente/documenti:/root/.ollama  # Path locale
```
- Mappa una cartella del tuo PC al container
- Posizione: quella che specifichi
- Pro: Vedi i file facilmente
- Cons: Meno portabile, percorsi diversi su diversi PC

#### Dove Sono i Dati su Windows?

Per trovare fisicamente i file di un volume Docker:

```bash
docker volume inspect knowledge-assistant_ollama_data
# Output:
# [
#   {
#     "Name": "knowledge-assistant_ollama_data",
#     "Mountpoint": "C:\\ProgramData\\Docker\\volumes\\knowledge-assistant_ollama_data\\_data",
#     ...
#   }
# ]
```

Dentro `_data` troverai la struttura completa di `/root/.ollama` dal container.

#### Backup e Restore

**Backup di un volume:**
```bash
# Crea una copia dei dati
docker run --rm -v knowledge-assistant_ollama_data:/data ^
  -v C:\backup:/backup ^
  busybox tar czf /backup/ollama_backup.tar.gz -C /data .
```

**Restore:**
```bash
docker run --rm -v knowledge-assistant_ollama_data:/data ^
  -v C:\backup:/backup ^
  busybox tar xzf /backup/ollama_backup.tar.gz -C /data
```

#### Ispezionare un Volume

```bash
# Vedere i volumi
docker volume ls

# Dettagli di un volume
docker volume inspect open-webui

# Entrare dentro un volume (temporaneamente)
docker run --rm -it -v open-webui:/data busybox sh
# Dentro il container puoi fare: ls -la /data
```

---

**Fine della sezione tecnica.**

Se hai domande sulla architettura, controlla i log con:
```bash
docker compose logs -f  # Vedi tutto
docker compose logs ollama  # Solo Ollama
docker compose logs open-webui  # Solo Open WebUI
```
