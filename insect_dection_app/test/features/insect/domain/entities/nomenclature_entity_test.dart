import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('Nomenclature', () {
    test(
        'copyWith() should return a new Nomenclature instance with the updated fields',
        () {
      // Arrange
      const nomenclature = Nomenclature(
        commonName: 'Common Name',
        otherName: 'Other Name',
        scientificName: 'Scientific Name',
      );

      // Act
      final updatedNomenclature = nomenclature.copyWith(
        commonName: 'Updated Common Name',
        otherName: 'Updated Other Name',
        scientificName: 'Updated Scientific Name',
      );

      // Assert
      expect(updatedNomenclature.commonName, 'Updated Common Name');
      expect(updatedNomenclature.otherName, 'Updated Other Name');
      expect(updatedNomenclature.scientificName, 'Updated Scientific Name');
    });

    test('isEmpty should return true if the Nomenclature is empty', () {
      // Arrange
      final nomenclature = Nomenclature.empty;

      // Act
      final isEmpty = nomenclature.isEmpty;

      // Assert
      expect(isEmpty, true);
    });

    test('isEmpty should return false if the Nomenclature is not empty', () {
      // Arrange
      const nomenclature = Nomenclature(
        commonName: 'Common Name',
        otherName: 'Other Name',
        scientificName: 'Scientific Name',
      );

      // Act
      final isEmpty = nomenclature.isEmpty;

      // Assert
      expect(isEmpty, false);
    });

    test('isNotEmpty should return true if the Nomenclature is not empty', () {
      // Arrange
      const nomenclature = Nomenclature(
        commonName: 'Common Name',
        otherName: 'Other Name',
        scientificName: 'Scientific Name',
      );

      // Act
      final isNotEmpty = nomenclature.isNotEmpty;

      // Assert
      expect(isNotEmpty, true);
    });

    test('isNotEmpty should return false if the Nomenclature is empty', () {
      // Arrange
      final nomenclature = Nomenclature.empty;

      // Act
      final isNotEmpty = nomenclature.isNotEmpty;

      // Assert
      expect(isNotEmpty, false);
    });
  });
}
