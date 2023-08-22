import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/user.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserProfile _getUserProfile;
  final UpdateUserProfile _updateUserProfile;

  UserProfileBloc({
    required GetUserProfile getUserProfile,
    required UpdateUserProfile updateUserProfile,
  })  : _getUserProfile = getUserProfile,
        _updateUserProfile = updateUserProfile,
        super(
          UserProfileState.intial(),
        ) {
    on<OnLoadUserProfileEvent>(_onLoad);
    on<UpdateUserProfileEvent>(_onUpdate);
    on<UpdatePhotoProfile>(_onUpdatePhoto);
  }

  Future<void> _onLoad(
      OnLoadUserProfileEvent event, Emitter<UserProfileState> emit) async {
    // Take params value from event which init with AuthBloc on Init
    final userParams = UserParams(
      uid: event.uid,
      username: event.username,
    );
    emit(state.copyWith(status: UserProfileStatus.loading));
    final result = await _getUserProfile(userParams);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: UserProfileStatus.error,
          message: failure.errorMessage,
        ));
      },
      (userProfile) {
        emit(state.fromEntity(entity: userProfile));
      },
    );
  }

  bool isEmptyOrNull(String? value) {
    return value == null || value.isEmpty;
  }

  Future<void> _onUpdate(
      UpdateUserProfileEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(status: UserProfileStatus.loading));

    // Map feild into state then into enity
    final userParams = mapUserProfileData(
      fieldName: event.feild,
      value: event.value,
    ).toParams();

    // Update State into Entity
    final result = await _updateUserProfile(userParams);

    result!.fold(
      (Failure failure) {
        emit(state.copyWith(
          status: UserProfileStatus.error,
          message: failure.errorMessage,
        ));
      },
      (UserProfileEntity entity) {
        emit(
          state
              .fromEntity(entity: entity)
              .copyWith(status: UserProfileStatus.succes),
        );
      },
    );
  }

  Future<void> _onUpdatePhoto(
      UpdatePhotoProfile event, Emitter<UserProfileState> emit) async {}

  UserProfileState mapUserProfileData(
      {required String fieldName, String? value}) {
    switch (fieldName) {
      case 'username':
        return state.copyWith(username: value);
      case 'phoneNumber':
        return state.copyWith(phoneNumber: value);
      case 'firstName':
        return state.copyWith(firstName: value);
      case 'lastName':
        return state.copyWith(lastName: value);
      case 'street':
        return state.copyWith(street: value);
      case 'city':
        return state.copyWith(city: value);
      case 'country':
        return state.copyWith(country: value);
      case 'photoUrl':
        return state.copyWith(photoUrl: value);
      default:
        return state.copyWith();
    }
  }
}
