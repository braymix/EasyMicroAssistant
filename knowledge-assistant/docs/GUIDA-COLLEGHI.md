# 🚀 Guida Completa — Knowledge Assistant

Ciao! 👋 Questa guida è pensata per te che non hai mai usato Docker e vuoi un assistente AI locale per i tuoi progetti. Non è complicato, promesso! Segui i passi uno dopo l'altro e tutto funzionerà.

---

## PARTE 1 - Installazione Docker Desktop 🐳

Docker Desktop è il "contenitore" (letteralmente!) che permette al progetto di funzionare. Non devi capirne i dettagli tecnici, basta installarlo e basta.

### Step 1️⃣ - Scarica Docker Desktop

1. Apri il browser (qualsiasi)
2. Vai a: **https://www.docker.com/products/docker-desktop/**
3. Dovresti vedere una pagina blu con il logo della balena (Docker)
4. Clicca il bottone blu grande che dice **"Download for Windows"**
   - Se ha Windows 11 o Windows 10 recente → seleziona la versione consigliata
   - Non preoccuparti della versione esatta, la pagina suggerisce quella giusta

### Step 2️⃣ - Installa il file

1. Guarda in basso a sinistra del browser, troverai il file scaricato (es. `Docker Desktop Installer.exe`)
2. **Doppio click** sul file per aprirlo
3. Se Windows ti chiede "Vuoi consentire a questo programma di apportare modifiche?" → clicca **SÌ**
4. Si apre una finestra di installazione
5. Vedrai vari messaggi che dicono cose come "Installing Docker..."
   - **Non toccare nulla**, aspetta che finisca (è automatico)

### Step 3️⃣ - Opzione Importante: WSL 2

Durante l'installazione (oppure dopo), potrebbe apparirti una finestra o una checkbox che chiede:

> **Use WSL 2 instead of Hyper-V?**

**Cosa fare:** Metti la spunta ✅ e procedi. WSL 2 è più veloce e moderno.

### Step 4️⃣ - Riavvio del PC

1. Quando l'installazione finisce, Windows ti chiederà di **riavviare il PC**
2. Clicca **"Riavvia ora"** (salva i tuoi lavori prima!)
3. Il PC si riavvia → è normale

### Step 5️⃣ - Primo Avvio di Docker Desktop

1. Dopo il riavvio, Docker Desktop si apre **automaticamente**
   - Se non si apre, cerca nel menu Start e clicca su "Docker Desktop"
2. Ti apparirà una finestra con una balena 🐳 e alcuni messaggi
3. **Accetta i termini di servizio** (il bottone è in basso)
4. Potrebbe chiederti la password Windows → inseriscila (serve per i permessi di sistema)
5. Aspetta che i messaggi finiscano e che tutto sia pronto
   - **Vedrai una barra di avanzamento** → aspetta che arrivi al 100%

### Step 6️⃣ - Verifica che Funzioni

1. Apri il **Prompt dei Comandi**:
   - Clicca il menu **Start** in basso a sinistra
   - Scrivi **`cmd`** e premi **Invio**
   - Si apre una finestra nera (il Prompt dei Comandi)

2. Scrivi questo comando e premi **Invio**:
   ```
   docker --version
   ```

3. Dovresti vedere una risposta tipo:
   ```
   Docker version 25.0.0, build abc123def
   ```

✅ **Se vedi il numero di versione → Docker è installato correttamente!**

---

### ⚠️ Se qualcosa va storto...

#### "Docker si apre ma poi si chiude"
- **Causa:** Potrebbe mancare WSL 2 sul tuo PC
- **Soluzione:**
  1. Apri PowerShell (menu Start → scrivi "PowerShell")
  2. Copia e incolla questo comando:
     ```
     wsl --install
     ```
  3. Aspetta il completamento e riavvia il PC

#### "Il comando 'docker' non è riconosciuto"
- **Causa:** Docker non è installato correttamente o il PC non lo vede
- **Soluzione:**
  1. Riavvia il PC
  2. Apri di nuovo il Prompt dei Comandi (`cmd`)
  3. Riprova il comando `docker --version`

#### "Errore: Docker Desktop is not running"
- **Causa:** Docker Desktop non è avviato
- **Soluzione:** Clicca l'icona della balena 🐳 nel menu Start oppure nella barra in basso a destra (system tray)

#### "Non trovo il file scaricato dal browser"
- **Soluzione:**
  1. Apri la cartella **Download** (scrivi "Download" nel menu Start)
  2. Cerchia il file più recente con ".exe" nel nome
  3. Doppio click per installare

---

## PARTE 2 - Preparazione del Progetto 📁

Ora che Docker è installato, prepariamo i file del progetto.

### Dove Scaricare la Cartella del Progetto

Hai due opzioni:

#### Opzione A: ZIP (più facile, consigliata)

1. Il collega o il responsabile ti ha passato un file `.zip` con il progetto
2. **Doppio click** sul file `.zip`
   - Windows lo estrae automaticamente in una cartella con lo stesso nome
3. Ricorda **dove l'hai estratto** (es. `C:\Users\TuoNome\Download\knowledge-assistant`)

#### Opzione B: Git Clone (se sai usare Git)

Se conosci Git, aprire PowerShell e:
```
git clone https://github.com/braymix/easymicroassistant.git
cd knowledge-assistant
```

### Dove Estrarre la Cartella

Consiglio di metterla in un posto facile da raggiungere:

**Scelta consigliata:**
```
C:\Progetti\knowledge-assistant
```

