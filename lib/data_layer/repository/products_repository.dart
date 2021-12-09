import 'package:hf/data_layer/api/products_services.dart';
import 'package:hf/data_layer/models/products.dart';

class ProductsRepository {
  final ProductsServices productsServices;
  ProductsRepository(this.productsServices);

  Future<List<Products>> getAllProducts() async {
    final productsList = await productsServices.getAllProducts();
    return productsList.map((product) => Products.fromJson(product)).toList();
  }
}
