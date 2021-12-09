import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class ShopServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getAllShops() async {
    try {
      String _token = await serviceManager.getToken();
      Response response =
          await serviceManager.dio.get('shops', queryParameters: {
        "token": _token,
      });
      if (response.data.toString().contains("error: Your token is expire")) {
        _token = await serviceManager.getToken(getNewToken: true);
        response = await serviceManager.dio.get('shops', queryParameters: {
          "token": _token,
        });
      }
      return response.data;
    } on DioError {
      return [];
    }
  }
}