**Come fare:**
1. Apri **Esplora File** (icona della cartella nella barra in basso)
2. Clicca su **Unità C** a sinistra
3. Se non vedi una cartella **"Progetti"**, creala:
   - Click destro → **Nuova Cartella**
   - Nomina **"Progetti"**
4. Estrai la cartella `knowledge-assistant` dentro **C:\Progetti**

### Cosa Contiene la Cartella

Una volta estratta, apri la cartella e vedrai:

```
knowledge-assistant/
├── docker-compose.full.yml       ← Configurazione Docker (non toccare)
├── docker-compose.hybrid.yml     ← Configurazione alternativa (non toccare)
├── .env.example                  ← Impostazioni d'esempio (non toccare)
├── README.md                     ← Guida principale
├── docs/                         ← Documentazione
│   ├── GUIDA-COLLEGHI.md        ← Questa guida!
│   └── knowledge/               ← Cartella dove mettere i tuoi documenti
│
└── scripts/                      ← I bottoni magici per controllare tutto
    ├── setup-windows.bat        ← CLICCA QUESTO per il primo avvio ⭐
    ├── start-full.bat           ← Avvia il sistema
    ├── start-hybrid.bat         ← Avvia il sistema (modalità alternativa)
    ├── stop.bat                 ← Ferma il sistema
    ├── pull-model.bat           ← Scarica nuovi modelli AI
    └── status.bat               ← Verifica che funzioni
```

**Per questa guida, ti serve solo la cartella `scripts/`.**

---

## PARTE 3 - Primo Avvio ▶️

Ecco il momento della verità! ✨

### Step 1️⃣ - Apri la Cartella scripts

1. Apri **Esplora File** (icona della cartella)
2. Vai dove hai estratto il progetto (es. `C:\Progetti\knowledge-assistant`)
3. Doppio click sulla cartella **`scripts`**
4. Vedrai un elenco di file `.bat` (bottoni magici)

### Step 2️⃣ - Avvia il Setup

1. Trova il file **`setup-windows.bat`**
   - È quello con il nome più lungo e un'icona "comando"
2. **Doppio click** su di esso
3. Si apre una **finestra nera** (il Prompt dei Comandi)
4. Leggi i messaggi con attenzione

### Step 3️⃣ - Cosa Vedrà Sullo Schermo

Ecco cosa appare in ordine. **Non è necessario fare nulla**, lo script fa tutto da solo:

```
============================================================
   KNOWLEDGE ASSISTANT - Setup Automatico
============================================================

[1/6] Verifica installazione Docker...
      Docker trovato.
[2/6] Verifica che Docker Desktop sia in esecuzione...
      Docker Desktop in esecuzione.
[3/6] Configurazione variabili d'ambiente...
      File .env creato da .env.example
[4/6] Scegli la modalità di installazione:

   [1] Tutto in Docker (consigliato)
       ...
   [2] Modalità ibrida
       ...

Inserisci la tua scelta (1 o 2):
```

**A questo punto lo script ti chiede una scelta:**

**Se non hai mai sentito parlare di "Ollama":**
- Scrivi **`1`** e premi **Invio**
- (Significato: installa tutto in Docker, più facile)

**Se invece hai Ollama già installato sul tuo PC:**
- Scrivi **`2`** e premi **Invio**

Continua a leggere i messaggi. Vedrai cose tipo:

```
        Modalità selezionata: Full Docker

[5/6] Avvio dei container Docker...
      File compose: docker-compose.full.yml

[carico...]
```

### Step 4️⃣ - Tempo di Attesa ⏱️

**Quanto tempo ci vuole:**
- **Primo avvio:** 5-15 minuti (dipende da Internet)
  - Scarica immagini Docker (~2-4 GB)
  - Installa il modello AI di default (~2 GB)
- **Avvii successivi:** 20-30 secondi (tutto è già scaricato)

**Cosa fare mentre aspetti:**
- Prendi un caffè ☕
- Non toccare nulla, lo script lavora
- Se il PC sembra bloccato, **non è vero** — il download è lento ma sta procedendo

### Step 5️⃣ - Quando Tutto è Pronto

Verso la fine vedrai questo messaggio:

```
============================================================
   SETUP COMPLETATO CON SUCCESSO!
============================================================

  Apri il browser su: http://localhost:3000

  Al primo accesso, crea il tuo account admin.
  Il primo utente registrato diventa automaticamente
  amministratore della piattaforma.

============================================================
   DOWNLOAD MODELLO AI
============================================================

  Scaricamento modello in corso... potrebbe richiedere qualche minuto.
  Modello: llama3.2:3b (~2GB)
```

**Se vedi "SETUP COMPLETATO CON SUCCESSO!" → tutto è andato bene!** 🎉

Poi premi un tasto qualsiasi per chiudere la finestra.

---

### ⚠️ Se la finestra si è chiusa da sola...

#### "La finestra nera si è chiusa da sola senza mostrare nulla"
- **Causa:** Probabilmente un errore silenzioso
- **Soluzione:**
  1. Apri il Prompt dei Comandi (menu Start → scrivi `cmd`)
  2. Naviga alla cartella del progetto:
     ```
     cd C:\Progetti\knowledge-assistant\scripts
     ```
  3. Esegui lo script manualmente:
     ```
     setup-windows.bat
     ```
  4. Questa volta vedrai i messaggi di errore. Screenshotta l'errore e chiedi aiuto!

#### "Dice: 'Docker Desktop non è in esecuzione'"
- **Causa:** Docker Desktop non è avviato
- **Soluzione:**
  1. Clicca il menu **Start**
  2. Cerca **Docker Desktop**
  3. Clicca per avviarlo
  4. Aspetta che l'icona della balena 🐳 nel system tray diventi verde
  5. Riprova lo script

