import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';

part 'insect_detail_event.dart';
part 'insect_detail_state.dart';

class InsectDetailBloc extends Bloc<InsectDetailEvent, InsectDetailState> {
  final GetInsectByModelId _getInsectByModelId;
  final AddBookmarkedInsect _addBookmarkedInsect;
  final AddRecentlySearchInsect _addRecentlySearchInsect;
  final GetInsectBookmarkedState _getInsectBookmarkedState;

  late UserBucketParams userBucketParams;

  InsectDetailBloc(
      {required GetInsectByModelId getInsectByModelId,
      required AddBookmarkedInsect addBookmarkedInsect,
      required AddRecentlySearchInsect addRecentlySearchInsect,
      required GetInsectBookmarkedState getInsectBookmarkedState})
      : _getInsectByModelId = getInsectByModelId,
        _addBookmarkedInsect = addBookmarkedInsect,
        _addRecentlySearchInsect = addRecentlySearchInsect,
        _getInsectBookmarkedState = getInsectBookmarkedState,
        super(InsectDetailState.initial()) {
    on<LoadInsectDetailEvent>(_onLoadInsectDetailEvent);
    on<ToggleBookmarkedInsectEvent>(_onToggleBookmarkedInsectEvent);
  }

  Future<void> _onLoadInsectDetailEvent(
      LoadInsectDetailEvent event, Emitter<InsectDetailState> emit) async {
    emit(state.copyWith(getDetailInsectProcess: Process.loading()));

    /// Load the user with id
    final result = await _getInsectByModelId(event.modelId);

    /// Handle result
    result.fold(
      (failure) {
        emit(state.copyWith(
          getDetailInsectProcess: Process.failed(failure.errorMessage ?? ''),
        ));
      },
      (insectDetail) async {
        final bookmarkedResult = await _getInsectBookmarkedState(
          userBucketParams,
          insectDetail.modelId,
        );
        emit(state.copyWith(
          getDetailInsectProcess: Process.success(),
          insect: insectDetail,
          isBookmarked: bookmarkedResult.fold(
            (Failure failure) => false,
            (bool isBookmarked) => isBookmarked,
          ),
        ));

        /// Add uer recently search
        unawaited(_onLoadCompleted(event, emit));
      },
    );
  }

  Future<void> _onToggleBookmarkedInsectEvent(ToggleBookmarkedInsectEvent event,
      Emitter<InsectDetailState> emit) async {
    emit(state.copyWith(toggleBookmarkInsectProcess: Process.loading()));
    final result = await _addBookmarkedInsect(
      userBucketParams,
      InsectParams.fromEntity(event.insect),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
          toggleBookmarkInsectProcess: Process.failed(
            failure.errorMessage ?? '',
          ),
        ));
      },
      (insectDetail) {
        emit(state.copyWith(
          toggleBookmarkInsectProcess: Process.success(),
          insect: insectDetail,
          isBookmarked: true,
        ));
      },
    );
  }

  Future<void> _onLoadCompleted(
      LoadInsectDetailEvent event, Emitter<InsectDetailState> emit) async {
    emit(state.copyWith(addRecentlySearchInsectProcess: Process.loading()));
    userBucketParams = event.userBucketParams;
    final result = await _addRecentlySearchInsect(
      userBucketParams,
      InsectParams.fromEntity(state.insect),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
            addRecentlySearchInsectProcess: Process.failed(
          failure.errorMessage ?? '',
        )));
      },
      (entity) {
        emit(state.copyWith(
          addRecentlySearchInsectProcess: Process.success(),
        ));
      },
    );
  }
}
