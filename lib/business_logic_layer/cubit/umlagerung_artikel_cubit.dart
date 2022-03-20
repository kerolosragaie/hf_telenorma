

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/umlagerung_artikel_state.dart';
import 'package:hf/data_layer/models/umlagerung_artikel.dart';
import 'package:hf/data_layer/repository/umlagerung_artikel_repository.dart';

class UmlagerungArtikelCubit extends Cubit<UmlagerungArtikelState> {
  final UmlagerungArtikelRepository umlagerungArtikelRepository;
  List<UmlagerungArtikel> umlagerungArtikels = [];

  UmlagerungArtikelCubit(this.umlagerungArtikelRepository)
      : super(UmlagerungArtikelInitial());

  List<UmlagerungArtikel> getAllUmlagerungArtikels(
      {required String umlagerungId}) {
    umlagerungArtikelRepository
        .getUmlagerungArtikels(umlagerungId: umlagerungId)
        .then((umlagerungArtikels) {
      emit(UmlagerungArtikelLoadedState(umlagerungArtikels));
      this.umlagerungArtikels = umlagerungArtikels;
    });
    return umlagerungArtikels;
  }
  Future updateUmlagerungStatus(id){
    return umlagerungArtikelRepository.updateUmlagerungStatus(id).then((value) {
      emit(UpdateUmlagerungState());
    });
  }
}
