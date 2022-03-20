
import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class UmlagerungArtikelServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getUmlagerungArtikels(
      {required String umlagerungId}) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'umlagerung_id': umlagerungId,
      });
      Response response = await serviceManager.dio
          .post('umlagerung-artikel/', data: _formData);
      print('umlagerung_artikel $response');
      return response.data["umlagerung_artikel"];
    } on DioError {
      return [];
    }
  }

  updateUmlagerungStatus(id) async{
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'archive',
        'token': _token,
        'id' : id,
      });
      Response response =
      await serviceManager.dio.post('umlagerung/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

  addUmlagerungArtikel(Map<String,dynamic> data) async{
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'add',
        'token': _token,
        'umlagerung_id' : data['umlagerung_id'],
        'artikel':data['artikel'],
        'charge' : 0,
        'kasse_artikel_id':0,
        'ean':data['ean'],
        'product':data['product'],
        'vk':data['vk'],
        'kasse':data['kasse_id'],
        'menge':data['menge'],
        'created':''
        /// Add Body

      });
      Response response =
      await serviceManager.dio.post('umlagerung-artikel/', data: _formData);
      print(response);
      return response.data;
    } on DioError {
      return [];
    }
  }
}