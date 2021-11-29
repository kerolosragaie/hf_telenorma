import 'package:dio/dio.dart';
import 'package:hf/constants/strings.dart';
class ShopApi{
  late Dio dio;

  shopApi(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);

  }

  Future <List<dynamic>> getAllShops() async{
    try{
      Response response = await dio.get('shops');
      //print(response.data.toString());
      return response.data;
    }catch(e){
      //print(e.toString());
      return [];
    }

  }
}