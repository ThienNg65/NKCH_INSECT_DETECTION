part of 'insect_remote_datasources.dart';

class InsectRemoteDatasourceImpl implements InsectRemoteDatasource {
  final FirebaseFirestore _data;
  final _firstSize = 11;
  final _sizeOffset = 14;
  final _totalInsect = 102;
  InsectRemoteDatasourceImpl({
    required FirebaseFirestore data,
    required FirebaseStorage storage,
  }) : _data = data;

  @override
  Future<Either<Failure, InsectModel>> getInsectByModelId(
      String modelId) async {
    try {
      // Take id
      final insectDocument = await _data
          .collection(InsectCollectionName.insects)
          .doc(modelId)
          .get();

      // Check if date is empty or not
      if (insectDocument.data() == null) {
        return const Left(DataNotFoundFailure());
      }
      // Convert model
      InsectModel model = InsectModel.fromMap(insectDocument.data()!);

      return Right(model);
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, InsectListModel>> getInitialInsectList(
      InsectListParams insectListParams) async {
    try {
      // Get the initial page of insects.
      final insectsQuery = _data
          .collection(InsectCollectionName.insects)
          .orderBy('modelId')
          .limit(_firstSize);

      final insectsSnapshot = await insectsQuery.get();

      final insects = insectsSnapshot.docs.map((doc) {
        return InsectModel.fromMap(doc.data());
      }).toList();

      return Right(InsectListModel(
        currentPage: insects,
        hasNextPage: true,
        size: insects.length,
      ));
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, InsectListModel>> getMoreInsectList(
      InsectListParams insectListParams) async {
    try {
      // Get the initial page of insects.
      final insectsQuery = _data
          .collection(InsectCollectionName.insects)
          .orderBy('modelId')
          .limit(_sizeOffset);

      // Take the last item of previous list
      final lastModelId = insectListParams.currentPage.last.modelId;

      // Fetch new list insect
      final insectsSnapshot =
          await insectsQuery.startAfter([lastModelId]).get();

      // Take the prvious page = current page + previous page
      var previous = <Insect>[
        ...insectListParams.previousPage,
        ...insectListParams.currentPage
      ];

      final previousPage =
          previous.map((e) => InsectModel.fromEntity(e)).toList();

      // Set new fetch into current page

      var currentPage = insectsSnapshot.docs
          .map((doc) => InsectModel.fromMap(doc.data()))
          .toList();

      // Check if there is a next page.
      final hasMorePages =
          _totalInsect >= previousPage.length + currentPage.length;

      return Right(
        InsectListModel(
          currentPage: currentPage,
          hasNextPage: hasMorePages,
          previousPage: previousPage,
          size: currentPage.length,
        ),
      );
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, InsectListModel>> getInsectByKeyword(
      InsectListFilterParams insectListFilterParams) async {
    // Get the initial page of insects.
    try {
      final keyword = insectListFilterParams.keyword;
      final filterAttribute = insectListFilterParams.filterAttribute;
      // Take id
      final insectsDocument = await _data
          .collection(InsectCollectionName.insects)
          .orderBy(filterAttribute)
          .where(
            filterAttribute,
            isGreaterThanOrEqualTo: keyword,
          )
          .where(
            filterAttribute,
            isLessThan: _replaceCharactersNext(keyword),
          )
          .limit(10)
          .get();

      // Check if date is empty or not
      if (insectsDocument.docs.isEmpty) {
        return const Left(DataNotFoundFailure());
      }
      // Convert models
      final insects = insectsDocument.docs
          .map((doc) => InsectModel.fromMap(doc.data()))
          .toList();

      return Right(InsectListModel(
        currentPage: insects,
        size: insects.length,
        hasNextPage: false,
      ));
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  String _replaceCharactersNext(String string) {
    final runes = string.runes;
    final result = String.fromCharCodes(runes.map((rune) => rune + 1).toList());
    return result;
  }
}
