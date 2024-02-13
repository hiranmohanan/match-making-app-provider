import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/firebase/firebase_signup.dart';
import 'package:match_making_test/local%20data/boxes.dart';

import '../database/usermodel.dart';
import '../local data/hive.dart';

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
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _fnamecontroller = TextEditingController();
  final TextEditingController _lnamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _heightcontroller = TextEditingController();
  final TextEditingController _weightcontroller = TextEditingController();
  final TextEditingController _housecontroller = TextEditingController();
  final TextEditingController _citycontroller = TextEditingController();
  final TextEditingController _statecontroller = TextEditingController();
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
  TextEditingController get fnamecontroller => _fnamecontroller;
  TextEditingController get lnamecontroller => _lnamecontroller;
  TextEditingController get phonecontroller => _phonecontroller;
  TextEditingController get heightcontroller => _heightcontroller;
  TextEditingController get weightcontroller => _weightcontroller;
  TextEditingController get housecontroller => _housecontroller;
  TextEditingController get statecontroller => _statecontroller;
  TextEditingController get citycontroller => _citycontroller;

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

  void clearall() {
    _emailcontroller.clear();
    _passwordcontroller.clear();
    _fnamecontroller.clear();
    _lnamecontroller.clear();
    _phonecontroller.clear();
    _heightcontroller.clear();
    _weightcontroller.clear();
    _housecontroller.clear();
    _citycontroller.clear();
    _statecontroller.clear();
    _gender = null;
    notifyListeners();
  }

  void setValidator() {
    if (_fnamecontroller.text == 'null') {
      _validatormessage = 'Please enter first name';
    } else if (_lnamecontroller.text == 'null') {
      _validatormessage = 'Please enter last name';
    } else if (_emailcontroller.text == 'null') {
      _validatormessage = 'Please enter the email';
    } else if (!_emailcontroller.text.contains('@')) {
      _validatormessage = 'Please enter a valid email';
    } else if (!_emailcontroller.text.contains('.')) {
      _validatormessage = 'Please enter a valid email';
    } else if (_passwordcontroller.text == 'null') {
      _validatormessage = 'Please enter the password';
    } else if (_passwordcontroller.text.length < 8) {
      _validatormessage = 'Password should be atleast 8 characters';
    } else if (_gender == null) {
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
    if (kDebugMode) {
      print('gender change $_gender');
    }
  }

  void setusermodel(UserModel value) {
    _usermodel = UserModel(
      uid: value.uid,
      fname: value.fname,
      lname: value.lname,
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
        clearall();
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
  await createUserInDatabase(UserModel(
    uid: FirebaseAuth.instance.currentUser!.uid,
    fname: user.fname,
    lname: user.lname,
    email: user.email,
    phone: user.phone,
    gender: user.gender,
  ));
  await boxuser.put(
      'primaryuser',
      UserModelHive(
        uid: user.uid,
        fname: user.fname,
        lname: user.lname,
        email: user.email,
        profilePic: null,
        phone: user.phone,
        height: null,
        weight: null,
        house: null,
        city: null,
        state: null,
        family: null,
        gender: user.gender,
        age: null,
      ));
}
