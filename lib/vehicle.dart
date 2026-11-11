import 'usuari.dart';

// Mixin de Posició GPS
mixin GPSLocation {
  double latitud = 0.0;
  double longitud = 0.0;

  void actualitzarUbicacio(double lat, double lng) {
    latitud = lat;
    longitud = lng;
  }

  // Retorna un Record de Dart 3
  (double, double) obtenirCoordenades() {
    return (latitud, longitud);
  }
}

// Classe abstracta Vehicle
abstract class Vehicle with GPSLocation {
  String id;
  int bateriaPercentatge;
  bool enUs;
  double preuPerMinut;

  Vehicle({
    required this.id,
    required this.bateriaPercentatge,
    this.enUs = false,
    required this.preuPerMinut,
  });

  // Switch Expression de Dart 3
  String estatBateria() {
    return switch (bateriaPercentatge) {
      >= 80 => "Alta",
      >= 20 => "Mitjana",
      _ => "Crítica (Requereix càrrega)",
    };
  }

  // Mètode abstracte. Passem l'usuari com a paràmetre opcional per aplicar lògica de descompte
  double calcularCostReserva(int minuts, {User? usuari});
}

// Subclasse Patinet
class Patinet extends Vehicle {
  int velocitatMaxima;

  Patinet({
    required super.id,
    required super.bateriaPercentatge,
    super.enUs,
    required super.preuPerMinut,
    required this.velocitatMaxima,
  });

  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    double cost = minuts * preuPerMinut;
    if (usuari != null && usuari.esVIP) {
      return cost * 0.9; // 10% de descompte aplicat
    }
    return cost;
  }
}

// Subclasse Cotxe
class Cotxe extends Vehicle {
  int places;
  bool requereixLlicencia;

  Cotxe({
    required super.id,
    required super.bateriaPercentatge,
    super.enUs,
    required super.preuPerMinut,
    required this.places,
    required this.requereixLlicencia,
  });

  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    double suplementFiltreEcologic = 2.0;
    return (minuts * preuPerMinut) + suplementFiltreEcologic;
  }
}