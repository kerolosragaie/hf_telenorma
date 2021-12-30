import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class ShopServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getAllShops() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'all',
        'token': _token,
        'kasse_id': 0,
        'id': 0,
      });
      Response response =
          await serviceManager.dio.post('shop/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

  Future<dynamic> getSingleShop(
      {required String kasseId, required String Id}) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'kasse_id': kasseId,
        'id': Id,
      });
      Response response =
          await serviceManager.dio.post('shop/', data: _formData);
      return response.data[0] == [] ? null : response.data[0];
    } on DioError {
      return [];
    }
  }
}
