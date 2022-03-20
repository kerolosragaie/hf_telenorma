import 'package:hf/data_layer/api/wareneingang_artikel_services.dart';
import 'package:hf/data_layer/models/wareneingang_artikel.dart';


class WareneingangArtikelRepository {
  final WareneingangArtikelServices wareneingangArtikelServices;

  WareneingangArtikelRepository(this.wareneingangArtikelServices);

  Future<List<WareneingangArtikel>> getWareneingangArtikels(
      {required String wareneingangId}) async {
    final teilWareneingangArtikelsList =
    await wareneingangArtikelServices.getWareneingangArtikels(
      wareneingangId: wareneingangId,
    );

    return teilWareneingangArtikelsList
        .map((teilWareneingangArtikel) =>
        WareneingangArtikel.fromJson(teilWareneingangArtikel))
        .toList();
  }
  Future updateWareneingangStatus(id) async {
    return await wareneingangArtikelServices.updateWareneingangStatus(id);
  }

  Future addWareneingangArtikel(Map<String,dynamic> data ) async{
    return await wareneingangArtikelServices.addWareneingangArtikel(data);
  }

}
