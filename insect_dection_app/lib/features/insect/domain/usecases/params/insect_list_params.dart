// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectListParams extends Equatable {
  final int? currentPage;
  final int? nextPage;
  final List<Insect>? insects;
  final int size;
  const InsectListParams({
    this.currentPage = 0,
    this.nextPage,
    required this.insects,
    this.size = 10,
  });

  factory InsectListParams.empty() => const InsectListParams(
        currentPage: 0,
        nextPage: 0,
        insects: <Insect>[],
        size: 10,
      );

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

  @override
  List<Object?> get props => [currentPage, nextPage, insects, size];
}
