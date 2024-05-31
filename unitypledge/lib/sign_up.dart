import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _isOrganization = false;
  String _name = '';
  String _username = '';
  String _password = '';
  String _address = '';
  String _contactNo = '';
  String _orgDescription = '';
  String _orgProof = '';
  late String _donorId; // Declare donorId variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact No.'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contactNo = value!;
                },
              ),
              SwitchListTile(
                title: Text('Sign up as an organization'),
                value: _isOrganization,
                onChanged: (bool value) {
                  setState(() {
                    _isOrganization = value;
                  });
                },
              ),
              if (_isOrganization) ...[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Organization Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your organization description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _orgDescription = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Proof of Legitimacy'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide proof of legitimacy';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _orgProof = value!;
                  },
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                        email: _username,
                        password: _password,
                      );

                      // Generate donorId
                      _donorId = _firestore.collection('users').doc().id;

                      await _firestore.collection('users').doc(userCredential.user!.uid).set({
                        'donorId': _donorId, // Save donorId to Firestore
                        'name': _name,
                        'username': _username,
                        'address': _address,
                        'contactNo': _contactNo,
                        'isOrganization': _isOrganization,
                        'isAdmin': false,
                      });

                      if (_isOrganization) {
                        await _firestore.collection('organizations').doc(userCredential.user!.uid).set({
                          'name': _name,
                          'description': _orgDescription,
                          'proof': _orgProof,
                          'approved': false,
                        });
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                    }
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
