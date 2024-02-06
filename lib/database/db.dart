import 'package:firebase_database/firebase_database.dart';

import 'usermodel.dart';

Future<void> createUserInDatabase(UserModel user) async {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('users/${user.uid}');
  await dbRef.set(user.toMap());
}
