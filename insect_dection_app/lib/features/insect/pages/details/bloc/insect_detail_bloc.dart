// ignore_for_file: constant_identifier_names

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
  final GetInsectsByTaxnomyRank _getInsectsByTaxnomyRank;

  InsectDetailBloc({
    required GetInsectByModelId getInsectByModelId,
    required AddBookmarkedInsect addBookmarkedInsect,
    required RemoveBookmarkedInsect removeBookmarkedInsect,
    required AddRecentlySearchInsect addRecentlySearchInsect,
    required GetInsectBookmarkedState getInsectBookmarkedState,
    required GetInsectsByTaxnomyRank getInsectsByTaxnomyRank,
  })  : _getInsectByModelId = getInsectByModelId,
        _addBookmarkedInsect = addBookmarkedInsect,
        _removeBookmarkedInsect = removeBookmarkedInsect,
        _addRecentlySearchInsect = addRecentlySearchInsect,
        _getInsectBookmarkedState = getInsectBookmarkedState,
        _getInsectsByTaxnomyRank = getInsectsByTaxnomyRank,
        super(InsectDetailState.initial()) {
    on<LoadInsectDetailEvent>(
      _onLoadInsectDetailEvent,
    );
    on<LoadUserInsectBookmarkStateEvent>(
      _onLoadUserInsectBookmarkStateProcessEvent,
    );
    on<AddRecentlySearchInsectEvent>(
      _onAddRecentlySearchInsectEvent,
    );
    on<ToggleBookmarkedInsectEvent>(
      _onToggleBookmarkedInsectEvent,
    );
    on<LoadInsectListInSameFamiliaRankEvent>(
      _onLoadInsectListInSameFamilaRankEvent,
    );
    on<LoadInsectListInSameOrdoRankEvent>(
      _onLoadInsectListInSameOrdoRankEvent,
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
      LoadUserInsectBookmarkStateEvent event,
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

  Future<void> _onLoadInsectListInSameFamilaRankEvent(
    LoadInsectListInSameFamiliaRankEvent event,
    Emitter<InsectDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(
        getInsectsByFamiliaRankProcess: const Loading(),
      ));
      InsectListFilterParams insectListFilterParams = InsectListFilterParams(
        filterAttribute: TaxnomyName.Familia.name,
        keyword: event.insect.taxonomy.family!,
      );

      /// Loading this after insect was loaded
      final familiaListResult = await _getInsectsByTaxnomyRank(
        insectListFilterParams,
      );
      familiaListResult.fold(
        (Failure failure) => emit(
          state.copyWith(
            getUserInsectBookmarkStateProcess: Failed(
              failure.errorMessage,
            ),
            isBookmarked: state.isBookmarked,
          ),
        ),
        (InsectList insectList) {
          emit(
            state.copyWith(
              getUserInsectBookmarkStateProcess: const Success(),
              insectListInOrderRank: insectList,
            ),
          );
        },
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onLoadInsectListInSameOrdoRankEvent(
    LoadInsectListInSameOrdoRankEvent event,
    Emitter<InsectDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(
        getInsectsByFamiliaRankProcess: const Loading(),
      ));
      InsectListFilterParams insectListFilterParams = InsectListFilterParams(
        filterAttribute: TaxnomyName.Ordo.name,
        keyword: event.insect.taxonomy.order!,
      );

      /// Loading this after insect was loaded
      final ordoListResult = await _getInsectsByTaxnomyRank(
        insectListFilterParams,
      );
      ordoListResult.fold(
        (Failure failure) => emit(
          state.copyWith(
            getUserInsectBookmarkStateProcess: Failed(
              failure.errorMessage,
            ),
            isBookmarked: state.isBookmarked,
          ),
        ),
        (InsectList insectList) {
          emit(
            state.copyWith(
              getUserInsectBookmarkStateProcess: const Success(),
              insectListInOrderRank: insectList,
            ),
          );
        },
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}

enum TaxnomyName { Ordo, Familia }
