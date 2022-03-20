import 'package:hf/data_layer/api/wareneingang_services.dart';
import 'package:hf/data_layer/models/Wareneingang.dart';

class WareneingangRepository {

  final WareneingangServices wareneingangServices;

  WareneingangRepository(this.wareneingangServices);

  Future<List<Wareneingang>> getAllWareneingang() async {
    final WareneingangList = await wareneingangServices.getAllWareneingang();
    return WareneingangList
        .map((eachWareneingang) => Wareneingang.fromJson(eachWareneingang))
        .toList();
  }
  Future<List<Wareneingang>> getArchivWareneingang() async {
    final archivWareneingangList = await wareneingangServices.getArchivWareneingang();
    return archivWareneingangList
        .map((eachWareneingang) => Wareneingang.fromJson(eachWareneingang))
        .toList();
  }


  Future addWareneingang(Map<String,dynamic> data) async {

    final response = await wareneingangServices.addWareneingang(data);
    return Wareneingang.fromJson(response);
  }


}
