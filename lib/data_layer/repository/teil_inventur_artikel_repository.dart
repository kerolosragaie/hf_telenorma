import 'package:hf/data_layer/api/teil_inventur_artikel_services.dart';
import 'package:hf/data_layer/models/teil_inventur_artikel.dart';

class TeilInventurArtikelRepository {
  final TeilInventurArtikelServices teilInventurArtikelServices;

  TeilInventurArtikelRepository(this.teilInventurArtikelServices);

  Future<List<TeilInventurArtikel>> getTeilInventurArtikels(
      {required String inventurId}) async {
    final teilInventurArtikelsList =
        await teilInventurArtikelServices.getTeilInventurArtikels(
      inventurId: inventurId,
    );

    return teilInventurArtikelsList
        .map((teilInventurArtikel) =>
            TeilInventurArtikel.fromJson(teilInventurArtikel))
        .toList();
  }
  Future updateTeilInventurStatus(id) async {
    return await teilInventurArtikelServices.updateTeilInventurStatus(id);
  }

  Future addTeilInventurArtikel(Map<String,dynamic> data ) async{
    return await teilInventurArtikelServices.addTeilInventurArtikel(data);
  }

}
