import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/UI%20Elements/bottomNavBar.dart';
import 'package:match_making_test/provider/profile_filter_provider.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../UI Elements/drawer.dart';
import '../../services/services_getit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppServices _appservices = GetIt.instance<AppServices>();
    final provider = Provider.of<ProfileFilterProvider>(context, listen: true);
    _appservices.setCurrentNavTab(2);
    _appservices.setCurrentDrawer(2);

    return RefreshIndicator(
      onRefresh: () async {
        provider.searchcontroller.clear();
        provider.searchloader();
      },
      child: Scaffold(
          bottomNavigationBar: const BottomNavBr(),
          appBar: AppBar(
            title: const Text('Search'),
          ),
          drawer: const AppDrawerCommon(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SearchBar(
                        trailing: [
                          IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                provider.searchcontroller.clear();
                                provider
                                    .setSearchprofiles(provider.fullProfile);
                              })
                        ],
                        onChanged: (value) {
                          if (value.isEmpty) {
                            provider.setSearchprofiles(provider.fullProfile);
                          }
                          provider.setSearchprofiles(
                            provider.fullProfile
                                .where(
                                    (element) => element.fname!.contains(value))
                                .toList(),
                          );
                        },
                        // trailing: [
                        //   IconButton(
                        //       icon: const Icon(Icons.search),
                        //       onPressed: () {
                        //         if (provider.fullProfile != null) {
                        //           provider.setSearchprofiles(
                        //             provider.fullProfile!
                        //                 .where((element) => element.name!
                        //                     .contains(searchcontroller.text))
                        //                 .toList(),
                        //           );
                        //         }
                        //       })
                        // ],
                        controller: provider.searchcontroller,
                        hintText: 'Search',
                      ),
                      vSizedBox1,
                      // ExpansionTile(
                      //     children: [],
                      //     title: const Text('Filter'),
                      //     trailing: ElevatedButton(
                      //       onPressed: () {},
                      //       child: ElevatedButton(
                      //         onPressed: () {
                      //           // showDialog(
                      //           //   context: context,
                      //           //   builder: (context) => const Filter(),
                      //           // );
                      //         },
                      //         child: const Text('Filter'),
                      //       ),
                      //     )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Expanded(flex: 2, child: SizedBox()),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const Filter(),
                                );
                              },
                              child: const Text('Filter'),
                            ),
                          )
                        ],
                      ),
                      vSizedBox1,
                      ListView.builder(
                        itemCount: provider.searchProfile!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (count == 0) {
                            return const Center(child: Text('No data found'));
                          }
                          return ListTile(
                              title:
                                  Text(provider.searchProfile![index].fname!),
                              subtitle:
                                  Text(provider.searchProfile![index].email!),
                              onTap: () {
                                provider.setselectprofile(
                                    provider.searchProfile![index]);
                                Navigator.pushNamed(context, '/searchview');
                              });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class Filter extends StatelessWidget {
  const Filter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 60.h,
        width: 80.w,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    "Filter",
                  ),
                  Text("Age"),
                  DropdownButtonFormField(items: [
                    DropdownMenuItem(child: Text("under 20"), value: 20),
                    DropdownMenuItem(
                      child: Text("20-30"),
                      value: 30,
                    ),
                  ], onChanged: (val) {}),
                  Text('Height'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
