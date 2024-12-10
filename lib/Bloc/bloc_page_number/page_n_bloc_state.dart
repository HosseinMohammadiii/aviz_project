// Class to manage navigation states in the application
class NavigationState {
  // Variable to the current page being viewed
  ViewPage viewPage;
  // Constructor to initialize the current page
  NavigationState(
    this.viewPage,
  );
}

// Enum to define the different pages within the application
enum ViewPage {
  backScreen,
  category,
  itemsBuyHome,
  itemsRentHome,
  registerDetialsBuyHomeAdvertising,
  registerDetialsRentHomeAdvertising,
  registerHomeAdvertising,
  registerRentHomeAdvertising,
}

// Class to manage different status modes
final class StatusModeState {
  // Variable to the current status mode
  final StatusMode statusMode;
  // Constructor to initialize the status mode
  StatusModeState(this.statusMode);
}

// Enum to define different statuses for a property
enum StatusMode {
  apartment,
  home,
  villa,
  buyLand,
}
