import 'package:flutter/material.dart';

/// Indicazione mostrata quando non ci sono attività (S2, variante).
class ElencoVuoto extends StatelessWidget {
  const ElencoVuoto({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.checklist, size: 80, color: tema.colorScheme.outline),
            const SizedBox(height: 16),
            Text('Nessuna attività', style: tema.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Tocca il pulsante "Nuova attività" in basso per aggiungerne una.',
              textAlign: TextAlign.center,
              style: tema.textTheme.bodyMedium?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
