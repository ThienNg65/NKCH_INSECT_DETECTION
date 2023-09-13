import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/features/insect/pages/recent_search/bloc/recently_detection_bloc.dart';
import 'package:insect_dection_app/injection_container.dart';

class RecentlyDetectedInsectsPage extends StatefulWidget {
  const RecentlyDetectedInsectsPage({super.key});
  static MaterialPageRoute<RecentlyDetectedInsectsPage> route(
    BuildContext context, {
    required UserBucketParams userBucketParams,
  }) {
    // final userBucketParams = UserBucketParams.fromEntity(
    //   BlocProvider.of<AuthBloc>(context).state.user,
    // );
    return MaterialPageRoute<RecentlyDetectedInsectsPage>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<RecentlyDetectionBloc>.call()
              ..add(
                LoadRecentlyDetectedInsectsEvent(
                  userBucketParams: userBucketParams,
                ),
              ),
          ),
        ],
        child: const RecentlyDetectedInsectsPage(),
      ),
    );
  }

  @override
  State<RecentlyDetectedInsectsPage> createState() =>
      _RecentlyDetectedInsectsPageState();
}

class _RecentlyDetectedInsectsPageState
    extends State<RecentlyDetectedInsectsPage> {
  // user selected a insects, go to the insect page
  void toggleInsectPage(Insect insects) {
    Navigator.of(context).push(
      InsectPage.route(
        context,
        modelId: insects.modelId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyDetectionBloc, RecentlyDetectedInsectsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppbar(),
          drawer: const MyDrawer(),
          backgroundColor: Colors.grey[300],
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recently Detections",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              _recentlyDetectedInsectList(),
            ],
          ),
        );
      },
    );
  }

  Widget _recentlyDetectedInsectList() {
    return BlocBuilder<RecentlyDetectionBloc, RecentlyDetectedInsectsState>(
      buildWhen: (previous, current) =>
          (current.getRecentlyDetectedInsectListProcess !=
              previous.getRecentlyDetectedInsectListProcess),
      builder: (context, state) {
        if (state.getRecentlyDetectedInsectListProcess == const Success()) {
          final insects = state.recentlyDetectedInsectList.insects;
          return Expanded(
            child: ListView.builder(
              itemCount: state.recentlyDetectedInsectList.insects.length,
              itemBuilder: (_, index) {
                final insect = insects[index];
                return InsectTile(
                  key: Key(
                    'recentlyDetectedInsectsPage_insectTile${insect.nomenclature.commonName}_listTile',
                  ),
                  insect: insect,
                  onTap: () => toggleInsectPage(insect),
                );
              },
            ),
          );
        } else {
          return const LoadingWigget();
        }
      },
    );
  }
}
