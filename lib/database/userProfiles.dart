// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  Users? users;

  UserProfile({
    this.users,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        users: Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "users": users?.toJson(),
      };
}

class Users {
  Uid? uid;

  Users({
    this.uid,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: Uid.fromJson(json["uid"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid?.toJson(),
      };
}

class Uid {
  String? address;
  String? email;
  String? name;
  String? phone;
  String? profilepic;
  String? uid;

  Uid({
    this.address,
    this.email,
    this.name,
    this.phone,
    this.profilepic,
    this.uid,
  });

  factory Uid.fromJson(Map<String, dynamic> json) => Uid(
        address: json["address"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        profilepic: json["profilepic"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "email": email,
        "name": name,
        "phone": phone,
        "profilepic": profilepic,
        "uid": uid,
      };
}
