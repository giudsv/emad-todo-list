# EMAD – To-do list (Task 2)

App Flutter per la gestione di una lista di attività, realizzata per il corso EMAD.

## Funzionalità

| Requisito | Come si usa |
|---|---|
| **R1 – Aggiungere attività** | Pulsante **"Nuova attività"** → inserire il titolo (obbligatorio) e, se serve, attivare **Importante** → **"Aggiungi attività"**. Al ritorno compare un messaggio di conferma. Se il titolo manca viene mostrato un errore, che scompare appena lo si corregge. Tornando indietro senza confermare non viene creato nulla. |
| **R2 – Consultare le attività** | L'elenco mostra per ogni attività titolo, stato (*Da fare* / *Completata*) e importanza (stella ⭐), più il conteggio **"Completate: X su Y"**. Se l'elenco è vuoto viene spiegato come aggiungere un'attività. |
| **R3 – Aggiornare lo stato** | Toccare l'attività (o la sua casella) per segnarla come completata o riportarla a "da fare". Il conteggio si aggiorna subito. |
| **R4 – Eliminare attività** | Icona del cestino oppure scorrimento verso sinistra → conferma nella finestra di dialogo. Con **"Annulla"** l'attività resta invariata. |

## Struttura del codice

```
lib/
├── main.dart                         # Avvio dell'app e tema
├── models/attivita.dart              # Entità Attività (titolo, stato, importanza)
├── screens/
│   ├── elenco_attivita_screen.dart   # Elenco + stato dell'app (StatefulWidget)
│   └── nuova_attivita_screen.dart    # Form di creazione con validazione
└── widgets/
    ├── attivita_tile.dart            # Riga di una singola attività
    ├── contatore_attivita.dart       # Conteggio completate / totale
    └── elenco_vuoto.dart             # Indicazione per elenco vuoto
test/widget_test.dart                 # Test dei vari scenari (S1–S4)
```

La navigazione usa `Navigator.push`/`pop`: la schermata di creazione restituisce l'attività creata, oppure `null` se l'utente rinuncia.

## Esecuzione

```bash
flutter pub get
flutter run
flutter test
```
