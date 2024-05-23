import 'package:flutter/material.dart';

import 'screens/authentication/sign_in.dart';
import 'screens/home.dart';
import 'services/authentication_service.dart'; 
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(), // Decide whether to show sign-in or home screen based on authentication state
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.authStateChanges, // Listen for authentication state changes
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // If user is not authenticated, show sign-in screen
            return SignInScreen();
          } else {
            // If user is authenticated, navigate to the home screen
            return HomeScreen();
          }
        } else {
          // Show a loading indicator while waiting for authentication state
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
