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
      'uid': '1',
      'name': 'user.name.toString()',
      'email': 'user.email.toString()',
      'profilePic': 'user.profilePic.toString()',
      'phone': 'user.phone.toString()',
      'address': 'user.address.toString()',
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
