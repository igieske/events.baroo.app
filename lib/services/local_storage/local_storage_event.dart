part of 'local_storage_bloc.dart';

@immutable
abstract class LocalStorageEvent {}

class ScaffoldGoToTabEvent extends LocalStorageEvent {
  // final int selectedTabIndex;
  // LocalStorageGoToTabEvent(this.selectedTabIndex);
}