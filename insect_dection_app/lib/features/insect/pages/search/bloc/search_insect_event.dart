part of 'search_insect_bloc.dart';

sealed class SearchInsectEvent {}

final class SearchInsectByKeyword extends SearchInsectEvent {
  final String keyword;

  SearchInsectByKeyword(this.keyword);
}
