import 'package:equatable/equatable.dart';

class Taxonomy extends Equatable {
  final String? species;
  final String? genus;
  final String? family;
  final String? order;
  final String? classic;
  final String? phylum;
  final String? regnum;

  const Taxonomy({
    required this.species,
    required this.genus,
    required this.family,
    required this.order,
    required this.classic,
    required this.phylum,
    required this.regnum,
  });

  @override
  List<Object?> get props {
    return [
      species,
      genus,
      family,
      order,
      classic,
      phylum,
      regnum,
    ];
  }

  static get empty => const Taxonomy(
        species: '',
        genus: '',
        family: '',
        order: '',
        classic: '',
        phylum: '',
        regnum: '',
      );

  Taxonomy copyWith({
    String? species,
    String? genus,
    String? family,
    String? order,
    String? classic,
    String? phylum,
    String? regnum,
  }) {
    return Taxonomy(
      species: species ?? this.species,
      genus: genus ?? this.genus,
      family: family ?? this.family,
      order: order ?? this.order,
      classic: classic ?? this.classic,
      phylum: phylum ?? this.phylum,
      regnum: regnum ?? this.regnum,
    );
  }
}
