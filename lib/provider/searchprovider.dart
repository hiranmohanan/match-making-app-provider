import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:match_making_test/local%20data/boxes.dart';

import '../database/db.dart';
import '../database/usermodel.dart';
import '../firebase/firebase_storage.dart';
import '../local data/hive.dart';

class SearchProvider extends ChangeNotifier {
  // initializing the search list
  bool _isloading = false;
  bool _isloadingimg = false;
  int? _filterheight;
  int? _filterweight;
  int? _filterage;
  UserModel? _selecedprofile;
  List<UserModel> _searchList = [];
  List<String> _imgurl1 = [];
  TextEditingController _searchcontroller = TextEditingController();

  // getters
  bool get isloading => _isloading;
  bool get isloadingimg => _isloadingimg;
  int? get filterheight => _filterheight;
  int? get filterweight => _filterweight;
  int? get filterage => _filterage;
  UserModel? get selecedprofile => _selecedprofile;
  List<UserModel> get searchList => _searchList;
  List<String> get imgurl1 => _imgurl1;
  TextEditingController get searchcontroller => _searchcontroller;

  // setters
  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void setisloadingimg(bool value) {
    _isloadingimg = value;
    notifyListeners();
  }

  void setSearchList(List<UserModel> list) {
    _searchList = list;
    notifyListeners();
  }

  void setimgurl1(List<String> value) {
    _imgurl1 = value;
    notifyListeners();
  }

  void clearsearch() {
    _searchList.clear();
    notifyListeners();
  }

  void getdata() {
    clearsearch();
    _searchcontroller.clear();
    fetchProfile();
  }

  void setselectprofile(UserModel val) {
    _selecedprofile = val;
    notifyListeners();
  }

  void callfilter({
    required int? height,
    required int? weight,
    required int? age,
  }) {
    _filterheight = height;
    _filterweight = weight;
    _filterage = age;
    notifyListeners();
    filter();
  }

  void setfiltrhight(int? val) {
    _filterheight = val;
    notifyListeners();
  }

  void setfiltrweight(int? val) {
    _filterweight = val;
    notifyListeners();
  }

  void setfiltrage(int? val) {
    _filterage = val;
    notifyListeners();
  }

  Future<void> filter() async {
    await fetchProfile();
    setLoading(true);
    // final List<UserModel> users = _searchList;
    // notifyListeners();

    if (_filterheight != null) {
      _searchList.removeWhere((user) {
        if (kDebugMode) {
          print(
              '=======================height ${user.height} filter $_filterheight');
        }
        if (user.height != 'null') {
          if (_filterheight == 130) {
            return int.parse(user.height) >= 130;
          } else if (_filterheight == 160) {
            return int.parse(user.height) < 130 &&
                int.parse(user.height) >= 160;
          } else if (_filterheight == 200) {
            return int.parse(user.height) <= 160 &&
                int.parse(user.height) < 200;
          } else {
            return int.parse(user.height) < 200;
          }
        } else {
          return false;
        }
      });
    }

    if (_filterweight != null) {
      _searchList.removeWhere((user) {
        if (user.weight != 'null') {
          if (_filterweight == 50) {
            return int.parse(user.weight) >= 50;
          } else if (_filterweight == 70) {
            return int.parse(user.weight) < 50 && int.parse(user.weight) >= 70;
          } else if (_filterweight == 90) {
            return int.parse(user.weight) < 70 && int.parse(user.weight) >= 90;
          } else if (_filterweight == 110) {
            return int.parse(user.weight) < 90 && int.parse(user.weight) >= 110;
          } else if (_filterweight == 130) {
            return int.parse(user.weight) < 110 &&
                int.parse(user.weight) >= 130;
          } else if (_filterweight == 150) {
            return int.parse(user.weight) < 130 &&
                int.parse(user.weight) >= 150;
          } else if (_filterweight == 170) {
            return int.parse(user.weight) < 150 &&
                int.parse(user.weight) >= 170;
          } else if (_filterweight == 190) {
            return int.parse(user.weight) < 170 &&
                int.parse(user.weight) >= 190;
          } else if (_filterweight == 210) {
            return int.parse(user.weight) < 190 &&
                int.parse(user.weight) >= 210;
          } else if (_filterweight == 230) {
            return int.parse(user.weight) < 210 &&
                int.parse(user.weight) >= 230;
          } else if (_filterweight == 250) {
            return int.parse(user.weight) < 230 &&
                int.parse(user.weight) >= 250;
          } else if (_filterweight == 270) {
            return int.parse(user.weight) < 250 &&
                int.parse(user.weight) >= 270;
          } else if (_filterweight == 290) {
            return int.parse(user.weight) < 270 &&
                int.parse(user.weight) >= 290;
          } else if (_filterweight == 310) {
            return int.parse(user.weight) < 290 &&
                int.parse(user.weight) >= 310;
          } else if (_filterweight == 330) {
            return int.parse(user.weight) < 310 &&
                int.parse(user.weight) >= 330;
          } else if (_filterweight == 350) {
            return int.parse(user.weight) < 330 &&
                int.parse(user.weight) >= 350;
          } else if (_filterweight == 370) {
            return int.parse(user.weight) < 350 &&
                int.parse(user.weight) >= 370;
          }
        } else {
          return false;
        }
        {
          return false;
        }
      });
    }
    if (_filterage != null) {
      _searchList.removeWhere((user) {
        if (user.age != null) {
          if (_filterage! < 18) {
            return false;
          }
          if (_filterage == 20) {
            return _filterage! <= 20;
          } else if (_filterage == 30) {
            return _filterage! <= 30;
          } else if (_filterage == 40) {
            return _filterage! <= 40;
          } else if (_filterage == 50) {
            return _filterage! <= 50;
          } else if (_filterage == 60) {
            return _filterage! <= 60;
          } else if (_filterage == 70) {
            return _filterage! <= 70;
          } else if (_filterage == 80) {
            return _filterage! <= 80;
          } else if (_filterage == 90) {
            return _filterage! <= 90;
          } else if (_filterage == 100) {
            return _filterage! <= 100;
          } else if (_filterage == 110) {
            return _filterage! <= 110;
          } else if (_filterage == 120) {
            return _filterage! <= 120;
          } else if (_filterage == 130) {
            return _filterage! <= 130;
          } else if (_filterage == 140) {
            return _filterage! <= 140;
          } else if (_filterage == 150) {
            return _filterage! <= 150;
          } else if (_filterage == 160) {
            return _filterage! <= 160;
          } else if (_filterage == 170) {
            return _filterage! <= 170;
          } else if (_filterage == 180) {
            return _filterage! <= 180;
          } else if (_filterage == 190) {
            return _filterage! <= 190;
          } else if (_filterage == 200) {
            return _filterage! <= 200;
          } else if (_filterage == 210) {
            return _filterage! <= 210;
          } else if (_filterage == 220) {
            return _filterage! <= 220;
          } else if (_filterage == 230) {
            return _filterage! <= 230;
          } else {
            return false;
          }
        }
        return false;
      });
    }
    // setSearchList(users);
    setLoading(false);
  }

