// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 2;

  @override
  File read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return File(
      id: fields[0] as String,
      type_: fields[1] as String,
      type: fields[2] as String,
      name: fields[3] as String,
      description: fields[4] as String,
      description_summary: fields[5] as String,
      poster_id: fields[6] as String,
      cover: fields[7] as File,
      original_extension: fields[8] as String,
      playable_length: fields[9] as int,
      data: (fields[10] as Map).cast<String, dynamic>(),
      user_id: fields[11] as int,
      user: fields[12] as User,
      page_id: fields[13] as String,
      page: fields[14] as Page,
      aspect_ratio: fields[15] as String,
      links: (fields[22] as Map).cast<String, dynamic>(),
      timestamps: (fields[17] as Map).cast<String, dynamic>(),
      manageable: fields[18] as bool,
      meta: fields[19] as bool,
      marked_as_nsfw: fields[20] as bool,
      m3u8_path: fields[21] as String,
    );
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type_)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.description_summary)
      ..writeByte(6)
      ..write(obj.poster_id)
      ..writeByte(7)
      ..write(obj.cover)
      ..writeByte(8)
      ..write(obj.original_extension)
      ..writeByte(9)
      ..write(obj.playable_length)
      ..writeByte(10)
      ..write(obj.data)
      ..writeByte(11)
      ..write(obj.user_id)
      ..writeByte(12)
      ..write(obj.user)
      ..writeByte(13)
      ..write(obj.page_id)
      ..writeByte(14)
      ..write(obj.page)
      ..writeByte(15)
      ..write(obj.aspect_ratio)
      ..writeByte(16)
      ..write(obj.links)
      ..writeByte(17)
      ..write(obj.timestamps)
      ..writeByte(18)
      ..write(obj.manageable)
      ..writeByte(19)
      ..write(obj.meta)
      ..writeByte(20)
      ..write(obj.marked_as_nsfw)
      ..writeByte(21)
      ..write(obj.m3u8_path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
