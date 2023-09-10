part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final InsectList recentlySearchInsectList;
  final InsectList bookmarkedInsectList;
  final InsectList intialList;

  final Process getBookmarkedInsectListProcess;
  final Process getRecentlySearchInsectListProcess;
  final Process getInitialInsectListProcess;
  const HomePageState._internal({
    required this.recentlySearchInsectList,
    required this.bookmarkedInsectList,
    required this.intialList,
    required this.getBookmarkedInsectListProcess,
    required this.getRecentlySearchInsectListProcess,
    required this.getInitialInsectListProcess,
  });

  factory HomePageState.initial() => HomePageState._internal(
        recentlySearchInsectList: InsectList.empty(),
        bookmarkedInsectList: InsectList.empty(),
        intialList: InsectList.empty(),
        getBookmarkedInsectListProcess: const Initial(),
        getRecentlySearchInsectListProcess: const Initial(),
        getInitialInsectListProcess: const Initial(),
      );

  HomePageState copyWith({
    InsectList? recentlySearchInsectList,
    InsectList? bookmarkedInsectList,
    InsectList? intialList,
    Process? getBookmarkedInsectListProcess,
    Process? getRecentlySearchInsectListProcess,
    Process? getInitialInsectListProcess,
  }) {
    return HomePageState._internal(
      recentlySearchInsectList:
          recentlySearchInsectList ?? this.recentlySearchInsectList,
      bookmarkedInsectList: bookmarkedInsectList ?? this.bookmarkedInsectList,
      intialList: intialList ?? this.intialList,
      getBookmarkedInsectListProcess:
          getBookmarkedInsectListProcess ?? this.getBookmarkedInsectListProcess,
      getRecentlySearchInsectListProcess: getRecentlySearchInsectListProcess ??
          this.getRecentlySearchInsectListProcess,
      getInitialInsectListProcess:
          getInitialInsectListProcess ?? this.getInitialInsectListProcess,
    );
  }

  @override
  List<Object> get props {
    return [
      recentlySearchInsectList,
      bookmarkedInsectList,
      intialList,
      getBookmarkedInsectListProcess,
      getRecentlySearchInsectListProcess,
      getInitialInsectListProcess,
    ];
  }
}
