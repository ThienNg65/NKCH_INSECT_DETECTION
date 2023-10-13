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

final class SearchFilterAttributeChanged extends SearchInsectEvent {
  final String filterAttribute;
  SearchFilterAttributeChanged(this.filterAttribute);
}
