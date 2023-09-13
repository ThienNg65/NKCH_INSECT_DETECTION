import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img_lib;
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

class InsectDetectionServiceImpl implements InsectDetectionService {
  final ImageClassificationHelper _classificationHelper;
  // final int _offset = 3;
  InsectDetectionServiceImpl({required ImageClassificationHelper helper})
      : _classificationHelper = helper {
    _classificationHelper.initHelper();
  }
  @override
  Future<Either<Failure, DetectionResultList>> getDetectionResult(
      img_lib.Image image) async {
    try {
      final result = await _classificationHelper.inferenceImage(image);
      final output = result
          .map<DetectionResult>(
              (e) => DetectionResultModel.fromInferenceOutput(e))
          .toList()
        ..sort((a, b) => a.score.compareTo(b.score));
      return Right(DetectionResultList(detectionResults: output));
    } catch (err) {
      debugPrint(err.toString());
      return Left(DetectionResultFailure(errorMessage: err.toString()));
    }
  }

  @override
  Future<void> close() async {
    _classificationHelper.close();
  }
}
