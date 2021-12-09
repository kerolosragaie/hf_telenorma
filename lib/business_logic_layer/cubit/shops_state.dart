part of 'shops_cubit.dart';

@immutable
abstract class ShopsState {}

class ShopsInitialState extends ShopsState {}

class ShopsLoadedState extends ShopsState {
  final List<Shops> shops;

  ShopsLoadedState(this.shops);
}

class ShopsErrorState extends ShopsState {
  final error;

  ShopsErrorState(this.error);
}
