// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'camara_detection_bloc.dart';

class CamaraDetectionState extends Equatable {
  final DetectionResultList detectionResultList;
  final Process insectDetectionProcess;
  final String? imagePath;

  final String? message;

  const CamaraDetectionState({
    required this.detectionResultList,
    required this.insectDetectionProcess,
    this.imagePath,
    this.message,
  });
  @override
  List<Object?> get props =>
      [detectionResultList, insectDetectionProcess, imagePath, message];

  CamaraDetectionState copyWith({
    DetectionResultList? detectionResultList,
    Process? insectDetectionProcess,
    String? imagePath,
    String? message,
  }) {
    return CamaraDetectionState(
      detectionResultList: detectionResultList ?? this.detectionResultList,
      insectDetectionProcess:
          insectDetectionProcess ?? this.insectDetectionProcess,
      imagePath: imagePath ?? this.imagePath,
      message: message ?? this.message,
    );
  }

  factory CamaraDetectionState.initial() => CamaraDetectionState(
        detectionResultList: DetectionResultList.empty(),
        insectDetectionProcess: const Initial(),
      );
}
