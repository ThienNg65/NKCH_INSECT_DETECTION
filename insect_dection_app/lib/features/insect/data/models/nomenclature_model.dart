import 'dart:convert';

import 'package:insect_dection_app/features/insect/insect.dart';

class NomenclatureModel extends Nomenclature {
  const NomenclatureModel({
    required super.commonName,
    required super.otherName,
    required super.scientificName,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commonName': commonName,
      'otherName': otherName,
      'scientificName': scientificName,
    };
  }

  factory NomenclatureModel.fromMap(Map<String, dynamic> map) {
    return NomenclatureModel(
      commonName: map['commonName'] as String,
      otherName: map['otherName'] as String,
      scientificName: map['scientificName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NomenclatureModel.fromJson(String source) =>
      NomenclatureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Nomenclature toEntity() => Nomenclature(
        commonName: commonName,
        otherName: otherName,
        scientificName: scientificName,
      );
}
