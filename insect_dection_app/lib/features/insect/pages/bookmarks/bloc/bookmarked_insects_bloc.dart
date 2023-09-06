import 'package:bloc/bloc.dart';
import 'package:insect_dection_app/features/features.dart';
import 'package:meta/meta.dart';

part 'bookmarked_insects_event.dart';
part 'bookmarked_insects_state.dart';

class BookmarkedInsectsBloc extends Bloc<BookmarkedInsectsEvent, BookmarkedInsectsState> {
  BookmarkedInsectsBloc() : super(BookmarkedInsectsInitial()) {
    on<BookmarkedInsectsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
