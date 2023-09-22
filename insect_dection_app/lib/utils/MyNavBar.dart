import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../features/features.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int _selectIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void goToCameraPage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to the profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CameraPage(),
      ),
    );
  }

  // pages to display
  final List<Widget> _pages = [
    //Home Page
    const HomePage(key: Key("bottomNavBarPage_HomePage")),

    // Camera Page
    const CameraPage(key: Key("bottomNavBarPage_CamaraPage")),

    // Profile Page
    const UserProfilePage(key: Key("bottomNavBarPage_ProfilePage")),
  ];

  @override
  Widget build(BuildContext context) {
    return GNav(
      tabMargin: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.grey[400],
      activeColor: Colors.grey.shade700,
      tabActiveBorder: Border.all(color: Colors.white),
      tabBackgroundColor: Colors.grey.shade100,
      mainAxisAlignment: MainAxisAlignment.center,
      tabBorderRadius: 16,
      gap: 8,
      // onTabChange: (value) => widget.onTabChange!(value),
      onTabChange: (index) => navigateBottomBar(index),
      tabs: [
        GButton(
          icon: Icons.home,
          text: 'Home',
        ),
        GButton(
          icon: Icons.camera_alt_rounded,
          text: 'Camera',
          // onPressed: () => {
          //   goToCameraPage(),
          // },
        ),
        GButton(
          icon: Icons.person,
          text: 'Profile',
        )
      ],
    );
  }
}
