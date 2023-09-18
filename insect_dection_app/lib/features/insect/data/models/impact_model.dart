import 'dart:convert';

import 'package:insect_dection_app/features/insect/insect.dart';

class ImpactModel extends Impact {
  const ImpactModel({
    super.benefits = '',
    super.harms = '',
  });
  Impact copyWith({
    String? benefits,
    String? harms,
  }) {
    return Impact(
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

  factory ImpactModel.fromMap(Map<String, dynamic>? map) {
    return map != null
        ? ImpactModel(
            benefits: map['benefits'] ?? '',
            harms: map['harms'] ?? '',
          )
        : const ImpactModel();
  }
  factory ImpactModel.fromJson(String source) =>
      ImpactModel.fromMap(json.decode(source) as Map<String, dynamic>,);


  factory ImpactModel.fromEntity(Impact entity) => ImpactModel(
        benefits: entity.benefits,
        harms: entity.harms,
      );
  String toJson() => json.encode(toMap());

  Impact toEntity() {
    return Impact(
      benefits: benefits,
      harms: harms,
    );
  }
}
