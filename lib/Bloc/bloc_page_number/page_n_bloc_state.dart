class NavigationState {
  ViewPage viewPage;

  NavigationState(
    this.viewPage,
  );
}

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

final class StatusModeState {
  final StatusMode statusMode;
  StatusModeState(this.statusMode);
}

enum StatusMode {
  apartment,
  home,
  villa,
  buyLand,
}
