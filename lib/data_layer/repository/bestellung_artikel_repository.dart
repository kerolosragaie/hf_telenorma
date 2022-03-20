
import 'package:hf/data_layer/api/bestellung_artikel_services.dart';
import 'package:hf/data_layer/models/bestellung_artikel.dart';

class BestellungArtikelRepository {
  final BestellungArtikelServices bestellungArtikelServices;

  BestellungArtikelRepository(this.bestellungArtikelServices);

  Future<List<BestellungArtikel>> getBestellungArtikels(
      {required String bestellungId}) async {
    final BestellungArtikelsList =
    await bestellungArtikelServices.getBestellungArtikels(
      bestellungId: bestellungId,
    );

    return BestellungArtikelsList
        .map((bestellungArtikel) =>
        BestellungArtikel.fromJson(bestellungArtikel))
        .toList();
  }
  Future updateBestellungStatus(id) async {
    return await bestellungArtikelServices.updateBestellungStatus(id);
  }

  Future addBestellungArtikel(Map<String,dynamic> data ) async{
    return await bestellungArtikelServices.addBestellungArtikel(data);
  }
}