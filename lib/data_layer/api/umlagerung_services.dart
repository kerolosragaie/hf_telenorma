

import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class UmlagerungServices{
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getAllUmlagerung() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'status':'neu'
      });
      Response response =
      await serviceManager.dio.post('umlagerung/', data: _formData);
      return response.data["umlagerung"];
    } on DioError {
      return [];
    }
  }

  Future<List<dynamic>> getArchivUmlagerung() async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'status' : 'archiviert'
      });
      Response response =
      await serviceManager.dio.post('umlagerung/', data: _formData);
      return response.data["umlagerung"];
    } on DioError {
      return [];
    }
  }

  addUmlagerung(Map<String,dynamic> data) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'add',
        'token': _token,
        'kasse_id' : data['kasse_id'],
        'user_id':44,
        'kassen_id': data['kassen_id'],
        'von_shop_id': data['von_shop_id'],
        'zu_shop_id': data['zu_shop_id'],
        //'shop_id':data['shop_id'],
        'bemerkung':data['bemerkung'],
        'status' : 'neu',
        'modified':'',
        'created':DateTime.now(),
        'kasse_document_id':''

      });
      Response response =
      await serviceManager.dio.post('umlagerung/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

}