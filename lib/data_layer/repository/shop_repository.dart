import 'package:hf/data_layer/api/shop_services.dart';
import 'package:hf/data_layer/models/shop.dart';

class ShopRepository {
  final ShopServices shopServices;

  ShopRepository(this.shopServices);

  Future<List<Shop>> getAllShops() async {
    final shopsList = await shopServices.getAllShops();
    return shopsList.map((shop) => Shop.fromJson(shop)).toList();
  }
}