#### "Dice: 'Nessun modello disponibile' oppure l'avvio è stato parziale"
- **Causa:** Probabile download incompleto
- **Soluzione:**
  1. Aspetta 5 minuti (il download potrebbe ancora procedere in background)
  2. Poi prova: doppio click su **`scripts/status.bat`**
  3. Se i container non sono tutti verdi, riprova il setup

#### "Errore di porta: 'Port 3000 is already in use'"
- **Causa:** Un altro programma usa la porta 3000
- **Soluzione:**
  1. Apri il Prompt dei Comandi
  2. Scrivi:
     ```
     netstat -ano | findstr :3000
     ```
  3. Vedi quale programma usa la porta e chiudilo
  4. Riprova lo script (oppure usa una porta diversa in `.env`)

---

---

## PARTE 4 - Primo Accesso a Open WebUI 🌐

Se lo script di setup è terminato correttamente, il tuo assistente AI è pronto! Accediamo all'interfaccia.

### Step 1️⃣ - Apri il Browser

1. Clicca sull'icona del browser che usi abitualmente:
   - **Chrome** (icona colorata con un cerchio)
   - **Edge** (icona blu)
   - **Firefox** (icona rossa/arancione)
   - Qualsiasi altro browser va bene

### Step 2️⃣ - Accedi all'Applicazione

1. Nella **barra degli indirizzi** in alto (dove scrivi normalmente i siti web)
2. Cancella quello che c'è scritto (seleziona tutto con **Ctrl+A** e cancella)
3. Scrivi esattamente questo:
   ```
   http://localhost:3000
   ```
4. Premi **Invio**
5. Attendi 2-3 secondi mentre carica la pagina

### Step 3️⃣ - Pagina di Login

Dovresti vedere una pagina con scritto **"Sign In"** (accedi).

La pagina è pulita e minimale, con due campi di testo:
- Nome utente o email
- Password

Sopra o sotto vedrai il link **"Sign Up"** (Registrati) — è quello che ti serve.

### Step 4️⃣ - Registrati

1. Clicca il link **"Sign Up"** (Registrati)
2. Si apre il modulo di registrazione con questi campi:
   - **Nome** (il tuo nome, es. "Marco Rossi")
   - **Email** (qualsiasi, es. "marco@example.com" — può essere fittizia!)
   - **Password** (una password sicura, es. "MiaPassword123!")
   - **Conferma Password** (digita la stessa password)

3. Riempi tutti i campi:
   ```
   Nome:                Marco
   Email:               marco@localhost
   Password:            SicuraMolto123!
   Conferma Password:   SicuraMolto123!
   ```

4. Clicca il bottone **"Sign Up"** (blu, in basso)

### Step 5️⃣ - ⚠️ Dati Locali — Non Vengono Inviati Da Nessuna Parte!

**IMPORTANTE:** Questi dati restano **SOLO sul tuo PC**, dentro il container Docker. Non vengono inviati a nessun server online. Non c'è nessuno che vede la tua email o password.

Puoi usare email fittizie (es. `admin@localhost`) senza problemi.

### Step 6️⃣ - Primo Utente = Amministratore

**Ricorda:** Il **PRIMO utente** che si registra diventa automaticamente l'**ADMIN** del sistema.

Se in futuro altri colleghi usano lo stesso sistema, gli altri utenti potranno fare domande ma non avranno i poteri di admin (che sono: aggiungere modelli, gestire le impostazioni, ecc.).

### Step 7️⃣ - Sei Dentro! ✨

Dopo la registrazione, sei dentro l'interfaccia di Open WebUI. Vedrai:

```
┌────────────────────────────────────────────────┐
│ [≡] KNOWLEDGE ASSISTANT                        │  ← Menu (hamburger) in alto a sinistra
├────────────────────────────────────────────────┤
│                                                │
│  Sidebar a sinistra:                           │
│  - New Chat                                    │
│  - Workspace                                   │
│  - Settings                                    │
│                                                │
├───────────────────┬─────────────────────────────┤
│   (vuoto)         │  Area principale:            │
│                   │  - Selettore modello (alto) │
│                   │  - Area chat (al centro)    │
│                   │  - Barra per scrivere       │
│                   │    (in basso)               │
│                   │                             │
└───────────────────┴─────────────────────────────┘
```

**Spiegazione:**
- **Sidebar sinistra:** Menu con opzioni (Chat, Workspace, Impostazioni)
- **Area centrale:** Dove scrivi domande e vedi le risposte
- **In alto a sinistra:** Selettore del modello ("Seleziona un modello")
- **In basso:** Barra per scrivere messaggi (come in WhatsApp)

### Step 8️⃣ - Prova a Scrivere

Se vuoi, prova a scrivere qualcosa nella barra in basso. Ma **attenzione:** se non hai ancora scaricato nessun modello, il sistema dirà "Nessun modello disponibile".

Se vedi questo messaggio, passa alla **PARTE 5** (subito dopo) per scaricare il primo modello.

---

## PARTE 5 - Scaricare il Primo Modello 🧠

Un **modello** è il "cervello" dell'assistente AI. Senza un modello, non può rispondere a nessuna domanda.

Lo script di setup potrebbe averlo già scaricato, ma se non lo ha fatto, lo fai tu. È facile!

### Controlliamo Prima Se c'è Già un Modello

1. In alto a sinistra nella chat, vedrai scritto **"Select a model"** (o un nome di modello)
2. Clicca su di esso per aprire la lista
3. Se vedi dei modelli nella lista (es. "llama3.2:3b") → **puoi saltare questa parte!** ✅
4. Se la lista è **vuota** → procedi con i passi sotto

