import 'package:flutter/cupertino.dart';
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
                        onChanged: (value) {
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
                        controller: provider.searchcontroller,
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
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Text('Filter'),
                  vSizedBox1,
                  const Text('Filter by:'),
                  vSizedBox1,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Age'),
                      DropdownButtonFormField(
                          items: [const DropdownMenuItem(child: Text("1"))],
                          onChanged: (val) {}),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Location')),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(''),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
