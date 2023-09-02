import 'package:insect_dection_app/features/insect/insect.dart';

class InsectListParams {
  final int? currentPage;
  final int? nextPage;
  final List<Insect>? insects;
  final int size;
  InsectListParams({
    this.currentPage = 0,
    this.nextPage,
    required this.insects,
    this.size = 10,
  });

  InsectListParams copyWith({
    int? currentPage,
    int? nextPage,
    List<Insect>? insects,
    int? size,
  }) {
    return InsectListParams(
      currentPage: currentPage ?? this.currentPage,
      nextPage: nextPage ?? this.nextPage,
      insects: insects ?? this.insects,
      size: size ?? this.size,
    );
  }
}
