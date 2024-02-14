import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/database/usermodel.dart';

class ProfileFetchProvider extends ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel _userProfile = UserModel();
  bool _isLoading = false;
  bool _isProfileFetched = false;
  bool _istextfalse = false;
  bool _changedone = false;
  String? _fieldmessage;

  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _houseController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _familyController = TextEditingController();

  UserModel get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  bool get isProfileFetched => _isProfileFetched;
  bool get istextfalse => _istextfalse;
  bool get changedone => _changedone;
  String? get fieldmessage => _fieldmessage;

  TextEditingController get nameController => _nameController;
  TextEditingController get heightController => _heightController;
  TextEditingController get weightController => _weightController;
  TextEditingController get houseController => _houseController;
  TextEditingController get cityController => _cityController;
  TextEditingController get stateController => _stateController;
  TextEditingController get familyController => _familyController;

  void setUserModel(UserModel user) {
    _userProfile = user;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setProfilefetched(bool value) {
    _isProfileFetched = value;
    notifyListeners();
  }

  void setistextfalse(bool value) {
    _istextfalse = value;
    notifyListeners();
  }

  void setchnagesdon(bool value) {
    _changedone = value;
    notifyListeners();
  }

  void setfieldmessage(String? message) {
    _fieldmessage = message;
    notifyListeners();
  }

  void saveUserModel({
    String? fname,
    String? lname,
    String? email,
    String? profilePic,
    int? phone,
    int? height,
    int? weight,
    String? house,
    String? city,
    String? state,
    String? family,
  }) {
    _userProfile = UserModel(
      fname: fname,
      lname: lname,
      height: int.parse(height.toString()),
      weight: int.parse(weight.toString()),
      house: house,
      city: city,
      state: state,
      family: family,
    );
    notifyListeners();
    saveChanges();
  }

  void saveChanges() async {
    setLoading(true);
    try {
      await updateUserInformation(_userProfile);
      setLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setLoading(false);
    }
  }

  void validator({
    String? fname,
    String? lname,
    String? height,
    String? weight,
    String? house,
    String? city,
    String? state,
    String? family,
  }) {
    if (fname == null || fname == 'null') {
      setchnagesdon(true);
      setfieldmessage('please enter a firs name');
    } else if (lname == null || lname == 'null') {
      setchnagesdon(true);
      setfieldmessage('please enter a last name');
    } else if (height == null || height == 'null') {
      setchnagesdon(true);
      setfieldmessage('please enter the height');
    } else if (weight == null || weight == 'null') {
      setchnagesdon(true);
      setfieldmessage('please enter the weight');
    } else if (house == null || house == 'null') {
      setchnagesdon(true);
      setfieldmessage('please enter the house');
    } else if (city == null || city == 'null') {
      setchnagesdon(true);
      setfieldmessage('please enter the city');
    } else if (state == null || state == 'null') {
      setchnagesdon(true);
      setfieldmessage('please enter the state');
    } else if (family == null || family == 'null') {
      setchnagesdon(true);
      setfieldmessage('please enter the family');
    } else {
      setchnagesdon(false);
      setfieldmessage(null);
    }
    // if ( name != 'null') {
    //   _changedone = true;
    // } else if ( height != 'null') {
    //   _changedone = true;
    // } else if (_userProfile.weight != null || _userProfile.weight != 'null') {
    //   _changedone = true;
    // } else {
    //   _istextfalse = false;
    // }
    notifyListeners();
  }

  Future<UserModel?> fetchProfile() async {
    setProfilefetched(false);
    setLoading(true);
    try {
      //   final String _uid = await SharedPreferences.getInstance()
      //       .then((value) => value.getString('uid')!);
      // final String _uid = _auth.currentUser!.uid;

      final UserModel? responce =
          await readUserInDatabase(FirebaseAuth.instance.currentUser!.uid);

      if (kDebugMode) {
        print('=======================user read: ${responce?.toMap()}');
      }
      if (responce != null) {
        setProfilefetched(true);
        setUserModel(responce);
        setLoading(false);
        return responce;
        // await boxuser.put(
        //     'primaryuser',
        //     UserModelHive(
        //       uid: responce.uid,
        //       name: responce.name,
        //       email: responce.email,
        //       profilePic: responce.profilePic,
        //       phone: int.parse(responce.phone),
        //       height: int.parse(responce.height),
        //       weight: int.parse(responce.weight),
        //       house: responce.house,
        //       city: responce.city,
        //       state: responce.state,
        //       family: responce.family,
        //       gender: int.parse(responce.gender.toString()),
        //       age: responce.age,
        //     ));
      } else {
        setProfilefetched(false);
        setLoading(false);
      }
      if (kDebugMode) {
        print('=======================user read: $responce');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
