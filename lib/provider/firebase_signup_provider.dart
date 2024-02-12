import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/firebase/firebase_signup.dart';
import 'package:match_making_test/local%20data/boxes.dart';

import '../database/usermodel.dart';
import '../local data/hive.dart';
import '../local data/shared_prefs.dart';

class FirebaseSignupProvider extends ChangeNotifier {
  bool _isUserLoggedIn = false;
  String _email = '';
  String _password = '';
  String _name = '';
  String _responce = '';
  bool _isloading = false;
  String? _validatormessage;
  bool _isSecure = true;
  int? _gender;
  UserModel _usermodel = UserModel();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  bool get isUserLoggedIn => _isUserLoggedIn;
  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get responce => _responce;
  bool get isloading => _isloading;
  String? get validator => _validatormessage;
  bool get issecurefont => _isSecure;
  int? get gender => _gender;
  UserModel get usermodel => _usermodel;
  TextEditingController get emailcontroller => _emailcontroller;
  TextEditingController get passwordcontroller => _passwordcontroller;
  TextEditingController get namecontroller => _namecontroller;
  TextEditingController get phonecontroller => _phonecontroller;

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
    _usermodel = UserModel();
    setGender(null);
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
    if (_usermodel.name == null) {
      _validatormessage = 'Please enter name';
    } else if (_usermodel.email == null) {
      _validatormessage = 'Please enter the email';
    } else if (!_usermodel.email!.contains('@')) {
      _validatormessage = 'Please enter a valid email';
    } else if (!_usermodel.email!.contains('.')) {
      _validatormessage = 'Please enter a valid email';
    } else if (_password.isEmpty) {
      _validatormessage = 'Please enter the password';
    } else if (_password.length < 8) {
      _validatormessage = 'Password should be atleast 8 characters';
    } else if (_usermodel.gender == null) {
      _validatormessage = 'Please select Your Gender';
    } else {
      _validatormessage = null;
    }
    notifyListeners();
  }

  void setisSecure(bool value) {
    _isSecure = value;
    notifyListeners();
  }

  void setGender(int? gender) {
    _gender = gender;
    notifyListeners();
  }

  void setusermodel(UserModel value) {
    _usermodel = UserModel(
      uid: value.uid,
      name: value.name,
      email: value.email,
      phone: value.phone,
      gender: value.gender,
    );
    notifyListeners();
  }

  Future<void> signUp() async {
    setLoading(true);

    final responce = await firebaseSignup(
      user: _usermodel,
      password: _password,
    );
    if (kDebugMode) {
      print('=======================responce of firebase is: $responce');
    }
    if (responce != null) {
      if (responce == 'Signed up') {
        createdbandstore(user: _usermodel);
        // SharedPrefs().setuid(FirebaseAuth.instance.currentUser!.uid);
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

createdbandstore({required UserModel user}) async {
  // boxuser.put(
  //     'primaryuser',
  //     UserModelHive(
  //       uid: user.uid,
  //       name: user.name,
  //       email: user.email,
  //       profilePic: user.profilePic,
  //       phone: user.phone,
  //       height: user.height,
  //       weight: user.weight,
  //       house: user.house,
  //       city: user.city,
  //       state: user.state,
  //       family: user.family,
  //       gender: user.gender,
  //       age: user.age,
  //     ));
  await createUserInDatabase(UserModel(
    uid: FirebaseAuth.instance.currentUser!.uid,
    name: user.name,
    email: user.email,
    phone: user.phone,
    gender: user.gender,
  ));
}