### Opzione A 🟦 - Scaricare dalla Interfaccia Web (più facile)

1. In alto a sinistra nella chat, clicca dove dice **"Select a model"**
2. Si apre una lista (probabilmente vuota)
3. **Clicca nella barra di ricerca** (il campo di testo)
4. Scrivi il nome di un modello:
   ```
   llama3.2:3b
   ```
   (Questo è il modello più leggero, perfetto per iniziare)

5. Appare un suggerimento: **"llama3.2:3b"** con un bottone **"Pull"** accanto
6. **Clicca il bottone "Pull"** (significato: scarica il modello)
7. Vedrai una barra di progresso. **Aspetta che finisca** (può durare 5-15 minuti)
   - Il modello è ~2GB, dipende dalla tua connessione internet

8. Quando è pronto, il modello appare nella lista e puoi iniziare a usarlo! ✅

### Opzione B 🟩 - Scaricare da Script (alternativa)

Se preferisci, puoi usare lo script:

1. Apri **Esplora File**
2. Vai nella cartella: `C:\Progetti\knowledge-assistant\scripts`
3. **Doppio click** su **`pull-model.bat`**
4. Si apre una finestra nera (Prompt dei Comandi)
5. Scrivi il nome del modello quando richiesto:
   ```
   llama3.2:3b
   ```
6. Premi **Invio**
7. Aspetta il download

### 💡 Quale Modello Scegliere?

Non sai quale modello usare? Non importa! Ecco una guida veloce:

| Modello | Ideale Per | Velocità |
|---------|-----------|---------|
| **llama3.2:3b** ⭐ | Iniziare, prototipare | Veloce ⚡ |
| **llama3.2:8b** | Uso generale, buona qualità | Medio ⚙️ |
| **mistral** | Scrivere codice | Medio ⚙️ |

**Consiglio:** Inizia con **`llama3.2:3b`** — è leggero, veloce, e perfetto per imparare.

Per la lista completa con spiegazioni, vedi il **README.md** della cartella principale.

### ✅ Sei Pronto!

Adesso hai:
1. ✅ Docker installato
2. ✅ Il progetto configurato
3. ✅ Open WebUI aperto
4. ✅ Un modello AI scaricato

**Puoi iniziare a fare domande al tuo assistente AI locale!** 🎉

Scrivi qualcosa nella barra in basso e premi **Invio**. Aspetta la risposta.

---

---

## PARTE 6 - Creare la Knowledge Base del Tuo Progetto 📚

Una **Knowledge Base** è una raccolta dei tuoi documenti (PDF, file di testo, appunti) su cui l'AI può cercare per rispondere alle tue domande in modo più accurato.

**Esempio:** Se carichi la documentazione del microservizio Byblos, poi potrai domandare "Quali sono gli endpoint REST?" e l'AI cercherà la risposta nei tuoi documenti.

Senza Knowledge Base, l'AI può rispondere solo in base a ciò che conosce dal suo addestramento (e potrebbe anche inventare risposte).

### Step 1️⃣ - Vai su Workspace

1. Guarda la **sidebar a sinistra** (il menu verticale)
2. Vedrai una voce che dice **"Workspace"** (simbolo: una cartella o una griglia)
3. **Clicca su "Workspace"**

### Step 2️⃣ - Seleziona la Tab "Knowledge"

1. Dopo aver cliccato Workspace, in alto vedrai diverse **tab** (schede):
   - Documents
   - Knowledge
   - Models
   - Prompts
   - ...

2. **Clicca sulla tab "Knowledge"**

3. Vedrai una pagina con scritto "Knowledge Bases" e una lista (probabilmente vuota se è la prima volta)

### Step 3️⃣ - Crea una Nuova Knowledge Base

1. In alto a destra della pagina, vedrai un bottone **"+"** (o un bottone "New")
2. **Clicca il "+"**
3. Si apre una finestra di dialogo con dei campi da riempire

### Step 4️⃣ - Compila i Dati della Knowledge Base

Riempi questi campi esattamente come negli esempi:

**Campo 1: Nome** (Name)
```
Byblos
```
(Può essere qualsiasi nome, preferibilmente il nome del tuo progetto)

**Campo 2: Descrizione** (Description — opzionale ma consigliato)
```
Documentazione del microservizio Byblos
```
(Descrivi brevemente cosa contiene)

Esempio se avessi più Knowledge Base:
- KB 1: "Byblos" — Documentazione del microservizio Byblos
- KB 2: "Architettura" — Diagrammi e decisioni architetturali
- KB 3: "Guidelines" — Linee guida di codice e sviluppo

### Step 5️⃣ - Crea la Knowledge Base

1. Guarda in basso nella finestra di dialogo
2. Vedrai un bottone **"Create Knowledge"** (o simile)
3. **Clicca il bottone**
4. Attendi 1-2 secondi mentre viene creata

### Step 6️⃣ - Sei nella Pagina della Knowledge Base

Dopo la creazione, sei dentro la Knowledge Base appena creata. Vedrai:

```
┌─────────────────────────────────────────┐
│ ← Byblos  (nome della KB)               │  ← Puoi tornare indietro
│                                         │
│  Descrizione: Documentazione...        │
│                                         │
├─────────────────────────────────────────┤
│                                         │
│  [Barra di ricerca]  [+]               │  ← Il "+" è quello che ti serve
│                                         │
│  File caricati:                         │
│  - (lista vuota per ora)               │
│                                         │
└─────────────────────────────────────────┘
```

### Step 7️⃣ - Clicca il Bottone "+" per Aggiungere Documenti

