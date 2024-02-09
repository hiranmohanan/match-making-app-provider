import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/database/usermodel.dart';

class ProfileFetchProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel _userProfile = UserModel();
  bool _isLoading = false;
  bool _isProfileFetched = false;
  bool _istextfalse = false;
  bool _changedone = false;

  UserModel get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  bool get isProfileFetched => _isProfileFetched;
  bool get istextfalse => _istextfalse;
  bool get changedone => _changedone;

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

  void validator() {
    if (_userProfile.name!.isNotEmpty) {
      _changedone = true;
    } else if (_userProfile.height != null || _userProfile.height != 'null') {
      _changedone = true;
    } else if (_userProfile.weight != null || _userProfile.weight != 'null') {
      _changedone = true;
    } else {
      _istextfalse = false;
    }
    notifyListeners();
  }

  Future<User?> fetchProfile() async {
    setProfilefetched(false);
    setLoading(true);
    try {
      //   final String _uid = await SharedPreferences.getInstance()
      //       .then((value) => value.getString('uid')!);
      final String _uid = _auth.currentUser!.uid;

      final UserModel? responce = await readUserInDatabase(_uid);
      if (responce != null) {
        setUserModel(responce);
        setProfilefetched(true);
        setLoading(false);
      } else {
        setProfilefetched(false);
        setLoading(false);
        return null;
      }
      if (kDebugMode) {
        print('=======================user read: $responce');
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
