import 'dart:convert';
import 'dart:io';

import 'package:insect_dection_app/features/features.dart';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
List<String> fixtures(String name) =>
    File('test/fixtures/$name').readAsLinesSync();

List<InsectModel> getInsectListFixture(String name) {
  final insectListFixtures = fixture('insects/$name');
  var map = jsonDecode(insectListFixtures);
  return map['insects']
      .map<InsectModel>((insect) => InsectModel.fromMap(insect))
      .toList();
}

List<ImpactModel> getImpactsListFixture(String name) {
  final impactsListFixtures = fixture('impacts/$name');
  var map = jsonDecode(impactsListFixtures);
  return map['impacts']
      .map<ImpactModel>(
        (impact) => ImpactModel.fromMap(impact),
      )
      .toList();
}

List<NomenclatureModel> getNomenclaturesListFixture(String name) {
  final impactsListFixtures = fixture('nomenclatures/$name');
  var map = jsonDecode(impactsListFixtures);
  return map['nomenclatures']
      .map<NomenclatureModel>(
        (nomenclature) => NomenclatureModel.fromMap(nomenclature),
      )
      .toList();
}

List<TaxonomyModel> getTaxonomiesListFixture(String name) {
  final impactsListFixtures = fixture('taxonomies/$name');
  var map = jsonDecode(impactsListFixtures);
  return map['taxonomies']
      .map<TaxonomyModel>(
        (taxonomy) => TaxonomyModel.fromMap(taxonomy),
      )
      .toList();
}
