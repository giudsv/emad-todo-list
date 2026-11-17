import 'package:flutter/material.dart';

/// Mostra il numero di attività completate sul totale, con una barra di
/// avanzamento.
class ContatoreAttivita extends StatelessWidget {
  const ContatoreAttivita({
    super.key,
    required this.completate,
    required this.totale,
  });

  final int completate;
  final int totale;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: tema.colorScheme.primaryContainer.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Completate: $completate su $totale',
            style: tema.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: totale == 0 ? 0 : completate / totale,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
