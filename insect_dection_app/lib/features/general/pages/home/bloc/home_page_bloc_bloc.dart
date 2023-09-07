

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_bloc_event.dart';
part 'home_page_bloc_state.dart';

class HomePageBlocBloc extends Bloc<HomePageBlocEvent, HomePageBlocState> {
  HomePageBlocBloc() : super(HomePageBlocInitial()) {
    on<HomePageBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
