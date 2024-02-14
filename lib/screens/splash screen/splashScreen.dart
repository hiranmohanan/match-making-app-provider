import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:match_making_test/UI%20Elements/lottie.dart';
import 'package:provider/provider.dart';

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
    // Provider.of<ProfileFilterProvider>(context, listen: false).getCurrenthive();
    // Provider.of<ProfileFetchProvider>(context, listen: false).fetchProfile();
    // Provider.of<FirebaseStorageProvider>(context, listen: false)
    //     .getLocalImage();
    // ProfileFilterProvider().fetchProfile();
    Navigator.pushReplacementNamed(context, '/home');
  }

  navigatetologin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void navigateToNextScreen() async {
    // Simulate some delay before navigating to the next screen
    await Future.delayed(const Duration(seconds: 5));
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
              return Center(
                  child: Lottie.asset(LottieDir().animWelcome, repeat: true));
            } else {
              return Center(
                  child: Lottie.asset(LottieDir().animWelcome, repeat: true));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
