// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectModel extends Equatable {
  final String modelId;
  final TaxonomyModel taxonomy;
  final NomenclatureModel nomenclature;
  final ImpactsModel impacts;
  final String? origin;
  final String? predators;
  final String? photoUrl;

  final String? identificationFeatures;
  final String? lifeCycle;
  final String? pestControl;

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
    };
  }

  factory InsectModel.fromMap(Map<String, dynamic> map) {
    return InsectModel(
      modelId: map['modelId'].toString(),
      taxonomy: TaxonomyModel.fromMap(map['taxonomy'] as Map<String, dynamic>),
      nomenclature: NomenclatureModel.fromMap(
          map['nomenclature'] as Map<String, dynamic>),
      impacts: ImpactsModel.fromMap(map['impacts'] as Map<String, dynamic>),
      origin: map['origin'],
      predators: map['predators'],
      photoUrl: map['photoUrl'],
      identificationFeatures: map['identificationFeatures'],
      lifeCycle: map['lifeCycle'],
      pestControl:
          map['pestControl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InsectModel.fromJson(String source) =>
      InsectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  InsectModel copyWith({
    String? modelId,
    TaxonomyModel? taxonomy,
    NomenclatureModel? nomenclature,
    ImpactsModel? impacts,
    String? origin,
    String? predators,
    String? photoUrl,
    String? identificationFeatures,
    String? lifeCycle,
    String? pestControl,
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
    );
  }

  static InsectModel fromParams(InsectParams insectParams) => InsectModel(
        modelId: insectParams.modelId,
        taxonomy: TaxonomyModel.fromEntity(insectParams.taxonomy),
        nomenclature: NomenclatureModel.fromEntity(insectParams.nomenclature),
        impacts: ImpactsModel.fromEntity(insectParams.impacts),
        origin: insectParams.origin,
        predators: insectParams.predators,
        photoUrl: insectParams.photoUrl,
        identificationFeatures: insectParams.identificationFeatures,
        lifeCycle: insectParams.lifeCycle,
        pestControl: insectParams.pestControl,
      );
  Insect toEntity() => Insect(
        modelId: modelId,
        taxonomy: taxonomy,
        nomenclature: nomenclature,
        impacts: impacts,
        origin: origin ?? origin,
        predators: predators ?? predators,
        photoUrl: photoUrl ?? photoUrl,
        identificationFeatures: identificationFeatures,
        lifeCycle: lifeCycle,
        pestControl: pestControl,
      );
  static InsectModel fromEntity(Insect enity) => InsectModel(
        modelId: enity.modelId,
        taxonomy: TaxonomyModel.fromEntity(enity.taxonomy),
        nomenclature: NomenclatureModel.fromEntity(enity.nomenclature),
        impacts: ImpactsModel.fromEntity(enity.impacts),
        origin: enity.origin,
        predators: enity.predators,
        photoUrl: enity.photoUrl,
        identificationFeatures: enity.identificationFeatures,
        lifeCycle: enity.lifeCycle,
        pestControl: enity.pestControl,
      );
}
