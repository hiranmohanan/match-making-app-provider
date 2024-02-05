import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> signUpwithemailandpassword(
    String email, String password) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}
