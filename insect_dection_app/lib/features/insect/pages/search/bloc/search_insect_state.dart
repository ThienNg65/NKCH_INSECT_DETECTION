// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'search_insect_bloc.dart';

class SearchInsectState extends Equatable {
  final bool isKeywordSearch;
  final bool isFirstLoad;
  final InsectList insectList;
  final InsectList searchResulList;

  final String filterAttribute;

  final Process getInsectByKeywordProcess;
  final Process getLoadInsectListProcess;

  const SearchInsectState({
    required this.isFirstLoad,
    required this.isKeywordSearch,
    required this.insectList,
    required this.searchResulList,
    required this.filterAttribute,
    required this.getInsectByKeywordProcess,
    required this.getLoadInsectListProcess,
  });

  factory SearchInsectState.initial() => SearchInsectState(
        isFirstLoad: true,
        isKeywordSearch: false,
        insectList: InsectList.empty,
        searchResulList: InsectList.empty,
        filterAttribute: NomenclatureName.commonName.attribute,
        getInsectByKeywordProcess: const Initial(),
        getLoadInsectListProcess: const Initial(),
      );
  @override
  List<Object> get props {
    return [
      isKeywordSearch,
      isFirstLoad,
      insectList,
      searchResulList,
      filterAttribute,
      getInsectByKeywordProcess,
      getLoadInsectListProcess,
    ];
  }

  SearchInsectState copyWith({
    bool? isKeywordSearch,
    bool? isFirstLoad,
    InsectList? insectList,
    InsectList? searchResulList,
    String? filterAttribute,
    Process? getInsectByKeywordProcess,
    Process? getLoadInsectListProcess,
  }) {
    return SearchInsectState(
      isKeywordSearch: isKeywordSearch ?? this.isKeywordSearch,
      isFirstLoad: isFirstLoad ?? this.isFirstLoad,
      insectList: insectList ?? this.insectList,
      searchResulList: searchResulList ?? this.searchResulList,
      filterAttribute: filterAttribute ?? this.filterAttribute,
      getInsectByKeywordProcess:
          getInsectByKeywordProcess ?? this.getInsectByKeywordProcess,
      getLoadInsectListProcess:
          getLoadInsectListProcess ?? this.getLoadInsectListProcess,
    );
  }
}
