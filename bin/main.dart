import 'package:ecoride/usuari.dart';
import 'package:ecoride/vehicle.dart';

void main() {
  // 1. Inicialització
  List<Vehicle> flota = [
    Patinet(id: 'P01', bateriaPercentatge: 90, preuPerMinut: 0.20, velocitatMaxima: 25),
    Patinet(id: 'P02', bateriaPercentatge: 15, preuPerMinut: 0.20, velocitatMaxima: 25, enUs: true),
    Patinet(id: 'P03', bateriaPercentatge: 45, preuPerMinut: 0.25, velocitatMaxima: 30),
    Cotxe(id: 'C01', bateriaPercentatge: 85, preuPerMinut: 0.50, places: 5, requereixLlicencia: true),
    Cotxe(id: 'C02', bateriaPercentatge: 10, preuPerMinut: 0.60, places: 2, requereixLlicencia: true, enUs: false),
  ];

  flota[0].actualitzarUbicacio(38.9067, 1.4206);
  flota[3].actualitzarUbicacio(38.9100, 1.4300);

  print('--- 2. Cerca i Filtres ---');
  
  // Trobar el vehicle amb la bateria més alta amb reduce
  Vehicle vehicleMesBateria = flota.reduce((actual, seguent) => 
    actual.bateriaPercentatge > seguent.bateriaPercentatge ? actual : seguent
  );
  print('Vehicle amb més bateria: ${vehicleMesBateria.id} amb un ${vehicleMesBateria.bateriaPercentatge}% (Estat: ${vehicleMesBateria.estatBateria()})');

  // Filtrar vehicles disponibles
  List<Vehicle> disponibles = flota.where((v) => v.bateriaPercentatge > 20 && v.enUs == false).toList();
  print('\nVehicles disponibles (Bateria > 20% i no en ús):');
  for (var v in disponibles) {
    print('- ${v.id} (${v.runtimeType})');
  }

  print('\n--- 3. Simulació d\'Ús i Destructuració de Records ---');
  
  User usuariProva = User.nou(id: 'U123', nom: 'Jaime', correu: 'jaime@test.com', esVIP: true);
  Patinet patinetReservat = flota[0] as Patinet;

  // Càlcul de cost
  double costReserva = patinetReservat.calcularCostReserva(15, usuari: usuariProva);
  print('Reserva de 15 min per usuari VIP en ${patinetReservat.id}: $costReserva €');

  // Destructuració de Records
  patinetReservat.actualitzarUbicacio(38.9150, 1.4250);
  var (lat, lng) = patinetReservat.obtenirCoordenades();
  print('Coordenades extretes amb destructuració -> Lat: $lat, Lng: $lng');

  print('\n--- 4. Maneig d\'Errors ---');
  try {
    print('Intentant recarregar -10.0 al saldo...');
    usuariProva.recarregarSaldo(-10.0);
  } catch (e) {
    print('Excepció capturada pel bloc try-catch: $e');
  }
  
  print('\nEl programa ha finalitzat correctament.');
}