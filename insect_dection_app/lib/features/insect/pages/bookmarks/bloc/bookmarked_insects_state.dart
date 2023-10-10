// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bookmarked_insects_bloc.dart';

class BookmarkedInsectsState extends Equatable {
  /// State Values
  final InsectList bookmarkedInsectList;

  /// State Process
  final Process getBookmarkedInsectListProcess;
  final Process toggleBookmarkedInsectProcess;

  const BookmarkedInsectsState._internal({
    required this.bookmarkedInsectList,
    required this.getBookmarkedInsectListProcess,
    required this.toggleBookmarkedInsectProcess,
  });
  factory BookmarkedInsectsState.initial() {
    return BookmarkedInsectsState._internal(
      getBookmarkedInsectListProcess: const Initial(),
      toggleBookmarkedInsectProcess: const Initial(),
      bookmarkedInsectList: InsectList.empty,
    );
  }

  @override
  List<Object> get props => [
        bookmarkedInsectList,
        getBookmarkedInsectListProcess,
        toggleBookmarkedInsectProcess,
      ];

  BookmarkedInsectsState copyWith({
    InsectList? bookmarkedInsectList,
    Process? getBookmarkedInsectListProcess,
    Process? toggleBookmarkedInsectProcess,
  }) {
    return BookmarkedInsectsState._internal(
      bookmarkedInsectList: bookmarkedInsectList ?? this.bookmarkedInsectList,
      getBookmarkedInsectListProcess:
          getBookmarkedInsectListProcess ?? this.getBookmarkedInsectListProcess,
      toggleBookmarkedInsectProcess:
          toggleBookmarkedInsectProcess ?? this.toggleBookmarkedInsectProcess,
    );
  }
}
