import 'package:hive/hive.dart';

part 'hive.g.dart'; // This file will be generated by build_runner

@HiveType(typeId: 0) // typeId is unique for each type of Hive object
class UserModelHive {
  @HiveField(0)
  final String? uid;

  @HiveField(1)
  final dynamic fname;

  @HiveField(2)
  final dynamic lname;

  @HiveField(3)
  final dynamic age;

  @HiveField(4)
  final dynamic email;

  @HiveField(5)
  final dynamic profilePic;

  @HiveField(6)
  final dynamic phone;

  @HiveField(7)
  final dynamic height;

  @HiveField(8)
  final dynamic weight;

  @HiveField(9)
  final dynamic house;

  @HiveField(10)
  final dynamic city;

  @HiveField(11)
  final dynamic state;

  @HiveField(12)
  final dynamic family;

  @HiveField(13)
  final dynamic gender;

  UserModelHive({
    this.uid,
    this.fname,
    this.lname,
    this.email,
    this.profilePic,
    this.phone,
    this.height,
    this.weight,
    this.house,
    this.city,
    this.state,
    this.family,
    this.gender,
    this.age,
  });
}
