import 'package:firebase_auth/firebase_auth.dart';
import 'package:match_making_test/firebase/firebase_provider.dart';

Future<String?> signIn(
    {required String email, required String password}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseLoginProvider().setUserLoggedIn(true);
    FirebaseLoginProvider().setResponce("Signed in");
    return "Signed in";
  } on FirebaseAuthException catch (e) {
    FirebaseLoginProvider().setResponce(e.message!);
    // Handle different error codes here
    if (e.code == 'user-not-found') {
      return "No user found for that email.";
    } else if (e.code == 'wrong-password') {
      return "Wrong password provided for that user.";
    } else {
      return e.message; // Generic error message
    }
  }
}
