import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/data_layer/models/shops.dart';
import 'package:hf/data_layer/repository/shops_repository.dart';
import 'package:meta/meta.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<ShopsState> {
  final ShopsRepository shopsRepository;
  List<Shops> shops = [];
  ShopsCubit(this.shopsRepository) : super(ShopsInitialState());
  //static InventoryCubit get(context) => BlocProvider.of(context);

  List<Shops> getAllShops() {
    shopsRepository.getAllShops().then((shops) {
      emit(ShopsLoadedState(shops));
      this.shops = shops;
    });

    return shops;
  }
}