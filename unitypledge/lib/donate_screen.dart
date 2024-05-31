import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_drawer.dart';

class DonateScreen extends StatefulWidget {
  final String organizationId;
  final String organizationName;
  final String donorId;

  DonateScreen({required this.organizationId, required this.organizationName, required this.donorId});

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> categories = ['Food', 'Clothes', 'Cash', 'Necessities', 'Others'];
  final Map<String, bool> selectedCategories = {};
  bool isPickup = true;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var category in categories) {
      selectedCategories[category] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donate to ${widget.organizationName}')),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Select Donation Categories'),
              Column(
                children: categories.map((category) {
                  return CheckboxListTile(
                    title: Text(category),
                    value: selectedCategories[category],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedCategories[category] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight (kg/lbs)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: dateTimeController,
                decoration: InputDecoration(labelText: 'Date and Time'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        dateTimeController.text = '${pickedDate.year}/${pickedDate.month}/${pickedDate.day} ${pickedTime.hour}:${pickedTime.minute}';
                      });
                    }
                  }
                },
              ),
              ListTile(
                title: Text('Pickup'),
                leading: Radio(
                  value: true,
                  groupValue: isPickup,
                  onChanged: (bool? value) {
                    setState(() {
                      isPickup = value ?? true;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Drop-off'),
                leading: Radio(
                  value: false,
                  groupValue: isPickup,
                  onChanged: (bool? value) {
                    setState(() {
                      isPickup = value ?? false;
                    });
                  },
                ),
              ),
              if (isPickup)
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Pickup Address'),
                ),
              if (isPickup)
                TextFormField(
                  controller: contactNoController,
                  decoration: InputDecoration(labelText: 'Contact No.'),
                ),
              SizedBox(height: 20),
              Text('Upload a Photo (optional)'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Save donation details to Firestore
                    await FirebaseFirestore.instance.collection('donations').add({
                      'organizationId': widget.organizationId,
                      'donorId': widget.donorId, // Use widget.donorId
                      'categories': selectedCategories.keys.where((key) => selectedCategories[key]!).toList(),
                      'weight': weightController.text,
                      'isPickup': isPickup,
                      'address': isPickup ? addressController.text : null,
                      'contactNo': isPickup ? contactNoController.text : null,
                      'dateTime': dateTimeController.text,
                      'status': 'Pending',
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Donate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
