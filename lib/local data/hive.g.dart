// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelHiveAdapter extends TypeAdapter<UserModelHive> {
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
      fname: fields[1] as dynamic,
      lname: fields[2] as dynamic,
      email: fields[4] as dynamic,
      profilePic: fields[5] as dynamic,
      phone: fields[6] as dynamic,
      height: fields[7] as dynamic,
      weight: fields[8] as dynamic,
      house: fields[9] as dynamic,
      city: fields[10] as dynamic,
      state: fields[11] as dynamic,
      family: fields[12] as dynamic,
      gender: fields[13] as dynamic,
      age: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, UserModelHive obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.fname)
      ..writeByte(2)
      ..write(obj.lname)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.profilePic)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.height)
      ..writeByte(8)
      ..write(obj.weight)
      ..writeByte(9)
      ..write(obj.house)
      ..writeByte(10)
      ..write(obj.city)
      ..writeByte(11)
      ..write(obj.state)
      ..writeByte(12)
      ..write(obj.family)
      ..writeByte(13)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
