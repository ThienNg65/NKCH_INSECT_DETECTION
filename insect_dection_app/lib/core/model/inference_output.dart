class InferenceOutput {
  final String modelId;
  final String labelName;
  final double score;

  InferenceOutput(this.modelId, this.labelName, this.score);

  @override
  bool operator ==(covariant InferenceOutput other) {
    if (identical(this, other)) return true;

    return other.modelId == modelId &&
        other.labelName == labelName &&
        other.score == score;
  }

  @override
  int get hashCode => modelId.hashCode ^ labelName.hashCode ^ score.hashCode;
}
