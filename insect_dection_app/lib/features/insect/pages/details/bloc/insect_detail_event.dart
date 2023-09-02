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

final class ToggleBookmarkedInsectEvent extends InsectDetailEvent {
  final Insect insect;
  final bool isBookmarked;

  ToggleBookmarkedInsectEvent({
    required this.insect,
    this.isBookmarked = false,
  });
  @override
  List<Object?> get props => [insect, isBookmarked];
}
