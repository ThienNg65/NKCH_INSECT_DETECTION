// import 'package:camera/camera.dart';

// import 'package:flutter/material.dart';


// class CameraPage extends StatefulWidget {
//   const CameraPage({super.key});

//   @override
//   State<CameraPage> createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late CameraDescription cameraDescription;
//   // int _selectedIndex = 0;
//   // List<Widget>? _widgetOptions;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     initPages();
//   //   });
//   // }

//   // initPages() async {
//   //   // get list available camera
//   //   List<CameraDescription> availableCamera = await availableCameras();
//   //   cameraDescription = availableCamera.first;

//   //   setState(() {
//   //     _widgetOptions = <Widget>[
//   //       const GalleryScreen(),
//   //       CameraScreen(
//   //         camera: cameraDescription,
//   //       )
//   //     ];
//   //   });
//   // }

//   // void _onItemTapped(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       // appBar: AppBar(
//       //   title: const Text("Camera"),
//       //   backgroundColor: Colors.transparent,
//       //   elevation: 0,
//       // ),
//       body: const Center(
//         // child: _widgetOptions?.elementAt(_selectedIndex),
//         child: GalleryScreen(),
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   items: const <BottomNavigationBarItem>[
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.image),
//       //       label: 'Gallery screen',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.camera),
//       //       label: 'Live Camera',
//       //     ),
//       //   ],
//       //   currentIndex: _selectedIndex,
//       //   selectedItemColor: Colors.amber[800],
//       //   onTap: _onItemTapped,
//       // ),
//     );
//   }
// }
