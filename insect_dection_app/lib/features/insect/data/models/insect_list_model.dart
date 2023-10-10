// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectListModel extends Equatable {
  final bool hasNextPage;
  final int size;
  final List<InsectModel>? previousPage;
  final List<InsectModel> currentPage;
  const InsectListModel({
    this.hasNextPage = false,
    this.size = 0,
    this.previousPage,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [hasNextPage, size, previousPage, currentPage];

  InsectListModel copyWith({
    bool? hasNextPage,
    int? size,
    List<InsectModel>? previousPage,
    List<InsectModel>? currentPage,
  }) {
    return InsectListModel(
      hasNextPage: hasNextPage ?? this.hasNextPage,
      size: size ?? this.size,
      previousPage: previousPage ?? this.previousPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  InsectList toEntity() {
    return InsectList(
      hasNextPage: hasNextPage,
      size: size,
      previousPage: previousPage != null
          ? previousPage!.map((e) => e.toEntity()).toList()
          : const <Insect>[],
      currentPage: currentPage.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  bool get stringify => true;
}
