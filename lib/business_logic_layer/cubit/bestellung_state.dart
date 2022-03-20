
import 'package:hf/data_layer/models/bestellung.dart';
import 'package:hf/data_layer/models/kassen.dart';


abstract class BestellungState {}

class BestellungInitial extends BestellungState{}
class BestellungLoadedState extends BestellungState {
  final List<Bestellung> Bestellungs;
  BestellungLoadedState(this.Bestellungs);
}
class KassenLoadedState extends BestellungState {
  final List<Kassen> KassenList;
  KassenLoadedState(this.KassenList);
}
class ArchivBestellungLoadedState extends BestellungState {
  final List<Bestellung> bestellung;
  ArchivBestellungLoadedState(this.bestellung);
}

class BestellungErrorState extends BestellungState {
  final String error;
  BestellungErrorState(this.error);
}
class addBestellungState extends BestellungState{}