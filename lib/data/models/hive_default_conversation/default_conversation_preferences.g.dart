// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_conversation_preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DefaultConversationPreferencesAdapter
    extends TypeAdapter<DefaultConversationPreferences> {
  @override
  final int typeId = 0;

  @override
  DefaultConversationPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DefaultConversationPreferences(
      doNotDisturb: fields[0] as bool,
      deletedAt: fields[1] as DateTime?,
      deletedByUserId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DefaultConversationPreferences obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.doNotDisturb)
      ..writeByte(1)
      ..write(obj.deletedAt)
      ..writeByte(2)
      ..write(obj.deletedByUserId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefaultConversationPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
