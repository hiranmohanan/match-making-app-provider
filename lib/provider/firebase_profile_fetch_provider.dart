import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/database/usermodel.dart';

class ProfileFetchProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel _userProfile = UserModel();
  bool _isLoading = false;
  bool _isProfileFetched = false;
  bool _istextfalse = false;
  bool _changedone = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _familyController = TextEditingController();

  UserModel get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  bool get isProfileFetched => _isProfileFetched;
  bool get istextfalse => _istextfalse;
  bool get changedone => _changedone;

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

  void setprofilePic() {}
  void saveUserModel({
    String? name,
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
      uid: _userProfile.uid,
      name: name,
      height: height,
      weight: weight,
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
    String? name,
    String? height,
    String? weight,
    String? house,
    String? city,
    String? state,
    String? family,
  }) {
    if (name == null || name == 'null') {
      _istextfalse = true;
    } else if (height == null || height == 'null') {
      _istextfalse = true;
    } else if (weight == null || weight == 'null') {
      _istextfalse = true;
    } else if (house == null || house == 'null') {
      _istextfalse = true;
    } else if (city == null || city == 'null') {
      _istextfalse = true;
    } else if (state == null || state == 'null') {
      _istextfalse = true;
    } else if (family == null || family == 'null') {
      _istextfalse = true;
    } else {
      _istextfalse = false;
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

  Future<void> fetchProfile() async {
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
  }
}
