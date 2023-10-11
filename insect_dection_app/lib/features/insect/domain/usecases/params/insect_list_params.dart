// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:insect_dection_app/features/insect/insect.dart';

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

class InsectListParams extends InsectList {
  final String? keyword;
  final String? filterAttribute;

  const InsectListParams({
    required super.hasNextPage,
    super.size = 0,
    required super.previousPage,
    required super.currentPage,
    this.keyword,
    this.filterAttribute ,
  });

  static InsectListParams get empty =>  InsectListParams(
        hasNextPage: false,
        previousPage: const <Insect>[],
        currentPage: const <Insect>[],
        size: 0,
        filterAttribute:  NomenclatureName.commonName.attribute,
      );
  @override
  InsectListParams copyWith({
    bool? hasNextPage,
    int? size,
    List<Insect>? previousPage,
    List<Insect>? currentPage,
    String? keyword,
    String? filterAttribute,
  }) {
    return InsectListParams(
      hasNextPage: hasNextPage ?? super.hasNextPage,
      size: size ?? super.size,
      previousPage: previousPage ?? super.previousPage,
      currentPage: currentPage ?? super.currentPage,
      keyword: keyword ?? this.keyword,
      filterAttribute: filterAttribute ?? this.filterAttribute,
    );
  }

  factory InsectListParams.fromEntity(InsectList entity) {
    return InsectListParams(
      hasNextPage: entity.hasNextPage,
      size: entity.size,
      previousPage: entity.previousPage,
      currentPage: entity.currentPage,
      filterAttribute: NomenclatureName.commonName.attribute,
    );
  }

  @override
  List<Object?> get props => [
        hasNextPage,
        size,
        previousPage,
        currentPage,
        keyword,
        filterAttribute,
      ];
}
