import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

part 'insect_detail_event.dart';
part 'insect_detail_state.dart';

class InsectDetailBloc extends Bloc<InsectDetailEvent, InsectDetailState> {
  final GetInsectByModelId _getInsectByModelId;
  final AddBookmarkedInsect _addBookmarkedInsect;
  final RemoveBookmarkedInsect _removeBookmarkedInsect;
  final AddRecentlySearchInsect _addRecentlySearchInsect;
  final GetInsectBookmarkedState _getInsectBookmarkedState;

  InsectDetailBloc({
    required GetInsectByModelId getInsectByModelId,
    required AddBookmarkedInsect addBookmarkedInsect,
    required RemoveBookmarkedInsect removeBookmarkedInsect,
    required AddRecentlySearchInsect addRecentlySearchInsect,
    required GetInsectBookmarkedState getInsectBookmarkedState,
  })  : _getInsectByModelId = getInsectByModelId,
        _addBookmarkedInsect = addBookmarkedInsect,
        _removeBookmarkedInsect = removeBookmarkedInsect,
        _addRecentlySearchInsect = addRecentlySearchInsect,
        _getInsectBookmarkedState = getInsectBookmarkedState,
        super(InsectDetailState.initial()) {
    on<LoadInsectDetailEvent>(
      _onLoadInsectDetailEvent,
    );
    on<LoadUserInsectBookmarkStateProcessEvent>(
      _onLoadUserInsectBookmarkStateProcessEvent,
    );
    on<AddRecentlySearchInsectEvent>(
      _onAddRecentlySearchInsectEvent,
    );
    on<ToggleBookmarkedInsectEvent>(
      _onToggleBookmarkedInsectEvent,
    );
  }

  Future<void> _onLoadInsectDetailEvent(
      LoadInsectDetailEvent event, Emitter<InsectDetailState> emit) async {
    emit(
      state.copyWith(getDetailInsectProcess: const Loading()),
    );

    /// Load the user with id
    final result = await _getInsectByModelId(event.modelId);

    /// Handle result
    result.fold(
      (failure) {
        emit(state.copyWith(
          getDetailInsectProcess: Failed(failure.errorMessage ?? ''),
        ));
      },
      (insectDetail) {
        emit(
          state.copyWith(
            getDetailInsectProcess: const Success(),
            insect: insectDetail,
          ),
        );
      },
    );
  }

  Future<void> _onToggleBookmarkedInsectEvent(ToggleBookmarkedInsectEvent event,
      Emitter<InsectDetailState> emit) async {
    try {
      emit(state.copyWith(toggleBookmarkInsectProcess: const Loading()));

      late Either<Failure, Insect>? result;

      /// Check if current is false
      if (event.isBookmarked) {
        result = await _removeBookmarkedInsect(
          event.userBucketParams,
          InsectParams.fromEntity(event.insect),
        );
      } else {
        result = await _addBookmarkedInsect(
          event.userBucketParams,
          InsectParams.fromEntity(event.insect),
        );
      }
      result.fold(
        (failure) {
          emit(state.copyWith(
            toggleBookmarkInsectProcess: Failed(
              failure.errorMessage ?? '',
            ),
          ));
        },
        (insectDetail) {
          emit(state.copyWith(
            toggleBookmarkInsectProcess: const Success(),
            insect: insectDetail,
            isBookmarked: !event.isBookmarked,
          ));
        },
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onAddRecentlySearchInsectEvent(
      AddRecentlySearchInsectEvent event,
      Emitter<InsectDetailState> emit) async {
    try {
      emit(state.copyWith(addRecentlySearchInsectProcess: const Loading()));
      final result = await _addRecentlySearchInsect(
        event.userBucketParams,
        InsectParams.fromEntity(state.insect),
      );
      result.fold(
        (failure) {
          emit(state.copyWith(
            addRecentlySearchInsectProcess: Failed(failure.errorMessage ?? ''),
          ));
        },
        (entity) {
          emit(state.copyWith(
            addRecentlySearchInsectProcess: const Success(),
          ));
        },
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onLoadUserInsectBookmarkStateProcessEvent(
      LoadUserInsectBookmarkStateProcessEvent event,
      Emitter<InsectDetailState> emit) async {
    try {
      emit(state.copyWith(getUserInsectBookmarkStateProcess: const Loading()));

      /// Loading this insect was bookmared
      final bookmarkedResult = await _getInsectBookmarkedState(
        event.userBucketParams,
        event.modelId,
      );
      bookmarkedResult.fold(
        (Failure failure) => emit(
          state.copyWith(
            getUserInsectBookmarkStateProcess: Failed(
              failure.errorMessage,
            ),
            isBookmarked: state.isBookmarked,
          ),
        ),
        (bool isBookmarked) {
          emit(
            state.copyWith(
              getUserInsectBookmarkStateProcess: const Success(),
              isBookmarked: isBookmarked,
            ),
          );
        },
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
