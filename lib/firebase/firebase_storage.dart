import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FireStorage {
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();
  // final imagesRef = storageRef.child("images");

  Future<String> uploadFile(PlatformFile filePath, String uid) async {
    final ref = storage.ref().child('profilepics/$uid.jpg');
    await ref.putFile(File(filePath.path!));
    return await ref.getDownloadURL();
  }

  Future<String?> downloadFile(String uid) async {
    final Directory location = await getApplicationDocumentsDirectory();
    final path = '${location.path}/$uid.jpg';
    try {
      final ref = storage.ref().child('profilepics/$uid.jpg');
      final file = File("${location.path}/$uid.jpg");
      final downloadTask = ref.writeToFile(file);
      downloadTask.snapshotEvents.listen((taskSnapshot) {
        if (kDebugMode) {
          print('=============takeshot out $taskSnapshot \n nwpath==$path');
        }
        switch (taskSnapshot.state) {
          case TaskState.running:
            // TODO: Handle this case.
            if (kDebugMode) {
              print('download complete');
            }

            break;
          case TaskState.paused:
            // TODO: Handle this case.
            if (kDebugMode) {
              print('download paused');
            }
            break;
          case TaskState.success:
            // TODO: Handle this case.
            if (kDebugMode) {
              print('download success');
            }
            break;
          case TaskState.canceled:
            // TODO: Handle this case.
            if (kDebugMode) {
              print('download canceled');
            }
            break;
          case TaskState.error:
            // TODO: Handle this case.
            if (kDebugMode) {
              print('download error');
            }
            break;
        }
      });
      return path;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString()); // Log the complete error
        print("Error code: ${e.code}");
        print("Error message: ${e.message}");
      }
    }
    return null;
  }
}
