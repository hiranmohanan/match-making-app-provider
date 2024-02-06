import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../UI Elements/drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: const AppDrawerCommon(),
      body: Center(
          child: Card(
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
              SizedBox(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    suffixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
              SizedBox(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Height',
                    suffixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
              SizedBox(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Weight',
                    suffixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
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
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Street',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'City',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'State',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
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
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
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
      ))),
    );
  }
}
