import 'package:bloc/bloc.dart';
import 'package:hf/data_layer/models/teil_inventur_artikel.dart';
import 'package:hf/data_layer/repository/teil_inventur_artikel_repository.dart';
import 'package:meta/meta.dart';

part 'teil_inventur_artikel_state.dart';

class TeilInventurArtikelCubit extends Cubit<TeilInventurArtikelState> {
  final TeilInventurArtikelRepository teilInventurArtikelRepository;
  List<TeilInventurArtikel> teilInventurArtikels = [];

  TeilInventurArtikelCubit(this.teilInventurArtikelRepository)
      : super(TeilInventurArtikelInitial());

  List<TeilInventurArtikel> getAllTeilInventurArtikels(
      {required String inventurId}) {
    teilInventurArtikelRepository
        .getTeilInventurArtikels(inventurId: inventurId)
        .then((teilInventurArtikels) {
      emit(TeilInventurArtikelLoadedState(teilInventurArtikels));
      this.teilInventurArtikels = teilInventurArtikels;
    });
    return teilInventurArtikels;
  }
}
