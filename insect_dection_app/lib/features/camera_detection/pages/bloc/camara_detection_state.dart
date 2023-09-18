// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'camara_detection_bloc.dart';

class CamaraDetectionState extends Equatable {
  final DetectionResultList detectionResultList;
  final Process insectDetectionProcess;
  final String? imagePath;

  final Process addRecentlySearchInsectProcess;

  final String? message;

  const CamaraDetectionState({
    required this.detectionResultList,
    required this.insectDetectionProcess,
    this.imagePath,
    required this.addRecentlySearchInsectProcess,
    this.message,
  });
  @override
  List<Object?> get props => [
        detectionResultList,
        insectDetectionProcess,
        imagePath,
        message,
      ];

  CamaraDetectionState copyWith({
    DetectionResultList? detectionResultList,
    Process? insectDetectionProcess,
    String? imagePath,
    Process? addRecentlySearchInsectProcess,
    String? message,
  }) {
    return CamaraDetectionState(
      detectionResultList: detectionResultList ?? this.detectionResultList,
      insectDetectionProcess:
          insectDetectionProcess ?? this.insectDetectionProcess,
      imagePath: imagePath ?? this.imagePath,
      addRecentlySearchInsectProcess:
          addRecentlySearchInsectProcess ?? this.addRecentlySearchInsectProcess,
      message: message ?? this.message,
    );
  }

  factory CamaraDetectionState.initial() => CamaraDetectionState(
        addRecentlySearchInsectProcess: const Initial(),
        detectionResultList: DetectionResultList.empty(),
        insectDetectionProcess: const Initial(),
      );
}
