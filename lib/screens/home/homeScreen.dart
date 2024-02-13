import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/UI%20Elements/bottomNavBar.dart';
import 'package:match_making_test/UI%20Elements/drawer.dart';
import 'package:match_making_test/provider/profile_filter_provider.dart';
import 'package:match_making_test/services/services_getit.dart';
import 'package:match_making_test/shared/colors.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:match_making_test/shared/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppServices _appservices = GetIt.instance<AppServices>();
    final provider = Provider.of<ProfileFilterProvider>(context, listen: true);
    final TextStyle _textstylename =
        KCustomTextStyle.kBold(context, 20, KConstantColors.appPrimaryColor);
    final TextStyle _textstyleage =
        KCustomTextStyle.kMedium(context, 15, KConstantColors.blueColor);

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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        height: 80.h,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 60.h,
                                  width: 100.w,
                                  child: provider.isloadingimg == true
                                      ? const CircularProgressIndicator()
                                      : Image.network(
                                          provider.imgurl?[index] ??
                                              'https://firebasestorage.googleapis.com/v0/b/match-making-app-bbfd5.appspot.com/o/profilepics%2F6i8pcqPckaUiUDR2umSBdaeOhn13.jpg?alt=media&token=f396558d-5800-4914-9478-3dd9d74acb34',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const FlutterLogo();
                                          },
                                        )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${provider.fullProfile?[index].fname} ${provider.fullProfile?[index].lname}",
                                  style: _textstylename,
                                ),
                              ),
                              provider.fullProfile?[index].age == null
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${Ks.ksage}: ${provider.fullProfile?[index].age}",
                                        style: _textstyleage,
                                      ),
                                    ),
                              provider.fullProfile?[index].height == "null"
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${Ks.ksHeight}: ${provider.fullProfile?[index].height}",
                                        style: _textstyleage,
                                      ),
                                    ),
                              provider.fullProfile?[index].weight == "null"
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${Ks.ksweight}: ${provider.fullProfile?[index].weight}",
                                        style: _textstyleage,
                                      ),
                                    ),
                              vSizedBox2,
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
