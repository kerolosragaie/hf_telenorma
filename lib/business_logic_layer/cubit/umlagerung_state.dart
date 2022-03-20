


import 'package:hf/data_layer/models/umlagerung.dart';

abstract class UmlagerungState {}

class UmlagerungInitial extends UmlagerungState {}

class UmlagerungLoadedState extends UmlagerungState {
  final List<Umlagerung> umlagerungs;
  UmlagerungLoadedState(this.umlagerungs);
}
class ArchivUmlagerungLoadedState extends UmlagerungState {
  final List<Umlagerung> umlagerungs;
  ArchivUmlagerungLoadedState(this.umlagerungs);
}

class UmlagerungErrorState extends UmlagerungState {
  final String error;
  UmlagerungErrorState(this.error);
}
class addUmlagerungState extends UmlagerungState{}
