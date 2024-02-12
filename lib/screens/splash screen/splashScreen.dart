import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/provider/firebase_storage_picture.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/firebase_profile_fetch_provider.dart';
import '../../provider/profile_filter_provider.dart';
import '../../services/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    permissionhaldlerinit();
    navigateToNextScreen();
  }

  navigatetohome() {
    Provider.of<ProfileFilterProvider>(context, listen: false).fetchProfile();
    Provider.of<ProfileFilterProvider>(context, listen: false).getCurrenthive();
    Provider.of<ProfileFetchProvider>(context, listen: false).fetchProfile();
    Provider.of<FirebaseStorageProvider>(context, listen: false)
        .getLocalImage();

    Navigator.pushReplacementNamed(context, '/home');
  }

  navigatetologin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void navigateToNextScreen() async {
    // Simulate some delay before navigating to the next screen
    await Future.delayed(const Duration(seconds: 2));
    // Determine which screen to navigate to based on some condition

    if (FirebaseAuth.instance.currentUser == null) {
      navigatetologin();
    } else {
      navigatetohome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // Hear we are checking is any user is logged in or not if not already logged in then goes to login page else home [age]
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const Center(child: Text('Welcome!'));
            } else {
              return const Center(child: Text('Welcome Back!'));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
