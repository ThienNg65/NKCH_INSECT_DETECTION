// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class Insect extends Equatable {
  final String modelId;
  final Taxonomy taxonomy;
  final Nomenclature nomenclature;
  final Impact impacts;
  final String origin;
  final String predators;
  final String photoUrl;

  final String identificationFeatures;
  final String lifeCycle;
  final String pestControl;

  final String harms;
  final String harmedObject;

  const Insect({
    required this.modelId,
    required this.taxonomy,
    required this.nomenclature,
    required this.impacts,
    this.origin = '',
    this.predators = '',
    this.photoUrl = '',
    this.identificationFeatures = '',
    this.lifeCycle = '',
    this.pestControl = '',
    this.harms = '',
    this.harmedObject = '',
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
      harms,
      harmedObject,
    ];
  }

  static get empty => Insect(
        modelId: '',
        taxonomy: Taxonomy.empty,
        nomenclature: Nomenclature.empty,
        impacts: Impact.empty,
      );

  Insect copyWith({
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
    String? harms,
    String? harmedObject,
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
      harmedObject: harmedObject ?? this.harmedObject,
      harms: harms ?? this.harms,
    );
  }

  @override
  String toString() => identificationFeatures;
}
