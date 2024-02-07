import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:match_making_test/database/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFetchProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> fetchProfile() async {
    try {
      final String _uid = await SharedPreferences.getInstance()
          .then((value) => value.getString('uid')!);

      readUserInDatabase(_uid);
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
