import 'package:flutter/material.dart';
import 'package:unitypledge/screens/donor/d_donorpage.dart';
import 'package:unitypledge/screens/donor/d_signin.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Address/es',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contact No.',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement sign-up logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorPage()),
                );
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20.0),
          GestureDetector(
              onTap: () {
                // Navigate to sign-up page
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text('Already have an account? '),
                  Text('Log in',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ]
              ),
            ),
        ],
      ),
    );
  }
}
