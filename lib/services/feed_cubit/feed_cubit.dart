import 'package:events_baroo_app/services/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:events_baroo_app/models/case.dart';

part 'feed_state.dart';


class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedState.initial());

  void getCases() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {

      final response = await Http.post('get-cases');
      final List<Case> allCases = (response as List).map((cs) {
        return Case.fromJson(cs);
      }).toList();

      DateTime now = DateTime.now();

      List<Case> pastCases = allCases.where((event) => event.date.isBefore(now)).toList();
      List<Case> futureCases = allCases.where((event) => event.date.isAfter(now)).toList();

      emit(state.copyWith(
        cases: futureCases,
        pastCases: pastCases,
        isLoading: false,
      ));

    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Ошибка загрузки событий: $e',
      ));
    }

  }
}
