import 'package:flutter/material.dart';

import '../models/attivita.dart';
import '../widgets/attivita_tile.dart';
import '../widgets/contatore_attivita.dart';
import '../widgets/elenco_vuoto.dart';
import 'nuova_attivita_screen.dart';

/// Schermata principale: mostra l'elenco delle attività (S2) e permette
/// di aggiungerne (S1), cambiarne lo stato (S3) ed eliminarle (S4).
class ElencoAttivitaScreen extends StatefulWidget {
  const ElencoAttivitaScreen({super.key});

  @override
  State<ElencoAttivitaScreen> createState() => _ElencoAttivitaScreenState();
}

class _ElencoAttivitaScreenState extends State<ElencoAttivitaScreen> {
  final List<Attivita> _attivita = [];

  int get _numeroCompletate => _attivita.where((a) => a.completata).length;

  /// S1 – Aggiungere un'attività.
  Future<void> _aggiungiAttivita() async {
    final nuova = await Navigator.of(context).push<Attivita>(
      MaterialPageRoute(builder: (_) => const NuovaAttivitaScreen()),
    );

    // Variante "rinuncia": l'utente è tornato indietro senza confermare.
    if (nuova == null || !mounted) return;

    setState(() => _attivita.add(nuova));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Attività "${nuova.titolo}" aggiunta')),
      );
  }

  /// S3 – Aggiornare lo stato di un'attività.
  void _cambiaStato(Attivita attivita) {
    setState(() => attivita.completata = !attivita.completata);
  }

  /// S4 – Chiede conferma prima di eliminare. Restituisce true se confermato.
  Future<bool> _chiediConfermaEliminazione(Attivita attivita) async {
    final conferma = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminare l\'attività?'),
        content: Text('"${attivita.titolo}" verrà eliminata definitivamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );
    return conferma ?? false;
  }

  Future<void> _eliminaConConferma(Attivita attivita) async {
    if (await _chiediConfermaEliminazione(attivita)) {
      _rimuovi(attivita);
    }
  }

  void _rimuovi(Attivita attivita) {
    setState(() => _attivita.remove(attivita));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Le mie attività'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          ContatoreAttivita(
            completate: _numeroCompletate,
            totale: _attivita.length,
          ),
          Expanded(
            child: _attivita.isEmpty
                ? const ElencoVuoto()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 88),
                    itemCount: _attivita.length,
                    itemBuilder: (context, index) {
                      final attivita = _attivita[index];
                      return Dismissible(
                        key: ValueKey(attivita.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Theme.of(context).colorScheme.error,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.onError,
                          ),
                        ),
                        confirmDismiss: (_) =>
                            _chiediConfermaEliminazione(attivita),
                        onDismissed: (_) => _rimuovi(attivita),
                        child: AttivitaTile(
                          attivita: attivita,
                          onCambiaStato: () => _cambiaStato(attivita),
                          onElimina: () => _eliminaConConferma(attivita),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _aggiungiAttivita,
        icon: const Icon(Icons.add),
        label: const Text('Nuova attività'),
      ),
    );
  }
}
