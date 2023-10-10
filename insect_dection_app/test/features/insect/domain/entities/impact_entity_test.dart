import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('Impact', () {
    test('copyWith() should return a new Impact instance with the updated fields', () {
      // Arrange
      const impact = Impact(
        benefits: 'Benefits',
        harms: 'Harms',
      );

      // Act
      final updatedImpact = impact.copyWith(
        benefits: 'Updated benefits',
        harms: 'Updated harms',
      );

      // Assert
      expect(updatedImpact.benefits, 'Updated benefits');
      expect(updatedImpact.harms, 'Updated harms');
    });

    test('isNotEmpty should return true if the Impact is not empty', () {
      // Arrange
      const impact = Impact(
        benefits: 'Benefits',
        harms: 'Harms',
      );

      // Act
      final isNotEmpty = impact.isNotEmpty;

      // Assert
      expect(isNotEmpty, true);
    });

    test('isNotEmpty should return false if the Impact is empty', () {
      // Arrange
      final impact = Impact.empty;

      // Act
      final isNotEmpty = impact.isNotEmpty;

      // Assert
      expect(isNotEmpty, false);
    });

    test('isEmpty should return true if the Impact is empty', () {
      // Arrange
      final impact = Impact.empty;

      // Act
      final isEmpty = impact.isEmpty;

      // Assert
      expect(isEmpty, true);
    });

    test('isEmpty should return false if the Impact is not empty', () {
      // Arrange
      const impact = Impact(
        benefits: 'Benefits',
        harms: 'Harms',
      );

      // Act
      final isEmpty = impact.isEmpty;

      // Assert
      expect(isEmpty, false);
    });
  });
}