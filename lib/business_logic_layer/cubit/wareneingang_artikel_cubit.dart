import 'package:bloc/bloc.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_artikel_state.dart';
import 'package:hf/data_layer/models/wareneingang_artikel.dart';
import 'package:hf/data_layer/repository/wareneingang_artikel_repository.dart';


class WareneingangArtikelCubit extends Cubit<WareneingangArtikelState> {
  final WareneingangArtikelRepository teilInventurArtikelRepository;
  List<WareneingangArtikel> teilInventurArtikels = [];

  WareneingangArtikelCubit(this.teilInventurArtikelRepository)
      : super(WareneingangArtikelInitial());

  List<WareneingangArtikel> getAllWareneingangArtikels(
      {required String wareneingangId}) {
    teilInventurArtikelRepository
        .getWareneingangArtikels(wareneingangId: wareneingangId)
        .then((teilInventurArtikels) {
      emit(WareneingangArtikelLoadedState(teilInventurArtikels));
      this.teilInventurArtikels = teilInventurArtikels;
    });
    return teilInventurArtikels;
  }
  Future updateWareneingangStatus(id){
    return teilInventurArtikelRepository.updateWareneingangStatus(id).then((value) {
      emit(UpdateWareneingangState());
    });
  }
}
