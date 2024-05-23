import 'package:flutter/material.dart';
import 'donate.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication/sign_in.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation App Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Donation App!'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DonateScreen()));
              },
              child: Text('Donate Now'),
            ),
          ],
        ),
      ),
    );
  }
}
