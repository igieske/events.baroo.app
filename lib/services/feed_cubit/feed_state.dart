part of 'feed_cubit.dart';

class FeedState {
  final List<Case> cases;
  final List<Case> pastCases;
  final bool isLoading;
  final String? errorMessage;

  FeedState({
    required this.cases,
    required this.pastCases,
    required this.isLoading,
    this.errorMessage,
  });

  FeedState copyWith({
    List<Case>? cases,
    List<Case>? pastCases,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FeedState(
      cases: cases ?? this.cases,
      pastCases: pastCases ?? this.pastCases,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  factory FeedState.initial() {
    return FeedState(
      cases: [],
      pastCases: [],
      isLoading: true,
      errorMessage: null,
    );
  }
}
