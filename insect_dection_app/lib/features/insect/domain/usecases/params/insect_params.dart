// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectParams extends Equatable {
  final String modelId;
  final Taxonomy taxonomy;
  final Nomenclature nomenclature;
  final Impact impacts;
  final String? origin;
  final String? predators;
  final String? photoUrl;

  final String? identificationFeatures;
  final String? lifeCycle;
  final String? pestControl;

  final String? effect;
  final String? harmedObject;

  const InsectParams({
    required this.modelId,
    required this.taxonomy,
    required this.nomenclature,
    required this.impacts,
    this.origin,
    this.predators,
    this.photoUrl,
    this.identificationFeatures,
    this.lifeCycle,
    this.pestControl,
    this.effect,
    this.harmedObject,
  });

  InsectParams copyWith({
    String? modelId,
    Taxonomy? taxonomy,
    Nomenclature? nomenclature,
    Impact? impacts,
    String? origin,
    String? predators,
    String? photoUrl,
    String? identificationFeatures,
    String? lifeCycle,
    String? pestControl,
    String? effect,
    String? harmedObject,
  }) {
    return InsectParams(
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
      effect: effect ?? this.effect,
      harmedObject: harmedObject ?? this.harmedObject,
    );
  }

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
      harmedObject,
      effect,
    ];
  }

  factory InsectParams.fromEntity(Insect enitty) => InsectParams(
        modelId: enitty.modelId,
        taxonomy: enitty.taxonomy,
        nomenclature: enitty.nomenclature,
        impacts: enitty.impacts,
        origin: enitty.origin,
        predators: enitty.predators,
        photoUrl: enitty.photoUrl,
        identificationFeatures: enitty.identificationFeatures,
        lifeCycle: enitty.lifeCycle,
        pestControl: enitty.pestControl,
        harmedObject: enitty.harmedObject,
        effect: enitty.effect,
      );
}
