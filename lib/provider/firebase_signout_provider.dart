import 'package:flutter/foundation.dart';
import 'package:match_making_test/firebase/firebase_sign_out.dart';

import '../local data/shared_prefs.dart';

class FirebaseSignoutProvider extends ChangeNotifier {
  bool _isloading = false;
  bool _islogout = false;

  bool get isloading => _isloading;
  bool get islogout => _islogout;

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void setLogout(bool value) {
    _islogout = value;
    notifyListeners();
  }

  Future<void> signOut() async {
    setLoading(true);
    final responce = await firebasesignout();
    if (kDebugMode) {
      print('Signout responce: $responce');
    }
    if (responce == "Signed out") {
      setLogout(true);
      SharedPrefs().clearuid();
    } else {
      setLogout(false);
    }

    setLoading(false);
  }
}
