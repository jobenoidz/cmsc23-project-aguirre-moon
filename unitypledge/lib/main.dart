import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In/Sign Up Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInSignUpPage(),
    );
  }
}

class SignInSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In/Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Column(
                children:[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.asset(
                      './images/unitypledge_logo.png',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  Text("Welcome back, ",
                  style: TextStyle(
                    fontSize: 30.0
                  ),),
                  Text("Join the Pledge, Ignite Unity."),
                ]
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
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
            ElevatedButton(
              onPressed: () {
                // Implement sign-in logic here
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // Navigate to sign-up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text('Don\'t have an account? '),
                  Text('Sign up',
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
      ),
    );
  }
}

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
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20.0),
          GestureDetector(
              onTap: () {
                // Navigate to sign-up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInSignUpPage()),
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
