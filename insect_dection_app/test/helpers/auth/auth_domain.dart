import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AuthRepository,
  AuthRemoteDatasource,
  GetCurrentAuthUserInfoStream,
  EmailLogin,
  EmailSignUp,
  LogOutRequested,
])
void main() {}
