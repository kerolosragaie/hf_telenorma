import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';
import 'package:logger/logger.dart';

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
      Logger().d(response.data);
      return response.data;
    } on DioError {
      return [];
    }
  }
}
