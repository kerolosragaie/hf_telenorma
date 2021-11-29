import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class ShopApi {
  late ServiceManager serviceManager;

  shopApi() {
    serviceManager = ServiceManager();
  }

  Future<List<dynamic>> getAllShops() async {
    try {
      Response response = await serviceManager.dio.get('shops');
      //print(response.data.toString());
      return response.data;
    } catch (e) {
      //print(e.toString());
      return [];
    }
  }
}
