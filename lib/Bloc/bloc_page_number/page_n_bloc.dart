import 'package:bloc/bloc.dart';

import 'page_n_bloc_state.dart';

// Bloc for managing navigation between pages
class NavigationPage extends Cubit<NavigationState> {
  
  // Constructor initializes the navigation state to the 'category' page
  NavigationPage() : super(NavigationState(ViewPage.category));
  
  // Method to navigate back to the first page (category)
  void backFirstPAge() {
    emit(NavigationState(ViewPage.category));
  }

  // Method to navigate to a specific page based on the provided item
  void getNavItems(ViewPage item) {
    switch (item) {
      case ViewPage.category:
        // Navigate to the category page
        emit(NavigationState(ViewPage.category));
        break;

      case ViewPage.itemsRentHome:
        // Navigate to the items for rent home page
        emit(NavigationState(ViewPage.itemsRentHome));
        break;

      case ViewPage.itemsBuyHome:
        // Navigate to the items for buy home page
        emit(NavigationState(ViewPage.itemsBuyHome));
        break;

      case ViewPage.registerDetialsBuyHomeAdvertising:
        // Navigate to the register details for buy home advertising page
        emit(NavigationState(ViewPage.registerDetialsBuyHomeAdvertising));
        break;

      case ViewPage.registerDetialsRentHomeAdvertising:
        // Navigate to the register details for rent home advertising page
        emit(NavigationState(ViewPage.registerDetialsRentHomeAdvertising));
        break;

      case ViewPage.registerHomeAdvertising:
        // Navigate to the register home advertising page
        emit(NavigationState(ViewPage.registerHomeAdvertising));
        break;

      case ViewPage.registerRentHomeAdvertising:
        // Navigate to the register rent home advertising page
        emit(NavigationState(ViewPage.registerRentHomeAdvertising));
        break;

      case ViewPage.backScreen:
        // Navigate back to the category page
        emit(NavigationState(ViewPage.category));
        break;

      default:
        // Fallback to the category page if no match is found
        emit(NavigationState(ViewPage.category));
        break;
    }
  }
}

// Bloc for managing the status mode of a property
class StatusModeBloc extends Cubit<StatusModeState> {
  
  // Constructor initializes the status mode to 'apartment'
  StatusModeBloc() : super(StatusModeState(StatusMode.apartment));

  // Method to update the status mode based on the provided status
  void getStatusMode(StatusMode status) {
    switch (status) {
      case StatusMode.apartment:
        // Update status to 'apartment'
        emit(StatusModeState(StatusMode.apartment));
        break;

      case StatusMode.home:
        // Update status to 'home'
        emit(StatusModeState(StatusMode.home));
        break;

      case StatusMode.villa:
        // Update status to 'villa'
        emit(StatusModeState(StatusMode.villa));
        break;

      case StatusMode.buyLand:
        // Update status to 'buy land'
        emit(StatusModeState(StatusMode.buyLand));
        break;

      default:
        // Fallback to 'apartment' status if no match is found
        emit(StatusModeState(StatusMode.apartment));
        break;
    }
  }
}
