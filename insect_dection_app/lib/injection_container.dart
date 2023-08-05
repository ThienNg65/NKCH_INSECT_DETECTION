import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  ///Cubit/Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      getAuthUserStream: sl.call(),
      logOutRequested: sl.call(),
    ),
  );
  sl.registerFactory<LoginCubit>(() => LoginCubit(login: sl<EmailLogin>()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(signUp: sl<EmailSignUp>()));

  /// Usecases
  /// Authentication Features
  sl.registerLazySingleton<EmailLogin>(
      () => EmailLogin(repo: sl<AuthRepository>()));
  sl.registerLazySingleton<EmailSignUp>(
      () => EmailSignUp(repo: sl<AuthRepository>()));
  sl.registerLazySingleton<GetCurrentAuthUserInfoStream>(
      () => GetCurrentAuthUserInfoStream(repo: sl<AuthRepository>()));
  sl.registerLazySingleton<LogOutRequested>(
      () => LogOutRequested(repo: sl<AuthRepository>()));

  /// Datasourcs
  // Authentication Repository
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceIml(auth: sl.call()));

  /// Repository
  // Authentication Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDatasource: sl.call()));

  /// External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
