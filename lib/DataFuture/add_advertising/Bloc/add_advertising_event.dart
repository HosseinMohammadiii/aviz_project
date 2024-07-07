abstract class AddAdvertisingEvent {}

class AddAdvertisingGetInitializeData extends AddAdvertisingEvent {}

class AddInfoAdvertising extends AddAdvertisingEvent {
  String idCt;
  String location;
  List<String> images;
  String titlehome;
  String description;
  int homeprice;

  AddInfoAdvertising(
    this.idCt,
    this.location,
    this.images,
    this.titlehome,
    this.description,
    this.homeprice,
  );
}
