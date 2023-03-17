// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeolocationAdapter extends TypeAdapter<Geolocation> {
  @override
  final int typeId = 3;

  @override
  Geolocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Geolocation()
      ..latitude = fields[0] as String
      ..longitude = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Geolocation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeolocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
