// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertising_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdvertisingHiveAdapter extends TypeAdapter<AdvertisingHive> {
  @override
  final int typeId = 1;

  @override
  AdvertisingHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdvertisingHive(
      idFacilities: fields[0] as String?,
      idGallery: fields[1] as String?,
      idSaveAd: fields[2] as String?,
      province: fields[3] as String?,
      city: fields[4] as String?,
    )..phoneNumber = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, AdvertisingHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.idFacilities)
      ..writeByte(1)
      ..write(obj.idGallery)
      ..writeByte(2)
      ..write(obj.idSaveAd)
      ..writeByte(3)
      ..write(obj.province)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdvertisingHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
