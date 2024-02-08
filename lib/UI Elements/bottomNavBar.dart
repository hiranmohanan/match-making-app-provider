import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../provider/firebase_profile_fetch_provider.dart';
import '../services/services_getit.dart';

class BottomNavBr extends StatelessWidget {
  const BottomNavBr({super.key});

  @override
  Widget build(BuildContext context) {
    final AppServices _appservices = GetIt.instance<AppServices>();
    return BottomNavigationBar(
      currentIndex: _appservices.getCurrentNavTab(),
      onTap: (value) {
        if (_appservices.getCurrentNavTab() == value) {
          return;
        } else {
          if (value == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (value == 1) {
            Provider.of<ProfileFetchProvider>(context, listen: false)
                .fetchProfile();
            Navigator.pushNamed(context, '/profile');
          } else if (value == 2) {
            Navigator.pushNamed(context, '/search');
          }
        }
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(Icons.home_outlined)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            activeIcon: Icon(Icons.person_outlined)),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            activeIcon: Icon(Icons.search_outlined)),
      ],
    );
  }
}