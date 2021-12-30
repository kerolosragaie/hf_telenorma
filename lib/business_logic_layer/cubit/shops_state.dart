part of 'shops_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopLoadedState extends ShopState {
  final List<Shop> shopsList;
  ShopLoadedState(this.shopsList);
}

class ShopErrorState extends ShopState {
  final String error;

  ShopErrorState(this.error);
}
