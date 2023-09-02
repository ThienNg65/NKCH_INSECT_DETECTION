import 'dart:convert';

import 'package:insect_dection_app/features/insect/insect.dart';

class ImpactsModel extends Impacts {
  const ImpactsModel({
    super.benefits,
    super.harms,
  });
  Impacts copyWith({
    String? benefits,
    String? harms,
  }) {
    return Impacts(
      benefits: benefits ?? this.benefits,
      harms: harms ?? this.harms,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'benefits': benefits,
      'harms': harms,
    };
  }

  @override
  List<Object?> get props => [
        benefits,
        harms,
      ];

  factory ImpactsModel.fromMap(Map<String, dynamic> map) {
    return ImpactsModel(
      benefits: map['benefits'] as String?,
      harms: map['harms'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImpactsModel.fromJson(String source) =>
      ImpactsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Impacts toEntity() {
    return Impacts(
      benefits: benefits,
      harms: harms,
    );
  }

  factory ImpactsModel.fromEntity(Impacts entity) => ImpactsModel(
        benefits: entity.benefits,
        harms: entity.harms,
      );
}
