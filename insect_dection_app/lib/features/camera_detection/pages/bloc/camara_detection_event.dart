// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'camara_detection_bloc.dart';

sealed class CamaraDetectionEvent {}

final class ProcessImageDetectionEvent extends CamaraDetectionEvent {
  final img_lib.Image insectImage;
  final String imagePath;

  ProcessImageDetectionEvent({
    required img_lib.Image imageData,
    required this.imagePath,
  }) : insectImage = imageData;
}
