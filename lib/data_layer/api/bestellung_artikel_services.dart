

import 'package:dio/dio.dart';
import 'package:hf/data_layer/api/service_manager.dart';

class BestellungArtikelServices {
  ServiceManager serviceManager = ServiceManager();

  Future<List<dynamic>> getBestellungArtikels(
      {required String bestellungId}) async {
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'select',
        'token': _token,
        'bestellung_id': bestellungId,
      });
      Response response = await serviceManager.dio
          .post('bestellung-artikel/', data: _formData);
      return response.data["bestellung_artikel"];
    } on DioError {
      return [];
    }
  }

  updateBestellungStatus(id) async{
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'archive',
        'token': _token,
        'id' : id
      });
      Response response =
      await serviceManager.dio.post('bestellung/', data: _formData);
      return response.data;
    } on DioError {
      return [];
    }
  }

  addBestellungArtikel(Map<String,dynamic> data) async{
    try {
      String _token = await serviceManager.getToken();
      var _formData = FormData.fromMap({
        'type': 'add',
        'token': _token,
        'bestellung_id' : data['bestellung_id'],
        'artikel':data['artikel'],
        'charge' : 0,
        'kasse_artikel_id':data['kasse_artikel_id'],
        'ean':data['ean'],
        'product':data['product'],
        'vk':data['vk'],
        'kasse':data['kasse_id'],
        'menge':data['menge'],
        'created':''
        /// Add Body

      });
      Response response =
      await serviceManager.dio.post('bestellung-artikel/', data: _formData);
      print(response);
      return response.data;
    } on DioError {
      return [];
    }
  }
}