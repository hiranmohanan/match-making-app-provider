import 'package:firebase_auth/firebase_auth.dart';
import 'package:match_making_test/provider/firebase_signup_provider.dart';

Future<String?> firebaseSignup(
    {required String email, required String password}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    FirebaseSignupProvider().setUserLoggedIn(true);
    return "Signed up";
  } on FirebaseAuthException catch (e) {
    FirebaseSignupProvider().setUserLoggedIn(false);
    FirebaseSignupProvider().setResponce(e.message!);
    // Handle different error codes here
    if (e.code == 'weak-password') {
      return e.message!;
    } else if (e.code == 'email-already-in-use') {
      return e.message!;
    } else {
      return 'Error Signing Up :${e.message}'; // Generic error message
    }
  }
}
