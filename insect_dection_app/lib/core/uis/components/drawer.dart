import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // Sign Out
  Future<void> signOut() async {
    // pop menu drawer
    Navigator.pop(context);
    BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
  }

  // to the Search page
  void goToSearchPage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to the profile page
    Navigator.of(context).push(
      SearchPage.route(
        context,
      ),
    );
  }

  // to the RecentPage page
  void goToRecentSearchPage() {
    final AuthUserInfo userInfo = BlocProvider.of<AuthBloc>(context).state.user;

    // pop menu drawer
    Navigator.pop(context);

    // go to the profile page
    Navigator.of(context).push(
      RecentlyDetectedInsectsPage.route(
        context,
        userBucketParams: UserBucketParams.fromAuthUserInfo(userInfo),
      ),
    );
  }

  // to the Bookmared page
  void goToBookmarkedPage() {
    // go to the profile page
    Navigator.pop(context);

    Navigator.of(context).push(
      BookmarkedInsectsPage.route(context),
    );
  }

  // to the Camera page
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

  // to the Home page
  void goToHomePage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to the profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyBottomNavBar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: DrawerHeader(
                  child: Icon(
                    Icons.bug_report_rounded,
                    color: Colors.white,
                    size: 65,
                  ),
                ),
              ),

              /// Home
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: MyListTile(
                  icon: Icons.home_filled,
                  text: 'Home',
                  onTap: goToHomePage,
                ),
              ),

              // Search
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: MyListTile(
                  icon: Icons.search_rounded,
                  text: 'Search',
                  onTap: goToSearchPage,
                ),
              ),

              // Recently Search
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: MyListTile(
                  icon: Icons.manage_search_rounded,
                  text: 'Recently Search',
                  onTap: goToRecentSearchPage,
                ),
              ),

              // Library
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: MyListTile(
                  icon: Icons.star,
                  text: 'Favourite',
                  onTap: goToBookmarkedPage,
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 25.0),
              //   child: MyListTile(
              //     icon: Icons.camera_alt_outlined,
              //     text: 'Camera',
              //     onTap: goToCameraPage,
              //   ),
              // ),
            ],
          ),

          // SIGN OUT
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'Log Out',
              onTap: signOut,
            ),
          )
        ],
      ),
    );
  }
}
