import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:image/image.dart' as img_lib;

part 'camara_detection_event.dart';
part 'camara_detection_state.dart';

class CamaraDetectionBloc
    extends Bloc<CamaraDetectionEvent, CamaraDetectionState> {
  final GetDetectionResult _getDetectionResult;
  CamaraDetectionBloc({required GetDetectionResult getDetectionResult})
      : _getDetectionResult = getDetectionResult,
        super(CamaraDetectionState.initial()) {
    on<ProcessImageDetectionEvent>(_onProcessImageDetectionEvent);
  }

  Future<void> _onProcessImageDetectionEvent(
    ProcessImageDetectionEvent event,
    Emitter<CamaraDetectionState> emit,
  ) async {
    emit(CamaraDetectionState.initial());
    emit(state.copyWith(imagePath: event.imagePath));
    final result = await _getDetectionResult(event.insectImage);

    result.fold(
      (Failure failure) {
        emit(state.copyWith(
            insectDetectionProcess: Failed(failure.errorMessage)));
      },
      (DetectionResultList detectionResultList) {
        var highestList =
            detectionResultList.detectionResults.reversed.take(3).toList();
        emit(state.copyWith(
          insectDetectionProcess: const Success(),
          detectionResultList:
              detectionResultList.copyWith(detectionResults: highestList),
        ));
      },
    );
  }

  Future<void> closeService() => _getDetectionResult.close();
}
