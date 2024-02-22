import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/UI%20Elements/bottomNavBar.dart';
import 'package:match_making_test/database/usermodel.dart';
import 'package:match_making_test/provider/profile_filter_provider.dart';
import 'package:match_making_test/provider/searchprovider.dart';
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
    final provider = Provider.of<SearchProvider>(context, listen: true);

    _appservices.setCurrentNavTab(2);
    _appservices.setCurrentDrawer(2);

    return RefreshIndicator(
      onRefresh: () async {
        provider.searchcontroller.clear();
        provider.getdata();
      },
      child: SafeArea(
        child: Scaffold(
            bottomNavigationBar: const BottomNavBr(),
            drawer: const AppDrawerCommon(),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  title: const Text('Search'),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      vSizedBox1,
                      SearchBar(
                        trailing: [
                          IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                provider.searchcontroller.clear();
                                provider
                                    .getdata(); // this is the function that fetches the data from the database
                              })
                        ],
                        onChanged: (value) {
                          if (value.isEmpty) {
                            provider.getdata();
                          } else {
                            provider.search();
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
                      provider.searchList.isEmpty
                          ? const Center(child: Text('No data found'))
                          : provider.searchList.isEmpty
                              ? const Center(child: Text('No data found'))
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.searchList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        title: Text(
                                            provider.searchList[index].fname!),
                                        subtitle: Text(
                                            provider.searchList[index].email!),
                                        onTap: () {
                                          provider.setselectprofile(
                                              provider.searchList[index]);
                                          Navigator.pushNamed(
                                              context, '/searchview');
                                        });
                                  },
                                ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class Filter extends StatelessWidget {
  const Filter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context, listen: true);
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
                    value: provider.filterage,
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
                      DropdownMenuItem(child: Text("above 50"), value: 60),
                    ],
                    onChanged: (val) {
                      provider.setfiltrage(val);
                    }),
                const Text('Height'),
                DropdownButtonFormField(
                    value: provider.filterheight,
                    items: const [
                      DropdownMenuItem(
                        child: Text("under 130"),
                        value: 130,
                      ),
                      DropdownMenuItem(
                        child: Text(" under 160"),
                        value: 160,
                      ),
                      DropdownMenuItem(
                        child: Text("under 200"),
                        value: 200,
                      ),
                      DropdownMenuItem(
                        child: Text("above 200"),
                        value: 210,
                      ),
                    ],
                    onChanged: (val) {
                      provider.setfiltrhight(val);
                    }),
                const Text('Weight'),
                DropdownButtonFormField(
                    value: provider.filterweight,
                    items: const [
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
                        child: Text("above 70"),
                        value: 80,
                      ),
                    ],
                    onChanged: (val) {
                      provider.setfiltrweight(val);
                    }),
                ElevatedButton(
                  onPressed: () {
                    provider.filter();
                    Navigator.pop(context);
                    // List<UserModel> model = [];

                    // model = provider.searchList;
                    // for (int index = 0; index < model.length; index++) {
                    //   for (int index = model.length - 1; index >= 0; index--) {
                    //     if ((model[index].age != null &&
                    //             model[index].age! < age) ||
                    //         (model[index].height != null &&
                    //             model[index].height < height) ||
                    //         (model[index].weight != null &&
                    //             model[index].weight! < weight)) {
                    //       model.removeAt(index);
                    //     }
                    //   }
                    // }
                    // provider.setSearchList(
                    //   model,
                    // );
                  },
                  child: const Text('Apply'),
                )
              ],
            ),
          );
        });
  }
}
