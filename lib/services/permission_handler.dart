import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

permissionhaldlerinit() async {
  try {
    final ext = await Permission.manageExternalStorage.request();
    final ph = await Permission.photos.request();
    final cam = await Permission.camera.request();
    final stor = await Permission.storage.request();
    final media = await Permission.mediaLibrary.request();
    if (ext.isGranted &&
        ph.isGranted &&
        cam.isGranted &&
        stor.isGranted &&
        media.isGranted) {
      if (kDebugMode) {
        print('all permissions granted');
      }
    } else {
      await Permission.manageExternalStorage.request();
      await Permission.photos.request();
      await Permission.camera.request();
      await Permission.storage.request();
      await Permission.mediaLibrary.request();
    }
  } catch (e) {
    if (kDebugMode) {
      print('error in permission handler: $e');
    }
  }
}
