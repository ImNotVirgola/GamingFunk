# GamingFunk

E-commerce per la vendita di videogiochi e prodotti gaming, sviluppato come progetto per l'esame di **Tecnologie e Sviluppo per il Web** del Corso di Laurea in Informatica (classe L-31) presso l'**Università degli Studi di Salerno**.

L'applicazione è una web app Java EE che permette agli utenti di sfogliare un catalogo di prodotti, gestire un carrello, effettuare ordini e amministrare il proprio account, con un'area riservata per la gestione amministrativa del catalogo.

---

## Indice

- [Funzionalità](#funzionalità)
- [Architettura](#architettura)
- [Stack tecnologico](#stack-tecnologico)
- [Struttura del progetto](#struttura-del-progetto)
- [Installazione e avvio](#installazione-e-avvio)
- [Sicurezza](#sicurezza)
- [Contributi](#contributi)
- [Autori](#autori)

---

## Funzionalità

- **Catalogo prodotti**: visualizzazione e ricerca dei videogiochi/prodotti disponibili.
- **Carrello**: aggiunta, modifica e rimozione dei prodotti prima dell'acquisto.
- **Gestione ordini**: finalizzazione dell'acquisto e storico degli ordini effettuati.
- **Account utente**: registrazione, login e gestione dei dati personali.
- **Area amministrativa**: gestione del catalogo (inserimento, modifica, rimozione prodotti).

> Nota: l'elenco riflette le funzionalità principali; per il dettaglio completo consultare il codice in `src/main`.

## Architettura

Il progetto adotta il pattern architetturale **MVC (Model–View–Controller)**:

- **Model**: classi di dominio (bean) e classi DAO per l'accesso ai dati tramite **JDBC**.
- **View**: pagine **JSP** per la presentazione, con fogli di stile **CSS** e logica lato client in **JavaScript**.
- **Controller**: **Servlet** che ricevono le richieste, coordinano la logica applicativa e instradano verso la view appropriata.

L'accesso al database è centralizzato nei DAO, mantenendo separati lo strato di presentazione e quello di persistenza.

## Stack tecnologico

| Ambito | Tecnologia |
|--------|------------|
| Linguaggio | Java |
| Web layer | JSP, Servlet |
| Persistenza | JDBC |
| Database | MariaDB / MySQL |
| Front-end | HTML, CSS, JavaScript |
| Application server | GlassFish |
| IDE | Eclipse |

## Struttura del progetto

```
GamingFunk/
├── src/main/          # Codice sorgente (package it.unisa): bean, DAO, servlet, JSP, risorse statiche
├── build/             # Output di compilazione
├── .classpath         # Configurazione classpath Eclipse
├── .project           # Configurazione progetto Eclipse
└── .settings/         # Impostazioni Eclipse
```

## Installazione e avvio

> Prerequisiti: Java JDK, GlassFish, MariaDB/MySQL, Eclipse (consigliato).

1. **Clona il repository**
   ```bash
   git clone https://github.com/ImNotVirgola/GamingFunk.git
   ```
2. **Crea il database** importando lo script SQL fornito nel progetto:
   ```bash
   mysql -u <utente> -p < <percorso_script>.sql
   ```
3. **Configura la connessione al database** (URL, utente, password) nel punto in cui i DAO inizializzano la connessione JDBC.
4. **Importa il progetto in Eclipse** (`File > Import > Existing Projects into Workspace`).
5. **Esegui il deploy** dell'applicazione su GlassFish e avvia il server.
6. Apri il browser su `http://localhost:<porta>/GamingFunk`.

## Sicurezza

Particolare attenzione è stata dedicata alla protezione delle pagine e dei dati:

- Gestione delle sessioni e controllo degli accessi alle aree riservate (utente/amministratore).
- Validazione degli input lato server per ridurre il rischio di richieste malevole.
- Uso di query parametrizzate (PreparedStatement) per prevenire SQL injection.

> Adatta questa sezione alle misure effettivamente implementate nel codice.

## Contributi

Progetto sviluppato in gruppo. Suddivisione principale del lavoro:

- **Riccardo Di Girolamo** ([@ImNotVirgola](https://github.com/ImNotVirgola)) — ruolo principale di sviluppo: progettazione della struttura del database, impostazione dello scheletro dell'applicazione, sviluppo del layout e dei fogli di stile (CSS) e gestione della sicurezza delle pagine.
- Altri membri del gruppo — `Giovanni Esposito, Marianna Diograzia`.

## Autori

- Riccardo Di Girolamo — [github.com/ImNotVirgola](https://github.com/ImNotVirgola)
- Giovanni Esposito — [github.com/GioVan1098](https://github.com/GioVan1098)
- Marianna Diograzia
---

*Progetto realizzato a scopo didattico nell'ambito del corso di Tecnologie e Sviluppo per il Web — Università degli Studi di Salerno.*
