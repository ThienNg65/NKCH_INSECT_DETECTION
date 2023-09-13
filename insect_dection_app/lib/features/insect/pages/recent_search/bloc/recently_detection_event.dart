part of 'recently_detection_bloc.dart';

sealed class RecentlyDetectedInsectsEvent extends Equatable {}

final class LoadRecentlyDetectedInsectsEvent extends RecentlyDetectedInsectsEvent {
  final UserBucketParams userBucketParams;

  LoadRecentlyDetectedInsectsEvent({required this.userBucketParams});

  @override
  List<Object?> get props => [userBucketParams];
}
