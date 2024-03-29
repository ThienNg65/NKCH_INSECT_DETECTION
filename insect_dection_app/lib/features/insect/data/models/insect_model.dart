// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectModel extends Equatable {
  final String modelId;
  final TaxonomyModel taxonomy;
  final NomenclatureModel nomenclature;
  final ImpactModel impacts;
  final String? origin;
  final String? predators;
  final String? photoUrl;

  final String? identificationFeatures;
  final String? lifeCycle;
  final String? pestControl;

  final String? effect;
  final String? harmedObject;

  const InsectModel({
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
      effect,
      harmedObject,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'modelId': modelId,
      'taxonomy': taxonomy.toMap(),
      'nomenclature': nomenclature.toMap(),
      'impacts': impacts.toMap(),
      'origin': origin,
      'predators': predators,
      'photoUrl': photoUrl,
      'identificationFeatures': identificationFeatures,
      'lifeCycle': lifeCycle,
      'pestControl': pestControl,
      'effect': effect,
      'harmedObject': harmedObject,
    };
  }

  factory InsectModel.fromMap(Map<String, dynamic>? map) {
    return map != null
        ? InsectModel(
            modelId: map['modelId'].toString(),
            taxonomy: TaxonomyModel.fromMap(map['taxonomy']),
            nomenclature: NomenclatureModel.fromMap(map['nomenclature']),
            impacts: ImpactModel.fromMap(map['impacts'] ?? map['impacts']),
            origin: map['origin'] ?? '',
            predators: map['predators'] ?? '',
            photoUrl: map['photoUrl'] ?? '',
            identificationFeatures: map['identificationFeatures'] ?? '',
            lifeCycle: map['lifeCycle'] ?? '',
            pestControl: map['pestControl'] ?? '',
            effect: map['effect'] ?? '',
            harmedObject: map['harmedObject'] ?? '',
          )
        : InsectModel.empty();
  }

  String toJson() => json.encode(toMap());

  factory InsectModel.fromJson(String source) =>
      InsectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  InsectModel copyWith({
    String? modelId,
    TaxonomyModel? taxonomy,
    NomenclatureModel? nomenclature,
    ImpactModel? impacts,
    String? origin,
    String? predators,
    String? photoUrl,
    String? identificationFeatures,
    String? lifeCycle,
    String? pestControl,
    String? effect,
    String? harmedObject,
  }) {
    return InsectModel(
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

  static InsectModel fromParams(InsectParams insectParams) => InsectModel(
        modelId: insectParams.modelId,
        taxonomy: TaxonomyModel.fromEntity(insectParams.taxonomy),
        nomenclature: NomenclatureModel.fromEntity(insectParams.nomenclature),
        impacts: ImpactModel.fromEntity(insectParams.impacts),
        origin: insectParams.origin,
        predators: insectParams.predators,
        photoUrl: insectParams.photoUrl,
        identificationFeatures: insectParams.identificationFeatures,
        lifeCycle: insectParams.lifeCycle,
        pestControl: insectParams.pestControl,
        harmedObject: insectParams.harmedObject,
        effect: insectParams.effect,
      );
  Insect toEntity() => Insect(
        modelId: modelId,
        taxonomy: taxonomy.toEntity(),
        nomenclature: nomenclature.toEntity(),
        impacts: impacts.toEntity(),
        origin: origin ?? '',
        predators: predators ?? '',
        photoUrl: photoUrl ?? '',
        identificationFeatures: identificationFeatures ?? '',
        lifeCycle: lifeCycle ?? '',
        pestControl: pestControl ?? '',
        harmedObject: harmedObject ?? '',
        effect: effect ?? '',
      );
  static InsectModel fromEntity(Insect enity) => InsectModel(
        modelId: enity.modelId,
        taxonomy: TaxonomyModel.fromEntity(enity.taxonomy),
        nomenclature: NomenclatureModel.fromEntity(enity.nomenclature),
        impacts: ImpactModel.fromEntity(enity.impacts),
        origin: enity.origin,
        predators: enity.predators,
        photoUrl: enity.photoUrl,
        identificationFeatures: enity.identificationFeatures,
        lifeCycle: enity.lifeCycle,
        pestControl: enity.pestControl,
        harmedObject: enity.harmedObject,
        effect: enity.effect,
      );
  factory InsectModel.empty() => InsectModel(
        modelId: '',
        taxonomy: TaxonomyModel.fromEntity(Taxonomy.empty),
        nomenclature: NomenclatureModel.fromEntity(Nomenclature.empty),
        impacts: ImpactModel.fromEntity(Impact.empty),
      );
}
