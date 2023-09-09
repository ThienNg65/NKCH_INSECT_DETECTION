import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/features.dart';

part 'bookmarked_insects_event.dart';
part 'bookmarked_insects_state.dart';

class BookmarkedInsectsBloc
    extends Bloc<BookmarkedInsectsEvent, BookmarkedInsectsState> {
  final GetBookmarkedInsectList _getBookmarkedInsectList;
  final RemoveBookmarkedInsect _removeBookmarkedInsect;
  BookmarkedInsectsBloc(
      {required GetBookmarkedInsectList getBookmarkedInsectList,
      required RemoveBookmarkedInsect removeBookmarkedInsect})
      : _getBookmarkedInsectList = getBookmarkedInsectList,
        _removeBookmarkedInsect = removeBookmarkedInsect,
        super(BookmarkedInsectsState.initial()) {
    on<LoadBookmaredInsectsEvent>(_onLoadBookmaredInsectsEvent);
    on<RemoveBookmarkedInsectEvent>(_onToggleBookmarkedInsectEvent);
  }

  Future<void> _onLoadBookmaredInsectsEvent(
    LoadBookmaredInsectsEvent event,
    Emitter<BookmarkedInsectsState> emit,
  ) async {
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

  Future<void> _onToggleBookmarkedInsectEvent(RemoveBookmarkedInsectEvent event,
      Emitter<BookmarkedInsectsState> emit) async {
    emit(state.copyWith(toggleBookmarkedInsectProcess: const Loading()));
    try {
      final result = await _removeBookmarkedInsect(
        event.userBucketParams,
        InsectParams.fromEntity(event.insect),
      );
      result.fold(
        (Failure failure) {
          emit(state.copyWith(
            toggleBookmarkedInsectProcess: Failed(failure.errorMessage),
          ));
        },
        (Insect insect) {
          /// Remove the insect unbookmarked
          final List<Insect> insects = state.bookmarkedInsectList.insects
            ..remove(insect);

          /// Emit the new list
          emit(
            state.copyWith(
              getBookmarkedInsectListProcess: const Success(),
              bookmarkedInsectList:
                  state.bookmarkedInsectList.copyWith(insects: insects),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
