part of 'teil_inventur_artikel_cubit.dart';

@immutable
abstract class TeilInventurArtikelState {}

class TeilInventurArtikelInitial extends TeilInventurArtikelState {}

class TeilInventurArtikelLoadedState extends TeilInventurArtikelState {
  final List<TeilInventurArtikel> teilInventurArtikels;
  TeilInventurArtikelLoadedState(this.teilInventurArtikels);
}

class TeilInventurArtikelErrorState extends TeilInventurArtikelState {
  final String error;
  TeilInventurArtikelErrorState(this.error);
}
