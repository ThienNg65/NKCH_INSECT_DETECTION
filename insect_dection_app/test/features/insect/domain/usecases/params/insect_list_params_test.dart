import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('InsectListParams', () {
    test(
        'copyWith() should return a new InsectListParams instance with the updated fields',
        () {
      // Arrange
      final insectListParams = InsectListParams(
        hasNextPage: true,
        size: 10,
        previousPage: [Insect.empty],
        currentPage: [Insect.empty],
      );

      // Act
      final updatedInsectListParams = insectListParams.copyWith(
        hasNextPage: false,
        size: 20,
        previousPage: [Insect.empty, Insect.empty],
        currentPage: [Insect.empty, Insect.empty],
      );

      // Assert
      expect(updatedInsectListParams.hasNextPage, false);
      expect(updatedInsectListParams.size, 20);
      expect(updatedInsectListParams.previousPage.length, 2);
      expect(updatedInsectListParams.currentPage.length, 2);
    });

    test(
        'fromEntity() should create a InsectListParams instance from a InsectList entity',
        () {
      // Arrange
      final insectListEntity = InsectList(
        hasNextPage: true,
        size: 10,
        previousPage: [Insect.empty],
        currentPage: [Insect.empty],
      );

      // Act
      final insectListParams = InsectListParams.fromEntity(insectListEntity);

      // Assert
      expect(insectListParams.hasNextPage, true);
      expect(insectListParams.size, 10);
      expect(insectListParams.previousPage.length, 1);
      expect(insectListParams.currentPage.length, 1);
    });

    test(
        'props should return a list of all the properties of the InsectListParams instance',
        () {
      // Arrange
      final insectListParams = InsectListParams(
        hasNextPage: true,
        size: 10,
        previousPage: [Insect.empty],
        currentPage: [Insect.empty],
      );

      // Act
      final props = insectListParams.props;

      // Assert
      expect(props, [
        true,
        10,
        [Insect.empty],
        [Insect.empty],
      ]);
    });
  });
}
