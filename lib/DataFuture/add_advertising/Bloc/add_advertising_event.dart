abstract class AddAdvertisingEvent {}

class AddAdvertisingGetInitializeData extends AddAdvertisingEvent {}

class AddInfoAdvertising extends AddAdvertisingEvent {
  String idInforegister;
  String idCt;
  String location;

  int metr;
  int countRoom;
  int floor;
  int yearBuild;

  AddInfoAdvertising(
    this.idInforegister,
    this.idCt,
    this.location,
    this.metr,
    this.countRoom,
    this.floor,
    this.yearBuild,
  );
}

final class AddFacilitiesAdvertising extends AddAdvertisingEvent {
  bool elevator;
  bool parking;
  bool storeroom;
  bool balcony;
  bool penthouse;

  AddFacilitiesAdvertising(
    this.elevator,
    this.parking,
    this.storeroom,
    this.balcony,
    this.penthouse,
  );
}
