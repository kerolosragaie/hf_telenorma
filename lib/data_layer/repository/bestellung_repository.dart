import 'package:hf/data_layer/api/bestellung_services.dart';
import 'package:hf/data_layer/models/bestellung.dart';
import 'package:hf/data_layer/models/kassen.dart';

class BestellungRepository {
  final BestellungServices bestellungServices;

  BestellungRepository(this.bestellungServices);

  Future<List<Bestellung>> getAllBestellung() async {
    final BestellungList = await bestellungServices.getAllBestellung();
    return BestellungList.map(
        (eachBestellung) => Bestellung.fromJson(eachBestellung)).toList();
  }

  Future<List<Kassen>> getAllKassen() async {
    final KassenList = await bestellungServices.getAllKassen();
    return KassenList.map((eachKassen) => Kassen.fromJson(eachKassen)).toList();
  }

  Future<List<Bestellung>> getArchivBestellung() async {
    final archivBestellungList = await bestellungServices.getArchivBestellung();
    return archivBestellungList
        .map((eachBestellung) => Bestellung.fromJson(eachBestellung))
        .toList();
  }

  Future addBestellung(Map<String, dynamic> data) async {
    final response = await bestellungServices.addBestellung(data);
    return Bestellung.fromJson(response);
  }
}
