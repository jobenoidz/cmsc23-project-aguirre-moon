import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
