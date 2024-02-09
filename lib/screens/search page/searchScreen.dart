import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/UI%20Elements/bottomNavBar.dart';
import 'package:match_making_test/provider/profile_filter_provider.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:provider/provider.dart';

import '../../UI Elements/drawer.dart';
import '../../services/services_getit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppServices _appservices = GetIt.instance<AppServices>();
    final provider = Provider.of<ProfileFilterProvider>(context, listen: false);
    _appservices.setCurrentNavTab(2);
    _appservices.setCurrentDrawer(2);

    var searchcontroller = TextEditingController();
    return RefreshIndicator(
      onRefresh: () async {
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
                        onSubmitted: (value) {
                          if (provider.fullProfile != null) {
                            if (value.isEmpty) {
                              provider.setSearchprofiles(provider.fullProfile!);
                            }
                            provider.setSearchprofiles(
                              provider.fullProfile!
                                  .where((element) =>
                                      element.name!.contains(value))
                                  .toList(),
                            );
                          }
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
                      ),
                      vSizedBox1,
                      ListView.builder(
                        itemCount: provider.searchProfile?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(provider.searchProfile![index].name!),
                            subtitle:
                                Text(provider.searchProfile![index].email!),
                          );
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
