import 'package:flutter/foundation.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/database/usermodel.dart';

class ProfileFilterProvider extends ChangeNotifier {
  List<UserModel>? _maleProfile;
  List<UserModel>? _femaleProfile;
  List<UserModel>? _fullProfile;
  List<UserModel>? _searchProfile;
  bool _isLoading = false;

  List<UserModel>? get maleProfile => _maleProfile;
  List<UserModel>? get femaleProfile => _femaleProfile;
  List<UserModel>? get fullProfile => _fullProfile;
  List<UserModel>? get searchProfile => _searchProfile;

  bool get isLoading => _isLoading;

  void setMaleProfile(List<UserModel> userlist) {
    _maleProfile = userlist;
    notifyListeners();
  }

  void setFemaleprofile(List<UserModel> userlist) {
    _femaleProfile = userlist;
    notifyListeners();
  }

  void setFullProfile(List<UserModel> userlist) {
    _fullProfile = userlist;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void searchloader() {
    _searchProfile = _fullProfile;
    notifyListeners();
  }

  void setSearchprofiles(List<UserModel> userlist) {
    _searchProfile = userlist;
    notifyListeners();
  }

  Future<List<UserModel>?> fetchProfile() async {
    setLoading(true);
    try {
      final List<UserModel>? responce = await getAllUser();
      if (kDebugMode) {
        print(
            '=======================data fetched  ${responce?.map((e) => e.toMap())}');
      }
      if (responce != null) {
        final List<UserModel> responcem = [];
        final List<UserModel> responcef = [];
        final List<UserModel> responceall = [];
        for (int i = 0; i < responce.length; i++) {
          final UserModel profile = UserModel(
            uid: responce[i].uid.toString(),
            name: responce[i].name.toString(),
            email: responce[i].email.toString(),
            profilePic: responce[i].profilePic.toString(),
            phone: responce[i].phone.toString(),
            height: responce[i].height.toString(),
            weight: responce[i].weight.toString(),
            house: responce[i].house.toString(),
            city: responce[i].city.toString(),
            state: responce[i].state.toString(),
            family: responce[i].family.toString(),
            gender: responce[i].gender == null
                ? 3
                : int.parse(
                    responce[i].gender.toString(),
                  ),
            age: responce[i].age,
          );
          responceall.add(profile);
          if (profile.gender == 1) {
            responcem.add(profile);
            // setMaleProfile(profile);
          } else if (profile.gender == 0) {
            // setFemaleprofile(profile);
            responcef.add(profile);
          }
        }
        setMaleProfile(responcem);
        setFemaleprofile(responcef);
        setFullProfile(responceall);
      } else {
        if (kDebugMode) {
          print('=======================error in fetching no data found');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('=======================error in fetching $e');
      }
    }
    setLoading(false);
    return null;
  }
}
