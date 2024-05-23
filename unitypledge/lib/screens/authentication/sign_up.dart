import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String name = '';
  String email = '';
  String password = '';
  String address = '';
  String contactNo = '';
  bool isOrganization = false;
  String organizationName = '';
  String proofOfLegitimacy = ''; // This could be a URL to an uploaded file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextField(
                onChanged: (value) {
                  address = value;
                },
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                onChanged: (value) {
                  contactNo = value;
                },
                decoration: InputDecoration(labelText: 'Contact No.'),
              ),
              CheckboxListTile(
                title: Text('Sign up as an organization'),
                value: isOrganization,
                onChanged: (bool? value) {
                  setState(() {
                    isOrganization = value ?? false;
                  });
                },
              ),
              if (isOrganization)
                TextField(
                  onChanged: (value) {
                    organizationName = value;
                  },
                  decoration: InputDecoration(labelText: 'Organization Name'),
                ),
              // Placeholder for proof of legitimacy upload
              if (isOrganization)
                TextField(
                  onChanged: (value) {
                    proofOfLegitimacy = value;
                  },
                  decoration: InputDecoration(labelText: 'Proof of Legitimacy'),
                ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    await _firestore.collection('users').doc(userCredential.user!.uid).set({
                      'name': name,
                      'email': email,
                      'address': address,
                      'contactNo': contactNo,
                      'isOrganization': isOrganization,
                      if (isOrganization) 'organizationName': organizationName,
                      if (isOrganization) 'proofOfLegitimacy': proofOfLegitimacy,
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
