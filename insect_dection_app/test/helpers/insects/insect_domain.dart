import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  /// Repo and Data
  InsectRepository,
  UserInsectDataRepository,
  InsectRemoteDatasource,
  UserInsectRemoteDatasource,
])
@GenerateMocks([
  /// Usecases
  /// Infos
  GetInsectByModelId,
  GetInitialInsectList,
  GetMoreInsectList,

  // User Info
  AddRecentlySearchInsect,
  GetRecentlySearchInsectList,

  /// Bookmarked
  AddBookmarkedInsect,
  GetInsectBookmarkedState,
  RemoveBookmarkedInsect,
  GetBookmarkedInsectList,
])
void main() {}
