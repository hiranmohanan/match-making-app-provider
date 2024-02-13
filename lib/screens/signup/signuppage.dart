import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_making_test/UI%20Elements/font_asowm.dart';
import 'package:match_making_test/constants/constants.dart';
import 'package:match_making_test/database/usermodel.dart';
import 'package:match_making_test/provider/firebase_signup_provider.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:provider/provider.dart';

import '../../shared/colors.dart';
import '../../shared/text_styles.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseSignupProvider>(context, listen: true);
    final commonpadding = EdgeInsets.symmetric(vertical: vBox0);

    logintohome() {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }

    showmessage({String? message}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ?? provider.responce,
              style: const TextStyle(fontSize: 20, color: Colors.red)),
        ),
      );
    }

    signup() async {
      provider.setValidator();
      if (provider.validator == null) {
        provider.setusermodel(
          UserModel(
            fname: provider.fnamecontroller.text,
            lname: provider.lnamecontroller.text,
            email: provider.emailcontroller.text,
            phone: int.parse(provider.phonecontroller.text),
            gender: provider.gender,
          ),
        );
        provider.setPassword(provider.passwordcontroller.text);
        await provider.signUp();
        if (provider.isloading == true) {
        } else {
          if (provider.isUserLoggedIn == true) {
            // boxuser.put(
            //     'primaryuser',
            //     UserModelHive(
            //       uid: FirebaseAuth.instance.currentUser!.uid,
            //       name: provider.usermodel.name,
            //       email: provider.usermodel.email,
            //       phone: provider.usermodel.phone,
            //       gender: provider.gender,
            //     ));
            logintohome();
          } else {
            showmessage(message: provider.responce);
          }
        }
      } else {
        showmessage(message: provider.validator);
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: provider.isloading == true
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomScrollView(

                  // mainAxisAlignment: MainAxisAlignment.center,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const Spacer(),
                          Center(
                              child: Text(Ks.ksSignUp,
                                  style: KCustomTextStyle.kBold(context, 20,
                                      KConstantColors.greyTextColor))),
                          const Spacer(),
                          vSizedBox2,
                          Padding(
                            padding: commonpadding,
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: provider.fnamecontroller,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return Ks.ksEnterFName;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Kappicons.ksiconfname,
                                  labelText: Ks.ksfname,
                                  hintText: Ks.ksfname,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: commonpadding,
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: provider.lnamecontroller,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return Ks.ksEnterLName;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Kappicons.ksiconfname,
                                  labelText: Ks.kslname,
                                  hintText: Ks.kslname,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: commonpadding,
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: provider.emailcontroller,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return Ks.ksEnterEmail;
                                  } else if (!value.contains('@')) {
                                    return Ks.ksEnterValidEmail;
                                  } else if (!value.contains('.')) {
                                    return Ks.ksEnterValidEmail;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Kappicons.ksiconemail,
                                  labelText: Ks.ksEmail,
                                  hintText: Ks.ksEmail,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: commonpadding,
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return Ks.ksEnterPhoneNumber;
                                  } else if (value.length < 10) {
                                    return Ks.ksEnterValidPhoneNumber;
                                  }
                                  return null;
                                },
                                controller: provider.phonecontroller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                keyboardType: TextInputType.phone,
                                autofillHints: const [
                                  AutofillHints.telephoneNumber
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Kappicons.ksiconphone,
                                  hintText: Ks.ksPhoneNumber,
                                  labelText: Ks.ksPhoneNumber,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: commonpadding,
                            child: TextFormField(
                              maxLines: 1,
                              minLines: 1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: provider.issecurefont,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return Ks.ksEnterPassword;
                                } else if (value.length < 8) {
                                  return Ks.ksPasswordLength;
                                }
                                return null;
                              },
                              controller: provider.passwordcontroller,
                              decoration: InputDecoration(
                                prefixIcon: Kappicons.ksiconpassword,
                                suffixIcon: SizedBox(
                                  height: 5,
                                  child: IconButton(
                                      constraints: BoxConstraints.tight(
                                          const Size(20, 20)),
                                      onPressed: () {
                                        provider.setisSecure(
                                            !provider.issecurefont);
                                      },
                                      icon: provider.issecurefont
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                ),
                                border: const OutlineInputBorder(),
                                hintText: Ks.ksPassword,
                                labelText: Ks.ksPassword,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                          vSizedBox1,
                          Padding(
                            padding: commonpadding,
                            child: SizedBox(
                              height: 60,
                              child: DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    prefixIcon: Kappicons.ksicongender,
                                    labelText: Ks.ksSelectyour,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  hint: const Text(Ks.ksSelect),
                                  value: provider.gender,
                                  items: const [
                                    DropdownMenuItem(
                                        value: 0, child: Text(Ks.ksBride)),
                                    DropdownMenuItem(
                                        value: 1, child: Text(Ks.ksGroom)),
                                  ],
                                  onChanged: (val) {
                                    provider.setGender(val!);
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null) {
                                      return Ks.ksSelect;
                                    }
                                    return null;
                                  }),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signup();
                            },
                            child: const Text(Ks.ksSignUp),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ])),
    );
  }
}
