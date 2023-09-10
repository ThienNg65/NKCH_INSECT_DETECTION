import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc({
    required GetBookmarkedInsectList getBookmarkedInsectList,
    required GetInitialInsectList getInitialInsectList,
    required GetRecentlySearchInsectList getRecentlySearchInsectList,
  })  : _getBookmarkedInsectList = getBookmarkedInsectList,
        _getInitialInsectList = getInitialInsectList,
        _getRecentlySearchInsectList = getRecentlySearchInsectList,
        super(HomePageState.initial()) {
    on<LoadRecentlyBookmarkedInsectListEvent>(
        _onLoadRecentlyBookmarkedInsectListEvent);
    on<LoadRecentlySearchInsectListEvent>(_onLoadRecentlySearchInsectListEvent);
    on<LoadInitialInsectListEvent>(_onLoadInitialInsectListEvent);
  }
  final GetBookmarkedInsectList _getBookmarkedInsectList;
  final GetInitialInsectList _getInitialInsectList;
  final GetRecentlySearchInsectList _getRecentlySearchInsectList;

  void onLoadInit(UserBucketParams userBucketParams) {
    add(LoadInitialInsectListEvent(insectListParams: InsectListParams.empty()));
    add(LoadRecentlySearchInsectListEvent(userBucketParams: userBucketParams));
    add(
      LoadRecentlyBookmarkedInsectListEvent(
        userBucketParams: userBucketParams,
        insectListParams: InsectListParams.empty(),
      ),
    );
  }

  Future<void> _onLoadRecentlyBookmarkedInsectListEvent(
      LoadRecentlyBookmarkedInsectListEvent event,
      Emitter<HomePageState> emit) async {
    emit(state.copyWith(getBookmarkedInsectListProcess: const Loading()));
    try {
      final result = await _getBookmarkedInsectList(event.userBucketParams);
      result.fold(
        (Failure failure) {
          emit(state.copyWith(
            getBookmarkedInsectListProcess: Failed(failure.errorMessage),
          ));
        },
        (InsectList insectList) {
          emit(
            state.copyWith(
              getBookmarkedInsectListProcess: const Success(),
              bookmarkedInsectList: insectList,
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onLoadRecentlySearchInsectListEvent(
      LoadRecentlySearchInsectListEvent event,
      Emitter<HomePageState> emit) async {
    emit(state.copyWith(getRecentlySearchInsectListProcess: const Loading()));
    try {
      final result = await _getRecentlySearchInsectList(
        event.userBucketParams,
        InsectListParams.empty(),
      );
      result?.fold(
        (Failure failure) {
          emit(state.copyWith(
            getRecentlySearchInsectListProcess: Failed(failure.errorMessage),
          ));
        },
        (InsectList insectList) {
          emit(
            state.copyWith(
              getRecentlySearchInsectListProcess: const Success(),
              recentlySearchInsectList: insectList,
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onLoadInitialInsectListEvent(
      LoadInitialInsectListEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(getInitialInsectListProcess: const Loading()));
    try {
      final result = await _getInitialInsectList(event.insectListParams);
      result.fold(
        (Failure failure) {
          emit(state.copyWith(
            getInitialInsectListProcess: Failed(failure.errorMessage),
          ));
        },
        (InsectList insectList) {
          emit(
            state.copyWith(
              getInitialInsectListProcess: const Success(),
              intialList: insectList,
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
