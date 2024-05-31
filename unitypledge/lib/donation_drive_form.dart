import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DonationDriveForm extends StatefulWidget {
  final String? driveId;

  DonationDriveForm({this.driveId});

  @override
  _DonationDriveFormState createState() => _DonationDriveFormState();
}

class _DonationDriveFormState extends State<DonationDriveForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  File? _image;
  // final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.driveId != null) {
      _loadDriveData();
    }
  }

  void _loadDriveData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('donation_drives').doc(widget.driveId).get();
    setState(() {
      _title = doc['title'];
      _description = doc['description'];
    });
  }

  // Future<void> _pickImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     }
  //   });
  // }

  Future<void> _saveDrive() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> driveData = {
        'title': _title,
        'description': _description,
      };

      if (widget.driveId == null) {
        await FirebaseFirestore.instance.collection('donation_drives').add(driveData);
      } else {
        await FirebaseFirestore.instance.collection('donation_drives').doc(widget.driveId).update(driveData);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.driveId == null ? 'Add Donation Drive' : 'Edit Donation Drive'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                initialValue: _title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                initialValue: _description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!),
              // ElevatedButton(
              //   onPressed: _pickImage,
              //   child: Text('Pick Image'),
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDrive,
                child: Text('Save Drive'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
