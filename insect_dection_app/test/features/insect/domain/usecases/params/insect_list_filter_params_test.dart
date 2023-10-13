import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('TaxonomicRank', () {
    test('values should return a list of all the taxonomic ranks', () {
      // Act
      const taxonomicRanks = TaxonomicRank.values;

      // Assert
      expect(taxonomicRanks, [
        TaxonomicRank.species,
        TaxonomicRank.genus,
        TaxonomicRank.family,
        TaxonomicRank.order,
        TaxonomicRank.classies,
        TaxonomicRank.phylum,
        TaxonomicRank.regnum,
      ]);
    });

    test('attribute should return the correct attribute for the taxonomic rank',
        () {
      // Act
      final speciesAttribute = TaxonomicRank.species.attribute;
      final genusAttribute = TaxonomicRank.genus.attribute;
      final familyAttribute = TaxonomicRank.family.attribute;
      final orderAttribute = TaxonomicRank.order.attribute;
      final classiesAttribute = TaxonomicRank.classies.attribute;
      final phylumAttribute = TaxonomicRank.phylum.attribute;
      final regnumAttribute = TaxonomicRank.regnum.attribute;

      // Assert
      expect(speciesAttribute, 'taxonomy.species');
      expect(genusAttribute, 'taxonomy.genus');
      expect(familyAttribute, 'taxonomy.family');
      expect(orderAttribute, 'taxonomy.order');
      expect(classiesAttribute, 'taxonomy.class');
      expect(phylumAttribute, 'taxonomy.phylum');
      expect(regnumAttribute, 'taxonomy.regnum');
    });
  });

  group('NomenclatureName', () {
    test('values should return a list of all the nomenclature names', () {
      // Act
      const nomenclatureNames = NomenclatureName.values;

      // Assert
      expect(nomenclatureNames, [
        NomenclatureName.scientificName,
        NomenclatureName.otherName,
        NomenclatureName.commonName,
      ]);
    });

    test(
        'attribute should return the correct attribute for the nomenclature name',
        () {
      // Act
      final scientificNameAttribute = NomenclatureName.scientificName.attribute;
      final otherNameAttribute = NomenclatureName.otherName.attribute;
      final commonNameAttribute = NomenclatureName.commonName.attribute;

      // Assert
      expect(scientificNameAttribute, 'nomenclature.scientificName');
      expect(otherNameAttribute, 'nomenclature.otherName');
      expect(commonNameAttribute, 'nomenclature.commonName');
    });
  });
  group('InsectListFilterParams', () {
    test(
        'props should return a list of all the properties of the InsectListFilterParams instance',
        () {
      // Arrange
      const insectListFilterParams = InsectListFilterParams(
        keyword: 'keyword',
        filterAttribute: 'filterAttribute',
      );

      // Act
      final props = insectListFilterParams.props;

      // Assert
      expect(props, ['keyword', 'filterAttribute']);
    });

    test(
        'copyWith() should return a new InsectListFilterParams instance with the updated fields',
        () {
      // Arrange
      const insectListFilterParams = InsectListFilterParams(
        keyword: 'keyword',
        filterAttribute: 'filterAttribute',
      );

      // Act
      final updatedInsectListFilterParams = insectListFilterParams.copyWith(
        keyword: 'updated keyword',
        filterAttribute: 'updated filterAttribute',
      );

      // Assert
      expect(updatedInsectListFilterParams.keyword, 'updated keyword');
      expect(updatedInsectListFilterParams.filterAttribute,
          'updated filterAttribute');
    });

    test('isEmpty should return true if the InsectListFilterParams is empty',
        () {
      // Arrange
      final insectListFilterParams = InsectListFilterParams.defaultOption;

      // Act
      final isEmpty = insectListFilterParams.isEmpty;

      // Assert
      expect(isEmpty, true);
    });

    test(
        'isEmpty should return false if the InsectListFilterParams is not empty',
        () {
      // Arrange
      const insectListFilterParams = InsectListFilterParams(
        keyword: 'keyword',
        filterAttribute: 'filterAttribute',
      );

      // Act
      final isEmpty = insectListFilterParams.isEmpty;

      // Assert
      expect(isEmpty, false);
    });

    test(
        'isNotEmpty should return true if the InsectListFilterParams is not empty',
        () {
      // Arrange
      const insectListFilterParams = InsectListFilterParams(
        keyword: 'keyword',
        filterAttribute: 'filterAttribute',
      );

      // Act
      final isNotEmpty = insectListFilterParams.isNotEmpty;

      // Assert
      expect(isNotEmpty, true);
    });

    test(
        'isNotEmpty should return false if the InsectListFilterParams is empty',
        () {
      // Arrange
      final insectListFilterParams = InsectListFilterParams.defaultOption;

      // Act
      final isNotEmpty = insectListFilterParams.isNotEmpty;

      // Assert
      expect(isNotEmpty, false);
    });
  });
}
