import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class WareneingangArtikelServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getWareneingangArtikels(
      {required String wareneingangId}) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'inventur_id': wareneingangId,
      });
      Response response = await serviceManager.dio
          .post('wareneingang-artikel/', data: _formData);
      print('wareneingang-artikelwareneingang-artikel $response');
      return response.data["wareneingang-artikel"];
    } on DioError {
      return [];
    }
  }

  updateWareneingangStatus(id) async{
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'archive',
        'token': _token,
        'id' : id
      });
      Response response =
      await serviceManager.dio.post('wareneingang/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

  addWareneingangArtikel(Map<String,dynamic> data) async{
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'add',
        'token': _token,
        'inventur_id' : data['inventur_id'],
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
      await serviceManager.dio.post('wareneingang-artikel/', data: _formData);
      print(response);
      return response.data;
    } on DioError {
      return [];
    }
  }


}
