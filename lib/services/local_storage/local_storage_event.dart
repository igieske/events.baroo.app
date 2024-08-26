part of 'local_storage_bloc.dart';

@immutable
abstract class LocalStorageEvent {}

class LocalStorageLoadEvent extends LocalStorageEvent {
  final Map<String, dynamic> newValue;
  LocalStorageLoadEvent(this.newValue);
}

class LocalStorageUpdateEvent extends LocalStorageEvent {
  final Map<String, dynamic> newValue;
  LocalStorageUpdateEvent(this.newValue);
}