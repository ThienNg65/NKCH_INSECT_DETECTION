
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class InsectListModel extends Equatable {
  final int? currentPage;
  final bool? hasNextPage;
  final int? size;
  final List<InsectModel>? insects;

  const InsectListModel({
    this.currentPage = 0,
    this.hasNextPage,
    this.size = 10,
    this.insects,
  });

  @override
  List<Object?> get props => [currentPage, hasNextPage, size, insects];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPage': currentPage,
      'hasNextPage': hasNextPage,
      'size': size,
      'insects': insects?.map((x) => x.toMap()).toList(),
    };
  }

  factory InsectListModel.fromMap(Map<String, dynamic> map) {
    return InsectListModel(
      currentPage:
          map['currentPage'] != null ? map['currentPage'] as int : null,
      hasNextPage:
          map['hasNextPage'] != null ? map['hasNextPage'] as bool : null,
      size: map['size'] != null ? map['size'] as int : null,
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
    bool? hasNextPage,
    int? size,
    List<InsectModel>? insects,
  }) {
    return InsectListModel(
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      size: size ?? this.size,
      insects: insects ?? this.insects,
    );
  }

  InsectList toEntity() => InsectList(
        currentPage: currentPage,
        hasNextPage: hasNextPage,
        size: size,
        insects: insects?.map<Insect>((model) => model.toEntity()).toList(),
      );

  @override
  bool get stringify => true;
}
