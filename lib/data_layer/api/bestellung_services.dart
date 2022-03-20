
import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class BestellungServices{
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getAllBestellung() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'status':'neu'
      });
      Response response =
      await serviceManager.dio.post('bestellung/', data: _formData);
      return response.data["bestellung"];
    } on DioError {
      return [];
    }
  }

  Future<List<dynamic>> getAllKassen() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
      });
      Response response =
      await serviceManager.dio.post('kassen/', data: _formData);
      return response.data["kassen"];
    } on DioError {
      return [];
    }
  }

  Future<List<dynamic>> getArchivBestellung() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'status' : 'archiviert'
      });
      Response response =
      await serviceManager.dio.post('bestellung/', data: _formData);
      return response.data["bestellung"];
    } on DioError {
      return [];
    }
  }

  addBestellung(Map<String,dynamic> data) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'add',
        'token': _token,
        'kasse_id' : data['kasse_id'],
        'user_id':44,
        'kassen_id': data['kassen_id'],
        'shop_id':data['shop_id'],
        'bemerkung':data['bemerkung'],
        'status' : 'neu',
        'modified':'',
        'created':DateTime.now(),
        'kasse_document_id':''

      });
      Response response =
      await serviceManager.dio.post('bestellung/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

}
