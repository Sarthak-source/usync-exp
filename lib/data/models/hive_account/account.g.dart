// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 7;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      status: fields[0] as String?,
      firstName: fields[1] as String?,
      middleName: fields[2] as String?,
      email: fields[3] as String?,
      gender: fields[4] as String?,
      lastName: fields[5] as String?,
      language: fields[6] as Language?,
      timezone: fields[7] as dynamic,
      lastLoginAt: fields[8] as String?,
      doNotDisturb: fields[9] as int?,
      locationDetail: fields[10] as dynamic,
      isNewUser: fields[11] as bool?,
      phone: fields[12] as String?,
      location: fields[13] as String?,
      birthdateAt: fields[14] as String?,
      type: fields[15] as String?,
      activeUser: fields[16] as User?,
      communityUser: fields[17] as User?,
      users: (fields[18] as List?)?.cast<User>(),
      communities: fields[19] as dynamic,
      id: fields[20] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.middleName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.lastName)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.timezone)
      ..writeByte(8)
      ..write(obj.lastLoginAt)
      ..writeByte(9)
      ..write(obj.doNotDisturb)
      ..writeByte(10)
      ..write(obj.locationDetail)
      ..writeByte(11)
      ..write(obj.isNewUser)
      ..writeByte(12)
      ..write(obj.phone)
      ..writeByte(13)
      ..write(obj.location)
      ..writeByte(14)
      ..write(obj.birthdateAt)
      ..writeByte(15)
      ..write(obj.type)
      ..writeByte(16)
      ..write(obj.activeUser)
      ..writeByte(17)
      ..write(obj.communityUser)
      ..writeByte(18)
      ..write(obj.users)
      ..writeByte(19)
      ..write(obj.communities)
      ..writeByte(20)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
