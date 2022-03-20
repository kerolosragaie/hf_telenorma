import 'package:hf/data_layer/models/inventur_artikel.dart';

abstract class InventurArtikelState {}

class InventurArtikelInitial extends InventurArtikelState {}

class InventurArtikelLoadedState extends InventurArtikelState {
  final List<InventurArtikel> teilInventurArtikels;
  InventurArtikelLoadedState(this.teilInventurArtikels);
}

class InventurArtikelErrorState extends InventurArtikelState {
  final String error;
  InventurArtikelErrorState(this.error);
}
class UpdateInventurState extends InventurArtikelState{}
