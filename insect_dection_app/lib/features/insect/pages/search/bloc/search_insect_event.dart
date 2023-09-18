part of 'search_insect_bloc.dart';

sealed class SearchInsectEvent {}

final class SearchInsectByKeyword extends SearchInsectEvent {
  final String keyword;

  SearchInsectByKeyword(this.keyword);
}

final class LoadMoreLibraryInsectList extends SearchInsectEvent {
  LoadMoreLibraryInsectList();
}

final class LoadInitalLibraryInsectList extends SearchInsectEvent {
  LoadInitalLibraryInsectList();
}

final class ResetSearchResult extends SearchInsectEvent {
  ResetSearchResult();
}
