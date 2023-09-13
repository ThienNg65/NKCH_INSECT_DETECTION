import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

part 'recently_detection_event.dart';
part 'recently_detection_state.dart';

class RecentlyDetectionBloc
    extends Bloc<RecentlyDetectedInsectsEvent, RecentlyDetectedInsectsState> {
  final GetRecentlySearchInsectList _getRecentlySearchInsectList;

  RecentlyDetectionBloc(
      {required GetRecentlySearchInsectList getRecentlySearchInsectList})
      : _getRecentlySearchInsectList = getRecentlySearchInsectList,
        super(RecentlyDetectedInsectsState.initial()) {
    on<LoadRecentlyDetectedInsectsEvent>(_onLoadRecentlyDetectedInsectsEvent);
  }

  Future<void> _onLoadRecentlyDetectedInsectsEvent(
      LoadRecentlyDetectedInsectsEvent event,
      Emitter<RecentlyDetectedInsectsState> emit) async {
    emit(state.copyWith(getRecentlyDetectedInsectListProcess: const Loading()));
    try {
      final result = await _getRecentlySearchInsectList(
        event.userBucketParams,
        InsectListParams.empty(),
      );
      result?.fold(
        (Failure failure) {
          emit(state.copyWith(
            getRecentlyDetectedInsectListProcess: Failed(failure.errorMessage),
          ));
        },
        (InsectList insectList) {
          emit(
            state.copyWith(
              getRecentlyDetectedInsectListProcess: const Success(),
              recentlyDetectedInsectList: insectList,
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
