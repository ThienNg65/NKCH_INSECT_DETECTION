import 'package:equatable/equatable.dart';

class DetectionResult extends Equatable {
  final String modelId;
  final String labelName;
  final double probability;

  const DetectionResult(
    this.modelId,
    this.labelName,
    this.probability,
  );

  @override
  List<Object?> get props => [
        modelId,
        labelName,
        probability,
      ];
}
