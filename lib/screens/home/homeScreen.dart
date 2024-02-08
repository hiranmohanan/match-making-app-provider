import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/UI%20Elements/bottomNavBar.dart';
import 'package:match_making_test/UI%20Elements/drawer.dart';
import 'package:match_making_test/services/services_getit.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppServices _appservices = GetIt.instance<AppServices>();
    _appservices.setCurrentNavTab(0);
    _appservices.setCurrentDrawer(0);
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawerCommon(),
      bottomNavigationBar: const BottomNavBr(),
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
                    child: const FlutterLogo(),
                  ),
                  const ListTile(
                    title: Text('Name'),
                    subtitle: Text('Null Man'),
                  ),
                  const ListTile(
                    title: Text('Height'),
                    subtitle: Text('22'),
                  ),
                  const ListTile(
                    title: Text('Weight'),
                    subtitle: Text('22'),
                  ),
                  const ListTile(
                    title: Text('Address'),
                    subtitle: Text('22'),
                  ),
                  const ListTile(
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
