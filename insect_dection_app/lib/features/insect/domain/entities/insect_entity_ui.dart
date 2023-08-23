// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UIInsects extends Equatable {
  final String name;
  final String image;
  final String description;
  final int? timestamp;

  const UIInsects({
    required this.name,
    required this.image,
    required this.description,
    this.timestamp,
  });

  @override
  List<Object?> get props => [name, image, description, timestamp];
}
