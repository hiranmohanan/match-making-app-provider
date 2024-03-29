import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:match_making_test/database/db.dart';
import 'package:match_making_test/database/usermodel.dart';

import '../firebase/firebase_storage.dart';
import '../local data/boxes.dart';
import '../local data/hive.dart';

class ProfileFilterProvider extends ChangeNotifier {
  List<UserModel>? _maleProfile;
  List<UserModel>? _femaleProfile;
  List<UserModel> _fullProfile = [];
  List<UserModel>? _searchProfile;
  TextEditingController _searchcontroller = TextEditingController();
  bool _isLoading = false;
  bool? _isloadingimg;
  List<String>? _imgurl;
  List<String> _imgurl1 = [];
  UserModel? _selecedprofile;

  List<UserModel>? get maleProfile => _maleProfile;
  List<UserModel>? get femaleProfile => _femaleProfile;
  List<UserModel> get fullProfile => _fullProfile;
  List<UserModel>? get searchProfile => _searchProfile;
  TextEditingController get searchcontroller => _searchcontroller;

  bool get isLoading => _isLoading;
  bool? get isloadingimg => _isloadingimg;
  List<String>? get imgurl => _imgurl;
  UserModel? get selecedprofile => _selecedprofile;

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

  void setselectprofile(UserModel val) {
    _selecedprofile = val;
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
        // final List<UserModel> responceall = [];
        // responce.asMap().forEach((index, value) async {
        //   await getimagelink(uid: value.uid.toString());
        //   final UserModel profile1 = UserModel(
        //     uid: value.uid.toString(),
        //     fname: value.fname.toString(),
        //     lname: value.lname.toString(),
        //     email: value.email.toString(),
        //     profilePic: _imgurl1[index],
        //     phone: value.phone.toString(),
        //     height: value.height.toString(),
        //     weight: value.weight.toString(),
        //     house: value.house.toString(),
        //     city: value.city.toString(),
        //     state: value.state.toString(),
        //     family: value.family.toString(),
        //   );
        // });
        for (int i = 0; i < responce.length; i++) {
          await getimagelink(uid: responce[i].uid.toString());
          final UserModel profile = UserModel(
            uid: responce[i].uid.toString(),
            fname: responce[i].fname.toString(),
            lname: responce[i].lname.toString(),
            email: responce[i].email.toString(),
            profilePic: _imgurl1[i],
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

          boxuser = await Hive.openBox<UserModelHive>('userBox');
          if (boxuser.get('primaryuser') != null) {
            final UserModelHive user = boxuser.get('primaryuser');

            if (user.gender != profile.gender) {
              _fullProfile.add(profile);
            }
          }
          setimgurl(_imgurl1);
        }
        notifyListeners();
        // setFullProfile(responceall);
        setLoading(false);
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
