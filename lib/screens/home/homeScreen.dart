import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/UI%20Elements/bottomNavBar.dart';
import 'package:match_making_test/UI%20Elements/drawer.dart';
import 'package:match_making_test/provider/profile_filter_provider.dart';
import 'package:match_making_test/services/services_getit.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppServices _appservices = GetIt.instance<AppServices>();
    final provider = Provider.of<ProfileFilterProvider>(context, listen: true);
    _appservices.setCurrentNavTab(0);
    _appservices.setCurrentDrawer(0);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(
            Icons.refresh,
            color: Colors.black,
          ),
          onPressed: () {
            provider.fetchProfile();
          },
        ),
      ]),
      drawer: const AppDrawerCommon(),
      bottomNavigationBar: const BottomNavBr(),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
            height: 100.h,
            width: 100.h,
              child: ListView.builder(
                shrinkWrap: true,
                
              itemBuilder: (context, index) {
                return Card(
                    child: SizedBox(
                  child: SingleChildScrollView(
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 30.h,
                          child: const FlutterLogo(),
                        ),
                        Positioned(
                          bottom: 1,
                          child: SizedBox(
                            height:10.h,
                            width: 90.w,
                            child: GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              children: [
                                Chip(
                                  
                                
                                  label: Text("${Ks.ksname}: ${provider.fullProfile?[index].name}"),
                                ),
                                Chip(
                                  label: Text("${Ks.ksage}: ${provider.fullProfile?[index].age}"),
                                ),
                                Chip(
                                  label: Text("${Ks.ksweight}: ${provider.fullProfile?[index].weight}"),
                                ),
                                
                              ],
                            
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ));
              },
              itemCount: provider.fullProfile?.length ?? 0,
            )),
    );
  }
}
