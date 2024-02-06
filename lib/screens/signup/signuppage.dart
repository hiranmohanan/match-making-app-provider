import 'package:flutter/material.dart';
import 'package:match_making_test/provider/firebase_signup_provider.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    var namecontroller = TextEditingController();
    final provider =
        Provider.of<FirebaseSignupProvider>(context, listen: false);
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
      provider.setEmail(emailcontroller.text);
      provider.setPassword(passwordcontroller.text);
      provider.setName(namecontroller.text);
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text('Signup', style: TextStyle(fontSize: 20)),
            vSizedBox2,
            TextFormField(
              controller: namecontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
            vSizedBox1,
            TextFormField(
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
                hintText: 'Email',
              ),
            ),
            vSizedBox1,
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the password';
                } else if (value.length < 8) {
                  return 'Password should be atleast 8 characters';
                }
                return null;
              },
              controller: passwordcontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
                labelText: 'Password',
              ),
            ),
            vSizedBox1,
            DropdownButtonFormField(
                hint: const Text('Select'),
                items: const [
                  DropdownMenuItem(value: "Bride", child: Text("Bride")),
                  DropdownMenuItem(value: "Groom", child: Text("Groom")),
                ],
                onChanged: (val) {},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select';
                  }
                  return null;
                }),
            vSizedBox2,
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
    );
  }
}
