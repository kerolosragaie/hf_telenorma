import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class TeilInventurArtikelServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getTeilInventurArtikels(
      {required String inventurId}) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'inventur_id': inventurId,
      });
      Response response = await serviceManager.dio
          .post('teil-inventur-artikel/', data: _formData);
      return response.data["teil-inventur-artikel"];
    } on DioError {
      return [];
    }
  }
}
