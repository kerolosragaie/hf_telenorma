part of 'inventurs_cubit.dart';

@immutable
abstract class InventursState {}

class InventursInitial extends InventursState {}

class InventursLoaded extends InventursState {
  final List<Inventurs> inventurs;
  InventursLoaded(this.inventurs);
}
