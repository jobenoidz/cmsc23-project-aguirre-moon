import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Check if user exists in the database
                  final userSnapshot = await FirebaseFirestore.instance.collection('users')
                      .where('username', isEqualTo: emailController.text)
                      .limit(1)
                      .get();
                  
                  if (userSnapshot.docs.isNotEmpty) {
                    // User exists in the database, proceed with sign-in
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    // Add logic to determine user role and navigate accordingly
                    // For now, navigate to the home screen
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // User does not exist in the database
                    // Show error message or handle appropriately
                    print('User does not exist. Please sign up.');
                  }
                } on FirebaseAuthException catch (e) {
                  print('Error: $e');
                }
              },
              child: Text('Sign In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
