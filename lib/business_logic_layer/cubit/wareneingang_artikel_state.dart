
import 'package:hf/data_layer/models/wareneingang_artikel.dart';

abstract class WareneingangArtikelState {}

class WareneingangArtikelInitial extends WareneingangArtikelState {}

class WareneingangArtikelLoadedState extends WareneingangArtikelState {
  final List<WareneingangArtikel> teilInventurArtikels;
  WareneingangArtikelLoadedState(this.teilInventurArtikels);
}

class WareneingangArtikelErrorState extends WareneingangArtikelState {
  final String error;
  WareneingangArtikelErrorState(this.error);
}
class UpdateWareneingangState extends WareneingangArtikelState{}
