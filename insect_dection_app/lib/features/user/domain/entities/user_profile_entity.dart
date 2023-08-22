// ignore_for_file: unnecessary_this

import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/core/core.dart';

class UserProfileEntity extends Equatable {
  /// Account Identity
  final String uid;
  final String? username;
  final String? phoneNumber;

  /// User'Information
  final String? firstName;
  final String? lastName;

  /// Others
  final Address? address;
  final String? photoUrl;

  const UserProfileEntity({
    required this.uid,
    this.username,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.address,
    this.photoUrl,
  });

  @override
  List<Object?> get props {
    return [
      uid,
      username,
      phoneNumber,
      firstName,
      lastName,
      address,
      photoUrl,
    ];
  }

  UserProfileEntity copyWith({
    String? uid,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    Address? address,
    String? photoUrl,
  }) {
    return UserProfileEntity(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
