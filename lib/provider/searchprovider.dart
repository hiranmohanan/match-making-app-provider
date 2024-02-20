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

  void filter() {
    // final List<UserModel> users = _searchList;

    if (_filterheight != null) {
      _searchList.removeWhere(
          (user) => user.height != null && user.height! < _filterheight!);
    }

    if (_filterweight != null) {
      _searchList.removeWhere(
          (user) => user.weight != null && user.weight! < _filterweight!);
    }

    if (_filterage != null) {
      _searchList
          .removeWhere((user) => user.age != null && user.age! < _filterage!);
    }
    notifyListeners();
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
