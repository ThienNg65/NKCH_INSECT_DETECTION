// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectList extends Equatable {
  final int? currentPage;
  final int? nextPage;
  final List<Insect>? insects;
  const InsectList({
    this.currentPage,
    this.nextPage,
    this.insects,
  });

  @override
  List<Object?> get props => [currentPage, nextPage, insects];

  InsectList copyWith({
    int? currentPage,
    int? nextPage,
    List<Insect>? insects,
  }) {
    return InsectList(
      currentPage: currentPage ?? this.currentPage,
      nextPage: nextPage ?? this.nextPage,
      insects: insects ?? this.insects,
    );
  }
}
