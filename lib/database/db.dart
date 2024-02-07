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
      'address': user.address.toString(),
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

Future<void> readUserInDatabase(String uid) async {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref('userInfo').child('users');
  final snapshot = await dbRef.get();
  if (snapshot.exists) {
    if (kDebugMode) {
      print('=======================user read: ${snapshot.value}');
    }
  } else {
    if (kDebugMode) {
      print('=======================user not found');
    }
  }
}
