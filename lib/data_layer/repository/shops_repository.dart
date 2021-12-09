import 'package:hf/data_layer/api/shops_services.dart';
import 'package:hf/data_layer/models/shops.dart';

class ShopsRepository {
  final ShopServices shopServices;

  ShopsRepository(this.shopServices);

  Future<List<Shops>> getAllShops() async {
    final shopsList = await shopServices.getAllShops();
    return shopsList.map((shop) => Shops.fromJson(shop)).toList();
  }
}
