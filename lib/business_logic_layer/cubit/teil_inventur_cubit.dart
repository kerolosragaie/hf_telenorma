import 'package:bloc/bloc.dart';
import 'package:hf/data_layer/models/teil_inventur.dart';
import 'package:hf/data_layer/repository/teil_inventur_repository.dart';
import 'package:meta/meta.dart';

part 'teil_inventur_state.dart';

class TeilInventurCubit extends Cubit<TeilInventurState> {
  final TeilInventurRepository teilInventurRepository;
  List<TeilInventur> allTeilInventursList = [];
  List<TeilInventur> archivTeilInventursList = [];

  TeilInventurCubit(this.teilInventurRepository) : super(TeilInventurInitial());

  List<TeilInventur> getAllTeilInventur() {
    teilInventurRepository.getAllTeilInventur().then((teilInventurs) {
      emit(TeilInventurLoadedState(teilInventurs));
      this.allTeilInventursList = teilInventurs;
    });
    return allTeilInventursList;

  }
  List<TeilInventur> getArchiveAllTeilInventur() {

    teilInventurRepository.getArchivTeilInventur().then((teilInventurs) {
      emit(ArchivTeilInventurLoadedState(teilInventurs));
      this.archivTeilInventursList = teilInventurs;
    });
    return archivTeilInventursList;

  }



  Future addTeilInventur(Map<String,dynamic> data){
    return teilInventurRepository.addTeilInventur(data).then((addTeilInventurResponse) {
      emit(addTeilInventurState());
      return addTeilInventurResponse;
    });
  }

}
