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

**Prossima parte: Primo accesso a Open WebUI!**

Quando sei pronto, continua con la guida per accedere all'interfaccia del tuo assistente AI. 👋
