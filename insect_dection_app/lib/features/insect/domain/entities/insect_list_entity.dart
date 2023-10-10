// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectList extends Equatable {
  final bool hasNextPage;
  final int size;
  final List<Insect> previousPage;
  final List<Insect> currentPage;
  const InsectList({
    required this.hasNextPage,
    required this.size,
    required this.previousPage,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [
        currentPage,
        previousPage,
        hasNextPage,
        size,
      ];

  InsectList copyWith({
    bool? hasNextPage,
    int? size,
    List<Insect>? previousPage,
    List<Insect>? currentPage,
  }) {
    return InsectList(
      hasNextPage: hasNextPage ?? this.hasNextPage,
      size: size ?? this.size,
      previousPage: previousPage ?? this.previousPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  static InsectList get empty => const InsectList(
        hasNextPage: false,
        previousPage: <Insect>[],
        currentPage: <Insect>[],
        size: 0,
      );
  bool get isEmpty => this == InsectList.empty;
  bool get isNotEmpty => !isEmpty;
}
