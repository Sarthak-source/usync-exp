// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 4;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      id: fields[0] as String?,
      type: fields[1] as String?,
      from_system: fields[2] as String?,
      conversation_id: fields[3] as String?,
      conversation: fields[4] as Conversation?,
      user_id: fields[5] as int?,
      user: fields[6] as User?,
      content: fields[7] as String?,
      attachable_type: fields[8] as String?,
      attachable_id: fields[9] as int?,
      attachable: fields[10] as HiveObject?,
      file_ids: (fields[11] as List?)?.cast<int>(),
      files: (fields[12] as List?)?.cast<File>(),
      geolocation: fields[13] as Geolocation?,
      created_at: fields[14] as DateTime?,
      updated_at: fields[15] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.from_system)
      ..writeByte(3)
      ..write(obj.conversation_id)
      ..writeByte(4)
      ..write(obj.conversation)
      ..writeByte(5)
      ..write(obj.user_id)
      ..writeByte(6)
      ..write(obj.user)
      ..writeByte(7)
      ..write(obj.content)
      ..writeByte(8)
      ..write(obj.attachable_type)
      ..writeByte(9)
      ..write(obj.attachable_id)
      ..writeByte(10)
      ..write(obj.attachable)
      ..writeByte(11)
      ..write(obj.file_ids)
      ..writeByte(12)
      ..write(obj.files)
      ..writeByte(13)
      ..write(obj.geolocation)
      ..writeByte(14)
      ..write(obj.created_at)
      ..writeByte(15)
      ..write(obj.updated_at);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
