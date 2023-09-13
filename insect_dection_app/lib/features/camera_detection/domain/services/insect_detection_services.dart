import 'package:dartz/dartz.dart';
import 'package:image/image.dart' as img_lib;
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

abstract class InsectDetectionService {
  Future<Either<Failure, DetectionResultList>> getDetectionResult(
      img_lib.Image image);
  Future<void> close();
}
