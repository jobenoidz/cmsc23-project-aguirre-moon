import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _about = '';
  bool _isOpen = true;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _loadProfileData();
  }

  void _loadProfileData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('organizations').doc(_currentUser!.uid).get();
    setState(() {
      _name = doc['name'];
      _about = doc['about'];
      _isOpen = doc['isOpen'];
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('organizations').doc(_currentUser!.uid).update({
        'name': _name,
        'about': _about,
        'isOpen': _isOpen,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization Name'),
                initialValue: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the organization name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'About the Organization'),
                initialValue: _about,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter information about the organization';
                  }
                  return null;
                },
                onSaved: (value) {
                  _about = value!;
                },
              ),
              SwitchListTile(
                title: Text('Status for donations (open or close)'),
                value: _isOpen,
                onChanged: (bool value) {
                  setState(() {
                    _isOpen = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
