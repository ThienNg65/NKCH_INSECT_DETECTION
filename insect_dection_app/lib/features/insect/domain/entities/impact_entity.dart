// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Impact extends Equatable {
  final String? benefits;
  final String? harms;

  const Impact({
    this.benefits,
    this.harms,
  });

  static get empty => const Impact(
        benefits: '',
        harms: '',
      );
  @override
  List<Object?> get props => [
        benefits,
        harms,
      ];
}
