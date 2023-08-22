// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Impacts extends Equatable {
  final String? benefits;
  final String? harms;

  const Impacts({
    this.benefits,
    this.harms,
  });

  @override
  List<Object?> get props => [
        benefits,
        harms,
      ];
}
