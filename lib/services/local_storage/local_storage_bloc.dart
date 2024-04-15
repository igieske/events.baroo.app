import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  LocalStorageBloc() : super(LocalStorageInitial()) {
    // on<ScaffoldGoToTabEvent>(_onGoToTab);
  }

  // _onGoToTab(ScaffoldGoToTabEvent event, Emitter<ScaffoldState> emit) {
  //   emit(state.copyWith(selectedTabIndex: event.selectedTabIndex));
  // }
}
