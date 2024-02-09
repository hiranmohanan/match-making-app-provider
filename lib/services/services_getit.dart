import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/firebase_storage_picture.dart';
import '../provider/profile_filter_provider.dart';

class AppServices {
  int currentNavTab = 0;
  int currentDrawer = 0;

  int getCurrentNavTab() {
    return currentNavTab;
  }

  void setCurrentNavTab(int value) {
    currentNavTab = value;
  }

  int getCurrentDrawer() {
    return currentDrawer;
  }

  void setCurrentDrawer(int value) {
    currentDrawer = value;
  }

  void homeloader({required BuildContext context}) {
    Provider.of<ProfileFilterProvider>(context, listen: false).fetchProfile();
  }

  void profileloader({required BuildContext context}) {
    Provider.of<ProfileFilterProvider>(context, listen: false).fetchProfile();
    Provider.of<FirebaseStorageProvider>(context, listen: false)
        .getLocalImage();
  }
}
