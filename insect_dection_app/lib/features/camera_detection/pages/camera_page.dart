import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/features/camera_detection/camera_detection.dart';
import 'package:insect_dection_app/injection_container.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraDescription cameraDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: BlocProvider.value(
          value: sl<CamaraDetectionBloc>.call(),
          child: const CamaraFormScreen(),
        ),
      ),
    );
  }
}
