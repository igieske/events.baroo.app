part of 'scaffold_bloc.dart';

@immutable
class ScaffoldState {
  final int selectedTabIndex;
  final PageController pageController = PageController(initialPage: 0);

  ScaffoldState({ this.selectedTabIndex = 0 });

  ScaffoldState copyWith({ required int selectedTabIndex }) {
    pageController.jumpToPage(selectedTabIndex);
    return ScaffoldState(
      selectedTabIndex: selectedTabIndex,
    );
  }

}

class ScaffoldInitial extends ScaffoldState {}
