import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class InventurArtikelServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getInventurArtikels(
      {required String inventurId}) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'inventur_id': inventurId,
      });
      Response response = await serviceManager.dio
          .post('inventur-artikel/', data: _formData);
      return response.data["inventur-artikel"];
    } on DioError {
      return [];
    }
  }

  updateInventurStatus(id) async{
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'archive',
        'token': _token,
        'id' : id
      });
      Response response =
      await serviceManager.dio.post('inventur/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

  addInventurArtikel(Map<String,dynamic> data) async{
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
      await serviceManager.dio.post('inventur-artikel/', data: _formData);
      print(response);
      return response.data;
    } on DioError {
      return [];
    }
  }


}
