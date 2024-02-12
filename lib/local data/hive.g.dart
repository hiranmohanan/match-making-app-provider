// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModelHive> {
  @override
  final int typeId = 0;

  @override
  UserModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModelHive(
      uid: fields[0] as String?,
      name: fields[1] as String?,
      email: fields[3] as String?,
      profilePic: fields[4] as String?,
      phone: fields[5] as int?,
      height: fields[6] as int,
      weight: fields[7] as int?,
      house: fields[8] as String?,
      city: fields[9] as String?,
      state: fields[10] as String?,
      family: fields[11] as String?,
      gender: fields[12] as int?,
      age: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModelHive obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.profilePic)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.house)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.state)
      ..writeByte(11)
      ..write(obj.family)
      ..writeByte(12)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
