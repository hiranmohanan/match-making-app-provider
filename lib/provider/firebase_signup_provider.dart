import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/firebase/firebase_signup.dart';

import '../database/usermodel.dart';

class FirebaseSignupProvider extends ChangeNotifier {
  bool _isUserLoggedIn = false;
  String _email = '';
  String _password = '';
  String _name = '';
  String _responce = '';
  bool _isloading = false;
  String? _validatormessage;
  bool get isUserLoggedIn => _isUserLoggedIn;
  String get email => _email;
  String get password => _password;
  String get name => _name;
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

  void setName(String value) {
    _name = value;
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

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void setValidator() {
    if (_name.isEmpty) {
      _validatormessage = 'Please enter name';
    } else if (_email.isEmpty) {
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

  Future<void> signUp() async {
    setLoading(true);
    final responce = await firebaseSignup(
      email: _email,
      password: _password,
    );
    if (kDebugMode) {
      print('=======================responce of firebase is: $responce');
    }
    if (responce != null) {
      if (responce == 'Signed up') {
        createdbandstore(name: _name, email: _email);
        setUserLoggedIn(true);
        setLoading(false);
      } else {
        _responce = responce;
        notifyListeners();
        setUserLoggedIn(false);

        setLoading(false);
      }
    } else {
      setUserLoggedIn(false);
    }
    setLoading(false);
  }
}

createdbandstore({required String name, required String email}) async {
  if (kDebugMode) {
    print('=======================creating user in database');
    print('uid: ${FirebaseAuth.instance.currentUser!.uid}');
  }
  await createUserInDatabase(UserModel(
    uid: FirebaseAuth.instance.currentUser!.uid,
    name: name,
    email: email,
  ));
}
