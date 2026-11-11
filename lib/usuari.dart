class User {
  final String _id;
  final String _nomComplet;
  double _saldo;

  String correu;
  bool esVIP;

  // Constructor nombrat (saldo inicial a 0.0 per defecte)
  User.nou({
    required String id,
    required String nom,
    required this.correu,
    this.esVIP = false,
  })  : _id = id,
        _nomComplet = nom,
        _saldo = 0.0;

  // Constructor complet amb tots els paràmetres
  User(this._id, this._nomComplet, this._saldo, this.correu, {this.esVIP = false});

  // Getters
  String get id => _id;
  double get saldo => _saldo;
  String get nomComplet => _nomComplet;

  // Mètode de recàrrega amb validació
  void recarregarSaldo(double quantitat) {
    if (quantitat <= 0) {
      throw ArgumentError('La quantitat a recarregar no pot ser negativa ni zero.');
    }
    _saldo += quantitat;
  }
}