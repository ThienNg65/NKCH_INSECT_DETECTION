import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('InsectListFilterParams', () {
    test('props should return a list of all the properties of the InsectListFilterParams instance', () {
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

    test('copyWith() should return a new InsectListFilterParams instance with the updated fields', () {
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
      expect(updatedInsectListFilterParams.filterAttribute, 'updated filterAttribute');
    });

    test('isEmpty should return true if the InsectListFilterParams is empty', () {
      // Arrange
      final insectListFilterParams = InsectListFilterParams.empty;

      // Act
      final isEmpty = insectListFilterParams.isEmpty;

      // Assert
      expect(isEmpty, true);
    });

    test('isEmpty should return false if the InsectListFilterParams is not empty', () {
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

    test('isNotEmpty should return true if the InsectListFilterParams is not empty', () {
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

    test('isNotEmpty should return false if the InsectListFilterParams is empty', () {
      // Arrange
      final insectListFilterParams = InsectListFilterParams.empty;

      // Act
      final isNotEmpty = insectListFilterParams.isNotEmpty;

      // Assert
      expect(isNotEmpty, false);
    });
  });
}