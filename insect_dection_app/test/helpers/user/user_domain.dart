import 'package:insect_dection_app/features/user/user.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  UserProfileRepository,
  UserProfileRemoteDataSource,
  CreateUserProfile,
  GetUserProfile,
  UpdateUserProfile,
])
void main() {}
