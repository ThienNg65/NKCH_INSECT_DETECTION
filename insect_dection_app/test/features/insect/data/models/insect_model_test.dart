import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/features.dart';

void main() {
  group('InsectModel', () {
    final taxonomy = TaxonomyModel.fromEntity(Taxonomy.empty);
    final nomenclature = NomenclatureModel.fromEntity(Nomenclature.empty);
    final impacts = ImpactModel.fromEntity(Impact.empty);
    const origin = "";
    const predators = "";
    const photoUrl = "";
    const identificationFeatures = "";
    const lifeCycle = "";
    const pestControl = "";
    const harms = "";
    const harmedObject = "";
    test(
        'copyWith() should return a new InsectModel instance with the updated fields',
        () {
      // Arrange
      final insectModel = InsectModel(
        modelId: '1',
        taxonomy: taxonomy,
        nomenclature: nomenclature,
        impacts: impacts,
      );

      // Act
      final updatedInsectModel = insectModel.copyWith(
        modelId: '2',
        taxonomy: TaxonomyModel.fromEntity(Taxonomy.empty),
        nomenclature: NomenclatureModel.fromEntity(Nomenclature.empty),
        impacts: ImpactModel.fromEntity(Impact.empty),
      );

      // Assert
      expect(updatedInsectModel.modelId, '2');
      expect(updatedInsectModel.taxonomy,
          TaxonomyModel.fromEntity(Taxonomy.empty));
      expect(updatedInsectModel.nomenclature,
          NomenclatureModel.fromEntity(Nomenclature.empty));
      expect(updatedInsectModel.impacts, ImpactModel.fromEntity(Impact.empty));
    });

    test(
        'toMap() should return a map representation of the InsectModel instance',
        () {
      // Arrange
      final insectModel = InsectModel(
        modelId: 'modelId',
        taxonomy: TaxonomyModel.fromEntity(Taxonomy.empty),
        nomenclature: NomenclatureModel.fromEntity(Nomenclature.empty),
        impacts: ImpactModel.fromEntity(Impact.empty),
      );

      // Act
      final map = insectModel.toMap();

      // Assert
      expect(map['modelId'], 'modelId');
      expect(map['taxonomy'], taxonomy.toMap());
      expect(map['nomenclature'], nomenclature.toMap());
      expect(map['impacts'], impacts.toMap());
    });

    test(
        'fromMap() should create a new InsectModel instance from a map representation',
        () {
      // Arrange
      final map = {
        'modelId': 'modelId',
        'taxonomy': taxonomy.toMap(),
        'nomenclature': nomenclature.toMap(),
        'impacts': impacts.toMap(),
      };

      // Act
      final insectModel = InsectModel.fromMap(map);

      // Assert
      expect(insectModel.modelId, 'modelId');
      expect(insectModel.taxonomy, taxonomy);
      expect(insectModel.nomenclature, nomenclature);
      expect(insectModel.impacts, impacts);
      expect(insectModel.origin, origin);
      expect(insectModel.predators, predators);
      expect(insectModel.photoUrl, photoUrl);
      expect(insectModel.identificationFeatures, identificationFeatures);
      expect(insectModel.lifeCycle, lifeCycle);
      expect(insectModel.pestControl, pestControl);
      expect(insectModel.effect, harms);
      expect(insectModel.harmedObject, harmedObject);
    });

    test(
        'toJson() should return a json representation of the InsectModel instance',
        () {
      // Arrange
      final insectModel = InsectModel(
        modelId: 'modelId',
        taxonomy: taxonomy,
        nomenclature: nomenclature,
        impacts: impacts,
      );

      // Act
      final json = insectModel.toJson();

      // Assert
      expect(json,
          '{"modelId":"modelId","taxonomy":{"species":"","genus":"","family":"","order":"","class":"","phylum":"","regnum":""},"nomenclature":{"commonName":"","otherName":"","scientificName":""},"impacts":{"benefits":"","harms":""},"origin":null,"predators":null,"photoUrl":null,"identificationFeatures":null,"lifeCycle":null,"pestControl":null,"effect":null,"harmedObject":null}');
    });

    test(
        'fromJson() should create a new InsectModel instance from a json representation',
        () {
      // Arrange
      const json =
          '{"modelId":"modelId","taxonomy":{"species":"","genus":"","family":"","order":"","class":"","phylum":"","regnum":""},"nomenclature":{"commonName":"","otherName":"","scientificName":""},"impacts":{"benefits":"","harms":""},"origin":null,"predators":null,"photoUrl":null,"identificationFeatures":null,"lifeCycle":null,"pestControl":null,"effect":null,"harmedObject":null}';

      // Act
      final insectModel = InsectModel.fromJson(json);

      // Assert
      expect(insectModel.modelId, 'modelId');
      expect(insectModel.taxonomy, taxonomy);
      expect(insectModel.nomenclature, nomenclature);
      expect(insectModel.impacts, impacts);
      expect(insectModel.origin, origin);
      expect(insectModel.predators, predators);
      expect(insectModel.photoUrl, photoUrl);
      expect(insectModel.identificationFeatures, identificationFeatures);
      expect(insectModel.lifeCycle, lifeCycle);
      expect(insectModel.pestControl, pestControl);
      expect(insectModel.effect, harms);
      expect(insectModel.harmedObject, harmedObject);
    });

    test(
        'fromParams() should return a new InsectModel instance from the given InsectParams',
        () {
      // Arrange
      final insectParams = InsectParams(
        modelId: '1',
        taxonomy: Taxonomy.empty,
        nomenclature: Nomenclature.empty,
        impacts: Impact.empty,
      );

      // Act
      final insectModel = InsectModel.fromParams(insectParams);

      // Assert
      expect(insectModel.modelId, '1');
      expect(insectModel.taxonomy, TaxonomyModel.fromEntity(Taxonomy.empty));
      expect(insectModel.nomenclature,
          NomenclatureModel.fromEntity(Nomenclature.empty));
      expect(insectModel.impacts, ImpactModel.fromEntity(Impact.empty));
    });

    test(
        'toEntity() should return a new Insect instance from the current InsectModel instance',
        () {
      // Arrange
      final insectModel = InsectModel(
        modelId: '1',
        taxonomy: TaxonomyModel.fromEntity(Taxonomy.empty),
        nomenclature: NomenclatureModel.fromEntity(Nomenclature.empty),
        impacts: ImpactModel.fromEntity(Impact.empty),
      );

      // Act
      final insect = insectModel.toEntity();

      // Assert
      expect(insect.modelId, '1');
      expect(insect.taxonomy, Taxonomy.empty);
      expect(insect.nomenclature, Nomenclature.empty);
      expect(insect.impacts, Impact.empty);
      expect(insect.origin, origin);
      expect(insect.predators, predators);
      expect(insect.photoUrl, photoUrl);
      expect(insect.identificationFeatures, identificationFeatures);
      expect(insect.lifeCycle, lifeCycle);
      expect(insect.pestControl, pestControl);
      expect(insect.effect, harms);
      expect(insect.harmedObject, harmedObject);
    });

    test(
        'fromEntity() should return a new InsectModel instance from the given Insect instance',
        () {
      // Arrange
      final insect = Insect(
        modelId: '1',
        taxonomy: Taxonomy.empty,
        nomenclature: Nomenclature.empty,
        impacts: Impact.empty,
      );

      // Act
      final insectModel = InsectModel.fromEntity(insect);

      // Assert
      expect(insectModel.modelId, '1');
      expect(insectModel.taxonomy, TaxonomyModel.fromEntity(Taxonomy.empty));
      expect(insectModel.nomenclature,
          NomenclatureModel.fromEntity(Nomenclature.empty));
      expect(insectModel.impacts, ImpactModel.fromEntity(Impact.empty));
      expect(insectModel.origin, origin);
      expect(insectModel.predators, predators);
      expect(insectModel.photoUrl, photoUrl);
      expect(insectModel.identificationFeatures, identificationFeatures);
      expect(insectModel.lifeCycle, lifeCycle);
      expect(insectModel.pestControl, pestControl);
      expect(insectModel.effect, harms);
      expect(insectModel.harmedObject, harmedObject);
    });
  });
}
