import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:insect_dection_app/features/insect/pages/recent_search/bloc/recently_detection_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  /// Features
  initAuthentication();
  initUserProfile();
  initInsectDetail();
  initGeneralPages();
  initInsectDetection();

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
      removeBookmarkedInsect: sl<RemoveBookmarkedInsect>(),
    ),
  );
  sl.registerFactory<BookmarkedInsectsBloc>(
    () => BookmarkedInsectsBloc(
      getBookmarkedInsectList: sl<GetBookmarkedInsectList>(),
      removeBookmarkedInsect: sl<RemoveBookmarkedInsect>(),
    ),
  );
  sl.registerFactory<SearchInsectBloc>(
    () => SearchInsectBloc(
      getInitialInsectList: sl<GetInitialInsectList>(),
      getInsectByKeyword: sl<GetInsectByKeyword>(),
      getMoreInsectList: sl<GetMoreInsectList>(),
    ),
  );
  sl.registerFactory<RecentlyDetectionBloc>(
    () => RecentlyDetectionBloc(
      getRecentlySearchInsectList: sl<GetRecentlySearchInsectList>(),
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
  sl.registerLazySingleton<GetInsectByKeyword>(
    () => GetInsectByKeyword(repo: sl.call()),
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

void initGeneralPages() {
  sl.registerFactory<HomePageBloc>(
    () => HomePageBloc(
      getBookmarkedInsectList: sl<GetBookmarkedInsectList>(),
      getInitialInsectList: sl<GetInitialInsectList>(),
      getRecentlySearchInsectList: sl<GetRecentlySearchInsectList>(),
    ),
  );
}

void initInsectDetection() {
  /// Bloc
  sl.registerFactory<CamaraDetectionBloc>(
    () => CamaraDetectionBloc(
      getDetectionResult: sl<GetDetectionResult>.call(),
      addRecentlySearchInsect: sl<AddRecentlySearchInsect>.call(),
      getInsectByModelId: sl<GetInsectByModelId>.call(),
    ),
  );

  /// Use case
  /// Camara detection
  sl.registerLazySingleton<GetDetectionResult>(
    () => GetDetectionResult(service: sl.call()),
  );

  /// Data Sources
  // Services
  sl.registerLazySingleton<InsectDetectionService>(
    () => InsectDetectionServiceImpl(helper: sl<ImageClassificationHelper>()),
  );
  sl.registerFactory<ImageClassificationHelper>(
    () => ImageClassificationHelper(),
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
