// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectListParams extends InsectList {
  // TODO: add fillter
  const InsectListParams({
    required super.hasNextPage,
    super.size = 0,
    required super.previousPage,
    required super.currentPage,
  });

  static InsectListParams get empty => const InsectListParams(
        hasNextPage: false,
        previousPage: <Insect>[],
        currentPage: <Insect>[],
        size: 0,
      );
  @override
  InsectListParams copyWith({
    bool? hasNextPage,
    int? size,
    List<Insect>? previousPage,
    List<Insect>? currentPage,
  }) {
    return InsectListParams(
      hasNextPage: hasNextPage ?? super.hasNextPage,
      size: size ?? super.size,
      previousPage: previousPage ?? super.previousPage,
      currentPage: currentPage ?? super.currentPage,
    );
  }

  factory InsectListParams.fromEntity(InsectList entity) {
    return InsectListParams(
      hasNextPage: entity.hasNextPage,
      size: entity.size,
      previousPage: entity.previousPage,
      currentPage: entity.currentPage,
    );
  }

  @override
  List<Object> get props => [hasNextPage, size, previousPage, currentPage];
}
