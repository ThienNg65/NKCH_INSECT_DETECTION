import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

void main() {
  group('Insect', () {
    test(
        'copyWith() should return a new Insect instance with the updated fields',
        () {
      // Arrange
      const insect = Insect(
        modelId: 'modelId',
        taxonomy: Taxonomy(
          species: 'species',
          genus: 'genus',
          family: 'family',
          order: 'order',
          classical: 'classical',
          phylum: 'phylum',
          regnum: 'regnum',
        ),
        nomenclature: Nomenclature(
          commonName: 'commonName',
          otherName: 'otherName',
          scientificName: 'scientificName',
        ),
        impacts: Impact(
          benefits: 'benefits',
          harms: 'harms',
        ),
        origin: 'origin',
        predators: 'predators',
        photoUrl: 'photoUrl',
        identificationFeatures: 'identificationFeatures',
        lifeCycle: 'lifeCycle',
        pestControl: 'pestControl',
        harmedObject: 'harmedObject',
        harms: 'harms',
      );

      // Act
      final updatedInsect = insect.copyWith(
        modelId: 'updatedModelId',
        taxonomy: const Taxonomy(
          species: 'updatedSpecies',
          genus: 'updatedGenus',
          family: 'updatedFamily',
          order: 'updatedOrder',
          classical: 'updatedClassical',
          phylum: 'updatedPhylum',
          regnum: 'updatedRegnum',
        ),
        nomenclature: const Nomenclature(
          commonName: 'updatedCommonName',
          otherName: 'updatedOtherName',
          scientificName: 'updatedScientificName',
        ),
        impacts: const Impact(
          benefits: 'updatedBenefits',
          harms: 'updatedHarms',
        ),
        origin: 'updatedOrigin',
        predators: 'updatedPredators',
        photoUrl: 'updatedPhotoUrl',
        identificationFeatures: 'updatedIdentificationFeatures',
        lifeCycle: 'updatedLifeCycle',
        pestControl: 'updatedPestControl',
        harmedObject: 'updatedharmedObject',
        harms: 'updatedharms',
      );

      // Assert
      expect(updatedInsect.modelId, 'updatedModelId');
      expect(updatedInsect.taxonomy.species, 'updatedSpecies');
      expect(updatedInsect.taxonomy.genus, 'updatedGenus');
      expect(updatedInsect.taxonomy.family, 'updatedFamily');
      expect(updatedInsect.taxonomy.order, 'updatedOrder');
      expect(updatedInsect.taxonomy.classical, 'updatedClassical');
      expect(updatedInsect.taxonomy.phylum, 'updatedPhylum');
      expect(updatedInsect.taxonomy.regnum, 'updatedRegnum');
      expect(updatedInsect.nomenclature.commonName, 'updatedCommonName');
      expect(updatedInsect.nomenclature.otherName, 'updatedOtherName');
      expect(
          updatedInsect.nomenclature.scientificName, 'updatedScientificName');
      expect(updatedInsect.impacts.benefits, 'updatedBenefits');
      expect(updatedInsect.impacts.harms, 'updatedHarms');
      expect(updatedInsect.origin, 'updatedOrigin');
      expect(updatedInsect.predators, 'updatedPredators');
      expect(updatedInsect.photoUrl, 'updatedPhotoUrl');
      expect(updatedInsect.identificationFeatures,
          'updatedIdentificationFeatures');
      expect(updatedInsect.lifeCycle, 'updatedLifeCycle');
      expect(updatedInsect.pestControl, 'updatedPestControl');
      expect(updatedInsect.harmedObject, 'updatedharmedObject');
      expect(updatedInsect.harms, 'updatedharms');
    });

    test('toString() should return the identificationFeatures of the Insect',
        () {
      // Arrange
      final insect = Insect(
        modelId: 'modelId',
        taxonomy: Taxonomy.empty,
        nomenclature: Nomenclature.empty,
        impacts: Impact.empty,
        identificationFeatures: 'identificationFeatures',
      );

      // Act
      final stringRepresentation = insect.toString();

      // Assert
      expect(stringRepresentation, 'identificationFeatures');
    });
  });
}
