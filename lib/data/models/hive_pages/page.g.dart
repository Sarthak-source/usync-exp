// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PageAdapter extends TypeAdapter<Page> {
  @override
  final int typeId = 5;

  @override
  Page read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Page(
      id: fields[0] as String?,
      type: fields[1] as String?,
      name: (fields[2] as Map?)?.cast<String, String>(),
      account: fields[3] as dynamic,
      avatar_id: fields[4] as String?,
      avatar: fields[5] as File?,
      cover_id: fields[6] as String?,
      cover: fields[7] as File?,
      avatar_data: fields[8] as dynamic,
      cover_data: fields[9] as dynamic,
      sub_title: fields[10] as String?,
      description: fields[11] as dynamic,
      description_summary: fields[12] as dynamic,
      isFirstView: fields[13] as bool,
      settings: (fields[14] as Map).cast<String, dynamic>(),
      pagename: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Page obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.account)
      ..writeByte(4)
      ..write(obj.avatar_id)
      ..writeByte(5)
      ..write(obj.avatar)
      ..writeByte(6)
      ..write(obj.cover_id)
      ..writeByte(7)
      ..write(obj.cover)
      ..writeByte(8)
      ..write(obj.avatar_data)
      ..writeByte(9)
      ..write(obj.cover_data)
      ..writeByte(10)
      ..write(obj.sub_title)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.description_summary)
      ..writeByte(13)
      ..write(obj.isFirstView)
      ..writeByte(14)
      ..write(obj.settings)
      ..writeByte(15)
      ..write(obj.pagename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
