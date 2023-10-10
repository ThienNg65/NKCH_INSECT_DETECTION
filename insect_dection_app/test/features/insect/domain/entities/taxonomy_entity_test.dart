import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/insect/domain/entities/taxonomy_entity.dart';

void main() {
  group('Taxonomy', () {
    test(
        'copyWith() should return a new Taxonomy instance with the updated fields',
        () {
      // Arrange
      const taxonomy = Taxonomy(
        species: 'species',
        genus: 'genus',
        family: 'family',
        order: 'order',
        classical: 'classical',
        phylum: 'phylum',
        regnum: 'regnum',
      );

      // Act
      final updatedTaxonomy = taxonomy.copyWith(
        species: 'new species',
        genus: 'new genus',
        family: 'new family',
        order: 'new order',
        classical: 'new classical',
        phylum: 'new phylum',
        regnum: 'new regnum',
      );

      // Assert
      expect(updatedTaxonomy.species, 'new species');
      expect(updatedTaxonomy.genus, 'new genus');
      expect(updatedTaxonomy.family, 'new family');
      expect(updatedTaxonomy.order, 'new order');
      expect(updatedTaxonomy.classical, 'new classical');
      expect(updatedTaxonomy.phylum, 'new phylum');
      expect(updatedTaxonomy.regnum, 'new regnum');
    });

    test('isEmpty should return true if the Taxonomy is empty', () {
      // Arrange
      final taxonomy = Taxonomy.empty;

      // Act
      final isEmpty = taxonomy.isEmpty;

      // Assert
      expect(isEmpty, true);
    });

    test('isEmpty should return false if the Taxonomy is not empty', () {
      // Arrange
      const taxonomy = Taxonomy(
        species: 'species',
        genus: 'genus',
        family: 'family',
        order: 'order',
        classical: 'classical',
        phylum: 'phylum',
        regnum: 'regnum',
      );

      // Act
      final isEmpty = taxonomy.isEmpty;

      // Assert
      expect(isEmpty, false);
    });

    test('isNotEmpty should return true if the Taxonomy is not empty', () {
      // Arrange
      const taxonomy = Taxonomy(
        species: 'species',
        genus: 'genus',
        family: 'family',
        order: 'order',
        classical: 'classical',
        phylum: 'phylum',
        regnum: 'regnum',
      );

      // Act
      final isNotEmpty = taxonomy.isNotEmpty;

      // Assert
      expect(isNotEmpty, true);
    });

    test('isNotEmpty should return false if the Taxonomy is empty', () {
      // Arrange
      final taxonomy = Taxonomy.empty;

      // Act
      final isNotEmpty = taxonomy.isNotEmpty;

      // Assert
      expect(isNotEmpty, false);
    });
  });
}
