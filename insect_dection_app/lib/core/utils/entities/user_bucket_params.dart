// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/auth/auth.dart';

class UserBucketParams extends Equatable {
  final String uid;
  final String? username;

  const UserBucketParams({required this.uid, this.username});

  @override
  List<Object?> get props => [uid, username];

  UserBucketParams copyWith({
    String? uid,
    String? username,
  }) {
    return UserBucketParams(
      uid: uid ?? this.uid,
      username: username ?? this.username,
    );
  }

  factory UserBucketParams.fromAuthUserInfo(AuthUserInfo userInfo) =>
      UserBucketParams(
        uid: userInfo.uid,
        username: userInfo.email,
      );
}
