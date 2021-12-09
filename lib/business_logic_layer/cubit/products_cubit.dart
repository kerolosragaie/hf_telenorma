import 'package:bloc/bloc.dart';
import 'package:hf/data_layer/models/products.dart';
import 'package:hf/data_layer/repository/products_repository.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository productsRepository;
  List<Products> products = [];
  ProductsCubit(this.productsRepository) : super(ProductsInitial());

  List<Products> getAllProducts() {
    productsRepository.getAllProducts().then((products) {
      emit(ProductsLoaded(products));
      this.products = products;
    });
    return products;
  }
}
