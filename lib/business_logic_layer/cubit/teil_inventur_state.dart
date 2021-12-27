part of 'teil_inventur_cubit.dart';

@immutable
abstract class TeilInventurState {}

class TeilInventurInitial extends TeilInventurState {}

class TeilInventurLoadedState extends TeilInventurState {
  final List<TeilInventur> teilInventurs;
  TeilInventurLoadedState(this.teilInventurs);
}

class TeilInventurErrorState extends TeilInventurState {
  final String error;
  TeilInventurErrorState(this.error);
}
