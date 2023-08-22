import 'dart:convert';

import 'package:insect_dection_app/features/insect/insect.dart';

class TaxonomyModel extends Taxonomy {
  const TaxonomyModel({
    required super.species,
    required super.genus,
    required super.family,
    required super.order,
    required super.classic,
    required super.phylum,
    required super.regnum,
  });
  factory TaxonomyModel.fromMap(Map<String, dynamic> map) {
    return TaxonomyModel(
      species: map['species'] as String,
      genus: map['genus'] as String,
      family: map['family'] as String,
      order: map['order'] as String,
      classic: map['classic'] as String,
      phylum: map['phylum'] as String,
      regnum: map['regnum'] as String,
    );
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
      'classic': classic,
      'phylum': phylum,
      'regnum': regnum,
    };
  }

  Taxonomy toEntity() => Taxonomy(
        species: species,
        genus: genus,
        family: family,
        order: order,
        classic: classic,
        phylum: phylum,
        regnum: regnum,
      );
}
