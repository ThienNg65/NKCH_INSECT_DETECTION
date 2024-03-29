import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

class MyBottomNavBar extends StatefulWidget {
  // void Function(int)? onTabChange;

  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  // Sign Out
  Future<void> signOut() async {
    BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
  }

  // this selected index is to control the bottom nav bar
  int _selectIndex = 0;

  // Update our selected index when the user tap on the bottom bar
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
    // ignore: prefer_const_constructors
    HomePage(key: Key("bottomNavBarPage_HomePage")),

    // Camera Page
    // ignore: prefer_const_constructors
    CameraPage(key: Key("bottomNavBarPage_CamaraPage")),

    // Profile Page
    // ignore: prefer_const_constructors
    UserProfilePage(key: Key("bottomNavBarPage_ProfilePage")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      drawer: const MyDrawer(),
      body: _pages[_selectIndex],
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: GNav(
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
        tabs: const [
          GButton(
            icon: Icons.home,
            // text: 'Home',
            text: 'Trang chủ',
          ),
          GButton(
            icon: Icons.camera_alt_rounded,
            text: 'Camera',
          ),
          GButton(
            icon: Icons.person,
            // text: 'Profile',
            text: 'Tài khoản',
          )
        ],
      ),
    );
  }
}
