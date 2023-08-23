// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_profile_bloc.dart';

class UserProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnLoadUserProfileEvent extends UserProfileEvent {
  final String uid;
  final String username;

  OnLoadUserProfileEvent({
    required this.uid,
    required this.username,
  });
  @override
  List<Object?> get props => [uid, username];
}

class UpdateUserProfileEvent extends UserProfileEvent {
  final String feild;
  final String? value;

  UpdateUserProfileEvent({
    required this.feild,
    required this.value,
  });

  @override
  List<Object?> get props => [feild, value];
}

class UpdatePhotoProfile extends UserProfileEvent {
  final String photoUrl;

  UpdatePhotoProfile({required this.photoUrl});
  @override
  List<Object?> get props => [photoUrl];
}
