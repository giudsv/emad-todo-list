import 'package:flutter/material.dart';

import '../models/attivita.dart';

/// Schermata di creazione di una nuova attività (S1).
///
/// Se l'utente conferma, la schermata si chiude restituendo l'[Attivita]
/// creata; se torna indietro (freccia o tasto "indietro" del dispositivo)
/// restituisce `null` e nessuna attività viene creata.
class NuovaAttivitaScreen extends StatefulWidget {
  const NuovaAttivitaScreen({super.key});

  @override
  State<NuovaAttivitaScreen> createState() => _NuovaAttivitaScreenState();
}

class _NuovaAttivitaScreenState extends State<NuovaAttivitaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titoloController = TextEditingController();
  bool _importante = false;

  // Dopo il primo tentativo di conferma fallito, il campo viene rivalidato
  // a ogni modifica: così l'errore sparisce appena il titolo viene corretto.
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _titoloController.dispose();
    super.dispose();
  }

  String? _validaTitolo(String? valore) {
    if (valore == null || valore.trim().isEmpty) {
      return 'Il titolo è obbligatorio';
    }
    return null;
  }

  void _conferma() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
      return;
    }
    Navigator.of(context).pop(
      Attivita(
        titolo: _titoloController.text.trim(),
        importante: _importante,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuova attività'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titoloController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Titolo *',
                hintText: 'Es. Studiare Flutter',
                prefixIcon: Icon(Icons.edit_note),
                border: OutlineInputBorder(),
              ),
              validator: _validaTitolo,
              onFieldSubmitted: (_) => _conferma(),
            ),
            const SizedBox(height: 16),
            Card(
              margin: EdgeInsets.zero,
              child: SwitchListTile(
                value: _importante,
                onChanged: (valore) => setState(() => _importante = valore),
                secondary: Icon(
                  _importante ? Icons.star : Icons.star_border,
                  color: _importante ? Colors.amber.shade700 : null,
                ),
                title: const Text('Importante'),
                subtitle: const Text('Evidenzia l\'attività nell\'elenco'),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _conferma,
              icon: const Icon(Icons.check),
              label: const Text('Aggiungi attività'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
