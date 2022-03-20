

import 'package:hf/data_layer/api/umlagerung_artikel_services.dart';
import 'package:hf/data_layer/models/umlagerung_artikel.dart';

class UmlagerungArtikelRepository {
  final UmlagerungArtikelServices umlagerungArtikelServices;

  UmlagerungArtikelRepository(this.umlagerungArtikelServices);

  Future<List<UmlagerungArtikel>> getUmlagerungArtikels(
      {required String umlagerungId}) async {
    final UmlagerungArtikelsList =
    await umlagerungArtikelServices.getUmlagerungArtikels(
      umlagerungId: umlagerungId,
    );

    return UmlagerungArtikelsList
        .map((umlagerungArtikel) =>
        UmlagerungArtikel.fromJson(umlagerungArtikel))
        .toList();
  }
  Future updateUmlagerungStatus(id) async {
    return await umlagerungArtikelServices.updateUmlagerungStatus(id);
  }

  Future addUmlagerungArtikel(Map<String,dynamic> data ) async{
    return await umlagerungArtikelServices.addUmlagerungArtikel(data);
  }
}