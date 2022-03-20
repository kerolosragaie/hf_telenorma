import 'package:hf/data_layer/api/inventur_services.dart';
import 'package:hf/data_layer/models/Inventur.dart';

class InventurRepository {

  final InventurServices inventurServices;

  InventurRepository(this.inventurServices);

  Future<List<Inventur>> getAllInventur() async {
    final InventurList = await inventurServices.getAllInventur();
    return InventurList
        .map((eachInventur) => Inventur.fromJson(eachInventur))
        .toList();
  }
  Future<List<Inventur>> getArchivInventur() async {
    final archivInventurList = await inventurServices.getArchivInventur();
    return archivInventurList
        .map((eachInventur) => Inventur.fromJson(eachInventur))
        .toList();
  }


  Future addInventur(Map<String,dynamic> data) async {

    final response = await inventurServices.addInventur(data);
    return Inventur.fromJson(response);
  }


}
