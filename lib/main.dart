import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/provider/firebase_login_provider.dart';
import 'package:match_making_test/firebase_options.dart';
import 'package:match_making_test/screens/home/homeScreen.dart';
import 'package:match_making_test/screens/login/loginScreen.dart';
import 'package:match_making_test/shared/theme_data_light.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'provider/firebase_signout_provider.dart';
import 'provider/firebase_signup_provider.dart';
import 'screens/profile/profileScreen.dart';
import 'screens/search page/searchScreen.dart';
import 'screens/signup/signuppage.dart';

void main() {
  beforeStartUp();
  runApp(const MyApp());
}

beforeStartUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Sizer is a package that helps to make the app responsive in basics of height and width
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<FirebaseLoginProvider>(
            create: (_) => FirebaseLoginProvider(),
          ),
          ChangeNotifierProvider<FirebaseSignoutProvider>(
            create: (_) => FirebaseSignoutProvider(),
          ),
          ChangeNotifierProvider<FirebaseSignupProvider>(
            create: (_) => FirebaseSignupProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme is the light theme that is imported from the theme_data_light.dart file
          theme: lightTheme,
          // initialRoute is the first page that will be shown when the app is opened
          initialRoute: '/home',
          // routes are the different pages that are in the app
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const SignUpPage(),
            '/home': (context) => const HomeScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/search': (context) => const SearchScreen(),
          },
        ),
      );
    });
  }
}
