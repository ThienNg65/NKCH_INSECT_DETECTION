// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'recently_detection_bloc.dart';

class RecentlyDetectedInsectsState extends Equatable {
  /// State Values
  final InsectList recentlyDetectedInsectList;

  /// State Process
  final Process getRecentlyDetectedInsectListProcess;

  const RecentlyDetectedInsectsState._internal({
    required this.getRecentlyDetectedInsectListProcess,
    required this.recentlyDetectedInsectList,
  });
  factory RecentlyDetectedInsectsState.initial() {
    return RecentlyDetectedInsectsState._internal(
      recentlyDetectedInsectList: InsectList.empty(),
      getRecentlyDetectedInsectListProcess: const Initial(),
    );
  }

  @override
  List<Object> get props => [
        recentlyDetectedInsectList,
        getRecentlyDetectedInsectListProcess,
      ];

  RecentlyDetectedInsectsState copyWith({
    InsectList? recentlyDetectedInsectList,
    Process? getRecentlyDetectedInsectListProcess,
  }) {
    return RecentlyDetectedInsectsState._internal(
      recentlyDetectedInsectList:
          recentlyDetectedInsectList ?? this.recentlyDetectedInsectList,
      getRecentlyDetectedInsectListProcess:
          getRecentlyDetectedInsectListProcess ??
              this.getRecentlyDetectedInsectListProcess,
    );
  }
}
