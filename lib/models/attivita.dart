/// L'unica entità gestita dall'app: un'attività della to-do list.
class Attivita {
  Attivita({
    required this.titolo,
    this.importante = false,
    this.completata = false,
  }) : id = (_contatore++).toString();

  static int _contatore = 0;

  /// Identificativo univoco, usato come chiave dei widget nell'elenco.
  final String id;

  /// Testo obbligatorio che descrive l'attività.
  final String titolo;

  /// Se l'attività è importante (per default no).
  final bool importante;

  /// Stato dell'attività: `false` = da fare, `true` = completata.
  /// Una nuova attività è sempre "da fare".
  bool completata;
}
