import 'package:baroo/services/local_storage/local_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  LocalStorageBloc() : super(const LocalStorageState()) {
    on<LocalStorageLoadEvent>(_onLoad);
    on<LocalStorageUpdateEvent>(_onUpdate);
  }

  _onLoad(LocalStorageLoadEvent event, Emitter<LocalStorageState> emit) async {
    final Map<String, dynamic> localData = await LocalStorage.read();
    emit(state.copyWith(data: localData));
  }

  _onUpdate(LocalStorageUpdateEvent event, Emitter<LocalStorageState> emit) {
    emit(state.update(event.newValue));
  }

}
