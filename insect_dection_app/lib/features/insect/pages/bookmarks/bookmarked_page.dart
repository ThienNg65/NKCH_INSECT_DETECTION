import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/injection_container.dart';

class BookmarkedInsectsPage extends StatefulWidget {
  const BookmarkedInsectsPage({super.key});
  static MaterialPageRoute<InsectPage> route(
    BuildContext context, {
    required UserBucketParams userBucketParams,
  }) {
    // final userBucketParams = UserBucketParams.fromEntity(
    //   BlocProvider.of<AuthBloc>(context).state.user,
    // );
    return MaterialPageRoute<InsectPage>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<BookmarkedInsectsBloc>.call()
              ..add(
                LoadBookmaredInsectsEvent(
                  userBucketParams: userBucketParams,
                ),
              ),
          ),
        ],
        child: const BookmarkedInsectsPage(),
      ),
    );
  }

  @override
  State<BookmarkedInsectsPage> createState() => _BookmarkedInsectsPageState();
}

class _BookmarkedInsectsPageState extends State<BookmarkedInsectsPage> {
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
      appBar: const CustomAppbar(),
      drawer: const MyDrawer(),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Library",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _bookmarkedInsectList(),
        ],
      ),
    );
  }

  Widget _bookmarkedInsectList() {
    return BlocBuilder<BookmarkedInsectsBloc, BookmarkedInsectsState>(
      buildWhen: (previous, current) =>
          (current.getBookmarkedInsectListProcess !=
              previous.getBookmarkedInsectListProcess),
      builder: (context, state) {
        if (state.getBookmarkedInsectListProcess == const Success()) {
          final insects = state.bookmarkedInsectList.insects;
          return Expanded(
            child: ListView.builder(
              itemCount: state.bookmarkedInsectList.insects.length,
              itemBuilder: (_, index) {
                final insect = insects[index];
                return InsectTile(
                  key: Key(
                    'booKmarkedInsectsPage_insectTile${insect.nomenclature.commonName}_listTile',
                  ),
                  insect: insect,
                  onTap: () => goToInsectPage(insect),
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
