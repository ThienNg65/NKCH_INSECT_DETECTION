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
      modelId: map['modelId'] as String,
      taxonomy: TaxonomyModel.fromMap(map['taxonomy'] as Map<String, dynamic>),
      nomenclature: NomenclatureModel.fromMap(
          map['nomenclature'] as Map<String, dynamic>),
      impacts: ImpactModel.fromMap(map['impacts'] as Map<String, dynamic>),
      origin: map['origin'] != null ? map['origin'] as String : null,
      predators: map['predators'] != null ? map['predators'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      identificationFeatures: map['identificationFeatures'] != null
          ? map['identificationFeatures'] as String
          : null,
      lifeCycle: map['lifeCycle'] != null ? map['lifeCycle'] as String : null,
      pestControl:
          map['pestControl'] != null ? map['pestControl'] as String : null,
    );
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
}