  Future<void> search() async {
    if (_searchcontroller.text.isEmpty) {
    } else {
      setLoading(true);
      final List<UserModel> _search = [];
      for (int i = 0; i < _searchList.length; i++) {
        if (_searchList[i]
                .fname!
                .toLowerCase()
                .contains(searchcontroller.text) ||
            _searchList[i]
                .lname!
                .toLowerCase()
                .contains(searchcontroller.text) ||
            _searchList[i]
                .city!
                .toLowerCase()
                .contains(searchcontroller.text) ||
            _searchList[i]
                .state!
                .toLowerCase()
                .contains(searchcontroller.text) ||
            _searchList[i]
                .family!
                .toLowerCase()
                .contains(searchcontroller.text)) {
          _search.add(_searchList[i]);
        }
      }

      setSearchList(_search);
      setLoading(false);
    }
  }

  Future<List<UserModel>?> fetchProfile() async {
    setLoading(true);
    setSearchList([]);
    try {
      final List<UserModel>? responce = await getAllUser();
      if (kDebugMode) {
        print(
            '=======================data fetched  ${responce?.map((e) => e.toMap())}');
      }
      if (responce != null) {
        // final List<UserModel> responcem = [];
        // final List<UserModel> responcef = [];
        // final List<UserModel> responceall = [];
        for (int i = 0; i < responce.length; i++) {
          String img = await getimagelink(uid: responce[i].uid.toString());
          final UserModel profile = UserModel(
            uid: responce[i].uid.toString(),
            fname: responce[i].fname.toString(),
            lname: responce[i].lname.toString(),
            email: responce[i].email.toString(),
            profilePic: img,
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
              _searchList.add(profile);
            }
          }
          // responceall.add(profile);
          // if (profile.gender == 1) {
          //   responcem.add(profile);
          // } else if (profile.gender == 0) {
          //   responcef.add(profile);
          // }
        }

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

  Future<String> getimagelink({required String uid}) async {
    setisloadingimg(true);
    try {
      final responce = await FireStorage().getimagelink(uid: uid);

      if (responce != null) {
        setisloadingimg(false);
        return responce;
      } else {
        setisloadingimg(false);
        return 'https://firebasestorage.googleapis.com/v0/b/match-making-app-bbfd5.appspot.com/o/profilepics%2F6i8pcqPckaUiUDR2umSBdaeOhn13.jpg?alt=media&token=f396558d-5800-4914-9478-3dd9d74acb34';
      }
    } catch (e) {
      setisloadingimg(false);
      return 'https://firebasestorage.googleapis.com/v0/b/match-making-app-bbfd5.appspot.com/o/profilepics%2F6i8pcqPckaUiUDR2umSBdaeOhn13.jpg?alt=media&token=f396558d-5800-4914-9478-3dd9d74acb34';
    }
  }
}
