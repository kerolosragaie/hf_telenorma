import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/models/ware.dart';

class WareRepository {
  final WareServices wareServices;

  WareRepository(this.wareServices);


  Future<List<Ware>> checkBarCodeInDatabase(
      {required barCode}) async {
    final checkBarcodeResponse = await wareServices.checkBarCodeInDatabase(barCode: barCode);

    return checkBarcodeResponse
        .map((eachWare) =>
        Ware.fromJson(eachWare))
        .toList();
  }

  Future<List<Ware>> getAllWare() async {
    final checkBarcodeResponse = await wareServices.getAllWare();
    return checkBarcodeResponse
        .map((eachWare) =>
        Ware.fromJson(eachWare))
        .toList();
  }

}
