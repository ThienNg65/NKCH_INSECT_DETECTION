import 'dart:convert';

import 'package:insect_dection_app/features/insect/insect.dart';

class NomenclatureModel extends Nomenclature {
  const NomenclatureModel({
    super.commonName = '',
    super.otherName = '',
    super.scientificName = '',
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commonName': commonName,
      'otherName': otherName,
      'scientificName': scientificName,
    };
  }

  factory NomenclatureModel.fromMap(Map<String, dynamic>? map) {
    return map != null
        ? NomenclatureModel(
            commonName: map['commonName'] as String,
            otherName: map['otherName'] ?? '',
            scientificName: map['scientificName'] ?? '',
          )
        : const NomenclatureModel();
  }

  String toJson() => json.encode(toMap());

  factory NomenclatureModel.fromJson(String source) =>
      NomenclatureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Nomenclature toEntity() => Nomenclature(
        commonName: commonName,
        otherName: otherName,
        scientificName: scientificName,
      );
  factory NomenclatureModel.fromEntity(Nomenclature enitity) =>
      NomenclatureModel(
        commonName: enitity.commonName,
        otherName: enitity.otherName,
        scientificName: enitity.scientificName,
      );
}
