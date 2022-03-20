import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_state.dart';
import 'package:hf/data_layer/models/bestellung.dart';
import 'package:hf/data_layer/models/kassen.dart';
import 'package:hf/data_layer/repository/bestellung_repository.dart';

class BestellungCubit extends Cubit<BestellungState>{
  final BestellungRepository _bestellungRepository;
  List<Bestellung> allBestellungList = [];
  List<Bestellung> archivBestellungList = [];
  List<Kassen> KassenList = [];
  BestellungCubit(this._bestellungRepository) : super(BestellungInitial());


  List<Kassen> getAllKassen(){
    _bestellungRepository.getAllKassen().then((kassen){
      emit(KassenLoadedState(kassen));
      this.KassenList = kassen;
    });
    return KassenList;
  }

  List<Bestellung> getAllBestellung() {
    _bestellungRepository.getAllBestellung().then((bestellungs) {
      emit(BestellungLoadedState(bestellungs));
      this.allBestellungList = bestellungs;
    });
    return allBestellungList;

  }
  List<Bestellung> getArchiveAllBestellung() {

    _bestellungRepository.getArchivBestellung().then((bestellungs) {
      emit(ArchivBestellungLoadedState(bestellungs));
      this.archivBestellungList = bestellungs;
    });
    return archivBestellungList;

  }

  Future addBestellung(Map<String,dynamic> data){
    return _bestellungRepository.addBestellung(data).then((addBestellungResponse) {
      emit(addBestellungState());
      return addBestellungResponse;
    });
  }

}