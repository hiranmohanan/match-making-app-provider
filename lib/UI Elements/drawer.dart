import 'package:flutter/material.dart';
import 'package:match_making_test/provider/firebase_signout_provider.dart';
import 'package:provider/provider.dart';

class AppDrawerCommon extends StatefulWidget {
  const AppDrawerCommon({super.key});

  @override
  State<AppDrawerCommon> createState() => _AppDrawerCommonState();
}

class _AppDrawerCommonState extends State<AppDrawerCommon> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const Card(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: FlutterLogo(),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User Name'),
                  subtitle: Text('User Email'),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: const Text('Search'),
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Provider.of<FirebaseSignoutProvider>(context, listen: false)
                  .signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
