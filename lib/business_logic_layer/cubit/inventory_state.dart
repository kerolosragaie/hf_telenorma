part of 'inventory_cubit.dart';

@immutable
abstract class InventoryState {}

class InventoryInitialState extends InventoryState {}

class ShopsLoaded extends InventoryState{
  final List<Shops> shops;

  ShopsLoaded(this.shops);
}

