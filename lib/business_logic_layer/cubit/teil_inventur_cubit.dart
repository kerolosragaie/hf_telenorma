import 'package:bloc/bloc.dart';
import 'package:hf/data_layer/models/teil_inventur.dart';
import 'package:hf/data_layer/repository/teil_inventur_repository.dart';
import 'package:meta/meta.dart';

part 'teil_inventur_state.dart';

class TeilInventurCubit extends Cubit<TeilInventurState> {
  final TeilInventurRepository teilInventurRepository;
  List<TeilInventur> teilInventursList = [];

  TeilInventurCubit(this.teilInventurRepository) : super(TeilInventurInitial());

  List<TeilInventur> getAllTeilInventur() {
    teilInventurRepository.getAllTeilInventur().then((teilInventurs) {
      emit(TeilInventurLoadedState(teilInventurs));
      this.teilInventursList = teilInventurs;
    });
    return teilInventursList;
  }
}
