import 'package:equatable/equatable.dart';

class AuthUserInfo extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;

  const AuthUserInfo({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
  });

  static const empty = AuthUserInfo(uid: '');
  bool get isEmpty => this == AuthUserInfo.empty;
  bool get isNotEmpty => this != AuthUserInfo.empty;

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoUrl,
        phoneNumber,
      ];
}
