
import 'package:hf/data_layer/api/umlagerung_services.dart';
import 'package:hf/data_layer/models/umlagerung.dart';

class UmlagerungRepository {

  final UmlagerungServices umlagerungServices;

  UmlagerungRepository(this.umlagerungServices);

  Future<List<Umlagerung>> getAllUmlagerung() async {
    final UmlagerungList = await umlagerungServices.getAllUmlagerung();
    return UmlagerungList
        .map((eachUmlagerung) => Umlagerung.fromJson(eachUmlagerung))
        .toList();
  }
  Future<List<Umlagerung>> getArchivUmlagerung() async {
    final archivUmlagerungList = await umlagerungServices.getArchivUmlagerung();
    return archivUmlagerungList
        .map((eachUmlagerung) => Umlagerung.fromJson(eachUmlagerung))
        .toList();
  }


  Future addUmlagerung(Map<String,dynamic> data) async {

    final response = await umlagerungServices.addUmlagerung(data);
    return Umlagerung.fromJson(response);
  }


}