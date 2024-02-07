import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:match_making_test/firebase/firebase_signin.dart';
import 'package:match_making_test/local%20data/shared_prefs.dart';

class FirebaseLoginProvider extends ChangeNotifier {
  bool _isUserLoggedIn = false;
  String _email = '';
  String _password = '';
  String _responce = '';
  bool _isloading = false;
  String? _validatormessage;
  bool get isUserLoggedIn => _isUserLoggedIn;
  String get email => _email;
  String get password => _password;
  String get responce => _responce;
  bool get isloading => _isloading;
  String? get validator => _validatormessage;

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

  void loading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void setValidator() {
    if (_email.isEmpty) {
      _validatormessage = 'Please enter the email';
    } else if (!_email.contains('@')) {
      _validatormessage = 'Please enter a valid email';
    } else if (!_email.contains('.')) {
      _validatormessage = 'Please enter a valid email';
    } else if (_password.isEmpty) {
      _validatormessage = 'Please enter the password';
    } else if (_password.isEmpty) {
      _validatormessage = 'Please enter the password';
    } else if (_password.length < 8) {
      _validatormessage = 'Password should be atleast 8 characters';
    } else {
      _validatormessage = null;
    }
    notifyListeners();
  }

  Future<void> login() async {
    loading(true);

    final responce = await signIn(password: _password, email: _email);
    // ignore: unnecessary_null_comparison
    if (kDebugMode) {
      print('=======================responce of firebase is: $responce');
    }
    if (responce != null) {
      if (responce == 'Signed in') {
        SharedPrefs().setuid(FirebaseAuth.instance.currentUser!.uid);
        setUserLoggedIn(true);
        loading(false);
      } else {
        _responce = responce;
        notifyListeners();
        setUserLoggedIn(false);

        loading(false);
      }
    } else {
      setUserLoggedIn(false);
    }
    loading(false);
  }
}
