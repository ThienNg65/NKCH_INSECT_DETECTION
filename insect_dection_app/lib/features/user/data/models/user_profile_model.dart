import 'dart:convert';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/user/user.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.uid,
    super.username,
    super.phoneNumber,
    super.firstName,
    super.lastName,
    super.address,
    super.photoUrl,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'address': address?.toMap(),
      'photoUrl': photoUrl,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      uid: map['uid'] ,
      username: map['username'],
      phoneNumber:
          map['phoneNumber'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      address: map['address'] != null
          ? Address.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserProfileEntity toEntity() => UserProfileEntity(
        uid: uid,
        username: username,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        address: address,
        photoUrl: photoUrl,
      );
  static UserProfileModel fromUserParams(UserParams userProfile) {
    return UserProfileModel(
      uid: userProfile.uid!,
      username: userProfile.username,
      phoneNumber: userProfile.phoneNumber,
      firstName: userProfile.firstName,
      lastName: userProfile.lastName,
      address: userProfile.address,
      photoUrl: userProfile.photoUrl,
    );
  }
}
