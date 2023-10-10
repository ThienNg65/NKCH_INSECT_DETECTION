// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Impact extends Equatable {
  final String benefits;
  final String harms;

  const Impact({
    this.benefits = '',
    this.harms = '',
  });

  static get empty => const Impact(
        benefits: '',
        harms: '',
      );
  bool get isNotEmpty => !isEmpty;
  bool get isEmpty => this == Impact.empty;
  @override
  List<Object?> get props => [
        benefits,
        harms,
      ];

  Impact copyWith({
    String? benefits,
    String? harms,
  }) {
    return Impact(
      benefits: benefits ?? this.benefits,
      harms: harms ?? this.harms,
    );
  }
}
