// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class Insect extends Equatable {
  final String modelId;
  final Taxonomy taxonomy;
  final Nomenclature nomenclature;
  final Impacts impacts;
  final String? origin;
  final String? predators;
  final String? photoUrl;

  final String? identificationFeatures;
  final String? lifeCycle;
  final String? pestControl;

  const Insect({
    required this.modelId,
    required this.taxonomy,
    required this.nomenclature,
    required this.impacts,
    this.origin,
    this.predators,
    this.photoUrl,
    this.identificationFeatures,
    required this.lifeCycle,
    this.pestControl,
  });

  @override
  List<Object?> get props {
    return [
      modelId,
      taxonomy,
      nomenclature,
      impacts,
      origin,
      predators,
      photoUrl,
      identificationFeatures,
      lifeCycle,
      pestControl,
    ];
  }

  Insect copyWith({
    String? modelId,
    Taxonomy? taxonomy,
    Nomenclature? nomenclature,
    Impacts? impacts,
    String? origin,
    String? predators,
    String? photoUrl,
    String? identificationFeatures,
    String? lifeCycle,
    String? pestControl,
  }) {
    return Insect(
      modelId: modelId ?? this.modelId,
      taxonomy: taxonomy ?? this.taxonomy,
      nomenclature: nomenclature ?? this.nomenclature,
      impacts: impacts ?? this.impacts,
      origin: origin ?? this.origin,
      predators: predators ?? this.predators,
      photoUrl: photoUrl ?? this.photoUrl,
      identificationFeatures:
          identificationFeatures ?? this.identificationFeatures,
      lifeCycle: lifeCycle ?? this.lifeCycle,
      pestControl: pestControl ?? this.pestControl,
    );
  }
}
