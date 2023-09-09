part of 'search_insect_bloc.dart';

class SearchInsectState extends Equatable {
  final InsectList insectList;

  final Process getInsectByKeywordProcess;

  const SearchInsectState._internal({
    required this.insectList,
    required this.getInsectByKeywordProcess,
  });

  factory SearchInsectState.initial() => SearchInsectState._internal(
        insectList: InsectList.empty(),
        getInsectByKeywordProcess: const Initial(),
      );
  @override
  List<Object?> get props => [
        insectList,
        getInsectByKeywordProcess,
      ];

  SearchInsectState copyWith({
    InsectList? insectList,
    Process? getInsectByKeywordProcess,
  }) {
    return SearchInsectState._internal(
      insectList: insectList ?? this.insectList,
      getInsectByKeywordProcess:
          getInsectByKeywordProcess ?? this.getInsectByKeywordProcess,
    );
  }
}
