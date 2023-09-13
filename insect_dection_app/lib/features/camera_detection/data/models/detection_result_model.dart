import 'dart:convert';

import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

class DetectionResultModel extends DetectionResult {
  const DetectionResultModel({
    required super.modelId,
    required super.labelName,
    required super.score,
  });
  DetectionResult copyWith({
    String? modelId,
    String? labelName,
    double? score,
  }) {
    return DetectionResult(
      modelId: modelId ?? this.modelId,
      labelName: labelName ?? this.labelName,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'modelId': modelId,
      'labelName': labelName,
      'score': score,
    };
  }

  factory DetectionResultModel.fromMap(Map<String, dynamic> map) {
    return DetectionResultModel(
      modelId: map['modelId'] as String,
      labelName: map['labelName'] as String,
      score: map['score'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetectionResultModel.fromJson(String source) =>
      DetectionResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory DetectionResultModel.fromInferenceOutput(InferenceOutput output) {
    return DetectionResultModel(
      modelId: output.modelId,
      labelName: output.labelName,
      score: output.score,
    );
  }
}
