import 'dart:io';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorView()),
                );
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

// Sign up (Name, Username, Password, Address/es, Contact No.)
//  ○ Can sign up as an organization that accepts donations
//    ■ Must enter the following information:
//  ● Name of organization
//  ● Proof/s of legitimacy
//    ■ Subject to approval
//  ○ Signed up as donors by default

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
                  MaterialPageRoute(builder: (context) => DonorView()),
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


class DonorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage - List of Organizations'),
      ),
      body: ListView.builder(
        itemCount: organizations.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(organizations[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationForm(organization: organizations[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DonationForm extends StatefulWidget {
  final String organization;

  DonationForm({required this.organization});

  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  File? _image;
  // final picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate to ${widget.organization}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Donation Item Category:'),
            CheckboxListTile(
              title: Text('Food'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Clothes'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Cash'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Necessities'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Others'),
              value: false,
              onChanged: (bool? value) {},
            ),
            ElevatedButton(
              onPressed: (){}, //getImage,
              child: Text('Take Photo of Items (Optional)'),
            ),
            _image != null ? Image.file(_image!) : SizedBox(),
            TextField(
              decoration: InputDecoration(
                labelText: 'Weight of Items (kg/lbs)',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Date and Time for Pickup/Drop-off',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Address for Pickup/Drop-off',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contact No for Pickup',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Generate QR Code and handle donation submission
              },
              child: Text('Submit Donation'),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> organizations = ['Organization 1', 'Organization 2', 'Organization 3'];