1. A destra della **barra di ricerca** (quella per cercare i documenti), vedrai un bottone **"+"**
2. **Clicca il "+"**
3. Si apre un menu con due opzioni:
   - **Upload Files** (Carica file)
   - **Add Text Content** (Aggiungi testo)

### Step 8️⃣ - Opzione A: Upload Files (Caricare File)

Se scegli **"Upload Files"**:

1. Si apre una finestra di selezione file (come quando alleghi una mail)
2. **Seleziona i file** che vuoi caricare:
   - `.pdf` (PDF)
   - `.txt` (File di testo)
   - `.md` (Markdown)
   - `.docx` (Word)
   - `.xlsx` (Excel)

   **Puoi selezionarne più di uno** (Ctrl+click per selezionare più file)

3. Clicca **"Apri"** o **"Seleziona"**

4. **Oppure trascina:** Se preferisci, puoi anche **trascinare i file direttamente** nella finestra (drag & drop)

### Step 8️⃣ - Opzione B: Add Text Content (Aggiungere Testo)

Se scegli **"Add Text Content"**:

1. Si apre un **editor di testo**
2. Puoi scrivere o incollare direttamente il contenuto (appunti, documenti, ecc.)
3. Clicca **"Save"** quando hai finito

### Step 9️⃣ - Aspetta l'Elaborazione

Dopo aver caricato i file:

1. Vedrai **un'icona di caricamento** (spinner, cerchietto che gira)
2. Sotto c'è scritto qualcosa come: **"Processing..."** o **"Elaborazione in corso..."**
3. **Non toccare nulla, aspetta** — il sistema estrae il testo dai file e lo prepara per le ricerche
4. Questo può durare da pochi secondi a qualche minuto (dipende dalla dimensione)

### Step 1️⃣0️⃣ - Conferma: File Processati

Quando l'elaborazione finisce:

1. Il file appare nella lista con accanto una **spunta verde ✅**
2. Sotto il file vedrai il numero di **"chunks"** (pezzi) in cui è stato diviso
3. Esempio: `"byblos-docs.pdf"` ✅ `(45 chunks)`

**Perfetto! Il file è pronto per le ricerche.**

---

### 💡 Formati Consigliati

| Formato | Funziona Bene? | Note |
|---------|----------------|------|
| `.md` (Markdown) | ✅✅ Eccellente | Perfetto, è testo puro |
| `.txt` (Testo) | ✅✅ Eccellente | Perfetto, è testo puro |
| `.pdf` (PDF) | ✅ Buono | Funziona se è testo (no immagini) |
| `.docx` (Word) | ✅ Buono | Supportato |
| `.xlsx` (Excel) | ⚠️ OK | Può funzionare ma non è ottimale |
| `.pdf` con immagini | ⚠️ Problematico | Potrebbe non estrarre il testo correttamente |

**Consiglio:** Se puoi, esporta i tuoi documenti come **`.md`** o **`.txt`** — funzionano sempre perfettamente.

Se hai un PDF che è principalmente immagini (screenshot), il sistema potrebbe non estrarre il testo. In questo caso, copia il testo in un `.txt` e carica quello.

---

## PARTE 7 - Usare la Knowledge Base nelle Chat 💬

Adesso che hai una Knowledge Base con i tuoi documenti, puoi usarla quando scrivi domande. Ecco come.

### Step 1️⃣ - Apri una Nuova Chat

1. Nella **sidebar sinistra**, clicca **"New Chat"** (o il bottone **"+"** in alto)
2. Si apre una chat vuota
3. Vedrai:
   - In alto a sinistra: il selettore modello
   - In basso: la barra per scrivere messaggi

### Step 2️⃣ - Seleziona il Modello

1. In alto a sinistra vedrai scritto **"Select a model"** (o il nome del modello precedente)
2. **Clicca per aprire la lista**
3. Scegli il modello che vuoi usare (es. `llama3.2:3b`)
4. Clicca per confermarlo

### Step 3️⃣ - Attiva la Knowledge Base Digitando #️⃣

**Questo è il passaggio chiave:**

1. Guarda la **barra di testo in basso** (dove scrivi i messaggi)
2. **Clicca dentro la barra** per iniziare a scrivere
3. **Digita il simbolo: `#`** (cancelletto/hash)
4. **Immediatamente** apparirà un menu a tendina con le tue Knowledge Base!

```
Esempio:

Scrivi: #
Appare:
┌──────────────────┐
│ Byblos      [✓]  │  ← La tua Knowledge Base
│ Architettura     │
│ Guidelines       │
└──────────────────┘
```

### Step 4️⃣ - Seleziona la Knowledge Base

1. Nel menu che appare, vedi le tue Knowledge Base
2. **Clicca su "Byblos"** (o quella che vuoi usare)
3. Vedrai che il `#` si trasforma in **un "tag"** o **un "badge"** che mostra il nome della KB
   - Esempio: `[Byblos]` o `#Byblos`

### Step 5️⃣ - Scrivi la Tua Domanda

1. Dopo il tag della Knowledge Base, continua a scrivere normalmente
2. Completa il tuo messaggio:
   ```
   [Byblos] Quali sono gli endpoint REST?
   ```

3. **Premi Invio** o clicca il bottone **"Invia"** (freccia in basso a destra)

### Step 6️⃣ - L'AI Cerca nei Tuoi Documenti

1. Appare un'icona di **"caricamento"** (spinner)
2. Dietro le quinte, il sistema:
   - Cerca nei documenti di Byblos le informazioni rilevanti
   - Prende i pezzi più importanti
   - Fornisce il contesto al modello AI
   - Il modello genera una risposta basata sui tuoi documenti

3. La risposta appare nella chat

