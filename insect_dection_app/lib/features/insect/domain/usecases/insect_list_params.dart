import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectListParams {
  final AuthUserInfo? userInfo;
  List<InsectList> insects;
  final int? loadNumber;

  InsectListParams({
    this.userInfo,
    required this.insects,
    this.loadNumber = 5,
  });

  InsectListParams copyWith({
    AuthUserInfo? userInfo,
    List<InsectList>? insects,
    int? loadNumber,
  }) {
    return InsectListParams(
      userInfo: userInfo ?? this.userInfo,
      insects: insects ?? this.insects,
      loadNumber: loadNumber ?? this.loadNumber,
    );
  }
}
