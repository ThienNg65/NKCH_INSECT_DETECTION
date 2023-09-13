import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/general/general.dart';

import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static MaterialPageRoute<HomePage> route(
    BuildContext context, {
    required UserBucketParams userBucketParams,
  }) {
    return MaterialPageRoute<HomePage>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<HomePageBloc>.call(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final userBucketParams = UserBucketParams.fromAuthUserInfo(
      BlocProvider.of<AuthBloc>(context).state.user,
    );
    BlocProvider.of<HomePageBloc>(context).onLoadInit(userBucketParams);
  }

  // to the RecentPage page
  void goToRecentSearchPage() {
    // go to the profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RecentSearchPage(),
      ),
    );
  }

  // user selected a insects, go to the insect page
  void goToInsectPage(Insect insects) {
    Navigator.of(context).push(
      InsectPage.route(
        context,
        modelId: insects.modelId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          _recentlySearchTitle(),
          _recentlySearchList(),
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
          Text(
            "Recently Search",
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 20,
              fontWeight: FontWeight.w500,
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
            child: const Text("See All"),
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
          final insects = state.recentlySearchInsectList.insects;
          return Expanded(
            key: const Key("homePage_RecentlySearchList_textRow"),
            child: ListView.builder(
              itemCount: insects.length,
              itemBuilder: (context, index) {
                //create a insect
                final insect = insects[index];
                return InsectTile(
                  key: Key(
                      "homePage_RecentlySearchTitle_insectTile${insect.modelId}_"),
                  insect: insect,
                  onTap: () => Navigator.of(context).push(
                    InsectPage.route(
                      context,
                      modelId: insect.modelId,
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
