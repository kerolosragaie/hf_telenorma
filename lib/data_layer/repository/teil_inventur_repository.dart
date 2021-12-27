import 'package:hf/data_layer/api/teil_inventur_services.dart';
import 'package:hf/data_layer/models/teil_inventur.dart';
import 'package:logger/logger.dart';

class TeilInventurRepository {
  final TeilInventurServices teilInventurServices;

  TeilInventurRepository(this.teilInventurServices);

  Future<List<TeilInventur>> getAllTeilInventur() async {
    final teilInventurList = await teilInventurServices.getAllTeilInventur();
    return teilInventurList
        .map((teilInventur) => TeilInventur.fromJson(teilInventur))
        .toList();
  }
}
