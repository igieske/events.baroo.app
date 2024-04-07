part of 'scaffold_bloc.dart';

@immutable
abstract class ScaffoldEvent {}

class ScaffoldGoToTabEvent extends ScaffoldEvent {
  final int selectedTabIndex;
  ScaffoldGoToTabEvent(this.selectedTabIndex);
}