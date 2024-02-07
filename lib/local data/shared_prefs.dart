import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  int() async {
    // Obtain shared preferences.
    await SharedPreferences.getInstance();
  }

  setuid(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

  getuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print('=======================uid: ${prefs.getString('uid')}');
    }
    return prefs.getString('uid');
  }

  clearuid() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.remove('uid');
    });
  }
}
