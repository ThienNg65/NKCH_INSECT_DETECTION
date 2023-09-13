// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/camera_detection/camera_detection.dart';

// ignore: must_be_immutable
class DetectionResultList extends Equatable {
  List<DetectionResult> detectionResults;
  DetectionResultList({
    required this.detectionResults,
  });
  factory DetectionResultList.empty() =>
      DetectionResultList(detectionResults: const <DetectionResult>[]);

  DetectionResultList copyWith({
    List<DetectionResult>? detectionResults,
  }) {
    return DetectionResultList(
      detectionResults: detectionResults ?? this.detectionResults,
    );
  }

  @override
  List<Object?> get props => [detectionResults];
}