### Step 7️⃣ - Esempio Completo

**Tu scrivi:**
```
[Byblos] Qual è l'URL dell'endpoint per ottenere gli utenti?
```

**Il sistema ricerca in Byblos e trova:**
```
POST /api/users
GET /api/users/{id}
PUT /api/users/{id}
DELETE /api/users/{id}
```

**L'AI risponde:**
```
Secondo la documentazione di Byblos, l'endpoint per ottenere tutti gli utenti è:
GET /api/users

Restituisce una lista di utenti in formato JSON.
```

---

### ⚠️ Se la Risposta Sembra Inventata

Qualche volta l'AI potrebbe generare risposte che non sono nei documenti. Come risolvere:

1. **Verifica che il file sia stato processato:**
   - Vai in Workspace > Knowledge > seleziona Byblos
   - Vedi una spunta verde ✅ accanto al file?
   - Se vedi solo un'icona di caricamento, aspetta che finisca

2. **Prova con un modello più grande:**
   - Usa `llama3.2:8b` invece di `llama3.2:3b`
   - Modelli più grandi sono migliori nel seguire le istruzioni

3. **Riformula la domanda:**
   - Invece di "Quali sono gli endpoint?" prova "Dammi un elenco di tutti gli endpoint REST"
   - A volte domande più specifiche danno risposte migliori

4. **Verifica i documenti:**
   - Magari l'informazione che cerchi non è nel documento caricato
   - Controlla di aver caricato il file giusto

---

## PARTE 8 - Creare un Modello Personalizzato (Consigliato) ⭐

### Cos'è un Modello Personalizzato?

Un **modello personalizzato** è una "scorciatoia" che ti permette di avere sempre la Knowledge Base collegata **senza dover digitare `#` ogni volta**.

**Esempio:**
- Senza modello custom: ogni volta scrivi `[Byblos]` + domanda
- Con modello custom "Assistente Byblos": seleziona semplicemente il modello e la KB è automaticamente attiva

È facoltativo, ma **molto consigliato** perché rende tutto più veloce.

### Step 1️⃣ - Vai a Workspace > Models

1. Nella **sidebar sinistra**, clicca **"Workspace"**
2. In alto, clicca la tab **"Models"**
3. Vedrai una lista dei modelli disponibili (es. `llama3.2:3b`, `llama3.2:8b`, ecc.)

### Step 2️⃣ - Crea un Nuovo Modello

1. In alto a destra, vedrai un bottone **"+"** (o "Add New Model")
2. **Clicca il "+"**
3. Si apre una **form con vari campi**

### Step 3️⃣ - Compila i Dati del Modello Personalizzato

Riempi i seguenti campi **esattamente come indicato:**

#### Campo 1: Nome (Name)

```
Assistente Byblos
```

Scegli un nome descrittivo. Esempi:
- "Assistente Byblos"
- "Byblos Expert"
- "Byblos Helper"

#### Campo 2: Modello Base (Base Model)

1. Vedrai un **dropdown** (lista a tendina)
2. **Clicca per aprire** la lista di modelli disponibili
3. Seleziona il modello che hai scaricato:
   - Se hai scaricato `llama3.2:3b` → seleziona **"llama3.2:3b"**
   - Se hai scaricato `llama3.2:8b` → seleziona **"llama3.2:8b"**

Il modello base è il "motore" del tuo assistente personalizzato.

#### Campo 3: System Prompt (Istruzioni Importanti!)

Questo è il campo **più importante**. Qui dai istruzioni al modello su come comportarsi.

**Copia-incolla ESATTAMENTE questo testo:**

```
Sei un assistente esperto del microservizio Byblos.
Rispondi sempre basandosi sulla documentazione fornita.
Se non trovi l'informazione nei documenti, dillo chiaramente.
Rispondi in italiano.
Sii conciso e preciso.
```

**Cos'è il "System Prompt"?**
È come dare istruzioni a un collega:
- "Sii un esperto di Byblos"
- "Rispondi solo in base ai nostri documenti"
- "Se non sai, dillo"
- "Parla in italiano"

Queste istruzioni influenzano ogni risposta che il modello genera.

#### Campo 4: Knowledge (Knowledge Base)

1. Vedrai un **dropdown** con le tue Knowledge Base
2. **Clicca per aprire** e seleziona **"Byblos"** (o quella che hai creato)
3. Questo collega il modello personalizzato alla tua KB

Così non devi digitare `#Byblos` ogni volta — è già "collegato".

### Esempio Visivo della Form Compilata

```
┌────────────────────────────────────────┐
│ CREATE NEW MODEL                       │
├────────────────────────────────────────┤
│                                        │
│ Name: [Assistente Byblos          ]   │
│                                        │
│ Base Model: [llama3.2:3b          ▼]  │
│                                        │
│ System Prompt:                         │
│ ┌──────────────────────────────────┐  │
│ │ Sei un assistente esperto...     │  │
│ │ Rispondi sempre basandosi...     │  │
│ │ Se non trovi l'informazione...   │  │
│ │ Rispondi in italiano.            │  │
│ │ Sii conciso e preciso.           │  │
│ └──────────────────────────────────┘  │
│                                        │
│ Knowledge: [Byblos                ▼]  │
│                                        │
│  [Salva]  [Annulla]                   │
│                                        │
└────────────────────────────────────────┘
```

### Step 4️⃣ - Salva il Modello

1. In basso nella form, vedrai i bottoni
2. **Clicca il bottone "Salva"** (o "Save", "Create")
3. Attendi 1-2 secondi mentre viene salvato

### Step 5️⃣ - Usa il Tuo Modello Personalizzato

