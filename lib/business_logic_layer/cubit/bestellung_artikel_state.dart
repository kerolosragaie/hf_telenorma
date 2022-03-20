
import 'package:hf/data_layer/models/bestellung_artikel.dart';

abstract class BestellungArtikelState{}

class BestellungArtikelInitial extends BestellungArtikelState {}

class BestellungArtikelLoadedState extends BestellungArtikelState {
  final List<BestellungArtikel> bestellungArtikel;
  BestellungArtikelLoadedState(this.bestellungArtikel);
}

class BestellungArtikelErrorState extends BestellungArtikelState {
  final String error;
  BestellungArtikelErrorState(this.error);
}

class UpdateBestellungState extends BestellungArtikelState{}
