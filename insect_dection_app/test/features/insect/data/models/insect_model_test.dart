import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  group('[Insect Model]', () {
    const insectModel = InsectModel(
      modelId: 'IP000000000',
      taxonomy: TaxonomyModel(
        species: 'Cnaphalocrocis medinalis',
        genus: 'Cnaphalococis',
        family: 'Crambidae',
        order: 'Lepidoptera',
        classical: 'Insecta',
        phylum: 'Arthropoda',
        regnum: 'Animalia',
      ),
      nomenclature: NomenclatureModel(
        commonName: 'Rice Leaf Roller',
        otherName:
            'Cnaphalocrocis exigua, Sameaexigua, and Susumia exigua. A moth of the Crambidae',
        scientificName: 'Marasmia exigua/Cnaphalocrocis medinalis',
      ),
      impacts: ImpactModel(
          benefits: "",
          harms: 'Harm,Feeds on rice leaves, causing damage to the crop'),
      origin: '',
      predators:
          'Trathala flavoorbitalis, Trichogramma chilonis, Cotesia flavipes',
      photoUrl: '',
      identificationFeatures:
          'The caterpillar of this butterfly usually has 5 instars, with a body length of about 15-18mm when mature. The head is brown, the thorax and abdomen are initially green, then change to yellow-green and finally to reddish-brown. There are two spiral black lines on the posterior margin of the prothoracic shield, and 8 distinct black small circles on the meso- and metathorax, 6 of which are anterior and 2 are posterior.',
      lifeCycle:
          'Eggs are laid on rice leaves. Larvae hatch and feed on rice leaves, making them curl up. Larvae go through 5 instars. Pupae form on rice leaves. Adults emerge from pupae and lay eggs.',
      pestControl: '',
    );
    const insectEnitty = Insect(
      modelId: 'IP000000000',
      taxonomy: Taxonomy(
        species: 'Cnaphalocrocis medinalis',
        genus: 'Cnaphalococis',
        family: 'Crambidae',
        order: 'Lepidoptera',
        classical: 'Insecta',
        phylum: 'Arthropoda',
        regnum: 'Animalia',
      ),
      nomenclature: Nomenclature(
        commonName: 'Rice Leaf Roller',
        otherName:
            'Cnaphalocrocis exigua, Sameaexigua, and Susumia exigua. A moth of the Crambidae',
        scientificName: 'Marasmia exigua/Cnaphalocrocis medinalis',
      ),
      impacts: Impact(
          benefits: "",
          harms: 'Harm,Feeds on rice leaves, causing damage to the crop'),
      origin: '',
      predators:
          'Trathala flavoorbitalis, Trichogramma chilonis, Cotesia flavipes',
      photoUrl: '',
      identificationFeatures:
          'The caterpillar of this butterfly usually has 5 instars, with a body length of about 15-18mm when mature. The head is brown, the thorax and abdomen are initially green, then change to yellow-green and finally to reddish-brown. There are two spiral black lines on the posterior margin of the prothoracic shield, and 8 distinct black small circles on the meso- and metathorax, 6 of which are anterior and 2 are posterior.',
      lifeCycle:
          'Eggs are laid on rice leaves. Larvae hatch and feed on rice leaves, making them curl up. Larvae go through 5 instars. Pupae form on rice leaves. Adults emerge from pupae and lay eggs.',
      pestControl: '',
    );
    test('should be a subclass of impact entity', () async {
      //assert
      expect(insectModel.toEntity(), insectEnitty);
    });
    group('fromMap', () {
      test(
        'should return various model with various fixtures',
        () async {
          final impactFixtures = getInsectListFixture("insect_data_list.json");
          for (var i = 0; i < impactFixtures.length; i++) {
            print(impactFixtures[i] == expects[i]);
          }
          expect(impactFixtures, expects);
        },
      );
    });

    group('toMap', () {
      test('should return a map containing proper data', () async {
        expect(
          insectModel.toMap(),
          equals({
            "modelId": 'IP000000000',
            "taxonomy": {
              "species": "Cnaphalocrocis medinalis",
              "genus": "Cnaphalococis",
              "family": "Crambidae",
              "order": "Lepidoptera",
              "classical": "Insecta",
              "phylum": "Arthropoda",
              "regnum": "Animalia",
            },
            "nomenclature": {
              "commonName": "Rice Leaf Roller",
              "otherName":
                  "Cnaphalocrocis exigua, Sameaexigua, and Susumia exigua. A moth of the Crambidae",
              "scientificName": 'Marasmia exigua/Cnaphalocrocis medinalis',
            },
            "impact": {
              "harms": 'Harm,Feeds on rice leaves, causing damage to the crop'
            },
            "origin": '',
            "predators":
                'Trathala flavoorbitalis, Trichogramma chilonis, Cotesia flavipes',
            "photoUrl": '',
            "identificationFeatures":
                'The caterpillar of this butterfly usually has 5 instars, with a body length of about 15-18mm when mature. The head is brown, the thorax and abdomen are initially green, then change to yellow-green and finally to reddish-brown. There are two spiral black lines on the posterior margin of the prothoracic shield, and 8 distinct black small circles on the meso- and metathorax, 6 of which are anterior and 2 are posterior.',
            "lifeCycle":
                'Eggs are laid on rice leaves. Larvae hatch and feed on rice leaves, making them curl up. Larvae go through 5 instars. Pupae form on rice leaves. Adults emerge from pupae and lay eggs.',
            "pestControl": '',
          }),
        );
      });
    });
  });
}

