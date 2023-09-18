part of 'insect_remote_datasources.dart';

class InsectRemoteDatasourceImpl implements InsectRemoteDatasource {
  final FirebaseFirestore _data;
  final _firstSize = 11;
  final _sizeOffset = 14;
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
        currentPage: insectListParams.currentPage,
        hasNextPage: true,
        insects: insects,
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
      final lastModelId = insectListParams.insects!.last.modelId;

      final insectsSnapshot =
          await insectsQuery.startAfter([lastModelId]).get();

      var previous = insectListParams.insects
          ?.map<InsectModel>(((e) => InsectModel.fromEntity(e)))
          .toList();
      var insects = insectsSnapshot.docs
          .map((doc) => InsectModel.fromMap(doc.data()))
          .toList();
      previous?.addAll(insects);
      // Check if there is a next page.
      final hasMorePages = insectsSnapshot.docs.length >= insectListParams.size;

      return Right(
        InsectListModel(
          currentPage: insectListParams.currentPage,
          hasNextPage: hasMorePages,
          insects: previous,
        ),
      );
    } on FirebaseException catch (e) {
      // Return a Failure object if an error occurs.
      return Left(ServerFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, InsectListModel>> getInsectByKeyword(
      String keyword) async {
    // Get the initial page of insects.
    try {
      // Take id
      final insectsDocument = await _data
          .collection(InsectCollectionName.insects)
          .orderBy("nomenclature.commonName")
          .where(
            "nomenclature.commonName",
            isGreaterThanOrEqualTo: keyword,
          )
          .where(
            "nomenclature.commonName",
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
        insects: insects,
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
