import 'package:flutter/material.dart';
import 'package:match_making_test/provider/firebase_signup_provider.dart';
import 'package:match_making_test/shared/colors.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:match_making_test/shared/text_styles.dart';
import 'package:provider/provider.dart';

import '../../provider/firebase_login_provider.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseLoginProvider>(context, listen: true);

    logintohome() {
      Navigator.pushNamed(context, '/home');
    }

    showmessage({String? message}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ?? provider.responce,
              style: const TextStyle(fontSize: 20, color: Colors.red)),
        ),
      );
    }

    login() async {
      provider.setEmail(emailcontroller.text);
      provider.setPassword(passwordcontroller.text);
      provider.setValidator();
      if (provider.validator == null) {
        await provider.login();
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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  const Spacer(),
                  Center(
                      child: Text('Login',
                          style: KCustomTextStyle.kBold(
                              context, 20, KConstantColors.greyTextColor))),
                  vSizedBox1,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: emailcontroller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordcontroller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the password';
                        } else if (value.length < 8) {
                          return 'Password should be atleast 8 characters';
                        }
                        return null;
                      },
                      obscureText: provider.issecurefont,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              provider.setsecurefont(!provider.issecurefont);
                            },
                            icon: provider.issecurefont
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  vSizedBox1,
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: const Text('Login'),
                  ),
                  vSizedBox0,
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<FirebaseSignupProvider>(context,
                              listen: false)
                          .clear();
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text('Register'),
                  ),
                  const Spacer(),
                  provider.isloading == true
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox(),
                  const Spacer(),
                ]),
              ),
            ],
          ),
        ));
  }
}
