import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/UI%20Elements/bottomNavBar.dart';
import 'package:match_making_test/database/usermodel.dart';
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
    provider.searchloader();
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
                                // showDialog(
                                //   context: context,
                                //   builder: (context) => const Filter(),
                                // );
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => const Filter());
                              },
                              child: const Text('Filter'),
                            ),
                          )
                        ],
                      ),
                      vSizedBox1,
                      provider.searchProfile == null
                          ? const Center(child: Text('No data found'))
                          : provider.searchProfile!.isEmpty
                              ? const Center(child: Text('No data found'))
                              : ListView.builder(
                                  itemCount: provider.searchProfile!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        title: Text(provider
                                            .searchProfile![index].fname!),
                                        subtitle: Text(provider
                                            .searchProfile![index].email!),
                                        onTap: () {
                                          provider.setselectprofile(
                                              provider.searchProfile![index]);
                                          Navigator.pushNamed(
                                              context, '/searchview');
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
    int age = 0;
    int weight = 0;
    int height = 0;
    final provider = Provider.of<ProfileFilterProvider>(context, listen: true);
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return SizedBox(
            height: 60.h,
            width: 90.w,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              children: [
                const Center(
                  child: Text(
                    "Filter",
                  ),
                ),
                const Text("Age"),
                DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(child: Text("under 20"), value: 20),
                      DropdownMenuItem(
                        child: Text("20-30"),
                        value: 30,
                      ),
                      DropdownMenuItem(
                        child: Text("30-40"),
                        value: 40,
                      ),
                      DropdownMenuItem(
                        child: Text("40-50"),
                        value: 50,
                      ),
                    ],
                    onChanged: (val) {
                      age = val as int;
                    }),
                const Text('Height'),
                DropdownButtonFormField(items: const [
                  DropdownMenuItem(
                    child: Text("under 5'0"),
                    value: 5,
                  ),
                  DropdownMenuItem(
                    child: Text("5'0-5'5"),
                    value: 5.5,
                  ),
                  DropdownMenuItem(
                    child: Text("5'5-6'0"),
                    value: 6,
                  ),
                  DropdownMenuItem(
                    child: Text("6'0-6'5"),
                    value: 6.5,
                  ),
                ], onChanged: (val) {}),
                const Text('Weight'),
                DropdownButtonFormField(items: const [
                  DropdownMenuItem(
                    child: Text("under 50"),
                    value: 50,
                  ),
                  DropdownMenuItem(
                    child: Text("50-60"),
                    value: 60,
                  ),
                  DropdownMenuItem(
                    child: Text("60-70"),
                    value: 70,
                  ),
                  DropdownMenuItem(
                    child: Text("70-80"),
                    value: 80,
                  ),
                ], onChanged: (val) {}),
                ElevatedButton(
                  onPressed: () {
                    for (provider.fullProfile.length;
                        provider.fullProfile.length > 0;
                        provider.fullProfile.length--) {
                      List<UserModel> model = [];
                      if (provider.fullProfile[provider.fullProfile.length - 1]
                              .age! >
                          age) {
                        model.add(provider
                            .fullProfile[provider.fullProfile.length - 1]);
                      }
                    }
                    provider.setSearchprofiles(
                      provider.fullProfile
                          .where(age != 0
                              ? (element) => element.age! < age
                              : (element) => element.age! < age)
                          .toList(),
                    );
                  },
                  child: const Text('Apply'),
                )
              ],
            ),
          );
        });
  }
}
