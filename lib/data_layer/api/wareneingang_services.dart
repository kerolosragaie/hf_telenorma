import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class WareneingangServices{
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getAllWareneingang() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'status':'neu'
      });
      Response response =
      await serviceManager.dio.post('wareneingang/', data: _formData);
      return response.data["wareneingang"];
    } on DioError {
      return [];
    }
  }

  Future<List<dynamic>> getArchivWareneingang() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'status' : 'archiviert'
      });
      Response response =
      await serviceManager.dio.post('wareneingang/', data: _formData);
      return response.data["wareneingang"];
    } on DioError {
      return [];
    }
  }

  addWareneingang(Map<String,dynamic> data) async {
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
      await serviceManager.dio.post('wareneingang/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

}
