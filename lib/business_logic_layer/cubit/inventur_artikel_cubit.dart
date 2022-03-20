

import 'package:bloc/bloc.dart';
import 'package:hf/data_layer/models/inventur_artikel.dart';
import 'package:hf/data_layer/repository/inventur_artikel_repository.dart';

import 'inventur_artikel_states.dart';

class InventurArtikelCubit extends Cubit<InventurArtikelState> {
  final InventurArtikelRepository inventurArtikelRepository;
  List<InventurArtikel> teilInventurArtikels = [];

  InventurArtikelCubit(this.inventurArtikelRepository)
      : super(InventurArtikelInitial());

  List<InventurArtikel> getAllInventurArtikels(
      {required String inventurId}) {
    inventurArtikelRepository
        .getInventurArtikels(inventurId: inventurId)
        .then((teilInventurArtikels) {
      emit(InventurArtikelLoadedState(teilInventurArtikels));
      this.teilInventurArtikels = teilInventurArtikels;
    });
    return teilInventurArtikels;
  }
  Future updateInventurStatus(id){
    return inventurArtikelRepository.updateInventurStatus(id).then((value) {
      emit(UpdateInventurState());
    });
  }
}
