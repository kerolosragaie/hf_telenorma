import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hf/data_layer/models/inventurs.dart';
import 'package:hf/data_layer/repository/inventurs_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inventurs_state.dart';

class InventursCubit extends Cubit<InventursState> {
  final InventursRepository inventursRepository;
  List<Inventurs> inventurs = [];
  //static InventursCubit get(context) => BlocProvider.of(context);
  InventursCubit(this.inventursRepository) : super(InventursInitial());

  List<Inventurs> getAllInventurs() {
    inventursRepository.getAllInventurs().then((inventurs) {
      emit(InventursLoaded(inventurs));
      this.inventurs = inventurs;
    });
    return inventurs;
  }
}
