import 'dart:convert';
import 'package:insect_dection_app/features/insect/insect.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  final insectListFixtures = fixture('insect_data_list.json');

  var map = jsonDecode(insectListFixtures);
  var insects = map['insects'];
  insects.map<InsectModel>((insect) => InsectModel.fromMap(insect)).toList();
}
