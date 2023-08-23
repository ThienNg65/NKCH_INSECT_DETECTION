part of 'user_profile_bloc.dart';

enum UserProfileStatus { intial, loading, succes, error }

class UserProfileState extends Equatable {
  // UID
  final String uid;

  /// Account Identity
  final String username;
  final String phoneNumber;

  /// User'Information
  final String firstName;
  final String lastName;

  /// Others
  final String street;
  final String city;
  final String country;
  final String photoUrl;
  final UserProfileStatus status;
  final String? message;

  const UserProfileState({
    required this.uid,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.city,
    required this.country,
    required this.photoUrl,
    required this.status,
    this.message,
  });
  factory UserProfileState.intial() => const UserProfileState(
        uid: '',
        username: '',
        phoneNumber: '',
        firstName: '',
        lastName: '',
        street: '',
        city: '',
        country: '',
        photoUrl: '',
        status: UserProfileStatus.intial,
      );

  @override
  List<Object?> get props => [
        uid,
        username,
        phoneNumber,
        firstName,
        lastName,
        street,
        city,
        country,
        photoUrl,
        status,
        message,
      ];

  UserProfileState copyWith({
    String? uid,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? street,
    String? city,
    String? country,
    String? photoUrl,
    UserProfileStatus? status,
    String? message,
  }) {
    return UserProfileState(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      street: street ?? this.street,
      city: city ?? this.city,
      country: country ?? this.country,
      photoUrl: photoUrl ?? this.photoUrl,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  UserProfileState fromEntity({required UserProfileEntity entity}) {
    return UserProfileState(
      uid: entity.uid,
      username: entity.username ?? username,
      phoneNumber: entity.phoneNumber ?? phoneNumber,
      firstName: entity.firstName ?? firstName,
      lastName: entity.lastName ?? lastName,
      street: entity.address!.street ?? street,
      city: entity.address!.city ?? city,
      country: entity.address!.country ?? country,
      photoUrl: entity.photoUrl ?? photoUrl,
      status: UserProfileStatus.succes,
    );
  }

  UserParams toParams() {
    return UserParams(
      uid: uid,
      username: username,
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      address: Address(
        street: street,
        city: city,
        country: country,
      ),
      photoUrl: photoUrl,
    );
  }
}
