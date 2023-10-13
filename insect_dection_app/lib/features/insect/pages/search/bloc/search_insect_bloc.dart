import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

part 'search_insect_event.dart';
part 'search_insect_state.dart';

class SearchInsectBloc extends Bloc<SearchInsectEvent, SearchInsectState> {
  SearchInsectBloc({
    required GetInitialInsectList getInitialInsectList,
    required GetInsectByKeyword getInsectByKeyword,
    required GetMoreInsectList getMoreInsectList,
  })  : _getInitialInsectList = getInitialInsectList,
        _getInsectByKeyword = getInsectByKeyword,
        _getMoreInsectList = getMoreInsectList,
        super(SearchInsectState.initial()) {
    on<SearchInsectByKeyword>(_onSearchInsectByKeyword);
    on<LoadMoreLibraryInsectList>(_onLoadLibaryInsectList);
    on<ResetSearchResult>(_onResetSearchResult);
    on<LoadInitalLibraryInsectList>(_onLoadInitalLibraryInsectList);
    on<SearchFilterAttributeChanged>(_onSearchFilterAttributeChanged);
  }

  final GetInitialInsectList _getInitialInsectList;
  final GetInsectByKeyword _getInsectByKeyword;
  final GetMoreInsectList _getMoreInsectList;

  Future<void> _onSearchInsectByKeyword(
    SearchInsectByKeyword event,
    Emitter<SearchInsectState> emit,
  ) async {
    try {
      // initial search mode state
      emit(state.copyWith(
        isKeywordSearch: true,
        getLoadInsectListProcess: const Initial(),
        getInsectByKeywordProcess: const Loading(),
      ));

      /// Trim the search
      final keyword = event.keyword.trim();
      final insectListFilterParams = InsectListFilterParams(
        keyword: keyword,
        filterAttribute: state.filterAttribute,
      );
      final result = await _getInsectByKeyword(insectListFilterParams);

      /// Handle result
      result.fold(
        (Failure failure) {
          if (failure is DataNotFoundFailure) {
            emit(
              state.copyWith(
                getInsectByKeywordProcess: Failed(
                  "Couldn't find the insect name containing$keyword",
                ),
                searchResulList: InsectList.empty,
              ),
            );
          } else {
            emit(
              state.copyWith(
                getInsectByKeywordProcess: Failed(failure.errorMessage),
                searchResulList: InsectList.empty,
              ),
            );
          }
        },
        (InsectList searchResulList) {
          emit(
            state.copyWith(
              getInsectByKeywordProcess: const Success(),
              searchResulList: searchResulList,
            ),
          );
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> _onLoadLibaryInsectList(
    LoadMoreLibraryInsectList event,
    Emitter<SearchInsectState> emit,
  ) async {
    try {
      //
      emit(state.copyWith(
        isKeywordSearch: false,
        getInsectByKeywordProcess: const Initial(),
        getLoadInsectListProcess: const Loading(),
      ));

      final result = await _getMoreInsectList(
        InsectListParams.fromEntity(state.insectList),
      );

      result.fold(
        (Failure failure) {
          if (failure is DataNotFoundFailure) {
            emit(
              state.copyWith(
                getLoadInsectListProcess: const Success(),
                insectList: InsectList.empty,
              ),
            );
          } else {
            emit(
              state.copyWith(
                getLoadInsectListProcess: Failed(failure.errorMessage),
              ),
            );
          }
        },
        (InsectList insectList) {
          emit(
            state.copyWith(
              getLoadInsectListProcess: const Success(),
              insectList: insectList,
            ),
          );
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> _onResetSearchResult(
      ResetSearchResult event, Emitter<SearchInsectState> emit) async {
    emit(state.copyWith(
      getInsectByKeywordProcess: const Initial(),
      getLoadInsectListProcess: const Success(),
      isKeywordSearch: false,
    ));
  }

  Future<void> _onLoadInitalLibraryInsectList(LoadInitalLibraryInsectList event,
      Emitter<SearchInsectState> emit) async {
    try {
      // initial search mode state
      emit(state.copyWith(
        isKeywordSearch: false,
        getLoadInsectListProcess: const Loading(),
        getInsectByKeywordProcess: const Initial(),
      ));

      final result = await _getInitialInsectList(InsectListParams.empty);

      /// Handle result
      result.fold(
        (Failure failure) {
          emit(
            state.copyWith(
              getInsectByKeywordProcess: Failed(failure.errorMessage),
              searchResulList: InsectList.empty,
            ),
          );
        },
        (InsectList insectList) {
          emit(
            state.copyWith(
              getLoadInsectListProcess: const Success(),
              insectList: insectList,
              isFirstLoad: false,
            ),
          );
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> _onSearchFilterAttributeChanged(
    SearchFilterAttributeChanged event,
    Emitter<SearchInsectState> emit,
  ) async {
    emit(state.copyWith(filterAttribute: event.filterAttribute));
  }
}
