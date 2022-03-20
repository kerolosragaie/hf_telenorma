import 'package:bloc/bloc.dart';
import 'package:hf/business_logic_layer/cubit/inventur_state.dart';
import 'package:hf/data_layer/models/Inventur.dart';
import 'package:hf/data_layer/repository/Inventur_repository.dart';

class InventurCubit extends Cubit<InventurState> {
  final InventurRepository inventurRepository;
  List<Inventur> allInventursList = [];
  List<Inventur> archivInventursList = [];

  InventurCubit(this.inventurRepository) : super(InventurInitial());

  List<Inventur> getAllInventur() {
    inventurRepository.getAllInventur().then((teilInventurs) {
      emit(InventurLoadedState(teilInventurs));
      this.allInventursList = teilInventurs;
    });
    return allInventursList;

  }
  List<Inventur> getArchiveAllInventur() {

    inventurRepository.getArchivInventur().then((teilInventurs) {
      emit(ArchivInventurLoadedState(teilInventurs));
      this.archivInventursList = teilInventurs;
    });
    return archivInventursList;

  }

  Future addInventur(Map<String,dynamic> data){
    return inventurRepository.addInventur(data).then((addInventurResponse) {
      emit(addInventurState());
      return addInventurResponse;
    });
  }

}
