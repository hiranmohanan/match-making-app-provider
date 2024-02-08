import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import 'usermodel.dart';

Future<void> createUserInDatabase(UserModel user) async {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref('userInfo').child('users/${user.uid}');
  if (kDebugMode) {
    print('=======================user to be created: ${user.toMap()}');
  }
  try {
    await dbRef.set({
      'uid': user.uid.toString(),
      'name': user.name.toString(),
      'email': user.email.toString(),
      'profilepic': user.profilePic.toString(),
      'phone': user.phone.toString(),
      'height': user.height.toString(),
      'weight': user.weight.toString(),
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

Future<void> updateUserInformation(UserModel user) async {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref('userInfo').child('users/${user.uid}');
  if (kDebugMode) {
    print('=======================user to be created: ${user.toMap()}');
  }
  try {
    await dbRef.update({
      'uid': user.uid.toString(),
      'name': user.name.toString(),
      'email': user.email.toString(),
      'profilepic': user.profilePic.toString(),
      'phone': user.phone.toString(),
      'height': user.height.toString(),
      'weight': user.weight.toString(),
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
        name: (snapshot.value as Map<dynamic, dynamic>)['name'],
        email: (snapshot.value as Map<dynamic, dynamic>)['email'],
        profilePic: (snapshot.value as Map<dynamic, dynamic>)['profilepic'],
        phone: (snapshot.value as Map<dynamic, dynamic>)['phone'],
        height: (snapshot.value as Map<dynamic, dynamic>)['height'],
        weight: (snapshot.value as Map<dynamic, dynamic>)['weight'],
        house: (snapshot.value as Map<dynamic, dynamic>)['house'],
        city: (snapshot.value as Map<dynamic, dynamic>)['city'],
        state: (snapshot.value as Map<dynamic, dynamic>)['state'],
        family: (snapshot.value as Map<dynamic, dynamic>)['family']);

    if (kDebugMode) {
      print('=======================user read: ${snapshot.value}');
      print('object: ${user.toMap()}');
    }
    return user;
  } else {
    if (kDebugMode) {
      print('=======================user not found');
    }
  }
  return null;
}
