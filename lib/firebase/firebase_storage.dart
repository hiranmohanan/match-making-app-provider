import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FireStorage {
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  // final imagesRef = storageRef.child("images");

  Future<String> uploadFile(PlatformFile filePath, String uid) async {
    final ref = storage.ref().child('profilepics/$uid.jpg');
    await ref.putFile(File(filePath.path!));
    return await ref.getDownloadURL();
  }

  Future<bool> checkMetadata() async {
    return await storage
        .ref()
        .child('profilepics/$uid.jpg')
        .getMetadata()
        .then((value) => true)
        .catchError((onError) => false);
  }

  Future<String?> downloadFile(String uid) async {
    final Directory location = await getApplicationDocumentsDirectory();
    final path = '${location.path}/$uid.jpg';
    try {
      final ref = storage.ref().child('profilepics/$uid.jpg');

      final file = File("${location.path}/$uid.jpg");

      final bool = await checkMetadata();
      if (bool == false) {
        return null;
      } else if (bool == true) {
        final downloadTask = ref.writeToFile(file);
        downloadTask.snapshotEvents.listen(
          (taskSnapshot) {
            if (kDebugMode) {
              print('=============takeshot out $taskSnapshot \n nwpath==$path');
            }
            switch (taskSnapshot.state) {
              case TaskState.running:
                // TODO: Handle this case.
                if (kDebugMode) {
                  print('download running');
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
          },
          onError: (error) {
            // This is where you handle errors from the stream
            if (error is FirebaseException &&
                error.code == 'object-not-found') {
              if (kDebugMode) {
                print(
                    'File does not exist at the specified location: profilepics/$uid.jpg');
              }
              // Handle the file not existing case
            } else {
              if (kDebugMode) {
                print('An unexpected error occurred: $error');
              }
              // Handle other errors
            }
          },
        );

        return path;
      }
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        // This is where you handle the case for the file not existing
        if (kDebugMode) {
          print(
              'File does not exist at the specified location: profilepics/$uid.jpg');
        }
      } else {
        // Handle other Firebase exceptions
        if (kDebugMode) {
          print(
              "FirebaseException, Error code: ${e.code}, Error message: ${e.message}");
        }
      }
      return null;
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print("An unexpected error occurred: $e");
      }
      return null;
    }
    return null;
  }
}
