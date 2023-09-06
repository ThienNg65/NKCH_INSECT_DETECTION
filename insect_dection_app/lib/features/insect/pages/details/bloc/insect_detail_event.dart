part of 'insect_detail_bloc.dart';

sealed class InsectDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoadInsectDetailEvent extends InsectDetailEvent {
  final UserBucketParams userBucketParams;

  final String modelId;

  LoadInsectDetailEvent({
    required this.modelId,
    required this.userBucketParams,
  });

  @override
  List<Object?> get props => [modelId, userBucketParams];
}

final class LoadUserInsectBookmarkStateProcessEvent extends InsectDetailEvent {
  final UserBucketParams userBucketParams;

  final String modelId;

  LoadUserInsectBookmarkStateProcessEvent({
    required this.modelId,
    required this.userBucketParams,
  });

  @override
  List<Object?> get props => [modelId, userBucketParams];
}

final class AddRecentlySearchInsectEvent extends InsectDetailEvent {
  final UserBucketParams userBucketParams;
  final Insect insect;

  AddRecentlySearchInsectEvent({
    required this.insect,
    required this.userBucketParams,
  });

  @override
  List<Object?> get props => [insect, userBucketParams];
}

final class ToggleBookmarkedInsectEvent extends InsectDetailEvent {
  final UserBucketParams userBucketParams;

  final Insect insect;
  final bool isBookmarked;

  ToggleBookmarkedInsectEvent({
    required this.userBucketParams,
    required this.insect,
    required this.isBookmarked,
  });
  @override
  List<Object?> get props => [userBucketParams, insect, isBookmarked];
}
