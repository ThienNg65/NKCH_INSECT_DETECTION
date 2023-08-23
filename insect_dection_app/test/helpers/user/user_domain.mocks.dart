// Mocks generated by Mockito 5.4.2 from annotations
// in insect_dection_app/test/helpers/user/user_domain.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:insect_dection_app/core/core.dart' as _i5;
import 'package:insect_dection_app/features/user/user.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserProfileRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserProfileRepository extends _i1.Mock
    implements _i3.UserProfileRepository {
  MockUserProfileRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>> getUserProfile(
          _i3.UserParams? userParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserProfile,
          [userParams],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>>.value(
                _FakeEither_0<_i5.Failure, _i3.UserProfileEntity>(
          this,
          Invocation.method(
            #getUserProfile,
            [userParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>> createUserProfile(
          _i3.UserParams? userParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUserProfile,
          [userParams],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>>.value(
                _FakeEither_0<_i5.Failure, _i3.UserProfileEntity>(
          this,
          Invocation.method(
            #createUserProfile,
            [userParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>> updateUserProfile(
          _i3.UserParams? userParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUserProfile,
          [userParams],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>>.value(
                _FakeEither_0<_i5.Failure, _i3.UserProfileEntity>(
          this,
          Invocation.method(
            #updateUserProfile,
            [userParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i3.UserProfileEntity>>>
      getUserProfileList() => (super.noSuchMethod(
            Invocation.method(
              #getUserProfileList,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure, List<_i3.UserProfileEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i3.UserProfileEntity>>(
              this,
              Invocation.method(
                #getUserProfileList,
                [],
              ),
            )),
          ) as _i4
              .Future<_i2.Either<_i5.Failure, List<_i3.UserProfileEntity>>>);
}

/// A class which mocks [UserProfileRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserProfileRemoteDataSource extends _i1.Mock
    implements _i3.UserProfileRemoteDataSource {
  MockUserProfileRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>> getUserProfile(
          _i3.UserParams? userParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserProfile,
          [userParams],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>>.value(
                _FakeEither_0<_i5.Failure, _i3.UserProfileModel>(
          this,
          Invocation.method(
            #getUserProfile,
            [userParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>> createUserProfile(
          _i3.UserParams? userParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUserProfile,
          [userParams],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>>.value(
                _FakeEither_0<_i5.Failure, _i3.UserProfileModel>(
          this,
          Invocation.method(
            #createUserProfile,
            [userParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>> updateUserProfile(
          _i3.UserParams? userParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUserProfile,
          [userParams],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>>.value(
                _FakeEither_0<_i5.Failure, _i3.UserProfileModel>(
          this,
          Invocation.method(
            #updateUserProfile,
            [userParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileModel>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i3.UserProfileModel>>>
      getUserProfileList() => (super.noSuchMethod(
            Invocation.method(
              #getUserProfileList,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure, List<_i3.UserProfileModel>>>.value(
                _FakeEither_0<_i5.Failure, List<_i3.UserProfileModel>>(
              this,
              Invocation.method(
                #getUserProfileList,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i3.UserProfileModel>>>);
}

/// A class which mocks [CreateUserProfile].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateUserProfile extends _i1.Mock implements _i3.CreateUserProfile {
  MockCreateUserProfile() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>?> call(
          _i3.UserParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>?>.value(),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>?>);
}

/// A class which mocks [GetUserProfile].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUserProfile extends _i1.Mock implements _i3.GetUserProfile {
  MockGetUserProfile() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>> call(
          _i3.UserParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>>.value(
                _FakeEither_0<_i5.Failure, _i3.UserProfileEntity>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>>);
}

/// A class which mocks [UpdateUserProfile].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateUserProfile extends _i1.Mock implements _i3.UpdateUserProfile {
  MockUpdateUserProfile() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>?> call(
          _i3.UserParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>?>.value(),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.UserProfileEntity>?>);
}