final expects = [
  InsectModel.empty(),
  const InsectModel(
    modelId: "0",
    nomenclature: NomenclatureModel(
      commonName: "Adristyrannus",
      scientificName: "Eudocima tyrannus",
      otherName: "Oriental Fruit-piercing Moth",
    ),
    taxonomy: TaxonomyModel(
      species: "E. tyranus",
      genus: "Eudocima",
      family: "Erebidae",
      order: "Lepidoptera",
      classical: "Insecta",
    ),
    impacts: ImpactModel(
      benefits: "",
      harms:
          "Nó làm hỏng các loại trái cây như cam quýt, táo, nho, loquat, xoài, lê, đào, mơ, mận, hồng và",
    ),
    predators: "",
    origin:
        "It is found in south-eastern Siberia, India, eastern China, the Philippines and Japan.",
    identificationFeatures:
        "Con trưởng thành: dài thân 35-38 mm, sải cánh 96-106 mm, đầu và ngực màu nâu",
    lifeCycle:
        "Ở Hoàng Nham, Chiết Giang, có 2 đến 3 thế hệ mỗi năm và trưởng thành qua mùa đông.",
    pestControl:
        "1. Phòng trừ nông nghiệp: Quy hoạch vườn ươm hợp lý, khi xây dựng vườn ươm mới nên bố trí càng xa vườn cây càng tốt.",
    photoUrl:
        "https://firebasestorage.googleapis.com/v0/b/nckh-insect.appspot.com/o/insects_img%2Fimg88.jpg?alt=media&token=7cd5ceab-4953-427d-8723-7eec23725784",
  ),
  const InsectModel(
    modelId: "1",
    nomenclature: NomenclatureModel(
      commonName: "Aleurocanthus spiniferus",
      scientificName: "Aleurocanthus spiniferus",
      otherName: "Orange Spiny Whitefly",
    ),
    taxonomy: TaxonomyModel(
      species: "A. spiniferus",
      genus: "Aleurocanthus",
      family: "Aleyrodidae",
      order: "Hemiptera",
      classical: "Insecta",
    ),
    impacts: ImpactModel(
      benefits: "",
      harms:
          "A. spiniferus causes direct damage, as well as indirect damage to an infested plant.",
    ),
    predators: "",
    origin:
        "The citrus spiny whitefly has spread to multiple continents including Asia, Africa, Australia, America, Pacific Islands and Italy.",
    identificationFeatures:
        "Egg: The egg is minute (0.2 x 0.1 mm), yellow, stalked, curved and marked with polygonal areas (Quaintance 1903, Quaintance and Baker 1917).",
    lifeCycle:
        "The eggs are typically laid near each other on a food plants, such as citrus plants, usually on a leaf.",
    pestControl:
        "Biological control: Orange spiny whitefly outbreaks in other countries have been successfully brought under control through biological control.",
    photoUrl:
        "https://firebasestorage.googleapis.com/v0/b/nckh-insect.appspot.com/o/insects_img%2Fimg83.jpg?alt=media&token=9d7b393a-b1ff-4ce5-b3c6-22dc536b4ecf",
  ),
  const InsectModel(
    modelId: "100",
    nomenclature: NomenclatureModel(
      commonName: "wireworm ",
      scientificName: "Elateridae",
      otherName: "họ bổ cũi",
    ),
    taxonomy: TaxonomyModel(
      species: "",
      genus: "",
      family: "Elateridae",
      order: "Coleoptera",
      classical: "Insecta",
    ),
    impacts: ImpactModel(benefits: "", harms: ""),
    predators: "",
    origin: "",
    identificationFeatures: "",
    lifeCycle: "",
    pestControl: "",
    photoUrl:
        "https://firebasestorage.googleapis.com/v0/b/nckh-insect.appspot.com/o/insects_img%2Fimg17.jpg?alt=media&token=44f91b14-8af3-4833-b969-a579dc109931",
  ),
];
