// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DetectionResult extends Equatable {
  final String modelId;
  final String labelName;
  final double score;

  const DetectionResult({
    required this.modelId,
    required this.labelName,
    required this.score,
  });

  @override
  List<Object> get props => [modelId, labelName, score];

  
}
