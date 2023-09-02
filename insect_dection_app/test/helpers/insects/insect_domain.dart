import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  InsectRepository,
  UserInsectDataRepository,
  InsectRemoteDatasource,
  UserInsectRemoteDatasource,
])
void main() {}
