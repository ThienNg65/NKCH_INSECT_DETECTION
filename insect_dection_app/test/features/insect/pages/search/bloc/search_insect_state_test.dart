import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('SearchInsectState', () {
    test('initial state', () {
      // Act
      final state = SearchInsectState.initial();

      // Assert
      expect(state.isKeywordSearch, false);
      expect(state.isFirstLoad, true);
      expect(state.insectList, InsectList.empty);
      expect(state.searchResulList, InsectList.empty);
      expect(state.filterAttribute, NomenclatureName.commonName.attribute);
      expect(state.getInsectByKeywordProcess, const Initial());
      expect(state.getLoadInsectListProcess, const Initial());
    });

    test('copyWith()', () {
      // Arrange
      final state = SearchInsectState.initial();

      // Act
      final newState = state.copyWith(
        isKeywordSearch: true,
        isFirstLoad: false,
        insectList: InsectList.empty,
        searchResulList: InsectList.empty,
        filterAttribute: NomenclatureName.scientificName.attribute,
        getInsectByKeywordProcess: const Loading(),
        getLoadInsectListProcess: const Loading(),
      );

      // Assert
      expect(newState.isKeywordSearch, true);
      expect(newState.isFirstLoad, false);
      expect(newState.insectList, InsectList.empty);
      expect(newState.searchResulList, InsectList.empty);
      expect(newState.filterAttribute, NomenclatureName.scientificName.attribute);
      expect(newState.getInsectByKeywordProcess, const Loading());
      expect(newState.getLoadInsectListProcess, const Loading());
    });

    test('props', () {
      // Arrange
      final state = SearchInsectState.initial();

      // Act
      final props = state.props;

      // Assert
      expect(props, [
        false,
        true,
        InsectList.empty,
        InsectList.empty,
        NomenclatureName.commonName.attribute,
        const Initial(),
        const Initial(),
      ]);
    });
  });
}