import 'package:hf/data_layer/api/inventur_artikel_services.dart';
import 'package:hf/data_layer/models/inventur_artikel.dart';

class InventurArtikelRepository {
  final InventurArtikelServices inventurArtikelServices;

  InventurArtikelRepository(this.inventurArtikelServices);

  Future<List<InventurArtikel>> getInventurArtikels(
      {required String inventurId}) async {
    final teilInventurArtikelsList =
    await inventurArtikelServices.getInventurArtikels(
      inventurId: inventurId,
    );

    return teilInventurArtikelsList
        .map((teilInventurArtikel) =>
        InventurArtikel.fromJson(teilInventurArtikel))
        .toList();
  }
  Future updateInventurStatus(id) async {
    return await inventurArtikelServices.updateInventurStatus(id);
  }

  Future addInventurArtikel(Map<String,dynamic> data ) async{
    return await inventurArtikelServices.addInventurArtikel(data);
  }

}
