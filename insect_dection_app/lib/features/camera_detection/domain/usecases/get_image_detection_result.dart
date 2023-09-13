// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:image/image.dart' as img_lib;
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

class GetDetectionResult extends UseCase<DetectionResultList, img_lib.Image> {
  final InsectDetectionService _service;
  GetDetectionResult({
    required InsectDetectionService service,
  }) : _service = service;
  @override
  Future<Either<Failure, DetectionResultList>> call(img_lib.Image params) =>
      _service.getDetectionResult(params);

  Future<void> close() async {
    _service.close();
  }
}
