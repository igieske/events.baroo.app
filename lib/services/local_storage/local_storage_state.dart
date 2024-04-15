part of 'local_storage_bloc.dart';

@immutable
class LocalStorageState {
  final int selectedTabIndex;
  final PageController pageController = PageController(initialPage: 0);

  LocalStorageState({ this.selectedTabIndex = 0 });

  LocalStorageState copyWith({ required int selectedTabIndex }) {
    pageController.jumpToPage(selectedTabIndex);
    return LocalStorageState(
      selectedTabIndex: selectedTabIndex,
    );
  }

}

class LocalStorageInitial extends LocalStorageState {}
