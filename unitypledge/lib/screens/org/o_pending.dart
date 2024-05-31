import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/providers/auth_provider.dart';
import 'package:unitypledge/screens/signin.dart';

class OrgPendingPage extends StatelessWidget {
  const OrgPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text("Your organization is pending approval.", textAlign: TextAlign.center),
          const Text("Please check again later.", textAlign: TextAlign.center),
          ElevatedButton(
              onPressed: () async {
                await context.read<UserAuthProvider>().signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              child: const Text("Logout"))
        ]),
      ),
    );
  }
}