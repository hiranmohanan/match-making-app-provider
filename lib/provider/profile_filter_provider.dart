import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/database/usermodel.dart';

import '../firebase/firebase_storage.dart';

class ProfileFilterProvider extends ChangeNotifier {
  List<UserModel>? _maleProfile;
  List<UserModel>? _femaleProfile;
  List<UserModel>? _fullProfile;
  List<UserModel>? _searchProfile;
  TextEditingController _searchcontroller = TextEditingController();
  bool _isLoading = false;
  bool? _isloadingimg;
  List<String>? _imgurl;
  List<String> _imgurl1 = [];

  List<UserModel>? get maleProfile => _maleProfile;
  List<UserModel>? get femaleProfile => _femaleProfile;
  List<UserModel>? get fullProfile => _fullProfile;
  List<UserModel>? get searchProfile => _searchProfile;
  TextEditingController get searchcontroller => _searchcontroller;

  bool get isLoading => _isLoading;
  bool? get isloadingimg => _isloadingimg;
  List<String>? get imgurl => _imgurl;

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

  void getCurrenthive() {
    // boxuser.get('primaryuser');
    // if (kDebugMode) {
    //   print(
    //       '=======================current hive user ${boxuser.get('primaryuser')}');
    // }
  }
  void setisloadingimg(bool? val) {
    _isloadingimg = val;
    notifyListeners();
  }

  void setimgurl(List<String>? val) {
    _imgurl = val;
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
            fname: responce[i].fname.toString(),
            lname: responce[i].lname.toString(),
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
          await getimagelink(uid: responce[i].uid.toString());
          if (profile.gender == 1) {
            responcem.add(profile);
            // setMaleProfile(profile);
          } else if (profile.gender == 0) {
            // setFemaleprofile(profile);
            responcef.add(profile);
          }
        }
        setimgurl(_imgurl1);
        if (kDebugMode) {
          print('=======================responce of image : ${imgurl?.length}');
          print("=======================imgurl: $_imgurl1");
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

  Future<void> getimagelink({required String uid}) async {
    setisloadingimg(true);
    final responce = await FireStorage().getimagelink(uid: uid);

    if (responce != null) {
      _imgurl1.add(responce);
    } else {
      _imgurl1.add(
          'https://firebasestorage.googleapis.com/v0/b/match-making-app-bbfd5.appspot.com/o/profilepics%2F6i8pcqPckaUiUDR2umSBdaeOhn13.jpg?alt=media&token=f396558d-5800-4914-9478-3dd9d74acb34');
    }
    setisloadingimg(false);
  }
}
