import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/provider/firebase_signout_provider.dart';
import 'package:match_making_test/shared/colors.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:match_making_test/shared/text_styles.dart';
import 'package:provider/provider.dart';

import '../provider/firebase_profile_fetch_provider.dart';
import '../services/services_getit.dart';

class AppDrawerCommon extends StatefulWidget {
  const AppDrawerCommon({
    super.key,
  });

  @override
  State<AppDrawerCommon> createState() => _AppDrawerCommonState();
}

class _AppDrawerCommonState extends State<AppDrawerCommon> {
  final AppServices _appservices = GetIt.instance<AppServices>();
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
          _appservices.getCurrentDrawer() == 0
              ? const SizedBox()
              : ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    _appservices.setCurrentNavTab(0);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home');
                  },
                ),
          _appservices.getCurrentDrawer() == 1
              ? const SizedBox()
              : ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Provider.of<ProfileFetchProvider>(context, listen: false)
                        .fetchProfile();
                    _appservices.setCurrentNavTab(1);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
          _appservices.getCurrentDrawer() == 2
              ? const SizedBox()
              : ListTile(
                  title: const Text('Search'),
                  onTap: () {
                    _appservices.setCurrentNavTab(2);
                    Navigator.pop(context);
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
