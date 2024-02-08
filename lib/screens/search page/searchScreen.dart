import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/UI%20Elements/bottomNavBar.dart';
import 'package:match_making_test/shared/dimensions.dart';

import '../../UI Elements/drawer.dart';
import '../../services/services_getit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppServices _appservices = GetIt.instance<AppServices>();
    _appservices.setCurrentNavTab(2);
    _appservices.setCurrentDrawer(2);
    var searchcontroller = TextEditingController();
    return Scaffold(
        bottomNavigationBar: const BottomNavBr(),
        appBar: AppBar(
          title: const Text('Search'),
        ),
        drawer: const AppDrawerCommon(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SearchBar(
                trailing: [
                  IconButton(icon: const Icon(Icons.search), onPressed: () {})
                ],
                controller: searchcontroller,
                hintText: 'Search',
              ),
              vSizedBox1,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Filter'),
                                vSizedBox1,
                                const Text('Filter by:'),
                                vSizedBox1,
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Age')),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Location')),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(''),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text('Filter'),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
