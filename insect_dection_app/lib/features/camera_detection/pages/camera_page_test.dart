import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/camera_detection/camera_detection.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

class CamaraFormScreen extends StatefulWidget {
  const CamaraFormScreen({super.key});

  @override
  State<CamaraFormScreen> createState() => _CamaraFormScreenState();
}

class _CamaraFormScreenState extends State<CamaraFormScreen> {
  final imagePicker = ImagePicker();

  // Process picked image
  Future<void> processImage(String? imagePath) async {
    if (imagePath != null) {
      // Read image bytes from file
      final imageData = File(imagePath).readAsBytesSync();

      // Decode image using package:image/image.dart (https://pub.dev/image)
      final image = img.decodeImage(imageData)!;

      BlocProvider.of<CamaraDetectionBloc>(context)
          .add(ProcessImageDetectionEvent(
        imageData: image,
        imagePath: imagePath,
      ));
    }
  }

  @override
  void dispose() {
    BlocProvider.of<CamaraDetectionBloc>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CamaraDetectionBloc, CamaraDetectionState>(
      listener: (_, state) {
        if (state.insectDetectionProcess is Success) {
          final AuthUserInfo userInfo =
              BlocProvider.of<AuthBloc>(context).state.user;
          final modelId =
              state.detectionResultList.detectionResults.first.modelId;
          BlocProvider.of<CamaraDetectionBloc>(context).add(
            AddRecentlyDetectedInsectEvent(
              modelId: modelId,
              userBucketParams: UserBucketParams.fromAuthUserInfo(userInfo),
            ),
          );
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  key:
                      const Key('detectionPage_takePhotoFromCamara_textButton'),
                  onPressed: () async {
                    // Take image from camera

                    final result = await imagePicker.pickImage(
                      source: ImageSource.camera,
                    );
                    processImage(result?.path);
                  },
                  icon: const Icon(
                    Icons.camera,
                    size: 48,
                    color: Colors.black54,
                  ),
                  label: const Text("Take a photo"),
                ),
                TextButton.icon(
                  key: const Key('detectionPage_takePhotoFromP_textButton'),
                  onPressed: () async {
                    // Take image from CamaraForm
                    final result = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    processImage(result?.path);
                  },
                  icon: const Icon(
                    Icons.photo,
                    size: 48,
                    color: Colors.black54,
                  ),
                  label: const Text("Pick from CamaraForm"),
                ),
              ],
            ),
            const Divider(color: Colors.black),
            _selectedImageView(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SingleChildScrollView(
                    child: _detectionResultListName(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedImageView() {
    return BlocBuilder<CamaraDetectionBloc, CamaraDetectionState>(
      builder: (context, state) {
        if (state == CamaraDetectionState.initial()) {
          return const Center(
            child: Text(
              "Take a photo or choose one from the CamaraForm to inference.",
            ),
          );
        } else {
          if (state.imagePath != null && state.imagePath!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Image.file(File(state.imagePath!)),
            );
          } else {
            return const Spacer();
          }
        }
      },
    );
  }

  Widget _detectionResultListName() {
    return BlocBuilder<CamaraDetectionBloc, CamaraDetectionState>(
      builder: (context, state) {
        if (state.insectDetectionProcess is Success) {
          final results = state.detectionResultList.detectionResults;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.detectionResultList.detectionResults.length,
            itemBuilder: (_, index) {
              final result = results[index];
              return Card(
                child: ListTile(
                  dense: true,
                  title: Text(result.labelName),
                  subtitle: Text(result.score.toStringAsFixed(2)),
                  trailing: const Icon(
                    Icons.arrow_forward_sharp,
                  ),
                  onTap: () {
                    toggleInsectPage(context, result);
                  },
                ),
              );
            },
          );
        } else {
          if (state.detectionResultList is Failed) {
            return Center(child: Text(state.message ?? ''));
          } else {
            if (state.detectionResultList is Loading) {
              return const LoadingWigget();
            } else {
              return Container();
            }
          }
        }
      },
    );
  }

  void toggleInsectPage(BuildContext context, DetectionResult result) {
    Navigator.of(context).push(
      InsectPage.route(
        context,
        modelId: result.modelId,
      ),
    );
  }
}
