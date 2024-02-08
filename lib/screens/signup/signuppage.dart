import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      provider.setusermodel(
        UserModel(
          name: provider.namecontroller.text,
          email: provider.emailcontroller.text,
          phone: int.parse(provider.phonecontroller.text),
          gender: provider.gender,
        ),
      );
      provider.setPassword(provider.passwordcontroller.text);
      provider.setValidator();

      if (provider.validator == null) {
        await provider.signUp();
        if (provider.isloading == true) {
        } else {
          if (provider.isUserLoggedIn == true) {
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
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
              shrinkWrap: true,

              // mainAxisAlignment: MainAxisAlignment.center,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const Spacer(),
                      Center(
                          child: Text('Sign Up',
                              style: KCustomTextStyle.kBold(
                                  context, 20, KConstantColors.greyTextColor))),
                      const Spacer(),
                      vSizedBox2,
                      Padding(
                        padding: EdgeInsets.all(vBox0),
                        child: SizedBox(
                          height: 60,
                          child: TextFormField(
                            controller: provider.namecontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              hintText: 'Name',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(vBox0),
                        child: SizedBox(
                          height: 60,
                          child: TextFormField(
                            controller: provider.emailcontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the email';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              } else if (!value.contains('.')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(vBox0),
                        child: SizedBox(
                          height: 60,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the phone number';
                              } else if (value.length < 10) {
                                return 'Please enter a valid phone number';
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
                              hintText: 'Phone Number',
                              labelText: 'Phone Number',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(vBox0),
                        child: TextFormField(
                          maxLines: 1,
                          minLines: 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: provider.issecurefont,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the password';
                            } else if (value.length < 8) {
                              return 'Password should be atleast 8 characters';
                            }
                            return null;
                          },
                          controller: provider.passwordcontroller,
                          decoration: InputDecoration(
                            suffixIcon: SizedBox(
                              height: 5,
                              child: IconButton(
                                  constraints:
                                      BoxConstraints.tight(const Size(20, 20)),
                                  onPressed: () {
                                    provider
                                        .setisSecure(!provider.issecurefont);
                                  },
                                  icon: provider.issecurefont
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(vBox0),
                        child: SizedBox(
                          height: 60,
                          child: DropdownButtonFormField(
                              hint: const Text('Select'),
                              value: provider.gender,
                              items: const [
                                DropdownMenuItem(
                                    value: 0, child: Text("Bride")),
                                DropdownMenuItem(
                                    value: 1, child: Text("Groom")),
                              ],
                              onChanged: (val) {
                                provider.setGender(val!);
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select';
                                }
                                return null;
                              }),
                        ),
                      ),
                      vSizedBox1,
                      ElevatedButton(
                        onPressed: () {
                          signup();
                        },
                        child: const Text('Signup'),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ])),
    );
  }
}
