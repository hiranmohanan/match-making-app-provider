import 'package:firebase_auth/firebase_auth.dart';

Future<String?> firebasesignout() async {
  try {
    await FirebaseAuth.instance.signOut();
    return "Signed out";
  } on FirebaseAuthException catch (e) {
    // showing exception messages
    return 'Error Signing out: ${e.message}';
  }
}
