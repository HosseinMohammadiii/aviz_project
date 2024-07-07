class NavigationState {
  final ViewPage viewPage;

  NavigationState(
    this.viewPage,
  );
}

enum ViewPage {
  backScreen,
  category, //All Items Category
  itemsBuyHome, //Different Types of House Sales
  itemsRentHome, //Different Types of House Rent
  itemsBuyBusinessPlace, //Different Types of BusinessPlace Sales
  itemsRentBusinessPlace, //Different Types of BusinessPlace Rent
  registerHomeLocation,
  registerBusinessLocation,
  registerDetialsBuyHomeAdvertising,
  registerDetialsRentHomeAdvertising,
  registerDetialsRentBusinessAdvertising,
  registerDetialsBuyBusinessAdvertising,
  registerHomeAdvertising,
  registerBusinessAdvertising,
}

final class StatusModeState {
  final StatusMode statusMode;
  StatusModeState(this.statusMode);
}

enum StatusMode {
  apartment,
  home,
  villa,
  rentBusinessPlace,
  buyLand,
  buyBusinessPlace,
}
