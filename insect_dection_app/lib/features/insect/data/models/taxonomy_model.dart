import 'dart:convert';

import 'package:insect_dection_app/features/insect/insect.dart';

class TaxonomyModel extends Taxonomy {
  const TaxonomyModel({
    super.species = '',
    super.genus = '',
    super.family = '',
    super.order = '',
    super.classical = '',
    super.phylum = 'Arthropoda',
    super.regnum = 'Animalia',
  });
  factory TaxonomyModel.fromMap(Map<String, dynamic>? map) {
    return map != null
        ? TaxonomyModel(
            species: map['species'] ?? '',
            genus: map['genus'] ?? '',
            family: map['family'] ?? '',
            order: map['order'] ?? '',
            classical: map['class'] ?? ' ',
            phylum: map['phylum'] ?? 'Arthropoda',
            regnum: map['regnum'] ?? 'Animalia',
          )
        : const TaxonomyModel();
  }

  String toJson() => json.encode(toMap());

  factory TaxonomyModel.fromJson(String source) =>
      TaxonomyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'species': species,
      'genus': genus,
      'family': family,
      'order': order,
      'class': classical,
      'phylum': phylum,
      'regnum': regnum,
    };
  }

  Taxonomy toEntity() => Taxonomy(
        species: species,
        genus: genus,
        family: family,
        order: order,
        classical: classical,
        phylum: phylum,
        regnum: regnum,
      );
  factory TaxonomyModel.fromEntity(Taxonomy entity) => TaxonomyModel(
        species: entity.species,
        genus: entity.genus,
        family: entity.family,
        order: entity.order,
        classical: entity.classical,
        phylum: entity.phylum,
        regnum: entity.regnum,
      );
}
