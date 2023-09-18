import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  group('[Taxonomy Model]', () {
    const testSpecies = 'testSpecies';
    const testGenus = 'testGenus';
    const testFamily = 'testFamily';
    const testOrder = 'testOrder';
    const testClassical = 'testClassical';
    const testPhylum = 'testPhylum';
    const testRegnum = 'testRegnum';
    const taxonomyModel = TaxonomyModel(
      species: testSpecies,
      genus: testGenus,
      family: testFamily,
      order: testOrder,
      classical: testClassical,
      phylum: testPhylum,
      regnum: testRegnum,
    );
    test('should be a subclass of impact entity', () async {
      //assert
      expect(taxonomyModel, isA<Taxonomy>());
    });
    group('fromMap', () {
      test(
        'should return various model with various fixtures',
        () async {
          final impactFixtures =
              getTaxonomiesListFixture("taxonomies_fixtures.json");

          final impactList = <TaxonomyModel>[
            const TaxonomyModel(
              species: "E. tyranus",
              genus: "Eudocima",
              family: "Erebidae",
              order: "Lepidoptera",
              classical: "Insecta",
            ),
            const TaxonomyModel(),
            const TaxonomyModel(
                species: "A. spiniferus",
                genus: "Aleurocanthus",
                family: "Aleyrodidae",
                order: "Hemiptera",
                classical: "Insecta"),
            const TaxonomyModel(
                species: "B. dorsalis",
                genus: "Bactrocera",
                family: "Tephritidae",
                order: "Diptera",
                classical: "Insecta",
                phylum: "Arthropoda",
                regnum: "Animalia"),
          ];
          expect(impactFixtures, impactList);
        },
      );
    });

    group('toMap', () {
      test('should return a map containing proper data', () async {
        expect(
          taxonomyModel.toMap(),
          equals({
            "species": testSpecies,
            "genus": testGenus,
            "family": testFamily,
            "order": testOrder,
            "class": testClassical,
            "phylum": testPhylum,
            "regnum": testRegnum,
          }),
        );
      });
    });
  });
}
