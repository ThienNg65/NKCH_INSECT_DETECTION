import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  group('[Impact Model]', () {
    const testBenefits = 'Test Benefits';
    const testHarms = 'Test Harms';
    const impactsModel = ImpactModel(
      benefits: testBenefits,
      harms: testHarms,
    );
    group('fromMap', () {
      test(
        'should return various model with various fixtures',
        () async {
          final impactFixtures = getImpactsListFixture("impact_fixture.json");

          final impactList = <ImpactModel>[
            const ImpactModel(benefits: "", harms: ""),
            const ImpactModel(),
            const ImpactModel(
                benefits: "",
                harms: "Nó làm hỏng các loại trái cây như cam quýt, ....."),
            const ImpactModel(
                benefits:
                    "A. spiniferus causes direct damage, as well as indirect damage to an infested plant...",
                harms: ""),
          ];
          expect(impactFixtures, impactList);
        },
      );
    });
    test('should be a subclass of impact entity', () async {
      //assert
      expect(impactsModel, isA<Impact>());
    });
    group('toMap', () {
      test('should return a map containing proper data', () async {
        expect(
            impactsModel.toMap(),
            equals({
              'benefits': testBenefits,
              'harms': testHarms,
            }));
      });
    });
  });
}
