

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_artikel_state.dart';
import 'package:hf/data_layer/models/bestellung_artikel.dart';
import 'package:hf/data_layer/repository/bestellung_artikel_repository.dart';

class BestellungArtikelCubit extends Cubit<BestellungArtikelState>
{
  final BestellungArtikelRepository bestellungArtikelRepository;
  List<BestellungArtikel> bestellungArtikels = [];

  BestellungArtikelCubit(this.bestellungArtikelRepository) : super(BestellungArtikelInitial());

  List<BestellungArtikel> getAllBestellungArtikels(
      {required String bestellungId}) {
    bestellungArtikelRepository
        .getBestellungArtikels(bestellungId: bestellungId)
        .then((bestellungArtikels) {
      emit(BestellungArtikelLoadedState(bestellungArtikels));
      this.bestellungArtikels = bestellungArtikels;
    });
    return bestellungArtikels;
  }

  Future updateBestellungStatus(id){
    return bestellungArtikelRepository.updateBestellungStatus(id).then((value) {
      emit(UpdateBestellungState());
    });
  }

}