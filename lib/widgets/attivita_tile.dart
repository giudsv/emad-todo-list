import 'package:flutter/material.dart';

import '../models/attivita.dart';

/// Riga dell'elenco che mostra titolo, stato e importanza di un'attività.
class AttivitaTile extends StatelessWidget {
  const AttivitaTile({
    super.key,
    required this.attivita,
    required this.onCambiaStato,
    required this.onElimina,
  });

  final Attivita attivita;
  final VoidCallback onCambiaStato;
  final VoidCallback onElimina;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final completata = attivita.completata;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: attivita.importante && !completata
          ? Colors.amber.shade50
          : null,
      child: ListTile(
        onTap: onCambiaStato,
        leading: Checkbox(
          value: completata,
          onChanged: (_) => onCambiaStato(),
        ),
        title: Text(
          attivita.titolo,
          style: tema.textTheme.titleMedium?.copyWith(
            decoration: completata ? TextDecoration.lineThrough : null,
            color: completata ? tema.colorScheme.outline : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              _Etichetta(
                testo: completata ? 'Completata' : 'Da fare',
                icona: completata ? Icons.check_circle : Icons.schedule,
                colore: completata ? Colors.green.shade700 : Colors.blueGrey,
              ),
              if (attivita.importante)
                _Etichetta(
                  testo: 'Importante',
                  icona: Icons.star,
                  colore: Colors.amber.shade800,
                ),
            ],
          ),
        ),
        trailing: IconButton(
          tooltip: 'Elimina',
          icon: const Icon(Icons.delete_outline),
          onPressed: onElimina,
        ),
      ),
    );
  }
}

class _Etichetta extends StatelessWidget {
  const _Etichetta({
    required this.testo,
    required this.icona,
    required this.colore,
  });

  final String testo;
  final IconData icona;
  final Color colore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colore.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icona, size: 14, color: colore),
          const SizedBox(width: 4),
          Text(
            testo,
            style: TextStyle(
              color: colore,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
