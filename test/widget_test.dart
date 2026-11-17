import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emad_todo/main.dart';

Future<void> aggiungi(WidgetTester tester, String titolo,
    {bool importante = false}) async {
  await tester.tap(find.text('Nuova attività'));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextFormField), titolo);
  if (importante) await tester.tap(find.byType(Switch));
  await tester.tap(find.text('Aggiungi attività'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('S2 variante: elenco vuoto mostra indicazione', (tester) async {
    await tester.pumpWidget(const TodoApp());
    expect(find.text('Nessuna attività'), findsOneWidget);
    expect(find.text('Completate: 0 su 0'), findsOneWidget);
  });

  testWidgets('S1: aggiunta con messaggio di conferma', (tester) async {
    await tester.pumpWidget(const TodoApp());
    await aggiungi(tester, 'Studiare Flutter', importante: true);

    expect(find.text('Studiare Flutter'), findsOneWidget);
    expect(find.text('Importante'), findsOneWidget);
    expect(find.text('Da fare'), findsOneWidget);
    expect(find.text('Completate: 0 su 1'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('S1 variante: titolo mancante, errore che poi scompare',
      (tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.tap(find.text('Nuova attività'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Aggiungi attività'));
    await tester.pump();
    expect(find.text('Il titolo è obbligatorio'), findsOneWidget);
    expect(find.text('Aggiungi attività'), findsOneWidget); // ancora nel form

    await tester.enterText(find.byType(TextFormField), 'Spesa');
    await tester.pump();
    expect(find.text('Il titolo è obbligatorio'), findsNothing);
  });

  testWidgets('S1 variante: rinuncia con "indietro"', (tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.tap(find.text('Nuova attività'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Non salvare');

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Non salvare'), findsNothing);
    expect(find.text('Nessuna attività'), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('S3: cambio di stato aggiorna il conteggio', (tester) async {
    await tester.pumpWidget(const TodoApp());
    await aggiungi(tester, 'Palestra');

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('Completata'), findsOneWidget);
    expect(find.text('Completate: 1 su 1'), findsOneWidget);

    await tester.tap(find.text('Palestra'));
    await tester.pump();
    expect(find.text('Da fare'), findsOneWidget);
    expect(find.text('Completate: 0 su 1'), findsOneWidget);
  });

  testWidgets('S4: eliminazione con conferma e rinuncia', (tester) async {
    await tester.pumpWidget(const TodoApp());
    await aggiungi(tester, 'Bollette');

    // Rinuncia
    await tester.tap(find.byTooltip('Elimina'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Annulla'));
    await tester.pumpAndSettle();
    expect(find.text('Bollette'), findsOneWidget);

    // Conferma
    await tester.tap(find.byTooltip('Elimina'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Elimina'));
    await tester.pumpAndSettle();
    expect(find.text('Bollette'), findsNothing);
    expect(find.text('Completate: 0 su 0'), findsOneWidget);
  });
}
