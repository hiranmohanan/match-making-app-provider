import 'package:firebase_auth/firebase_auth.dart';

Future<void> signout() async {
  await FirebaseAuth.instance.signOut();
}
