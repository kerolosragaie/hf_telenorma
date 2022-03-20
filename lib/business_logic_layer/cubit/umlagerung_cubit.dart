

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/umlagerung_state.dart';
import 'package:hf/data_layer/models/umlagerung.dart';
import 'package:hf/data_layer/repository/umlagerung_repository.dart';

class UmlagerungCubit extends Cubit<UmlagerungState> {

  final UmlagerungRepository _umlagerungRepository;
  List<Umlagerung> allUmlagerungsList = [];
  List<Umlagerung> archivUmlagerungsList = [];

  UmlagerungCubit(this._umlagerungRepository) : super(UmlagerungInitial());

  List<Umlagerung> getAllUmlagerung() {
    _umlagerungRepository.getAllUmlagerung().then((umlagerungs) {
      emit(UmlagerungLoadedState(umlagerungs));
      this.allUmlagerungsList = umlagerungs;
    });
    return allUmlagerungsList;

  }

  List<Umlagerung> getArchiveAllUmlagerung() {

    _umlagerungRepository.getArchivUmlagerung().then((umlagerungs) {
      emit(ArchivUmlagerungLoadedState(umlagerungs));
      this.archivUmlagerungsList = umlagerungs;
    });
    return archivUmlagerungsList;

  }

  Future addUmlagerung(Map<String,dynamic> data){
    return _umlagerungRepository.addUmlagerung(data).then((addUmlagerungResponse) {
      emit(addUmlagerungState());
      return addUmlagerungResponse;
    });
  }

}