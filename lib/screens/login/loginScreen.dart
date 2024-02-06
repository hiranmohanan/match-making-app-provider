import 'package:flutter/material.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:provider/provider.dart';

import '../../provider/firebase_login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseLoginProvider>(context, listen: false);
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
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
        body: Stack(
          children: [
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text('Login', style: TextStyle(fontSize: 20)),
                    vSizedBox1,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
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
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Register'),
                    ),
                    const Spacer(),
                  ]),
            ),
            provider.isloading == true
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
          ],
        ));
  }
}
