import 'package:hf/data_layer/models/Inventur.dart';

abstract class InventurState {}

class InventurInitial extends InventurState {}

class InventurLoadedState extends InventurState {
  final List<Inventur> teilInventurs;
  InventurLoadedState(this.teilInventurs);
}
class ArchivInventurLoadedState extends InventurState {
  final List<Inventur> teilInventurs;
  ArchivInventurLoadedState(this.teilInventurs);
}

class InventurErrorState extends InventurState {
  final String error;
  InventurErrorState(this.error);
}
class addInventurState extends InventurState{}
