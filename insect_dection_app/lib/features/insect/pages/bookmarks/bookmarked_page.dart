import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/injection_container.dart';

class BookmarkedInsectsPage extends StatefulWidget {
  const BookmarkedInsectsPage({super.key});
  static MaterialPageRoute<BookmarkedInsectsPage> route(
    BuildContext context,
  ) {
    return MaterialPageRoute<BookmarkedInsectsPage>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: sl<BookmarkedInsectsBloc>.call()),
        ],
        child: const BookmarkedInsectsPage(),
      ),
    );
  }

  @override
  State<BookmarkedInsectsPage> createState() => _BookmarkedInsectsPageState();
}

class _BookmarkedInsectsPageState extends State<BookmarkedInsectsPage> {
  @override
  void initState() {
    final userBucketParams = UserBucketParams.fromAuthUserInfo(
      BlocProvider.of<AuthBloc>(context).state.user,
    );
    BlocProvider.of<BookmarkedInsectsBloc>(context).add(
      LoadBookmaredInsectsEvent(userBucketParams: userBucketParams),
    );
    super.initState();
  }

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
                  "Danh sách yêu thích",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _BookmarkedInsectList(),
        ],
      ),
    );
  }
}

class _BookmarkedInsectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkedInsectsBloc, BookmarkedInsectsState>(
      buildWhen: (previous, current) =>
          (current.getBookmarkedInsectListProcess !=
              previous.getBookmarkedInsectListProcess),
      builder: (context, state) {
        if (state.getBookmarkedInsectListProcess == const Success()) {
          final insects = state.bookmarkedInsectList.currentPage;
          return Expanded(
            child: ListView.builder(
              itemCount: state.bookmarkedInsectList.currentPage.length,
              itemBuilder: (_, index) {
                final insect = insects[index];
                return InsectTile(
                  key: Key(
                    'bookmarkedInsectsPage_insectTile${insect.nomenclature.commonName}_listTile',
                  ),
                  insect: insect,
                  onTap: () {
                    Navigator.of(context).push(
                      InsectPage.route(
                        context,
                        modelId: insect.modelId,
                      ),
                    );
                  },
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
