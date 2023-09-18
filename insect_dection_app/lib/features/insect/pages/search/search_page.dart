import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
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
          BlocProvider.value(value: sl<SearchInsectBloc>.call()),
        ],
        child: const SearchPage(),
      ),
    );
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _toggleInsectPage(Insect insects) {
    Navigator.of(context).push(
      InsectPage.route(
        context,
        modelId: insects.modelId,
      ),
    );
  }

  void _toggleLoadMore() {
    BlocProvider.of<SearchInsectBloc>(context).add(
      LoadMoreLibraryInsectList(),
    );
  }

  @override
  void initState() {
    BlocProvider.of<SearchInsectBloc>(context).add(
      LoadInitalLibraryInsectList(),
    );
    super.initState();
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
              onChanged: (value) {
                BlocProvider.of<SearchInsectBloc>(context).add(
                  SearchInsectByKeyword(value),
                );
              }),
        ),
      ),
      drawer: const MyDrawer(),
      body: BlocBuilder<SearchInsectBloc, SearchInsectState>(
        builder: (context, state) {
          /// If the process is Loading then return loading wigget
          if (state.getInsectByKeywordProcess is Loading ||
              state.getLoadInsectListProcess is Loading) {
            return const LoadingWigget();
          }

          /// If the process is succes then return the list view of insect
          if (state.getInsectByKeywordProcess is Success ||
              state.getLoadInsectListProcess is Success) {
            /// Populate the list based on search mode or not
            final insects = state.isKeywordSearch
                ? state.searchResulList.insects
                : state.insectList.insects;

            /// Return the list view
            return ListView.builder(
              itemCount: insects.length + 1,
              itemBuilder: (context, index) {
                if (index == insects.length) {
                  if (state.isKeywordSearch == false) {
                    return ListTile(
                      title: const Center(child: Text("Show more")),
                      onTap: () => _toggleLoadMore(),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  final insect = insects[index];
                  return _insectSearchResultTile(insect, index);
                }
              },
            );
          } else {
            return const Text("Not found... ");
          }
        },
      ),
    );
  }

  Widget _insectSearchResultTile(Insect insect, int index) {
    return GestureDetector(
      onTap: () => _toggleInsectPage(insect),
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
          backgroundImage:
              insect.photoUrl.isNotEmpty ? NetworkImage(insect.photoUrl) : null,
        ),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
