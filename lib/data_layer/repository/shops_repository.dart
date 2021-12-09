import 'package:hf/data_layer/api/shop_api.dart';
import 'package:hf/data_layer/models/shops.dart';

class ShopsRepository {
  final ShopApi shopApi;

  ShopsRepository(this.shopApi);

  Future<List<Shops>> getAllShops() async {
    final shopsList = await shopApi.getAllShops();
    return shopsList.map((shop) => Shops.fromJson(shop)).toList();
  }
}
