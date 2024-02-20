import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/provider/firebase_signout_provider.dart';
import 'package:match_making_test/provider/profile_filter_provider.dart';
import 'package:match_making_test/shared/colors.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:match_making_test/shared/text_styles.dart';
import 'package:provider/provider.dart';

import '../provider/firebase_profile_fetch_provider.dart';
import '../provider/firebase_storage_picture.dart';
import '../provider/searchprovider.dart';
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
    // final provider = Provider.of<ProfileFilterProvider>(context, listen: true);
    final pictureprovider =
        Provider.of<FirebaseStorageProvider>(context, listen: true);
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: pictureprovider.fileout == null
                        ? const CircleAvatar(
                            radius: 50,
                            child: FlutterLogo(
                              size: 50,
                            ),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: Image.file(
                              File(pictureprovider.fileout!),
                              errorBuilder: (context, error, stackTrace) {
                                return const FlutterLogo();
                              },
                            ).image,
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
                    final provider = Provider.of<ProfileFilterProvider>(context,
                        listen: false);
                    provider.fetchProfile();
                    _appservices.setCurrentNavTab(0);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
          _appservices.getCurrentDrawer() == 1
              ? const SizedBox()
              : ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    final provider = Provider.of<ProfileFetchProvider>(context,
                        listen: false);

                    provider.fetchProfile();
                    FirebaseStorageProvider().downloadFile();
                    _appservices.setCurrentNavTab(1);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/profile');
                  },
                ),
          _appservices.getCurrentDrawer() == 2
              ? const SizedBox()
              : ListTile(
                  title: const Text('Search'),
                  onTap: () {
                    Provider.of<SearchProvider>(context, listen: false)
                        .getdata();

                    _appservices.setCurrentNavTab(2);

                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/search');
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
