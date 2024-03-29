import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import 'usermodel.dart';

Future<void> createUserInDatabase(UserModel user) async {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref('userInfo').child('users/${user.uid}');
  if (kDebugMode) {
    print('=======================user to be created: ${user.toMap()}');
  }
  try {
    await dbRef.set({
      'uid': uid,
      'fname': user.fname.toString(),
      'lname': user.lname.toString(),
      'email': user.email.toString(),
      'phone': user.phone,
      'gender': user.gender,
    });
    if (kDebugMode) {
      print('=======================user created');
    }
  } catch (e) {
    if (kDebugMode) {
      print('=======================error in creating user: $e');
    }
  }
}

Future<void> updateUserInformation(UserModel user) async {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref('userInfo').child('users/$uid');
  if (kDebugMode) {
    print('=======================user to be created: ${user.toMap()}');
  }
  try {
    await dbRef.update({
      'fname': user.fname.toString(),
      'lname': user.lname.toString(),
      'height': user.height,
      'weight': user.weight,
      'house': user.house.toString(),
      'city': user.city.toString(),
      'state': user.state.toString(),
      'family': user.family.toString(),
    });
    if (kDebugMode) {
      print('=======================user created');
    }
  } catch (e) {
    if (kDebugMode) {
      print('=======================error in creating user: $e');
    }
  }
}

Future<UserModel?> readUserInDatabase(String uid) async {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref('userInfo').child('users/$uid');
  final snapshot = await dbRef.get();
  if (snapshot.exists) {
    final UserModel user = UserModel(
      uid: (snapshot.value as Map<dynamic, dynamic>)['uid'],
      fname: (snapshot.value as Map<dynamic, dynamic>)['fname'],
      lname: (snapshot.value as Map<dynamic, dynamic>)['lname'],
      email: (snapshot.value as Map<dynamic, dynamic>)['email'],
      profilePic: (snapshot.value as Map<dynamic, dynamic>)['profilepic'],
      phone: (snapshot.value as Map<dynamic, dynamic>)['phone'],
      height: (snapshot.value as Map<dynamic, dynamic>)['height'],
      weight: (snapshot.value as Map<dynamic, dynamic>)['weight'],
      house: (snapshot.value as Map<dynamic, dynamic>)['house'],
      city: (snapshot.value as Map<dynamic, dynamic>)['city'],
      state: (snapshot.value as Map<dynamic, dynamic>)['state'],
      family: (snapshot.value as Map<dynamic, dynamic>)['family'],
      gender: (snapshot.value as Map<dynamic, dynamic>)['gender'],
    );

    return user;
  } else {
    if (kDebugMode) {
      print('=======================user not found');
    }
    return null;
  }
}

Future<List<UserModel>?> getAllUser() async {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref('userInfo').child('users');
  final snapshot = await dbRef.get();
  if (snapshot.exists) {
    if (kDebugMode) {
      print('=======================user read: ${snapshot.value}');
    }
    final List<UserModel> users = [];

    (snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
      final UserModel user = UserModel(
        uid: value['uid'],
        fname: value['fname'],
        lname: value['lname'],
        email: value['email'],
        profilePic: value['profilepic'],
        phone: value['phone'],
        height: value['height'],
        weight: value['weight'],
        house: value['house'],
        city: value['city'],
        state: value['state'],
        family: value['family'],
        gender:
            value['gender'] == null ? 3 : int.parse(value['gender'].toString()),
      );
      users.add(user);
    });

    return users;
  } else {
    if (kDebugMode) {
      print('=======================user not found');
    }
  }
  return null;
}
