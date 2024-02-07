import 'package:flutter/material.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../UI Elements/drawer.dart';
import '../../provider/firebase_profile_fetch_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileFetchProvider>(context, listen: false);
    provider.fetchProfile();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (value == 1) {
            Navigator.pushNamed(context, '/profile');
          } else if (value == 2) {
            Navigator.pushNamed(context, '/search');
          }
        },
        currentIndex: 1,
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
      ),
      drawer: const AppDrawerCommon(
        index: 1,
      ),
      body: Center(
          child: Container(
        height: 90.h,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
                width: 30.h,
                child: const FlutterLogo(),
              ),
              vSizedBox1,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
              vSizedBox1,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Height',
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
              vSizedBox1,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
              vSizedBox1,
              ExpansionTile(
                  title: const Text('Address'),
                  childrenPadding: const EdgeInsets.all(10),
                  tilePadding: const EdgeInsets.all(10),
                  maintainState: true,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'House Name/Number',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    vSizedBox1,
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Street',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    vSizedBox1,
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'City',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    vSizedBox1,
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'State',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    vSizedBox1,
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    vSizedBox1,
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Pincode',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ]),
              ExpansionTile(
                  title: const Text('Family Members'),
                  childrenPadding: const EdgeInsets.all(10),
                  tilePadding: const EdgeInsets.all(10),
                  maintainState: true,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    vSizedBox1,
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    vSizedBox1,
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Relation',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ])
            ],
          ),
        ),
      )),
    );
  }
}
