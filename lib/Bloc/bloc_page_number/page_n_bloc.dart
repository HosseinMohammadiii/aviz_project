import 'package:bloc/bloc.dart';

import 'page_n_bloc_state.dart';

class NavigationPage extends Cubit<NavigationState> {
  NavigationPage() : super(NavigationState(ViewPage.category));

  void backFirstPAge() {
    emit(NavigationState(ViewPage.category));
  }

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

class StatusModeBloc extends Cubit<StatusModeState> {
  StatusModeBloc() : super(StatusModeState(StatusMode.apartment));

  void getStatusMode(StatusMode status) {
    switch (status) {
      case StatusMode.apartment:
        emit(StatusModeState(StatusMode.apartment));
        break;

      case StatusMode.home:
        emit(StatusModeState(StatusMode.home));
        break;

      case StatusMode.villa:
        emit(StatusModeState(StatusMode.villa));
        break;

      case StatusMode.buyLand:
        emit(StatusModeState(StatusMode.buyLand));
        break;

      case StatusMode.rentBusinessPlace:
        emit(StatusModeState(StatusMode.rentBusinessPlace));
        break;

      case StatusMode.buyBusinessPlace:
        emit(StatusModeState(StatusMode.buyBusinessPlace));
        break;

      default:
        emit(StatusModeState(StatusMode.apartment));
        break;
    }
  }
}
