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
