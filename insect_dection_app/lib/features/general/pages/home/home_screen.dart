import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/general/general.dart';

import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static MaterialPageRoute<HomeScreen> route(
    BuildContext context, {
    required UserBucketParams userBucketParams,
  }) {
    return MaterialPageRoute<HomeScreen>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<HomePageBloc>.call(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final userBucketParams = UserBucketParams.fromAuthUserInfo(
      BlocProvider.of<AuthBloc>(context).state.user,
    );
    BlocProvider.of<HomePageBloc>(context).onLoadInit(userBucketParams);
    super.initState();
  }

  // to the RecentPage page
  void goToRecentSearchPage() {
    final AuthUserInfo userInfo = BlocProvider.of<AuthBloc>(context).state.user;

    // go to the profile page
    Navigator.of(context).push(
      RecentlyDetectedInsectsPage.route(
        context,
        userBucketParams: UserBucketParams.fromAuthUserInfo(userInfo),
      ),
    );
  }

  // user selected a insects, go to the insect page
  void toggleInsectPage(Insect insect) {
    Navigator.of(context).push(
      InsectPage.route(
        context,
        modelId: insect.modelId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _recentlySearchTitle(),
          Expanded(
            child: _recentlySearchList(),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0, left: 25.0, right: 25.0),
            child: Divider(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentlySearchTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
      child: Row(
        key: const Key("homePage_RecentlySearchTitle_textRow"),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              // "Recently Search",
              "Đã tra cứu gần đây",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () => goToRecentSearchPage(),
            // child: const Text("See All"),
            child: const Text("Xem tất cả"),
          ),
        ],
      ),
    );
  }

  Widget _recentlySearchList() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state.getRecentlySearchInsectListProcess is Loading ||
            state.getRecentlySearchInsectListProcess is Initial) {
          return const LoadingWigget();
        } else {
          final insects = state.recentlySearchInsectList.currentPage;
          return ListView.builder(
            key: const Key("homePage_RecentlySearchList_textRow"),
            shrinkWrap: true,
            itemCount: insects.length,
            itemBuilder: (context, index) {
              //create a insect
              final insect = insects[index];
              return InsectTile(
                key: Key(
                    "homePage_RecentlySearchTitle_insectTile${insect.modelId}_"),
                insect: insect,
                onTap: () => toggleInsectPage(insect),
              );
            },
          );
        }
      },
    );
  }
}
