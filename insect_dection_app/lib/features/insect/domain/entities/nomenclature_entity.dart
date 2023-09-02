// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Nomenclature extends Equatable {
  final String? commonName;
  final String? otherName;
  final String? scientificName;

  const Nomenclature({
    required this.commonName,
    required this.otherName,
    required this.scientificName,
  });

  static get empty => const Nomenclature(
        commonName: '',
        otherName: '',
        scientificName: '',
      );
  @override
  List<Object?> get props => [commonName, otherName, scientificName];

  Nomenclature copyWith({
    String? commonName,
    String? otherName,
    String? scientificName,
  }) {
    return Nomenclature(
      commonName: commonName ?? this.commonName,
      otherName: otherName ?? this.otherName,
      scientificName: scientificName ?? this.scientificName,
    );
  }
}
