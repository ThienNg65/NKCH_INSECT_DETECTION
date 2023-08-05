import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/auth/auth_domain.mocks.dart';

void main() {
  group('Usecase: Test log out', () {
    late MockAuthRepository mockAuthRepository;
    late LogOutRequested logOutRequested;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      logOutRequested = LogOutRequested(repo: mockAuthRepository);
    });

    test(
      'should return the result of calling repo.logOut when the use case is invoked',
      () async {
        // arrange
        when(mockAuthRepository.logOut())
            .thenAnswer((_) async => const Right(null));
        // act
        final result = await logOutRequested.call(null);
        // assert
        expect(result, const Right(null));
        verify(mockAuthRepository.logOut());
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
    test(
      'should return Left(ServerFailure) when repo.logOut returns Left(ServerFailure)',
      () async {
        // arrange
        when(mockAuthRepository.logOut()).thenAnswer((_) async =>
            const Left(ServerFailure(errorMessage: 'Server Error')));
        // act
        final result = await logOutRequested.call(null);
        // assert
        expect(result, const Left(ServerFailure(errorMessage: 'Server Error')));
        verify(mockAuthRepository.logOut());
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );
  });
}
