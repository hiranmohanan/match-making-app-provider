import 'package:flutter/material.dart';
import 'package:match_making_test/UI%20Elements/drawer.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawerCommon(
        index: 0,
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
      body: Center(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              child: SizedBox(
            height: 90.h,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 30.h,
                    child: FlutterLogo(),
                  ),
                  ListTile(
                    title: Text('Name'),
                    subtitle: Text('Null Man'),
                  ),
                  ListTile(
                    title: Text('Height'),
                    subtitle: Text('22'),
                  ),
                  ListTile(
                    title: Text('Weight'),
                    subtitle: Text('22'),
                  ),
                  ListTile(
                    title: Text('Address'),
                    subtitle: Text('22'),
                  ),
                  ListTile(
                    title: Text('Family Members'),
                    subtitle: Text('22'),
                  ),
                ],
              ),
            ),
          ));
        },
        itemCount: 10,
      )),
    );
  }
}
