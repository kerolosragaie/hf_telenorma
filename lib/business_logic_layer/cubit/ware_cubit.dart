import 'package:bloc/bloc.dart';
import 'package:hf/business_logic_layer/cubit/ware_states.dart';
import 'package:hf/data_layer/models/ware.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';

class WareCubit extends Cubit<WareStates> {
  final WareRepository wareRepository;
  List<Ware> ware = [];
  List<Ware> allWare = [];
  double menge = 1.0;

  increaseMenge(){
    menge++;
    emit(IncreaseMenge());
  }
  decreaseMenge(){
    menge > 1 ? menge -- : menge;
    emit(DecreaseMenge());
  }
  WareCubit(this.wareRepository)
      : super(WareInitialState());


  Future<List<Ware>> getWare(
      {required  barCode}) {
    wareRepository.checkBarCodeInDatabase(barCode: barCode).then((wareResponse) {
      ware = wareResponse;
      emit(WareLoadedState());
    });

    return Future.value(ware);

  }

  List<Ware> getAllWare() {
    wareRepository.getAllWare().then((wareResponse) {
      allWare = wareResponse;
       emit(AllWareLoadedState(wareResponse));
    });

    return allWare;

  }

}
