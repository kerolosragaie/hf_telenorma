part of 'inventory_cubit.dart';

@immutable
abstract class InventoryState {}

class InventoryInitialState extends InventoryState {}

class ShopsLoadedState extends InventoryState{
  final List<Shops> shops;

  ShopsLoadedState(this.shops);
}
class ShopsErrorState extends InventoryState {
  final error;

  ShopsErrorState(this.error);
}