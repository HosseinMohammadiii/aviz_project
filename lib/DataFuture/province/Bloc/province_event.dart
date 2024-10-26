abstract class ProvinceEvent {}

final class ProvinceInitializedData extends ProvinceEvent {
  String? province;

  String? city;

  ProvinceInitializedData({this.province, this.city});
}

final class ProvinceSearchEvent extends ProvinceEvent {
  String province;

  ProvinceSearchEvent({required this.province});
}

final class ProvinceCitySearchEvent extends ProvinceEvent {
  String city;
  ProvinceCitySearchEvent({required this.city});
}
