import 'package:bloc/bloc.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_state.dart';
import 'package:hf/data_layer/models/Wareneingang.dart';
import 'package:hf/data_layer/repository/wareneingang_repository.dart';

class WareneingangCubit extends Cubit<WareneingangState> {
  final WareneingangRepository _wareneingangRepository;
  List<Wareneingang> allWareneingangsList = [];
  List<Wareneingang> archivWareneingangsList = [];

  WareneingangCubit(this._wareneingangRepository) : super(WareneingangInitial());

  List<Wareneingang> getAllWareneingang() {
    _wareneingangRepository.getAllWareneingang().then((Wareneingangs) {
      emit(WareneingangLoadedState(Wareneingangs));
      this.allWareneingangsList = Wareneingangs;
    });
    return allWareneingangsList;

  }
  List<Wareneingang> getArchiveAllWareneingang() {

    _wareneingangRepository.getArchivWareneingang().then((Wareneingangs) {
      emit(ArchivWareneingangLoadedState(Wareneingangs));
      this.archivWareneingangsList = Wareneingangs;
    });
    return archivWareneingangsList;

  }

  Future addWareneingang(Map<String,dynamic> data){
    return _wareneingangRepository.addWareneingang(data).then((addWareneingangResponse) {
      emit(addWareneingangState());
      return addWareneingangResponse;
    });
  }

}
