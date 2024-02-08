import 'package:flutter/foundation.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/database/usermodel.dart';

class ProfileFilterProvider extends ChangeNotifier {
  List<UserModel>? _maleProfile;
  List<UserModel>? _femaleProfile;
  bool _isLoading = false;
  List<UserModel>? get maleProfile => _maleProfile;
  bool get isLoading => _isLoading;
  List<UserModel>? get femaleProfile => _femaleProfile;

  void setMaleProfile(UserModel user) {
    _maleProfile?.add(user);
    notifyListeners();
  }

  void setFemaleprofile(UserModel user) {
    _femaleProfile?.add(user);
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
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
                : int.parse(responce[i].gender.toString()),
          );
          if (kDebugMode) {
            print(
                '=======================data fetched are ${profile.toMap()['gender']}');
          }
          if (profile.gender == 1) {
            setMaleProfile(profile);
          } else if (profile.gender == 0) {
            setFemaleprofile(profile);
          }
        }
        if (kDebugMode) {
          print('=======================data fetched');
          print('male profile: ${_maleProfile?.length}');
          print('female profile: ${_femaleProfile?.length}');
        }
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
