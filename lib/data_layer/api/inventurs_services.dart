import 'package:hf/data_layer/api/service_manager.dart';
import 'package:dio/dio.dart';

class InventursServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getAllInventurs() async {
    try {
      String _token = await serviceManager.getToken();
      Response response =
          await serviceManager.dio.get('inventurs', queryParameters: {
        "token": _token,
      });
      if (response.data.toString().contains("error: Your token is expire")) {
        _token = await serviceManager.getToken(getNewToken: true);
        response = await serviceManager.dio.get('inventurs', queryParameters: {
          "token": _token,
        });
      }
      return response.data;
    } on DioError {
      return [];
    }
  }
}
