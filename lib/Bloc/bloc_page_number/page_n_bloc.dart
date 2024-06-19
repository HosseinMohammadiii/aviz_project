import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_event.dart';
import 'package:bloc/bloc.dart';

import 'page_n_bloc_state.dart';

class NavigationPage extends Cubit<NavigationState> {
  NavigationPage() : super(NavigationState(ViewPage.category));

  void getNavItems(ViewPage item) {
    switch (item) {
      case ViewPage.category:
        emit(NavigationState(ViewPage.category));
        break;

      case ViewPage.itemsRentHome:
        emit(NavigationState(ViewPage.itemsRentHome));
        break;

      case ViewPage.itemsBuyHome:
        emit(NavigationState(ViewPage.itemsBuyHome));
        break;

      case ViewPage.itemsRentBusinessPlace:
        emit(NavigationState(ViewPage.itemsRentBusinessPlace));
        break;

      case ViewPage.itemsBuyBusinessPlace:
        emit(NavigationState(ViewPage.itemsBuyBusinessPlace));
        break;

      case ViewPage.registerHomeLocation:
        emit(NavigationState(ViewPage.registerHomeLocation));
        break;

      case ViewPage.registerDetialsBuyHomeAdvertising:
        emit(NavigationState(ViewPage.registerDetialsBuyHomeAdvertising));
        break;

      case ViewPage.registerDetialsRentHomeAdvertising:
        emit(NavigationState(ViewPage.registerDetialsRentHomeAdvertising));
        break;

      // case ViewPage.registerDetialsRentBusinessAdvertising:
      //   emit(NavigationState(ViewPage.registerDetialsRentBusinessAdvertising));
      //   break;

      case ViewPage.registerHomeAdvertising:
        emit(NavigationState(ViewPage.registerHomeAdvertising));
        break;

      case ViewPage.registerBusinessAdvertising:
        emit(NavigationState(ViewPage.registerBusinessAdvertising));
        break;

      case ViewPage.registerBusinessLocation:
        emit(NavigationState(ViewPage.registerBusinessLocation));
        break;

      case ViewPage.backScreen:
        emit(NavigationState(ViewPage.category));
        break;

      default:
        emit(NavigationState(ViewPage.category));
        break;
    }
  }
}

class PageNumberBloc extends Bloc<PageNumberEvent, PageNumberState> {
  int pageNumber = 1;
  PageNumberBloc() : super(PageNumberState(1)) {
    on<AddPageNumber>((event, emit) {
      if (pageNumber == 5) {
        return;
      }
      emit(PageNumberState(++pageNumber));
    });
    on<MinusPageNumber>((event, emit) {
      if (pageNumber == 1) {
        return;
      }
      emit(PageNumberState(--pageNumber));
    });
  }
}
