import 'package:hf/data_layer/api/service_manager.dart';
import 'package:dio/dio.dart';

class ProductsServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getAllProducts() async {
    try {
      Response response = await serviceManager.dio.get('products');
      return response.data;
    } catch (e) {
      return [];
    }
  }
}
