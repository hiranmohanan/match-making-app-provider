import 'package:firebase_auth/firebase_auth.dart';
import 'package:match_making_test/database/usermodel.dart';
import 'package:match_making_test/provider/firebase_login_provider.dart';
import 'package:match_making_test/provider/firebase_profile_fetch_provider.dart';

import '../local data/boxes.dart';
import '../local data/hive.dart';

Future<String?> signIn(
    {required String email, required String password}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseLoginProvider().setUserLoggedIn(true);
    FirebaseLoginProvider().setResponce("Signed in");
    final UserModel? user = await ProfileFetchProvider().fetchProfile();
    if (user != null) {
      await boxuser.put(
          'primaryuser',
          UserModelHive(
            uid: user.uid,
            fname: user.fname,
            lname: user.lname,
            email: user.email,
            profilePic: null,
            phone: user.phone,
            height: user.height,
            weight: user.weight,
            house: user.house,
            city: user,
            state: user.state,
            family: user.family,
            gender: user.gender,
            age: user.age,
          ));
    }
    return "Signed in";
  } on FirebaseAuthException catch (e) {
    FirebaseLoginProvider().setResponce(e.message!);
    // Handle different error codes here
    if (e.code == 'user-not-found') {
      return "No user found for that email.";
    } else if (e.code == 'wrong-password') {
      return "Wrong password ";
    } else {
      return 'Error Signing in :${e.message}'; // Generic error message
    }
  }
}
