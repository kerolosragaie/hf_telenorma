import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class WareServices{
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> checkBarCodeInDatabase(
      {required barCode}) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'ean': barCode,
      });
      Response response = await serviceManager.dio
          .post('ware/', data: _formData);

      return response.data["ware"];
    } on DioError {
      return [];
    }
  }

  Future<List<dynamic>> getAllWare() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'all',
        'token': _token,
      });
      Response response = await serviceManager.dio
          .post('ware/', data: _formData);

      return response.data["ware"];
    } on DioError {
      return [];
    }
  }

}