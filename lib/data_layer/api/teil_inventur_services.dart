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

  Future<List<dynamic>> getArchivTeilInventur() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'status' : 'archiviert'
      });
      Response response =
          await serviceManager.dio.post('teil-inventur/', data: _formData);
      return response.data["teil-inventur"];
    } on DioError {
      return [];
    }
  }

  addTeilInventur(Map<String,dynamic> data) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'add',
        'token': _token,
        'kasse_id' : data['kasse_id'],
        'user_id':44,
        'shop_id':data['shop_id'],
        'bemerkung':data['bemerkung'],
        'status' : 'neu',
        'modified':'',
        'created':DateTime.now(),
        'kasse_document_id':''

      });
      Response response =
          await serviceManager.dio.post('teil-inventur/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

}
