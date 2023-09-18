import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  group('[Nomenclature Model]', () {
    const testCommonName = 'Test Common Name';
    const testOtherName = 'Test Other Name';
    const testScientificName = 'Test Scientific Name ';
    const nomenclatureModel = NomenclatureModel(
      commonName: testCommonName,
      otherName: testOtherName,
      scientificName: testScientificName,
    );
    test('should be a subclass of impact entity', () async {
      //assert
      expect(nomenclatureModel, isA<Nomenclature>());
    });
    group('fromMap', () {
      test(
        'should return various model with various fixtures',
        () async {
          final impactFixtures =
              getNomenclaturesListFixture("nomenclature_fixtures.json");

          final impactList = <NomenclatureModel>[
            const NomenclatureModel(
                commonName: "yellow cutworm ",
                scientificName: "Agrotis segetum",
                otherName: "turnip moth"),
            const NomenclatureModel(),
            const NomenclatureModel(
              commonName: "white margined moth ",
              scientificName: "",
              otherName: "",
            ),
            const NomenclatureModel(
              commonName: "white margined moth ",
            ),
          ];
          expect(impactFixtures, impactList);
        },
      );
    });

    group('toMap', () {
      test('should return a map containing proper data', () async {
        expect(
          nomenclatureModel.toMap(),
          equals({
            'commonName': testCommonName,
            'otherName': testOtherName,
            'scientificName': testScientificName,
          }),
        );
      });
    });
  });
}
