// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'insect_detail_bloc.dart';

class InsectDetailState extends Equatable {
  // State values
  final Insect insect;
  final bool isBookmarked;

  // Process
  final Process getDetailInsectProcess;
  final Process getUserInsectBookmarkStateProcess;
  final Process addRecentlySearchInsectProcess;
  final Process toggleBookmarkInsectProcess;

  const InsectDetailState._internal({
    /// Data
    required this.insect,
    required this.isBookmarked,

    /// Process
    required this.getDetailInsectProcess,
    required this.getUserInsectBookmarkStateProcess,
    required this.toggleBookmarkInsectProcess,
    required this.addRecentlySearchInsectProcess,
  });
  factory InsectDetailState.initial() {
    return InsectDetailState._internal(
      insect: Insect.empty,
      isBookmarked: false,
      getDetailInsectProcess: const Initial(),
      getUserInsectBookmarkStateProcess: const Initial(),
      toggleBookmarkInsectProcess: const Initial(),
      addRecentlySearchInsectProcess: const Initial(),
    );
  }

  @override
  List<Object?> get props {
    return [
      insect,
      isBookmarked,
      getDetailInsectProcess,
      getUserInsectBookmarkStateProcess,
      toggleBookmarkInsectProcess,
      addRecentlySearchInsectProcess,
    ];
  }

  InsectDetailState copyWith({
    Insect? insect,
    bool? isBookmarked,
    Process? getDetailInsectProcess,
    Process? getUserInsectBookmarkStateProcess,
    Process? addRecentlySearchInsectProcess,
    Process? toggleBookmarkInsectProcess,
  }) {
    return InsectDetailState._internal(
      insect: insect ?? this.insect,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      getDetailInsectProcess:
          getDetailInsectProcess ?? this.getDetailInsectProcess,
      getUserInsectBookmarkStateProcess: getUserInsectBookmarkStateProcess ??
          this.getUserInsectBookmarkStateProcess,
      addRecentlySearchInsectProcess:
          addRecentlySearchInsectProcess ?? this.addRecentlySearchInsectProcess,
      toggleBookmarkInsectProcess:
          toggleBookmarkInsectProcess ?? this.toggleBookmarkInsectProcess,
    );
  }
}
