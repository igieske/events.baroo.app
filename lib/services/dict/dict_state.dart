part of 'dict_cubit.dart';

@immutable
sealed class DictState {}

final class DictInitial extends DictState {}

final class DictLoading extends DictState {}

final class Dict extends DictState {
  final List<Bar> bars;
  final List<Band> bands;
  final List<Fella> fellas;
  final List<Genre> genres;
  final List<CaseType> caseTypes;

  List<Artist> get artists => [...fellas, ...bands];

  Dict({
    required this.bars,
    required this.bands,
    required this.fellas,
    required this.genres,
    required this.caseTypes,
  });
}

final class DictError extends DictState {
  final String message;

  DictError({required this.message});
}