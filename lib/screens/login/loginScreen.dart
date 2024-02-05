import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../firebase/firebase_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseLoginProvider>(context, listen: false);
    return Scaffold(
        body: Center(
      child: ListView(children: [
        const SizedBox(height: 20),
        const Text('Login', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              provider.setEmail(value);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              provider.setPassword(value);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            provider.login();
            if (provider.isUserLoggedIn) {
              Navigator.pushNamed(context, '/home');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.responce,
                      style: const TextStyle(fontSize: 20, color: Colors.red)),
                ),
              );
            }
          },
          child: const Text('Login'),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text('Register'),
        ),
      ]),
    ));
  }
}
