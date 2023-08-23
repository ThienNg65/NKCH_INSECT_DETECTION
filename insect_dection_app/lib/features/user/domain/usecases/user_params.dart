import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/core/core.dart';

class UserParams extends Equatable {
  /// Account Identity
  final String? uid;
  final String? username;
  final String? phoneNumber;

  /// User'Information
  final String? firstName;
  final String? lastName;

  /// Others
  final Address? address;
  final String? photoUrl;

  const UserParams({
    this.uid,
    this.username,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.address,
    this.photoUrl,
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
}
