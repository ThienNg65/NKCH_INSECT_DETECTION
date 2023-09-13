import 'dart:async';

import 'package:dartz/dartz.dart';
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
  })  : _getInitialInsectList = getInitialInsectList,
        _getInsectByKeyword = getInsectByKeyword,
        super(SearchInsectState.initial()) {
    on<SearchInsectByKeyword>(_onSearchInsectByKeyword);
  }

  final GetInitialInsectList _getInitialInsectList;
  final GetInsectByKeyword _getInsectByKeyword;

  Future<void> _onSearchInsectByKeyword(
      SearchInsectByKeyword event, Emitter<SearchInsectState> emit) async {
    try {
      final keyword = event.keyword.trim();
      late Either<Failure, InsectList> result;
      if (keyword.isEmpty) {
        result = await _getInitialInsectList(InsectListParams.empty());
      } else {
        result = await _getInsectByKeyword(keyword);
      }
      result.fold(
        (Failure failure) {
          if (failure is DataNotFoundFailure) {
            emit(state.copyWith(
              getInsectByKeywordProcess: const Success(),
              insectList: InsectList.empty(),
            ));
          } else {
            emit(state.copyWith(
              getInsectByKeywordProcess: Failed(failure.errorMessage),
            ));
          }
        },
        (InsectList insectList) {
          emit(
            state.copyWith(
              getInsectByKeywordProcess: const Success(),
              insectList: insectList,
            ),
          );
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
