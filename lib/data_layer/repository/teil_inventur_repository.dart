import 'package:hf/data_layer/api/teil_inventur_services.dart';
import 'package:hf/data_layer/models/teil_inventur.dart';

class TeilInventurRepository {
  final TeilInventurServices teilInventurServices;

  TeilInventurRepository(this.teilInventurServices);

  Future<List<TeilInventur>> getAllTeilInventur() async {
    final teilInventurList = await teilInventurServices.getAllTeilInventur();
    return teilInventurList
        .map((teilInventur) => TeilInventur.fromJson(teilInventur))
        .toList();
  }
  Future<List<TeilInventur>> getArchivTeilInventur() async {
    final archivTeilInventurList = await teilInventurServices.getArchivTeilInventur();
    return archivTeilInventurList
        .map((teilInventur) => TeilInventur.fromJson(teilInventur))
        .toList();
  }
  Future addTeilInventur(Map<String,dynamic> data) async {

    final response = await teilInventurServices.addTeilInventur(data);
  return TeilInventur.fromJson(response);
  }


}
