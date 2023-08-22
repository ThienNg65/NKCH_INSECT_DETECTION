// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectListModel extends Equatable {
  final int? currentPage;
  final int? nextPage;
  final List<InsectModel>? insects;

  const InsectListModel({
    this.currentPage,
    this.nextPage,
    this.insects,
  });

  @override
  List<Object?> get props => [currentPage, nextPage, insects];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPage': currentPage,
      'nextPage': nextPage,
      'insects': insects?.map((x) => x.toMap()).toList(),
    };
  }

  factory InsectListModel.fromMap(Map<String, dynamic> map) {
    return InsectListModel(
      currentPage:
          map['currentPage'] != null ? map['currentPage'] as int : null,
      nextPage: map['nextPage'] != null ? map['nextPage'] as int : null,
      insects: map['insects'] != null
          ? List<InsectModel>.from(
              (map['insects'] as List<int>).map<InsectModel?>(
                (x) => InsectModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InsectListModel.fromJson(String source) =>
      InsectListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  InsectListModel copyWith({
    int? currentPage,
    int? nextPage,
    List<InsectModel>? insects,
  }) {
    return InsectListModel(
      currentPage: currentPage ?? this.currentPage,
      nextPage: nextPage ?? this.nextPage,
      insects: insects ?? this.insects,
    );
  }

  InsectList toEntity() => InsectList(
        currentPage: currentPage,
        nextPage: nextPage,
        insects: insects?.map<Insect>((model) => model.toEntity()).toList(),
      );
}
