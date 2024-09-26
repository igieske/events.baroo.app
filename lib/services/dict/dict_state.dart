part of 'dict_cubit.dart';

@immutable
sealed class DictState {}

final class DictInitial extends DictState {}

final class DictLoading extends DictState {}

final class Dict extends DictState {
  final List<Bar> bars;
  final List<Genre> genres;
  final List<CaseType> caseTypes;

  Dict({
    required this.bars,
    required this.genres,
    required this.caseTypes,
  });
}

final class DictError extends DictState {
  final String message;

  DictError({required this.message});
}