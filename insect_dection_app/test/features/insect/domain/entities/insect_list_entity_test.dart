import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('InsectList', () {
    test('copyWith() should return a new InsectList instance with the updated fields', () {
      // Arrange
      final insectList = InsectList(
        hasNextPage: true,
        size: 10,
        previousPage: [Insect.empty],
        currentPage: [Insect.empty],
      );

      // Act
      final updatedInsectList = insectList.copyWith(
        hasNextPage: false,
        size: 20,
        previousPage: [Insect.empty, Insect.empty],
        currentPage: [Insect.empty, Insect.empty],
      );

      // Assert
      expect(updatedInsectList.hasNextPage, false);
      expect(updatedInsectList.size, 20);
      expect(updatedInsectList.previousPage.length, 2);
      expect(updatedInsectList.currentPage.length, 2);
    });

    test('isEmpty should return true if the InsectList is empty', () {
      // Arrange
      final insectList = InsectList.empty;

      // Act
      final isEmpty = insectList.isEmpty;

      // Assert
      expect(isEmpty, true);
    });

    test('isEmpty should return false if the InsectList is not empty', () {
      // Arrange
      final insectList = InsectList(
        hasNextPage: true,
        size: 10,
        previousPage: [Insect.empty],
        currentPage: [Insect.empty],
      );

      // Act
      final isEmpty = insectList.isEmpty;

      // Assert
      expect(isEmpty, false);
    });

    test('isNotEmpty should return true if the InsectList is not empty', () {
      // Arrange
      final insectList = InsectList(
        hasNextPage: true,
        size: 10,
        previousPage: [Insect.empty],
        currentPage: [Insect.empty],
      );

      // Act
      final isNotEmpty = insectList.isNotEmpty;

      // Assert
      expect(isNotEmpty, true);
    });

    test('isNotEmpty should return false if the InsectList is empty', () {
      // Arrange
      final insectList = InsectList.empty;

      // Act
      final isNotEmpty = insectList.isNotEmpty;

      // Assert
      expect(isNotEmpty, false);
    });
  });
}