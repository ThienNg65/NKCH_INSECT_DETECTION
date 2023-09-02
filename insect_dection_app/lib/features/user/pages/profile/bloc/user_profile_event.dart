// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class OnLoadUserProfileEvent extends UserProfileEvent {
  final String uid;
  final String username;

  OnLoadUserProfileEvent({
    required this.uid,
    required this.username,
  });
  @override
  List<Object?> get props => [uid, username];
}

final class UpdateUserProfileEvent extends UserProfileEvent {
  final String felid;
  final String? value;

  UpdateUserProfileEvent({
    required this.felid,
    required this.value,
  });

  @override
  List<Object?> get props => [felid, value];
}

final class UpdatePhotoProfile extends UserProfileEvent {
  final String photoUrl;

  UpdatePhotoProfile({required this.photoUrl});
  @override
  List<Object?> get props => [photoUrl];
}
