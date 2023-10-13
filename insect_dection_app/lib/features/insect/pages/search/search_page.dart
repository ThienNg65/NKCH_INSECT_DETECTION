// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/injection_container.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });
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
  void Function()? onPressed;
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

  void _toggleSearchValueChanged(String keyword) {
    if (keyword.isNotEmpty) {
      BlocProvider.of<SearchInsectBloc>(context).add(
        SearchInsectByKeyword(keyword),
      );
    } else {
      BlocProvider.of<SearchInsectBloc>(context).add(ResetSearchResult());
    }
  }

  void _toggleSearchFilterChanged(String filterAttribute) {
    BlocProvider.of<SearchInsectBloc>(context)
        .add(SearchFilterAttributeChanged(filterAttribute));
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
      appBar: const CustomAppbar(),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 25.0),
            child: CupertinoSearchTextField(
              padding: const EdgeInsets.all(15.0),
              backgroundColor: Colors.grey[100],
              onChanged: (value) => _toggleSearchValueChanged(value),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15.0),
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.grey[200],
            ),
            child: BlocBuilder<SearchInsectBloc, SearchInsectState>(
              buildWhen: (previous, current) =>
                  current.filterAttribute.
                  compareTo(previous.filterAttribute,) !=
                      0 ||
                  current.isFirstLoad == true,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text("Search for:"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // ignore: avoid_print
                              debugPrint(TaxonomicRank.family.attribute);
                              _toggleSearchFilterChanged(
                                TaxonomicRank.family.attribute,
                              );
                            },
                            icon: state.filterAttribute
                                    .contains(TaxonomicRank.family.attribute)
                                ? const Icon(Icons.radio_button_checked)
                                : const Icon(Icons.radio_button_off),
                          ),
                          const Text("Họ"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // ignore: avoid_print
                              debugPrint(
                                  "Search Filter:${TaxonomicRank.order.attribute}");
                              _toggleSearchFilterChanged(
                                TaxonomicRank.order.attribute,
                              );
                            },
                            icon: state.filterAttribute
                                    .contains(TaxonomicRank.order.attribute)
                                ? const Icon(Icons.radio_button_checked)
                                : const Icon(Icons.radio_button_off),
                          ),
                          const Text("Bộ"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // ignore: avoid_print
                              debugPrint(
                                  "Search Filter:${NomenclatureName.commonName.attribute}");
                              _toggleSearchFilterChanged(
                                NomenclatureName.commonName.attribute,
                              );
                            },
                            icon: state.filterAttribute.contains(
                                    NomenclatureName.commonName.attribute)
                                ? const Icon(Icons.radio_button_checked)
                                : const Icon(Icons.radio_button_off),
                          ),
                          const Text("Loài"),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchInsectBloc, SearchInsectState>(
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
                      ? state.searchResulList.currentPage
                      : [
                          ...state.insectList.previousPage,
                          ...state.insectList.currentPage,
                        ];

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
          ),
        ],
      ),
    );
  }

  Widget _insectSearchResultTile(Insect insect, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 1.0),
      child: GestureDetector(
        onTap: () => _toggleInsectPage(insect),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(12.0),
          ),
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
              backgroundImage: insect.photoUrl.isNotEmpty
                  ? NetworkImage(insect.photoUrl)
                  : null,
            ),
            trailing: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
