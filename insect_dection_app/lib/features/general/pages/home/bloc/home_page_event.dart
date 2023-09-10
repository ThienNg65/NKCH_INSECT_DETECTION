part of 'home_page_bloc.dart';

sealed class HomePageEvent {}

final class LoadRecentlySearchInsectListEvent extends HomePageEvent {
  final UserBucketParams userBucketParams;

  LoadRecentlySearchInsectListEvent({required this.userBucketParams});
}

final class LoadRecentlyBookmarkedInsectListEvent extends HomePageEvent {
  final UserBucketParams userBucketParams;
  final InsectListParams insectListParams;

  LoadRecentlyBookmarkedInsectListEvent({
    required this.userBucketParams,
    required this.insectListParams,
  });
}

final class LoadInitialInsectListEvent extends HomePageEvent {
  final InsectListParams insectListParams;

  LoadInitialInsectListEvent({required this.insectListParams});
}
