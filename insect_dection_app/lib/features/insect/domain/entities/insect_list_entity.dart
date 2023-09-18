// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectList extends Equatable {
  final int currentPage;
  final bool hasNextPage;
  final int size;
  final List<Insect> insects;
  const InsectList({
    required this.currentPage,
    required this.hasNextPage,
    required this.size,
    required this.insects,
  });

  @override
  List<Object?> get props => [currentPage, hasNextPage, size, insects];

  InsectList copyWith({
    int? currentPage,
    bool? hasNextPage,
    int? size,
    List<Insect>? insects,
  }) {
    return InsectList(
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      size: size ?? this.size,
      insects: insects ?? this.insects,
    );
  }

  factory InsectList.empty() => const InsectList(
        insects: <Insect>[],
        currentPage: 0,
        hasNextPage: true,
        size: 0,
      );
  bool get isEmpty => this == InsectList.empty();
  bool get isNotEmpty => !isEmpty;
}
