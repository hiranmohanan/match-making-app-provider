import 'package:flutter/material.dart';
import 'package:match_making_test/provider/firebase_signout_provider.dart';
import 'package:match_making_test/shared/colors.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:match_making_test/shared/text_styles.dart';
import 'package:provider/provider.dart';

class AppDrawerCommon extends StatefulWidget {
  final int? index;
  const AppDrawerCommon({
    super.key,
    required this.index,
  });

  @override
  State<AppDrawerCommon> createState() => _AppDrawerCommonState();
}

class _AppDrawerCommonState extends State<AppDrawerCommon> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: KConstantColors.dimWhite,
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  vSizedBox2,
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: KConstantColors.extraFaintPurple,
                      radius: 50,
                      child: FlutterLogo(
                        curve: Curves.bounceIn,
                        size: 50,
                        textColor: KConstantColors.dimWhite,
                        style: FlutterLogoStyle.stacked,
                      ),
                    ),
                  ),
                  ListTile(
                    // leading: Icon(Icons.person),
                    title: Text(
                      'User Name',
                      style: KCustomTextStyle.kBold(
                        context,
                        12,
                        KConstantColors.textFieldTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.index == 0
              ? const SizedBox()
              : ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
          widget.index == 1
              ? const SizedBox()
              : ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
          widget.index == 2
              ? const SizedBox()
              : ListTile(
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
