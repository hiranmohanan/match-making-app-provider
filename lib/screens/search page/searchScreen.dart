import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/shared/dimensions.dart';

import '../../UI Elements/drawer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchcontroller = TextEditingController();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
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
