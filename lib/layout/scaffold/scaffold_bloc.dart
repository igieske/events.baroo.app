import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'scaffold_event.dart';
part 'scaffold_state.dart';

class ScaffoldBloc extends Bloc<ScaffoldEvent, ScaffoldState> {
  ScaffoldBloc() : super(ScaffoldInitial()) {
    on<ScaffoldGoToTabEvent>(_onGoToTab);
  }

  _onGoToTab(ScaffoldGoToTabEvent event, Emitter<ScaffoldState> emit) {
    emit(state.copyWith(selectedTabIndex: event.selectedTabIndex));
  }
}
