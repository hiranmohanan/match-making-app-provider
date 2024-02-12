import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:match_making_test/firebase/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageProvider extends ChangeNotifier {
  bool _isImageUploading = false;
  String _imageUrl = '';
  PlatformFile? _file;
  String? _imglink;
  String? _fileout;
  String? _responcepath;

  bool get isImageUploading => _isImageUploading;
  String get imageUrl => _imageUrl;
  PlatformFile? get file => _file;
  String? get imagelink => _imglink;
  String? get fileout => _fileout;
  String? get responcepath => _responcepath;

  void setImageUploading(bool value) {
    _isImageUploading = value;
    notifyListeners();
  }

  void setImageUrl(String value) {
    _imageUrl = value;
    notifyListeners();
  }

  void setFile(PlatformFile value) {
    _file = value;
    notifyListeners();
  }

  void setimglink(String val) {
    _imglink = val;
    notifyListeners();
  }

  void setfileout(String? val) {
    _fileout = val;
    notifyListeners();
  }

  void setresponcepath(String? val) {
    _responcepath = val;
    notifyListeners();
  }

  Future<void> getLocalImage() async {
    if (_fileout != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final Directory location = await getApplicationDocumentsDirectory();
      final path = '${location.path}/$uid.jpg';

      _fileout = path;
      notifyListeners();
    }
  }

  Future<void> selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowCompression: true,
      );
      if (result != null) {
        setFile(result.files.first);
      }
    } catch (e) {
      if (kDebugMode) {
        print('==================error in selecting file $e');
      }
    }
  }

  Future<void> uploadfile() async {
    try {
      FireStorage().uploadFile(_file!, FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      if (kDebugMode) {
        print('exception occures===================== $e');
      }
    }
  }

  Future<void> downloadFile() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final fileout = await FireStorage().downloadFile(uid);

      setfileout(fileout);
      // if (fileout != null) {
      //   setfileout(fileout);
      // }
      // setresponcepath(fileout);
      // if (fileout == null) {
      //   setfileout(null);
      // }
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        setfileout(null);
      }
    }
  }
}
