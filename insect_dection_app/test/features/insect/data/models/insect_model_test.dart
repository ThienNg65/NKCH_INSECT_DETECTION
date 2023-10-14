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

    test('toEntity() should convert model to entity', () {
      // Create an InsectModel instance
      const insectModel = InsectModel(
        modelId: 'insect-123',
        taxonomy: TaxonomyModel(
          species: 'Danaus plexippus',
          genus: 'Danaus',
          family: 'Nymphalidae',
          order: 'Lepidoptera',
          classical: 'Insecta',
          phylum: 'Arthropoda',
          regnum: 'Animalia',
        ),
        nomenclature: NomenclatureModel(
          commonName: 'Monarch Butterfly',
          otherName: 'Milkweed butterfly',
          scientificName: 'Danaus plexippus',
        ),
        impacts: ImpactModel(),
        origin: 'North America',
        predators: 'Birds, spiders, lizards',
        photoUrl: 'https://example.com/monarch-butterfly.jpg',
        identificationFeatures: 'Orange and black wings with white spots',
        lifeCycle: 'Four stages: egg, larva, pupa, adult',
        pestControl: 'Remove milkweed plants from gardens',
        effect: 'Feeds on milkweed plants',
        harmedObject: 'Milkweed plants',
      );

      // Convert the model to an entity
      final insectEntity = insectModel.toEntity();

      // Verify the entity properties
      expect(insectEntity.modelId, 'insect-123');
      expect(insectEntity.taxonomy.species, 'Danaus plexippus');
      expect(insectEntity.taxonomy.genus, 'Danaus');
      expect(insectEntity.taxonomy.family, 'Nymphalidae');
      expect(insectEntity.taxonomy.order, 'Lepidoptera');
      expect(insectEntity.taxonomy.classical, 'Insecta');
      expect(insectEntity.taxonomy.phylum, 'Arthropoda');
      expect(insectEntity.taxonomy.regnum, 'Animalia');
      expect(insectEntity.nomenclature.commonName, 'Monarch Butterfly');
      expect(insectEntity.nomenclature.otherName, 'Milkweed butterfly');
      expect(insectEntity.nomenclature.scientificName, 'Danaus plexippus');
      expect(insectModel.impacts, ImpactModel.fromEntity(Impact.empty));
      expect(insectEntity.effect, 'Feeds on milkweed plants');
      expect(insectEntity.harmedObject, 'Milkweed plants');
      expect(insectEntity.origin, 'North America');
      expect(insectEntity.predators, 'Birds, spiders, lizards');
      expect(
          insectEntity.photoUrl, 'https://example.com/monarch-butterfly.jpg');
      expect(insectEntity.identificationFeatures,
          'Orange and black wings with white spots');
      expect(insectEntity.lifeCycle, 'Four stages: egg, larva, pupa, adult');
      expect(insectEntity.pestControl, 'Remove milkweed plants from gardens');
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
