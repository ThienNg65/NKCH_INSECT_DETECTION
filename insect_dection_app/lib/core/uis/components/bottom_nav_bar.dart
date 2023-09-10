import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:insect_dection_app/features/general/pages/home/bloc/home_page_bloc.dart';
import 'package:insect_dection_app/injection_container.dart' as di;

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
    // Camera Page
    BlocProvider<HomePageBloc>.value(
      value: di.sl<HomePageBloc>(),
      child: const HomePage(),
    ),

    // Camera Page
    const CameraPage(),

    // Profile Page
    BlocProvider<UserProfileBloc>.value(
      value: di.sl<UserProfileBloc>(),
      child: const ProfilePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            text: 'Camera',
          ),
          GButton(
            icon: Icons.camera_alt_rounded,
            text: 'Camera',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          )
        ],
      ),
      appBar: const CustomAppbar(),
      drawer: const MyDrawer(),
      body: _pages[_selectIndex],
    );
  }
}
