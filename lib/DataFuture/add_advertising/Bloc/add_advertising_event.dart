abstract class AddAdvertisingEvent {}

class AddAdvertisingGetInitializeData extends AddAdvertisingEvent {}

class AddInfoAdvertising extends AddAdvertisingEvent {
  String idCt;
  String location;

  int metr;
  int countRoom;
  int floor;
  int yearBuild;

  AddInfoAdvertising(
    this.idCt,
    this.location,
    this.metr,
    this.countRoom,
    this.floor,
    this.yearBuild,
  );
}
