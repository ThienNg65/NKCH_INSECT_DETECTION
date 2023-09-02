import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insect_dection_app/features/features.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  /// Features
  initAuthentication();
  initUserProfile();
  initInsectDetail();

  /// Externals
  initExternalServices();
}

void initAuthentication() {
  /// Cubit-Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      getAuthUserStream: sl.call(),
      logOutRequested: sl.call(),
    ),
  );
  sl.registerFactory<LoginCubit>(() => LoginCubit(login: sl<EmailLogin>()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(
        signUp: sl<EmailSignUp>(),
        createUserProfile: sl<CreateUserProfile>(),
      ));

  /// Usecases
  sl.registerLazySingleton<EmailLogin>(
      () => EmailLogin(repo: sl<AuthRepository>()));
  sl.registerLazySingleton<EmailSignUp>(
      () => EmailSignUp(repo: sl<AuthRepository>()));
  sl.registerLazySingleton<GetCurrentAuthUserInfoStream>(
      () => GetCurrentAuthUserInfoStream(repo: sl<AuthRepository>()));
  sl.registerLazySingleton<LogOutRequested>(
      () => LogOutRequested(repo: sl<AuthRepository>()));

  /// Datasources
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceIml(auth: sl.call()));

  /// Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDatasource: sl.call()));
}

void initUserProfile() {
  /// Bloc
  sl.registerFactory<UserProfileBloc>(
    () => UserProfileBloc(
      getUserProfile: sl.call(),
      updateUserProfile: sl.call(),
    ),
  );

  /// Usercases
  sl.registerLazySingleton<CreateUserProfile>(
      () => CreateUserProfile(repo: sl.call()));
  sl.registerLazySingleton<GetUserProfile>(
      () => GetUserProfile(repo: sl.call()));
  sl.registerLazySingleton<UpdateUserProfile>(
      () => UpdateUserProfile(repo: sl.call()));

  /// Data Sources
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
      () => UserProfileRemoteDatasourceImpl(database: sl.call()));

  /// Repository
  sl.registerLazySingleton<UserProfileRepository>(
      () => UserProfileRepositoryImpl(remoteDataSource: sl.call()));
}

void initInsectDetail() {
  /// Bloc
  sl.registerFactory<InsectDetailBloc>(
    () => InsectDetailBloc(
      getInsectByModelId: sl<GetInsectByModelId>(),
      addBookmarkedInsect: sl<AddBookmarkedInsect>(),
      addRecentlySearchInsect: sl<AddRecentlySearchInsect>(),
      getInsectBookmarkedState: sl<GetInsectBookmarkedState>(),
    ),
  );

  /// Usecases
  /// Favorites
  sl.registerLazySingleton<AddBookmarkedInsect>(
    () => AddBookmarkedInsect(repo: sl.call()),
  );
  sl.registerLazySingleton<GetBookmarkedInsectList>(
    () => GetBookmarkedInsectList(repo: sl.call()),
  );
  sl.registerLazySingleton<GetInsectBookmarkedState>(
    () => GetInsectBookmarkedState(repo: sl.call()),
  );
  sl.registerLazySingleton<RemoveBookmarkedInsect>(
    () => RemoveBookmarkedInsect(repo: sl.call()),
  );

  /// Infos
  sl.registerLazySingleton<GetInsectByModelId>(
    () => GetInsectByModelId(repo: sl.call()),
  );
  sl.registerLazySingleton<GetInitialInsectList>(
    () => GetInitialInsectList(repo: sl.call()),
  );
  sl.registerLazySingleton<GetMoreInsectList>(
    () => GetMoreInsectList(repo: sl.call()),
  );

  /// Recently search
  sl.registerLazySingleton<AddRecentlySearchInsect>(
    () => AddRecentlySearchInsect(repo: sl.call()),
  );
  sl.registerLazySingleton<GetRecentlySearchInsectList>(
    () => GetRecentlySearchInsectList(repo: sl.call()),
  );

  /// Data Sources
  // Info
  sl.registerLazySingleton<InsectRemoteDatasource>(
    () => InsectRemoteDatasourceImpl(data: sl.call(), storage: sl.call()),
  );
  // User Insect Info
  sl.registerLazySingleton<UserInsectRemoteDatasource>(
    () => UserInsectRemoteDatasourceImpl(data: sl.call(), storage: sl.call()),
  );

  /// Repositories
  // Info
  sl.registerLazySingleton<InsectRepository>(
    () => InsectRepositoryImpl(remoteDatasource: sl.call()),
  );
  // User Insect Info
  sl.registerLazySingleton<UserInsectDataRepository>(
    () => UserInsectDataRepositoryImpl(remoteDatasource: sl.call()),
  );
}

void initExternalServices() {
  /// External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final firestorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => firestorage);
}
