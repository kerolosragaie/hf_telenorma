import 'package:hf/data_layer/api/inventurs_services.dart';
import 'package:hf/data_layer/models/inventurs.dart';

class InventursRepository {
  final InventursServices inventursServices;
  InventursRepository(this.inventursServices);

  Future<List<Inventurs>> getAllInventurs() async {
    final inventursList = await inventursServices.getAllInventurs();
    return inventursList
        .map((inventur) => Inventurs.fromJson(inventur))
        .toList();
  }
}
