import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_event.dart';
import 'package:bloc/bloc.dart';

import 'page_n_bloc_state.dart';

class PageNumberBloc extends Bloc<PageNumberEvent, PageNumberState> {
  int pageNumber = 1;
  PageNumberBloc() : super(PageNumberState(1)) {
    on<addPageNumber>((event, emit) {
      emit(PageNumberState(++pageNumber));
    });
    on<minusPageNumber>((event, emit) {
      if (pageNumber == 1) {
        return;
      }
      emit(PageNumberState(--pageNumber));
    });
  }
}
