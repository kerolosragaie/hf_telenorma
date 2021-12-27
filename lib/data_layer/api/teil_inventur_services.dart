import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class TeilInventurServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getAllTeilInventur() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
      });
      Response response =
          await serviceManager.dio.post('teil-inventur/', data: _formData);
      return response.data["teil-inventur"];
    } on DioError {
      return [];
    }
  }
}
