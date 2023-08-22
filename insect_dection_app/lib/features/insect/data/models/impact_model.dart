import 'dart:convert';

import 'package:insect_dection_app/features/insect/insect.dart';

class ImpactModel extends Impacts {
  const ImpactModel({
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

  factory ImpactModel.fromMap(Map<String, dynamic> map) {
    return ImpactModel(
      benefits: map['benefits'] != null ? map['benefits'] as String : null,
      harms: map['harms'] != null ? map['harms'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImpactModel.fromJson(String source) =>
      ImpactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Impacts toEntity() {
    return Impacts(
      benefits: benefits,
      harms: harms,
    );
  }
}
