// abstract class PageNumberState {}

// class CategoryScreen extends PageNumberState {}

// class ItemsBuyHome extends PageNumberState {}

// class ItemsRentHome extends PageNumberState {}

// class ItemsBuyBusinessPlace extends PageNumberState {}

// class ItemsRentBusinessPlace extends PageNumberState {}

class PageNumberState {
  int pageNumber;
  PageNumberState(this.pageNumber);
}

class NavigationState {
  final ViewPage viewPage;

  NavigationState(this.viewPage);
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
