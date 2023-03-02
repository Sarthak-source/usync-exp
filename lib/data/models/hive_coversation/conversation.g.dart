// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationAdapter extends TypeAdapter<Conversation> {
  @override
  final int typeId = 0;

  @override
  Conversation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conversation(
      id: fields[0] as int?,
      name: fields[1] as String,
      user_id: fields[2] as int?,
      last_message_id: fields[3] as String?,
      messages: (fields[4] as List?)?.cast<Message>(),
      user_ids: (fields[5] as List?)?.cast<String>(),
      users: (fields[6] as List).cast<User>(),
      lastMessage: fields[7] as Message?,
      created_at: fields[8] as DateTime?,
      updated_at: fields[9] as DateTime?,
      type: fields[10] as String?,
      preferences: fields[11] as DefaultConversationPreferences?,
      unseen_messages_count: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.user_id)
      ..writeByte(3)
      ..write(obj.last_message_id)
      ..writeByte(4)
      ..write(obj.messages)
      ..writeByte(5)
      ..write(obj.user_ids)
      ..writeByte(6)
      ..write(obj.users)
      ..writeByte(7)
      ..write(obj.lastMessage)
      ..writeByte(8)
      ..write(obj.created_at)
      ..writeByte(9)
      ..write(obj.updated_at)
      ..writeByte(10)
      ..write(obj.type)
      ..writeByte(11)
      ..write(obj.preferences)
      ..writeByte(12)
      ..write(obj.unseen_messages_count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
