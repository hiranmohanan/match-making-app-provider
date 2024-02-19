import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:match_making_test/local%20data/boxes.dart';
import 'package:match_making_test/local%20data/hive.dart';
import 'package:match_making_test/provider/firebase_login_provider.dart';
import 'package:match_making_test/firebase_options.dart';
import 'package:match_making_test/provider/firebase_profile_fetch_provider.dart';
import 'package:match_making_test/provider/firebase_storage_picture.dart';
import 'package:match_making_test/provider/profile_filter_provider.dart';
import 'package:match_making_test/screens/home/homeScreen.dart';
import 'package:match_making_test/screens/login/loginScreen.dart';
import 'package:match_making_test/screens/search%20page/searchview.dart';
import 'package:match_making_test/service%20locator.dart';
import 'package:match_making_test/shared/theme_data_light.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'provider/firebase_signout_provider.dart';
import 'provider/firebase_signup_provider.dart';
import 'screens/profile/profileScreen.dart';
import 'screens/search page/searchScreen.dart';
import 'screens/signup/signuppage.dart';
import 'screens/splash screen/splashScreen.dart';

// Starting the application with void main

Future<void> main() async {
  // before the app staring we initialize the firebase core and set our options for it
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // initializing hive for local storage
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelHiveAdapter());
  boxuser = await Hive.openBox<UserModelHive>('userBox');
// dependency injuction using getIt is initializing
  serviceLocator();

  runApp(const MyApp());
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
          ChangeNotifierProvider<ProfileFetchProvider>(
            create: (_) => ProfileFetchProvider(),
          ),
          ChangeNotifierProvider<ProfileFilterProvider>(
            create: (_) => ProfileFilterProvider(),
          ),
          ChangeNotifierProvider<FirebaseStorageProvider>(
            create: (_) => FirebaseStorageProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme is the light theme that is imported from the theme_data_light.dart file
          theme: FlexThemeData.light(scheme: FlexScheme.indigoM3),
          darkTheme: FlexThemeData.dark(scheme: FlexScheme.indigoM3),
          // initialRoute is the first page that will be shown when the app is opened
          initialRoute: '/splash',
          // routes are the different pages that are in the app
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/login': (context) => const LoginPage(),
            '/register': (context) => const SignUpPage(),
            '/home': (context) {
              // Provider.of<ProfileFilterProvider>(context, listen: false)
              //     .fetchProfile();
              // Provider.of<ProfileFetchProvider>(context, listen: false)
              //     .fetchProfile();

              return const HomeScreen();
            },
            '/profile': (context) {
              // Provider.of<FirebaseStorageProvider>(context, listen: false)
              //     .downloadFile(FirebaseAuth.instance.currentUser!.uid).then((value) => null);
              // Provider.of<ProfileFetchProvider>(context, listen: false)
              //     .fetchProfile();
              return const ProfileScreen();
            },
            '/search': (context) => const SearchScreen(),
            '/searchview': (context) => const SearchView(),
          },
        ),
      );
    });
  }
}
