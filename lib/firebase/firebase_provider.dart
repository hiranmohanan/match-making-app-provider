import 'package:flutter/foundation.dart';
import 'package:match_making_test/firebase/firebase_signin.dart';

class FirebaseLoginProvider extends ChangeNotifier {
  bool _isUserLoggedIn = false;
  String _email = '';
  String _password = '';
  String _responce = '';
  bool get isUserLoggedIn => _isUserLoggedIn;
  String get email => _email;
  String get password => _password;
  String get responce => _responce;

  void setUserLoggedIn(bool value) {
    _isUserLoggedIn = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void clear() {
    _isUserLoggedIn = false;
    _email = '';
    _password = '';
    notifyListeners();
  }

  void clearEmail() {
    _email = '';
    notifyListeners();
  }

  void clearPassword() {
    _password = '';
    notifyListeners();
  }

  void clearUserLoggedIn() {
    _isUserLoggedIn = false;
    notifyListeners();
  }

  void setResponce(String value) {
    _responce = value;
    notifyListeners();
  }

  void clearresponce() {
    _responce = '';
    notifyListeners();
  }

  Future<void> login() async {
    final responce = await signIn(password: _password, email: _email);
    // ignore: unnecessary_null_comparison
    if (responce != null) {
      if (responce == 'Signed in') {
        setUserLoggedIn(true);
      } else {
        _responce = responce;
        notifyListeners();
        setUserLoggedIn(false);
      }
    } else {
      setUserLoggedIn(false);
    }
    if (kDebugMode) {
      print('responce of firebase is: $responce');
    }
  }
}
