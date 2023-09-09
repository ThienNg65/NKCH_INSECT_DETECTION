part of 'bookmarked_insects_bloc.dart';

sealed class BookmarkedInsectsEvent extends Equatable {}

final class LoadBookmaredInsectsEvent extends BookmarkedInsectsEvent {
  final UserBucketParams userBucketParams;

  LoadBookmaredInsectsEvent({required this.userBucketParams});

  @override
  List<Object?> get props => [userBucketParams];
}

final class RemoveBookmarkedInsectEvent extends BookmarkedInsectsEvent {
  RemoveBookmarkedInsectEvent({
    required this.userBucketParams,
    required this.insect,
  });

  final UserBucketParams userBucketParams;
  final Insect insect;
  @override
  List<Object?> get props => [
        userBucketParams,
        insect,
      ];
}
