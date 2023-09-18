import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:image/image.dart' as img_lib;

part 'camara_detection_event.dart';
part 'camara_detection_state.dart';

class CamaraDetectionBloc
    extends Bloc<CamaraDetectionEvent, CamaraDetectionState> {
  final GetDetectionResult _getDetectionResult;
  final AddRecentlySearchInsect _addRecentlySearchInsect;
  final GetInsectByModelId _getInsectByModelId;
  CamaraDetectionBloc({
    required GetDetectionResult getDetectionResult,
    required AddRecentlySearchInsect addRecentlySearchInsect,
    required GetInsectByModelId getInsectByModelId,
  })  : _getDetectionResult = getDetectionResult,
        _addRecentlySearchInsect = addRecentlySearchInsect,
        _getInsectByModelId = getInsectByModelId,
        super(CamaraDetectionState.initial()) {
    on<ProcessImageDetectionEvent>(_onProcessImageDetectionEvent);
    on<AddRecentlyDetectedInsectEvent>(_onAddRecentlyDetectedInsectEvent);
  }

  Future<void> _onProcessImageDetectionEvent(
    ProcessImageDetectionEvent event,
    Emitter<CamaraDetectionState> emit,
  ) async {
    emit(state.copyWith(
      imagePath: event.imagePath,
      addRecentlySearchInsectProcess: const Success(),
      insectDetectionProcess: const Loading(),
    ));
    final result = await _getDetectionResult(event.insectImage);

    result.fold(
      (Failure failure) {
        emit(state.copyWith(
            insectDetectionProcess: Failed(failure.errorMessage)));
      },
      (DetectionResultList detectionResultList) {
        var highestList =
            detectionResultList.detectionResults.reversed.take(3).toList();
        if (highestList.isNotEmpty) {
          emit(
            state.copyWith(
              insectDetectionProcess: const Success(),
              detectionResultList: detectionResultList.copyWith(
                detectionResults: highestList,
              ),
            ),
          );
        } else {
          emit(state.copyWith(
            insectDetectionProcess:
                const Failed("Cannot detect the insects in the image "),
          ));
        }
      },
    );
  }

  Future<void> _onAddRecentlyDetectedInsectEvent(
      AddRecentlyDetectedInsectEvent event,
      Emitter<CamaraDetectionState> emit) async {
    try {
      emit(state.copyWith(addRecentlySearchInsectProcess: const Loading()));

      final insectResult = await _getInsectByModelId(event.modelId);
      await insectResult.fold(
        (Failure failure) {
          emit(
            state.copyWith(
              addRecentlySearchInsectProcess:
                  Failed(failure.errorMessage ?? ''),
            ),
          );
        },
        (Insect insect) async {
          final result = await _addRecentlySearchInsect(
            event.userBucketParams,
            InsectParams.fromEntity(insect),
          );
          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  addRecentlySearchInsectProcess:
                      Failed(failure.errorMessage ?? ''),
                ),
              );
            },
            (entity) {
              emit(
                state.copyWith(
                  addRecentlySearchInsectProcess: const Success(),
                ),
              );
            },
          );
        },
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> closeService() => _getDetectionResult.close();
}
