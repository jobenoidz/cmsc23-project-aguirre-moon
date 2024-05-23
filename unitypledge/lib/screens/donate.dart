import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DonateScreen extends StatefulWidget {
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _firestore = FirebaseFirestore.instance;
  String category = 'Food';
  String pickupOrDropoff = 'Pickup';
  double weight = 0;
  File? image;
  String dateTime = '';
  String address = '';
  String contactNo = '';
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donate')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                value: category,
                items: ['Food', 'Clothes', 'Cash', 'Necessities', 'Others'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    category = newValue!;
                  });
                },
              ),
              DropdownButton<String>(
                value: pickupOrDropoff,
                items: ['Pickup', 'Drop-off'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    pickupOrDropoff = newValue!;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  weight = double.parse(value);
                },
                decoration: InputDecoration(labelText: 'Weight (kg/lbs)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // final pickedFile = await _picker.getImage(source: ImageSource.camera);
                  // setState(() {
                  //   image = File(pickedFile!.path);
                  // });
                },
                child: Text('Upload Image'),
              ),
              TextField(
                onChanged: (value) {
                  dateTime = value;
                },
                decoration: InputDecoration(labelText: 'Date and Time for Pickup/Drop-off'),
              ),
              TextField(
                onChanged: (value) {
                  address = value;
                },
                decoration: InputDecoration(labelText: 'Address (for pickup)'),
              ),
              TextField(
                onChanged: (value) {
                  contactNo = value;
                },
                decoration: InputDecoration(labelText: 'Contact No. (for pickup)'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _firestore.collection('donations').add({
                    'category': category,
                    'pickupOrDropoff': pickupOrDropoff,
                    'weight': weight,
                    'image': image != null ? image!.path : '',
                    'dateTime': dateTime,
                    'address': address,
                    'contactNo': contactNo,
                    'status': 'Pending',
                  });
                  Navigator.pop(context);
                },
                child: Text('Submit Donation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
