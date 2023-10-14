// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'insect_detail_bloc.dart';

class InsectDetailState extends Equatable {
  // State values
  final Insect insect;
  final bool isBookmarked;

  final InsectList insectListInOrderRank;
  final InsectList insectListInFamiliaRank;

  // Process
  final Process getDetailInsectProcess;
  final Process getUserInsectBookmarkStateProcess;
  final Process addRecentlySearchInsectProcess;
  final Process toggleBookmarkInsectProcess;
  final Process getInsectsByFamiliaRankProcess;
  final Process getInsectsByOrdoRankProcess;

  const InsectDetailState._internal({
    /// Data
    required this.insect,
    required this.isBookmarked,
    required this.insectListInOrderRank,
    required this.insectListInFamiliaRank,

    /// Process
    required this.getDetailInsectProcess,
    required this.getUserInsectBookmarkStateProcess,
    required this.toggleBookmarkInsectProcess,
    required this.addRecentlySearchInsectProcess,
    required this.getInsectsByFamiliaRankProcess,
    required this.getInsectsByOrdoRankProcess,
  });
  factory InsectDetailState.initial() {
    return InsectDetailState._internal(
      insect: Insect.empty,
      isBookmarked: false,
      insectListInOrderRank: InsectList.empty,
      insectListInFamiliaRank: InsectList.empty,
      getDetailInsectProcess: const Initial(),
      getUserInsectBookmarkStateProcess: const Initial(),
      toggleBookmarkInsectProcess: const Initial(),
      addRecentlySearchInsectProcess: const Initial(),
      getInsectsByFamiliaRankProcess: const Initial(),
      getInsectsByOrdoRankProcess: const Initial(),
    );
  }

  @override
  List<Object> get props {
    return [
      insect,
      isBookmarked,
      insectListInOrderRank,
      insectListInFamiliaRank,
      getDetailInsectProcess,
      getUserInsectBookmarkStateProcess,
      toggleBookmarkInsectProcess,
      addRecentlySearchInsectProcess,
      getInsectsByFamiliaRankProcess,
      getInsectsByOrdoRankProcess,
    ];
  }

  InsectDetailState copyWith({
    Insect? insect,
    bool? isBookmarked,
    InsectList? insectListInOrderRank,
    InsectList? insectListInFamiliaRank,
    Process? getDetailInsectProcess,
    Process? getUserInsectBookmarkStateProcess,
    Process? addRecentlySearchInsectProcess,
    Process? toggleBookmarkInsectProcess,
    Process? getInsectsByFamiliaRankProcess,
    Process? getInsectsByOrdoRankProcess,
  }) {
    return InsectDetailState._internal(
      insect: insect ?? this.insect,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      insectListInOrderRank:
          insectListInOrderRank ?? this.insectListInOrderRank,
      insectListInFamiliaRank:
          insectListInFamiliaRank ?? this.insectListInFamiliaRank,
      getDetailInsectProcess:
          getDetailInsectProcess ?? this.getDetailInsectProcess,
      getUserInsectBookmarkStateProcess: getUserInsectBookmarkStateProcess ??
          this.getUserInsectBookmarkStateProcess,
      addRecentlySearchInsectProcess:
          addRecentlySearchInsectProcess ?? this.addRecentlySearchInsectProcess,
      toggleBookmarkInsectProcess:
          toggleBookmarkInsectProcess ?? this.toggleBookmarkInsectProcess,
      getInsectsByFamiliaRankProcess:
          getInsectsByFamiliaRankProcess ?? this.getInsectsByFamiliaRankProcess,
      getInsectsByOrdoRankProcess:
          getInsectsByOrdoRankProcess ?? this.getInsectsByOrdoRankProcess,
    );
  }
}
