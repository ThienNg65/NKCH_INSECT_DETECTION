import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/features/insect/pages/search/search.dart';
import 'package:insect_dection_app/injection_container.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static MaterialPageRoute<SearchPage> route(BuildContext context) {
    // final userBucketParams = UserBucketParams.fromEntity(
    //   BlocProvider.of<AuthBloc>(context).state.user,
    // );
    return MaterialPageRoute<SearchPage>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<SearchInsectBloc>.call()
              ..add(
                SearchInsectByKeyword(''),
              ),
          ),
        ],
        child: const BookmarkedInsectsPage(),
      ),
    );
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // final currentUser = FirebaseAuth.instance.currentUser!;

  // final TextEditingController _searchController = TextEditingController();

  // @override
  // void initState() {
  //   // _searchController.addListener(_onSearchChanged);
  //   super.initState();
  // }

  // _onSearchChanged() {
  //   debugPrint(_searchController.text);

  // }

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
      appBar: CustomAppbar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CupertinoSearchTextField(
            backgroundColor: Colors.grey[200],
            // controller: _searchController,
            onChanged: (value) => BlocProvider.of<SearchInsectBloc>(context)
              ..add(
                SearchInsectByKeyword(value),
              ),
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: _searchInsectBody(),
    );
  }

  Widget _searchInsectBody() {
    return BlocBuilder<SearchInsectBloc, SearchInsectState>(
      builder: (context, state) {
        if (state.getInsectByKeywordProcess == const Loading()) {
          return const LoadingWigget();
        } else {
          if (state.getInsectByKeywordProcess == const Success() &&
              state.insectList.insects.isNotEmpty) {
            final insects = state.insectList.insects;
            return ListView.builder(
              itemCount: insects.length,
              itemBuilder: (context, index) {
                final insect = insects[index];
                return _insectSearchResultTile(insect, index);
              },
            );
          } else {
            return const Text("Not found... ");
          }
        }
      },
    );
  }

  Widget _insectSearchResultTile(Insect insect, int index) {
    return GestureDetector(
      onTap: () => goToInsectPage(insect),
      child: ListTile(
        key: Key(
          'searchPage_insectResult${insect.nomenclature.commonName}_$index',
        ),
        title: Text(insect.nomenclature.commonName),
        subtitle: Text(
            '${insect.nomenclature.scientificName}  ${insect.nomenclature.otherName}'),
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 35,
          backgroundImage: NetworkImage(insect.photoUrl),
        ),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
