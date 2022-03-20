

import 'package:hf/data_layer/models/umlagerung_artikel.dart';

abstract class UmlagerungArtikelState {}

class UmlagerungArtikelInitial extends UmlagerungArtikelState {}

class UmlagerungArtikelLoadedState extends UmlagerungArtikelState {
  final List<UmlagerungArtikel> umlagerungArtikels;
  UmlagerungArtikelLoadedState(this.umlagerungArtikels);
}

class UmlagerungArtikelErrorState extends UmlagerungArtikelState {
  final String error;
  UmlagerungArtikelErrorState(this.error);
}
class UpdateUmlagerungState extends UmlagerungArtikelState{}