Perfetto! Ora il tuo modello personalizzato è pronto. Ecco come usarlo:

1. Apri una **nuova chat** (New Chat)
2. In alto a sinistra, **seleziona il modello**
3. Dalla lista, vedrai ora **"Assistente Byblos"** (il tuo modello custom!)
4. **Clicca per selezionarlo**
5. Ora puoi scrivere domande direttamente — la KB è già collegata! 🎉

**Esempio:**
```
Tu: Quali sono tutti gli endpoint REST?
(Nota: NON devi digitare [Byblos], è già automatico!)

Assistente Byblos risponde cercando in Byblos:
Secondo la documentazione, gli endpoint sono:
- GET /api/users
- POST /api/users
- ...
```

---

### 💡 Puoi Avere Più Modelli Personalizzati!

Creane quanti vuoi:
- "Assistente Byblos" (per domande su Byblos)
- "Assistente Architettura" (per l'architettura)
- "Code Reviewer" (per rivedere il codice)
- ...

Ogni modello avrà le sue istruzioni (system prompt) e la sua Knowledge Base collegata.

Quando apri una chat, scegli il modello adatto al tipo di domanda che vuoi fare.

---

## 🎉 Congratulazioni!

Adesso conosci:
1. ✅ Come creare Knowledge Base
2. ✅ Come caricare i tuoi documenti
3. ✅ Come usare le KB nelle chat
4. ✅ Come creare modelli personalizzati

**Sei pronto a sfruttare il tuo assistente AI locale al 100%!**

Inizia a caricare i tuoi documenti e fai domande intelligenti. Buon lavoro! 🚀

---

## PARTE 9 - Aggiungere Nuove Informazioni 📝

Una Knowledge Base non è "una tantum" — la tieni viva aggiungendo continuamente nuove informazioni man mano che il progetto evolve.

### Come Aggiornare la Knowledge Base

**È semplicissimo:**

1. **Vai in Workspace > Knowledge**
   - Nella sidebar sinistra, clicca "Workspace"
   - Clicca la tab "Knowledge"

2. **Seleziona la Knowledge Base da aggiornare**
   - Clicca su "Byblos" (o il nome della KB che vuoi aggiornare)

3. **Aggiungi nuovo contenuto**
   - Clicca il **"+"** accanto alla barra di ricerca
   - Scegli tra:
     - **Upload Files** - carica nuovi file PDF, TXT, MD, DOCX
     - **Add Text Content** - scrivi o incolla testo direttamente

4. **I Nuovi Contenuti Sono Disponibili SUBITO**
   - Non devi riavviare nulla
   - Nella prossima chat, l'AI avrà già accesso alle informazioni nuove

5. **Per Rimuovere Contenuti Vecchi**
   - Vai nella pagina della Knowledge Base
   - Nella lista dei file/contenuti, clicca la **"X"** accanto a quello che vuoi eliminare
   - Conferma l'eliminazione

### Strategia Pratica: Tieni la KB Aggiornata

**Consiglio:** Non aspettare di avere 100 documenti da caricare. Aggiungi le cose gradualmente:

1. **Tieni un file "note-byblos.md"**
   - Appunta le cose importanti che scopri durante il lavoro
   - Domande ricorrenti dei colleghi
   - Decisioni architetturali
   - Problemi e soluzioni
   - Ogni settimana, aggiorna il file e ricaricalo nella KB

   **Esempio di note-byblos.md:**
   ```markdown
   # Note Byblos

   ## Endpoint Comuni
   - GET /api/users - Ottieni lista utenti
   - POST /api/users - Crea nuovo utente
   ...

   ## Problemi Noti
   - Se il servizio non risponde, controllare logs con:
     docker logs byblos_service
   ...

   ## Decisioni Architetturali
   - 2024-01-15: Abbiamo deciso di usare PostgreSQL per Byblos
   - 2024-02-01: Migrato a microservizi da monolito
   ...
   ```

2. **Ogni volta che prendi una decisione importante**
   - Scrivi un breve documento (anche 2-3 righe)
   - Aggiungilo alla KB con `Add Text Content`
   - Esempio: "2024-03-01: Cambiato il formato di risposta da XML a JSON"

3. **Messaggi Slack o Email importanti**
   - Se un collega posta qualcosa di utile su Slack
   - Copia il messaggio
   - Incollalo in `Add Text Content` della KB
   - La prossima domanda non necessiterà di cercare vecchi messaggi!

4. **Documenti di riferimento**
   - Link alla API documentation ufficiale
   - Link ai commit importanti su GitHub
   - Link a documenti condivisi
   - Puoi anche copiarli come testo dentro la KB per non dipendere da link esterni

**Risultato:** Una Knowledge Base sempre fresca, sempre utile, che cresce con il progetto. 📈

---

## PARTE 10 - Operazioni Quotidiane 📅

Ecco le operazioni che farai regolarmente.

### Avviare l'Ambiente ▶️

**Di solito, si avvia da solo!**

- Quando accendi il PC, Docker Desktop si avvia automaticamente
- I container si riavviano automaticamente (`restart: unless-stopped`)
- Dopo 1-2 minuti, tutto è pronto

**Se per qualche motivo non parte da solo:**
1. Apri **Esplora File**
2. Vai in `C:\Progetti\knowledge-assistant\scripts`
3. **Doppio click su `start-full.bat`** (se usi modalità Full)
   - Oppure **`start-hybrid.bat`** se usi modalità Ibrida
4. Attendi il caricamento (10-20 secondi)
5. Apri il browser su `http://localhost:3000`

### Fermare l'Ambiente ⏹️

**Quando vuoi fermare tutto:**

1. Apri **Esplora File**
2. Vai in `C:\Progetti\knowledge-assistant\scripts`
3. **Doppio click su `stop.bat`**
4. Vedrai i messaggi di arresto
5. Quando finisce, tutto è spento

**Alternativa:** Chiudi Docker Desktop dal menu Start. Ma questo ferma **tutti** i container di Docker, non solo i tuoi.

### Verificare Che Funzioni ✅

**Ci sono due modi:**

#### Metodo 1: Status Veloce

1. Vai in `scripts`
2. **Doppio click su `status.bat`**
3. Vedrai una tabella con lo stato dei container
4. Se vedi **"Up"** accanto a `ollama` e `open-webui` → tutto funziona! ✅

#### Metodo 2: Test Completo (se hai dubbi)

1. Vai in `scripts`
2. **Doppio click su `test-setup.bat`** (se esiste, altrimenti usa status.bat)
3. Il sistema verifica:
   - Docker è installato?
   - Docker Desktop è in esecuzione?
   - I container girano?
   - Ollama è raggiungibile?
   - Open WebUI risponde?
4. Se tutto è verde → perfetto! ✅

### Aggiornare il Sistema 🔄

**Se vuoi aggiornare Open WebUI o Ollama:**

1. **Ferma tutto:**
   - **Doppio click su `stop.bat`**

2. **Avvia di nuovo:**
   - **Doppio click su `start-full.bat`** (o `start-hybrid.bat`)
   - Docker scarica automaticamente le ultime versioni delle immagini
   - I tuoi dati restano intatti (chat, Knowledge Base, impostazioni)

3. **Non devi fare nulla di manuale!**
   - Docker gestisce tutto
   - Potrebbe durare 2-5 minuti la prima volta (download immagini)

### Routine Settimanale Consigliata

**Lunedì mattina:**
- Riavvia Docker Desktop (Ctrl+Alt+Canc → Task Manager → Docker Desktop → Riavvia)
- O semplice: fai `stop.bat` e `start-full.bat`

**Durante la settimana:**
- Aggiungi nuove informazioni alla Knowledge Base
- Ricarica il file "note-progetto.md" settimanalmente

**Venerdì:**
- Aggiorna il file "note-progetto.md" con le cose della settimana
- Caricalo nella KB

---

## 🆘 Aiuto! Problemi Rapidi

Se qualcosa non funziona, prova queste soluzioni velocissime:

### ❌ "Non funziona niente"

**Soluzione (95% dei casi):**
1. Riavvia Docker Desktop (chiudilo e riaprilo)
2. Aspetta che l'icona della balena 🐳 nel system tray diventi verde
3. **Doppio click su `scripts/start-full.bat`**
4. Aspetta 20-30 secondi
5. Apri `http://localhost:3000` nel browser
6. Funziona? ✅

### ❌ "Ho cancellato una chat per sbaglio"

**Buone notizie:**
- Le chat si salvano nel **volume Docker**
- I volumi persistono tra i riavvii
- Se il container era acceso quando hai cancellato, le chat potrebbero ancora essere nel database

**Cosa fare:**
- Se è un'eliminazione recente (ultimo minuto), il database potrebbe non aver salvato ancora
- Se è passato più tempo, purtroppo è persa
- Lezione: fai screenshot delle chat importanti!

### ❌ "Ho cancellato un documento dalla Knowledge Base per sbaglio"

**Stesso discorso come le chat:**
- Se è recente, il database potrebbe non aver salvato
- Se è passato tempo, è persa
- Lezione: tieni backup dei tuoi documenti sul PC

### ❌ "La Knowledge Base non trova informazioni che ho caricato"

1. **Verifica che il file sia stato processato:**
   - Vai in Workspace > Knowledge > seleziona la KB
   - Vedi una spunta verde ✅ accanto al file?
   - Se vedi un spinner (caricamento), aspetta che finisca

2. **Prova a ricaricare il file:**
   - A volte il processamento non va a buon fine per errori
   - Cancella il file (X accanto al nome)
   - Ricaricalo di nuovo

3. **Prova con testo puro:**
   - Se è un PDF, prova a copiare il testo in un `.txt` e caricare quello
   - I PDF con immagini possono dar problemi

### ❌ "Serve aiuto, non so cosa fare"

**Contatta il team:**
- Chiedi aiuto a [il responsabile del progetto] 😄
- Descrivi cosa hai fatto
- Fai uno screenshot della schermata di errore se c'è
- Avrai risposta velocemente!

---

## 📞 Contatti Rapidi

Se hai bisogno di aiuto, contatta:

**Responsabile Tecnico:**
- [Nome e contatto del responsabile]
- [Email o numero]

**Documentazione:**
- Leggi il `README.md` nella cartella principale per dettagli tecnici
- La sezione "Architettura Tecnica" spiega come funziona tutto

**Per Segnalare Bug:**
- Apri una issue su GitHub (se il progetto è su GitHub)
- O scrivi al responsabile

---

## 🎓 Prossimi Passi

Adesso che conosci tutto:

1. ✅ Installa Docker
2. ✅ Avvia il setup
3. ✅ Crea la tua Knowledge Base
4. ✅ Carica i documenti del tuo progetto
5. ✅ Usa l'AI locale per domande intelligenti

**Sei completo!** Continua a esplorare e scopri nuove features. Open WebUI ha tante altre cose che puoi fare — fidati e prova! 🚀

---

**Fine della guida.**

Buon lavoro, collega! Se questa guida ti è stata utile, condividila con i tuoi colleghi. 🤝

Domande? Rileggi la parte corrispondente (ogni parte è self-contained) oppure contatta il team.

Ciao! 👋
