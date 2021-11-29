
import 'package:hf/data_layer/api/shop_api.dart';
import 'package:hf/data_layer/models/shops.dart';

class ShopsRepository{
  final ShopApi shopApi;

  ShopsRepository(this.shopApi);
  Future <List<Shops>> getAllShops() async{
    final shops = await shopApi.getAllShops();
    return shops.map((shop) => shops.fromJson(shop)).toList();

  }
}