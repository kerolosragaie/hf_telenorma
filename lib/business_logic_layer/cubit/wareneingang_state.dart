import 'package:hf/data_layer/models/Wareneingang.dart';

abstract class WareneingangState {}

class WareneingangInitial extends WareneingangState {}

class WareneingangLoadedState extends WareneingangState {
  final List<Wareneingang> wareneingangs;
  WareneingangLoadedState(this.wareneingangs);
}
class ArchivWareneingangLoadedState extends WareneingangState {
  final List<Wareneingang> wareneingangs;
  ArchivWareneingangLoadedState(this.wareneingangs);
}

class WareneingangErrorState extends WareneingangState {
  final String error;
  WareneingangErrorState(this.error);
}
class addWareneingangState extends WareneingangState{}
