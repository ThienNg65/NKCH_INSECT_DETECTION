// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String? street;
  final String? country;
  final String? city;

  const Address({
    this.street = '',
    this.country = '',
    this.city = '',
  });
  @override
  List<Object?> get props => [
        street,
        city,
        country,
      ];

  Address copyWith({
    String? street,
    String? country,
    String? city,
  }) {
    return Address(
      street: street ?? this.street,
      country: country ?? this.country,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'country': country,
      'city': city,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      country: map['country'] ?? '',
      city: map['city'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  static Address get empty => const Address();
}
