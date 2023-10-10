import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

void main() {
  group('NomenclatureModel', () {
    test('toMap() should return a map of the NomenclatureModel instance', () {
      // Arrange
      const nomenclatureModel = NomenclatureModel(
        commonName: 'Common name',
        otherName: 'Other name',
        scientificName: 'Scientific name',
      );

      // Act
      final map = nomenclatureModel.toMap();

      // Assert
      expect(map['commonName'], 'Common name');
      expect(map['otherName'], 'Other name');
      expect(map['scientificName'], 'Scientific name');
    });

    test('fromMap() should create a NomenclatureModel instance from a map', () {
      // Arrange
      final map = {
        'commonName': 'Common name',
        'otherName': 'Other name',
        'scientificName': 'Scientific name',
      };

      // Act
      final nomenclatureModel = NomenclatureModel.fromMap(map);

      // Assert
      expect(nomenclatureModel.commonName, 'Common name');
      expect(nomenclatureModel.otherName, 'Other name');
      expect(nomenclatureModel.scientificName, 'Scientific name');
    });

    test(
        'toJson() should return a JSON string of the NomenclatureModel instance',
        () {
      // Arrange
      const nomenclatureModel = NomenclatureModel(
        commonName: 'Common name',
        otherName: 'Other name',
        scientificName: 'Scientific name',
      );

      // Act
      final jsonString = nomenclatureModel.toJson();

      // Assert
      expect(jsonString,
          '{"commonName":"Common name","otherName":"Other name","scientificName":"Scientific name"}');
    });

    test(
        'fromJson() should create a NomenclatureModel instance from a JSON string',
        () {
      // Arrange
      const jsonString =
          '{"commonName":"Common name","otherName":"Other name","scientificName":"Scientific name"}';

      // Act
      final nomenclatureModel = NomenclatureModel.fromJson(jsonString);

      // Assert
      expect(nomenclatureModel.commonName, 'Common name');
      expect(nomenclatureModel.otherName, 'Other name');
      expect(nomenclatureModel.scientificName, 'Scientific name');
    });

    test(
        'toEntity() should return a Nomenclature instance from the NomenclatureModel instance',
        () {
      // Arrange
      const nomenclatureModel = NomenclatureModel(
        commonName: 'Common name',
        otherName: 'Other name',
        scientificName: 'Scientific name',
      );

      // Act
      final nomenclature = nomenclatureModel.toEntity();

      // Assert
      expect(nomenclature.commonName, 'Common name');
      expect(nomenclature.otherName, 'Other name');
      expect(nomenclature.scientificName, 'Scientific name');
    });

    test(
        'fromEntity() should create a NomenclatureModel instance from a Nomenclature instance',
        () {
      // Arrange
      const nomenclature = Nomenclature(
        commonName: 'Common name',
        otherName: 'Other name',
        scientificName: 'Scientific name',
      );

      // Act
      final nomenclatureModel = NomenclatureModel.fromEntity(nomenclature);

      // Assert
      expect(nomenclatureModel.commonName, 'Common name');
      expect(nomenclatureModel.otherName, 'Other name');
      expect(nomenclatureModel.scientificName, 'Scientific name');
    });
  });
}
