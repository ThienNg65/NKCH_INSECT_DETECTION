// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectParams extends Equatable {
  /// User parmas
  final AuthUserInfo userInfo;
  // Insects
  final Insect insect;

  const InsectParams({
    required this.userInfo,
    required this.insect,
  });

  InsectParams copyWith({
    AuthUserInfo? userInfo,
    Insect? insect,
  }) {
    return InsectParams(
      userInfo: userInfo ?? this.userInfo,
      insect: insect ?? this.insect,
    );
  }

  @override
  List<Object> get props => [userInfo, insect];
}
