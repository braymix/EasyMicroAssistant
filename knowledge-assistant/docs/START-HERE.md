# 🚀 KNOWLEDGE ASSISTANT — Guida Completa da Zero

**Indice Veloce:**
- [Cos'è Knowledge Assistant?](#cos'è)
- [Cosa Ti Serve](#cosa-ti-serve)
- [Fase 1: Download](#fase-1-download-della-repo)
- [Fase 2: Installazione Docker](#fase-2-installazione-docker)
- [Fase 3: Setup Automatico](#fase-3-setup-automatico)
- [Fase 4: Primo Accesso](#fase-4-primo-accesso)
- [Fase 5: Creazione Knowledge Base](#fase-5-creazione-knowledge-base)
- [Fase 6: Uso Pratico](#fase-6-uso-pratico)
- [Operazioni Comuni](#operazioni-comuni)
- [Backup e Restore](#backup-e-restore)
- [Se Qualcosa Non Funziona](#se-qualcosa-non-funziona)

---

## Cos'è?

Knowledge Assistant è **un assistente AI locale** che gira interamente sul tuo PC.

**Senza internet, senza cloud, senza limiti.**

- **Ollama**: Il "motore" che fa girare i modelli AI (llama, mistral, ecc.)
- **Open WebUI**: L'interfaccia web dove scrivi domande (simile a ChatGPT)
- **Knowledge Base**: Carica i tuoi documenti e l'AI risponde basandosi su quelli

### Perché usare Knowledge Assistant?

✅ **Privacy totale** — tutto rimane sul tuo PC
✅ **Gratis** — nessun abbonamento, nessun costo
✅ **Offline** — funziona senza internet
✅ **Specializzato** — risposte specifiche sui tuoi progetti
✅ **Niente Limiti** — niente rate limit, niente throttling

---

## Cosa Ti Serve

Prima di iniziare, verifica che hai:

| Requisito | Dettagli |
|-----------|----------|
| **Sistema Operativo** | Windows 10 o 11 (64-bit) |
| **RAM** | Minimo 8 GB (16 GB consigliato) |
| **Spazio Disco** | Minimo 15 GB liberi |
| **Internet** | Solo per il primo download (~5-10 GB di dati) |
| **Tempo** | ~30 minuti per il setup completo |

### Controlla la tua RAM

1. Clicca con tasto destro su **"Questo PC"** (Desktop o Esplora File)
2. Clicca **"Proprietà"**
3. Guarda **"RAM installata"** — deve dire almeno "8.0 GB"

---

## FASE 1: Download della Repo

### Opzione A: ZIP (Più Semplice) ⭐ CONSIGLIATO

Se qualcuno ti ha passato il file:

1. **Estrai il file ZIP:**
   - Clicca destro sul file `.zip`
   - **"Estrai qui"** oppure **"Estrai tutto"**

2. **Ricorda dove l'hai estratto** (es. `C:\Progetti\knowledge-assistant`)

3. **Vai alla cartella estratta** — contiene tutto quello che serve

### Opzione B: Git Clone (Se Conosci Git)

Se preferisci da terminale:

```bash
git clone https://github.com/braymix/easymicroassistant.git
cd easymicroassistant/knowledge-assistant
```

### Struttura della Cartella

Una volta estratto, vedrai:

```
knowledge-assistant/
├── README.md                    ← Documentazione principale
├── docker-compose.full.yml      ← Configurazione Docker (non toccare)
├── docker-compose.hybrid.yml    ← Alternativa Docker (non toccare)
├── .env.example                 ← Impostazioni (non toccare)
│
├── docs/
│   ├── START-HERE.md           ← Questa guida!
│   ├── GUIDA-COLLEGHI.md       ← Per utenti non tecnici
│   └── knowledge/              ← Cartella per i tuoi documenti
│
└── scripts/
    ├── setup-windows.bat       ← Setup automatico (CLICCA QUI!) ⭐
    ├── start-full.bat          ← Avvia il sistema
    ├── stop.bat                ← Ferma il sistema
    ├── pull-model.bat          ← Scarica modelli
    ├── status.bat              ← Verifica stato
    ├── test-setup.bat          ← Testa la configurazione
    └── backup.bat              ← Backup dati
```

---

## FASE 2: Installazione Docker

Docker è il "contenitore" in cui gira tutto. È **obbligatorio**.

### Step 1️⃣ - Scarica Docker Desktop

1. Apri il browser
2. Vai a: **https://www.docker.com/products/docker-desktop/**
3. Clicca il bottone blu **"Download for Windows"**
4. Scaricherà un file `.exe` (~500 MB)

### Step 2️⃣ - Installa Docker

1. **Doppio click** sul file `.exe` scaricato
2. Se Windows chiede permessi → clicca **"SÌ"**
3. Segui l'installazione (clicca "Next" per continuare)
4. **IMPORTANTE:** Quando vedi la checkbox **"Use WSL 2"** → metti la spunta ✅

### Step 3️⃣ - Riavvia il PC

1. Quando l'installazione finisce, **riavvia il PC**
2. Docker Desktop si avvierà automaticamente dopo il riavvio
3. Aspetta che l'icona della balena 🐳 nel system tray diventi **verde**

### Step 4️⃣ - Verifica l'Installazione

1. Apri il **Prompt dei Comandi:**
   - Clicca **Start** → scrivi `cmd` → premi **Invio**

2. Scrivi questo comando:
   ```
   docker --version
   ```

3. Dovresti vedere:
   ```
   Docker version 25.0.0, build abc123def
   ```

✅ Se vedi il numero di versione → Docker è installato correttamente!

---

## FASE 3: Setup Automatico

Il file `setup-windows.bat` fa tutto da solo. Permette di scegliere tra:
- **Modalità Full**: Tutto in Docker (consigliato)
- **Modalità Ibrida**: Solo Open WebUI in Docker, Ollama nativo

### Step 1️⃣ - Apri la Cartella Scripts

1. Apri **Esplora File**
2. Naviga dove hai estratto la cartella (es. `C:\Progetti\knowledge-assistant`)
3. Apri la cartella **`scripts`**

### Step 2️⃣ - Avvia il Setup

1. Cerca il file **`setup-windows.bat`**
2. **Doppio click** su di esso
3. Si apre una **finestra nera** (il Prompt dei Comandi)

### Step 3️⃣ - Segui le Istruzioni

La finestra ti farà 4 domande:

**Domanda 1:** "Tutto è configurato?"
- Risponde automaticamente (verifica Docker, permessi, ecc.)

**Domanda 2:** "Quale modalità vuoi?"
```
[1] Tutto in Docker (consigliato)
[2] Modalità ibrida (ho già Ollama)
```
- Scrivi **`1`** e premi **Invio** (se non sai cosa scegliere)

**Domanda 3:** Scaricamento e avvio
- La finestra inizia a scaricare le immagini Docker
- **NON toccare nulla**, aspetta
- Visualizzerai messaggi tipo "Pulling image..." o "Starting container..."

**Domanda 4:** Scaricamento modello
- Dopo l'avvio, scarica il modello AI di default (`llama3.2:3b`)
- Questo può durare **5-15 minuti** a seconda della connessione

### Step 4️⃣ - Finito!

Quando vedi questo messaggio, sei a buon punto:
```
============================================================
   SETUP COMPLETATO CON SUCCESSO!
============================================================

  Apri il browser su: http://localhost:3000
```

✅ Lo script è terminato correttamente!

---

## FASE 4: Primo Accesso

### Step 1️⃣ - Apri il Browser

1. Qualsiasi browser: Chrome, Edge, Firefox, Safari
2. Nella barra degli indirizzi, scrivi:
   ```
   http://localhost:3000
   ```
3. Premi **Invio**

### Step 2️⃣ - Pagina di Login

Dovresti vedere una pagina con:
- **"Sign In"** (Accedi) — per chi ha già un account
- **"Sign Up"** (Registrati) — per il primo accesso

### Step 3️⃣ - Registrati

1. Clicca **"Sign Up"**
2. Compila i campi:
   ```
   Nome:              Il Tuo Nome
   Email:             tuo@email.com (può essere fittizia!)
   Password:          Una password sicura
   Conferma Password: Stessa password
   ```
3. Clicca **"Sign Up"**

**⚠️ Nota:** Il **primo utente** diventa **ADMIN**. Se è la prima volta, il tuo account avrà pieni poteri.

### Step 4️⃣ - Sei Dentro!

Adesso vedi l'interfaccia di Open WebUI:

```
┌─────────────────────────────────────────┐
│ [≡] Menu          | Workspace            │
├─────────────────────────────────────────┤
│ Sidebar:          │   Chat Area:        │
│ • New Chat        │   - Selettore Model │
│ • Workspace       │   - Messaggi        │
│ • Settings        │   - Barra testo     │
│                   │   (qui scrivi!)     │
└─────────────────────────────────────────┘
```

---

## FASE 5: Creazione Knowledge Base

Una **Knowledge Base** è dove carichi i tuoi documenti. L'AI li userà per rispondere alle domande.

### Step 1️⃣ - Vai a Workspace

1. Nella sidebar sinistra, clicca **"Workspace"**
2. In alto vedrai le **tab**: Documents, Knowledge, Models, ecc.

### Step 2️⃣ - Clicca su Knowledge

1. Clicca la tab **"Knowledge"**
2. Vedrai una lista (probabilmente vuota)

### Step 3️⃣ - Crea una Nuova KB

1. In alto a destra, clicca il bottone **"+"**
2. Si apre una form:
   ```
   Nome:        Byblos
   Descrizione: Documentazione del progetto Byblos
   ```
3. Clicca **"Create Knowledge"**

### Step 4️⃣ - Carica Documenti

1. Sei adesso nella pagina della KB
2. A destra della barra di ricerca, clicca il **"+"**
3. Scegli:
   - **"Upload Files"** — se hai file PDF, TXT, MD
   - **"Add Text Content"** — se vuoi scrivere testo direttamente

4. Se scegli Upload Files:
   - Seleziona uno o più file dal tuo PC
   - Clicca **"Apri"**

5. Aspetta il **caricamento** (vedrai un'icona di spinning)

6. Quando finisce, il file appare nella lista con una **spunta verde ✅**

✅ **I tuoi documenti sono pronti!**

---

## FASE 6: Uso Pratico

Adesso che hai una Knowledge Base con documenti, puoi fare domande intelligenti.

### Come Usare la Knowledge Base in Chat

1. **Apri una nuova chat** → clicca **"New Chat"** nella sidebar

2. **Seleziona il modello** → in alto a sinistra, clicca il selettore

3. **Attiva la Knowledge Base** → nel campo testo scrivi **`#`**
   - Apparirà un menu con le tue KB
   - Clicca **"Byblos"**

4. **Scrivi la domanda:**
   ```
   [Byblos] Quali sono gli endpoint REST?
   ```

5. **Premi Invio** → l'AI cercherà nei tuoi documenti e risponderà

### Esempio Pratico Completo

**Scenario:** Hai caricato la documentazione del microservizio Byblos (un PDF con endpoint, database, workflow)

**Tu scrivi:**
```
[Byblos] Come creo un nuovo utente?
```

**L'AI risponde:**
```
Secondo la documentazione di Byblos, per creare un nuovo utente:

1. Chiama l'endpoint POST /api/users
2. Body della richiesta:
{
  "name": "Mario Rossi",
  "email": "mario@example.com"
}
3. La risposta contiene l'ID dell'utente creato

Vedi la sezione "User Management" della documentazione per i dettagli.
```

### Creare un Modello Personalizzato (Opzionale)

Se usi spesso la stessa Knowledge Base, crea un modello custom per non digitare `#Byblos` ogni volta:

1. **Workspace > Models > "+"**
2. Riempi:
   ```
   Nome:        Assistente Byblos
   Base Model:  llama3.2:3b
   Knowledge:   Byblos
   System Prompt:

   Sei un esperto di Byblos.
   Rispondi sempre basandoti sulla documentazione.
   Se non trovi info, dillo chiaramente.
   Rispondi in italiano.
   ```

3. Clicca **"Salva"**

4. La prossima volta, seleziona **"Assistente Byblos"** e la KB è già utenteta!

---

## Operazioni Comuni

### Avviare il Sistema

**Di solito si avvia da solo** quando accendi il PC (Docker Desktop + restart automatico).

**Se non parte:**
1. Vai in `scripts`
2. Doppio click su **`start-full.bat`**
3. Aspetta 20-30 secondi
4. Apri `http://localhost:3000` nel browser

### Fermare il Sistema

1. Vai in `scripts`
2. Doppio click su **`stop.bat`**
3. Aspetta che finisca (vedrai i messaggi di arresto)

### Verificare che Funzioni

1. Vai in `scripts`
2. Doppio click su **`status.bat`**
3. Vedrai una tabella con lo stato dei container
4. Se vedi **"Up"** accanto a ollama e open-webui → tutto funziona ✅

### Scaricare Nuovi Modelli

**Opzione A - Dalla UI:**
1. In Open WebUI, clicca il selettore modelli
2. Digita il nome (es. `mistral`)
3. Clicca il bottone "Pull"
4. Aspetta il download

**Opzione B - Da Script:**
1. Vai in `scripts`
2. Doppio click su **`pull-model.bat`**
3. Scrivi il nome del modello
4. Premi Invio e aspetta

### Modelli Consigliati

| Modello | Uso | Dimensione |
|---------|-----|-----------|
| `llama3.2:3b` ⭐ | Iniziare, test | ~2 GB |
| `llama3.2:8b` | Uso generale | ~4.7 GB |
| `mistral` | Coding | ~4 GB |
| `qwen2.5-coder:7b` | Codice, tecnico | ~4.5 GB |

---

## Backup e Restore

### Fare un Backup

1. Vai in `scripts`
2. Doppio click su **`backup.bat`**
3. Vedrai:
   ```
   [3/3] Eseguo il backup del volume...
   ✓ BACKUP COMPLETATO!
   Backup salvato in: backups/openwebui-backup-20260325.tar.gz
   Dimensione: 2.34 GB
   ```

4. Il file è in `backups/openwebui-backup-YYYYMMDD.tar.gz`

5. **Consiglio:** Copia il file in una cartella esterna (pen drive, cloud, disco esterno)

### Ripristinare da un Backup

Se qualcosa va male e vuoi ripristinare:

1. **Ferma il sistema:**
   ```
   scripts\stop.bat
   ```

2. **Rimuovi il volume corrente:**
   ```
   docker volume rm open-webui
   ```

3. **Estrai il backup:**
   - Apri il file `openwebui-backup-YYYYMMDD.tar.gz`
   - Estrai con un tool (7-Zip, WinRAR)
   - Segui i passaggi per ripristinare nel volume (tecnico)

**Oppure contatta il team se non sai come fare.**

---

## Se Qualcosa Non Funziona

### "Non si apre http://localhost:3000"

**Causa:** Docker non è avviato
**Soluzione:**
1. Apri Docker Desktop dal menu Start
2. Aspetta che l'icona della balena diventi verde
3. Riprova il browser

### "Dice: 'Docker non trovato' oppure 'Docker not found'"

**Causa:** Docker non è installato
**Soluzione:**
1. Scarica e installa Docker Desktop da https://www.docker.com/products/docker-desktop/
2. Riavvia il PC
3. Riprova

### "Nessun modello disponibile nella chat"

**Causa:** Non hai scaricato nessun modello
**Soluzione:**
1. Doppio click su `scripts/pull-model.bat`
2. Scrivi `llama3.2:3b` e premi Invio
3. Aspetta 5-15 minuti (dipende dalla connessione)
4. Riprova la chat

### "Le risposte sono molto lente"

**Causa:** Modello troppo grande per la tua RAM
**Soluzione:**
1. Usa un modello più piccolo (`llama3.2:3b` invece di `8b`)
2. Oppure chiudi altri programmi per liberare RAM

### "La Knowledge Base non trova le informazioni"

**Causa:** Il file non è stato processato bene
**Soluzione:**
1. Vai in Workspace > Knowledge > seleziona la KB
2. Controlla che il file abbia una **spunta verde ✅**
3. Se vedi un'icona di caricamento, aspetta
4. Se non funziona, cancella il file (X) e ricaricalo

### "Ho cancellato qualcosa per sbaglio"

**Buone notizie:** I dati si salvano nel volume Docker
**Se è recente:** Il database potrebbe non aver salvato ancora
**Se è passato tempo:** Sfortunatamente è perso
**Prevenzione:** Fai backup regolarmente con `backup.bat`

### "Ho altri problemi"

1. **Verifica lo stato:**
   ```
   scripts\test-setup.bat
   ```
   Questo testa tutto il sistema

2. **Leggi i log:**
   ```
   docker compose logs -f
   ```

3. **Contatta il team** con lo screenshot dell'errore

---

## Checkpoints Finali

Prima di iniziare veramente, assicurati di aver fatto:

- [ ] Scaricato e estratto la cartella
- [ ] Installato Docker Desktop
- [ ] Eseguito `setup-windows.bat`
- [ ] Visto il messaggio "SETUP COMPLETATO!"
- [ ] Aperto `http://localhost:3000` nel browser
- [ ] Fatto Sign Up e creato un account
- [ ] Creato una Knowledge Base di test
- [ ] Caricato un documento test
- [ ] Fatto una domanda using la Knowledge Base

✅ Se hai fatto tutto → **sei completamente setup!**

---

## Cosa Fare Adesso

1. **Crea Knowledge Base** per i tuoi progetti (Byblos, Architettura, Guidelines, ecc.)
2. **Carica documenti** (API docs, README, guide, appunti)
3. **Fai domande** all'AI basandoti sui tuoi documenti
4. **Scopri nuove cose** — il sistema ha molte features!
5. **Fai backup** regolarmente con `backup.bat`

---

## Link Utili

- 📖 **README.md** — Documentazione tecnica completa
- 👥 **GUIDA-COLLEGHI.md** — Per chi non è tecnico
- 🔧 **Architettura Tecnica** — Come funziona tutto (nel README.md)
- 🐳 **Docker Docs** — https://docs.docker.com/
- 🧠 **Ollama Library** — https://ollama.com/library

---

## Prossimi Step Avanzati (Opzionali)

Una volta che padroneggi il basics:

- **Crea modelli personalizzati** con system prompt custom
- **Usa RAG avanzato** con chunk size personalizzato
- **Aggiungi embedding model** più potenti
- **Esporta chat** in vari formati
- **Integra APIs** esterne (se supportate)
- **Fai backup automatici** settimanali

---

**Sei pronto a partire! 🚀**

Se hai dubbi, rilleggi questa guida sezione per sezione.
Se hai problemi, controlla la sezione "Se Qualcosa Non Funziona".
Se vuoi aiuto, contatta il team.

**Buon lavoro con il tuo assistente AI locale!** 🤖✨
