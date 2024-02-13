import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:match_making_test/provider/firebase_storage_picture.dart';
import 'package:match_making_test/shared/colors.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../UI Elements/bottomNavBar.dart';
import '../../UI Elements/drawer.dart';
import '../../provider/firebase_profile_fetch_provider.dart';
import '../../services/services_getit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppServices _appservices = GetIt.instance<AppServices>();
    final commonpadding = EdgeInsets.symmetric(vertical: vBox1);
    final provider = Provider.of<ProfileFetchProvider>(context, listen: true);
    final pictureprovider =
        Provider.of<FirebaseStorageProvider>(context, listen: true);
    TextEditingController fnameController = TextEditingController(
        text: provider.userProfile.fname == 'null'
            ? null
            : provider.userProfile.fname);
    TextEditingController lnameController = TextEditingController(
        text: provider.userProfile.lname == 'null'
            ? null
            : provider.userProfile.lname);
    TextEditingController heightController = TextEditingController(
        text: provider.userProfile.height.toString() == 'null'
            ? null
            : provider.userProfile.height.toString());
    TextEditingController weightController = TextEditingController(
        text: provider.userProfile.weight.toString() == 'null'
            ? null
            : provider.userProfile.weight.toString());
    TextEditingController houseController = TextEditingController(
        text: provider.userProfile.house == 'null'
            ? null
            : provider.userProfile.house);
    TextEditingController cityController = TextEditingController(
        text: provider.userProfile.city == 'null'
            ? null
            : provider.userProfile.city);
    TextEditingController stateController = TextEditingController(
        text: provider.userProfile.state == 'null'
            ? null
            : provider.userProfile.state);
    TextEditingController familyController = TextEditingController(
        text: provider.userProfile.family == 'null'
            ? null
            : provider.userProfile.family);
    bool istextfield = provider.istextfalse;
    _appservices.setCurrentNavTab(1);
    _appservices.setCurrentDrawer(1);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavBr(),
      drawer: const AppDrawerCommon(),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
              height: 90.h,
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          pictureprovider.fileout == null
                              ? CircleAvatar(
                                  radius: 20.w,
                                  child: FlutterLogo(
                                    size: 20.w,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 20.w,
                                  backgroundImage: Image.file(
                                    File(pictureprovider.fileout!),
                                    errorBuilder: (context, error, stackTrace) {
                                      return const FlutterLogo();
                                    },
                                  ).image,
                                ),
                          istextfield
                              ? InkWell(
                                  borderRadius: BorderRadius.circular(20.w),
                                  onTap: () {
                                    pictureprovider.selectFile();
                                  },
                                  child: pictureprovider.file == null
                                      ? CircleAvatar(
                                          radius: 20.w,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.5),
                                          foregroundColor: Colors.transparent,
                                          child: const Text(
                                              'Tap Here To Edit Profile Picture',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: KConstantColors.dimWhite,
                                              )),
                                        )
                                      : CircleAvatar(
                                          radius: 20.w,
                                          backgroundImage: Image.file(File(
                                                  pictureprovider.file!.path!))
                                              .image),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    vSizedBox1,
                    istextfield
                        ? Padding(
                            padding: EdgeInsets.all(vBox1),
                            child: ElevatedButton(
                              onPressed: () async {
                                provider.validator(
                                  fname: fnameController.text,
                                  lname: lnameController.text,
                                  height: heightController.text,
                                  weight: weightController.text,
                                  house: houseController.text,
                                  city: cityController.text,
                                  state: stateController.text,
                                  family: familyController.text,
                                );
                                if (provider.changedone == false) {
                                  provider.saveUserModel(
                                    fname: fnameController.text,
                                    lname: lnameController.text,
                                    height: int.parse(heightController.text),
                                    weight: int.parse(weightController.text),
                                    house: houseController.text,
                                    city: cityController.text,
                                    state: stateController.text,
                                    family: familyController.text,
                                  );
                                  if (pictureprovider.file != null) {
                                    await pictureprovider.uploadfile();
                                    await pictureprovider.downloadFile();

                                    await provider.fetchProfile();
                                  }
                                  provider.setistextfalse(!istextfield);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Alert'),
                                          content: Text(
                                              'Please add required datas to save\n${provider.fieldmessage}'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Ok'))
                                          ],
                                        );
                                      });
                                }
                              },
                              child: const Text('Save Changes'),
                            ),
                          )
                        : const SizedBox(),
                    istextfield
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.all(vBox1),
                            child: ElevatedButton(
                                onPressed: () {
                                  provider.setistextfalse(!istextfield);
                                },
                                child: const Text('Edit Profile')),
                          ),
                    vSizedBox1,

                    Padding(
                      padding: commonpadding,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the first name';
                          }
                          return null;
                        },
                        controller: fnameController,
                        enabled: istextfield,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Name',
                          hintText: String.fromEnvironment(fnameController.text,
                              defaultValue: 'Please provide first Name'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: commonpadding,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the last name';
                          }
                          return null;
                        },
                        controller: lnameController,
                        enabled: istextfield,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Name',
                          hintText: String.fromEnvironment(lnameController.text,
                              defaultValue: 'Please provide last Name'),
                        ),
                      ),
                    ),
                    // provider.userProfile.height == null
                    //     ? const SizedBox()
                    //     :
                    Padding(
                      padding: commonpadding,
                      child: TextFormField(
                        enabled: istextfield,
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the height';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Height',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: String.fromEnvironment(
                              heightController.text,
                              defaultValue: 'Please provide Height'),
                        ),
                      ),
                    ),
                    // provider.userProfile.weight == null
                    //     ? const SizedBox()
                    //     :
                    Padding(
                      padding: commonpadding,
                      child: TextFormField(
                        enabled: istextfield,
                        controller: weightController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the weight';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Weight',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: String.fromEnvironment(
                              weightController.text,
                              defaultValue: 'Please provide Weight'),
                        ),
                      ),
                    ),
                    // provider.userProfile.house == null
                    //     ? const SizedBox()
                    //     :
                    Padding(
                      padding: commonpadding,
                      child: TextFormField(
                        enabled: istextfield,
                        controller: houseController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'House Name/Number',
                          hintText: String.fromEnvironment(houseController.text,
                              defaultValue: 'Please provide House Name/Number'),
                        ),
                      ),
                    ),
                    // provider.userProfile.city == null
                    //     ? const SizedBox()
                    //     :
                    Padding(
                      padding: commonpadding,
                      child: TextFormField(
                        enabled: istextfield,
                        controller: cityController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: String.fromEnvironment(cityController.text,
                              defaultValue: 'Please provide City'),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    // provider.userProfile.state == null
                    //     ? const SizedBox()
                    //     :
                    Padding(
                      padding: commonpadding,
                      child: TextFormField(
                        enabled: istextfield,
                        controller: stateController,
                        decoration: InputDecoration(
                          labelText: 'State',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: String.fromEnvironment(stateController.text,
                              defaultValue: 'Please provide State'),
                        ),
                      ),
                    ),
                    // provider.userProfile.family == null
                    //     ? const SizedBox()
                    //     :
                    Padding(
                      padding: commonpadding,
                      child: TextFormField(
                        enabled: istextfield,
                        controller: familyController,
                        decoration: InputDecoration(
                          labelText: 'Family Information',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: String.fromEnvironment(
                              familyController.text,
                              defaultValue:
                                  'Please provide Family Information'),
                        ),
                      ),
                    ),
                    vSizedBox2,
                  ],
                ),
              ),
            )),
    );
  }
}
