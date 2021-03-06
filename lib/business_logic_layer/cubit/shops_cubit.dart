import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/data_layer/models/kassen.dart';
import 'package:hf/data_layer/models/shop.dart';
import 'package:hf/data_layer/repository/shop_repository.dart';
import 'package:meta/meta.dart';

part 'shops_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final ShopRepository shopsRepository;
  List<Shop> shopsList = [];
  ShopCubit(this.shopsRepository) : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  List<Shop> getAllShops() {
    shopsRepository.getAllShops().then((shops) {
      emit(ShopLoadedState(shops));
      this.shopsList = shops;
    });

    return shopsList;
  }
}
