// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum TaxonomicRank { species, genus, family, order, classies, phylum, regnum }

extension TaxonomicRankX on TaxonomicRank {
  String get attribute {
    switch (this) {
      case TaxonomicRank.classies:
        return "taxonomy.class";
      default:
        return "taxonomy.$name";
    }
  }
}

enum NomenclatureName { scientificName, otherName, commonName }

extension NomenclatureNameX on NomenclatureName {
  String get attribute => "nomenclature.$name";
}

class InsectListFilterParams extends Equatable {
  final String keyword;
  final String filterAttribute;

  const InsectListFilterParams({
    required this.keyword,
    required this.filterAttribute,
  });

  @override
  List<Object?> get props => [keyword, filterAttribute];

  static InsectListFilterParams get empty => InsectListFilterParams(
        keyword: '',
        filterAttribute: NomenclatureName.commonName.attribute,
      );
  bool get isEmpty => this == InsectListFilterParams.empty;

  bool get isNotEmpty => !isEmpty;
  InsectListFilterParams copyWith({
    String? keyword,
    String? filterAttribute,
  }) {
    return InsectListFilterParams(
      keyword: keyword ?? this.keyword,
      filterAttribute: filterAttribute ?? this.filterAttribute,
    );
  }
}
