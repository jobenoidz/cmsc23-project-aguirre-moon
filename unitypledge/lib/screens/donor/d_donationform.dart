import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/donation_drive.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:unitypledge/models/donation_model.dart';
import 'package:unitypledge/models/org_model.dart';
import 'package:unitypledge/providers/auth_provider.dart';
import 'package:unitypledge/providers/donation_provider.dart';

class DonationForm extends StatefulWidget {
  final Org organization;

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
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isFood = false;
  bool isClothes = false;
  bool isCash = false;
  bool isNecessities = false;
  bool isOthers = false;
  bool isPickup = false;
  String? weight;
  String? datetime;
  String? address;
  String? contactNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Donate to ${widget.organization.orgName}")),
        body: Container(
            margin: const EdgeInsets.all(18),
            child: Center(
              child: SingleChildScrollView(
              child: 
                 Container(
                  margin: const EdgeInsets.all(10),
                   child: Form(
                    key: formKey,
                     child: Column(
                      children: [
                        const Text("Donation Category",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        categoriesField,
                        const Divider(),
                        weightField,
                        dateTimeField,
                        pickUpField,
                        const Divider(),
                        submitDonation(widget.organization.email),
                      ],
                                     ),
                   ),
                 ),
              ),
            )));
  }

  Widget get categoriesField => Column(
      children: [
        FormField<bool>(              
          initialValue: false,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                title: const Text('Food'),
                value: state.value,
                onChanged: (value) {
                  state.didChange(value);
                });
          }, //passes yes/no to callback function
          onSaved: (bool? value) {
            isFood = value!;
          }
        ),
        FormField<bool>(
          initialValue: false,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                title: const Text('Clothes'),
                value: state.value,
                onChanged: (value) {
                  state.didChange(value);
                });
          }, //passes yes/no to callback function
          onSaved: (bool? value) {
            isClothes = value!;
          }
        ),
        FormField<bool>(
          initialValue: false,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                title: const Text('Cash'),
                value: state.value,
                onChanged: (value) {
                  state.didChange(value);
                });
          }, //passes yes/no to callback function
          onSaved: (bool? value) {
            isCash = value!;
          }
        ),
        FormField<bool>(
          initialValue: false,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                title: const Text('Necessities'),
                value: state.value,
                onChanged: (value) {
                  state.didChange(value);
                });
          }, //passes yes/no to callback function
          onSaved: (bool? value) {
            isNecessities = value!;
          }
        ),
        FormField<bool>(
          initialValue: false,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                title: const Text('Others'),
                value: state.value,
                onChanged: (value) {
                  state.didChange(value);
                });
          }, //passes yes/no to callback function
          onSaved: (bool? value) {
            isOthers = value!;
          }
        ),
      ]
    );

  Widget get weightField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Weight of Items (kg/lbs)"),
          hintText: "Enter weight"),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onSaved: (value) => setState(() => weight = value),
      validator: (value) {
        if (value == null || value.isEmpty){
          return "Please enter weight";
        }
        return null;
      },
    ),
  );

  Widget get dateTimeField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Date and Time for Pick Up / Drop Off"),
          hintText: "Enter date and time"),
      onSaved: (value) => setState(() => datetime = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter date and time";
        }
        return null;
      },
    ),
  );

  Widget get pickUpField => Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FormField<bool>(
          builder: (FormFieldState<bool> forPickup) {
            return CheckboxListTile(
              title: const Text("For Pick Up?"),
              value: isPickup,
              onChanged: (val) {
                setState(() {
                  isPickup = val!;
                  forPickup.didChange(val);
                }
                );
              }
            );
          },
        )
      ),
      if (isPickup)
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextFormField(
                onSaved: (value) => setState(() => address = value),
                validator: (value) {
                  if (!isPickup) {
                    return "Please enter your address";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Address"),
                    hintText: "Enter address"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextFormField(
                onSaved: (value) => setState(() => contactNo = value),
                validator: (value) {
                  if (!isPickup) {
                    return "Please enter your contact number";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Contact No."),
                    hintText: "Enter contact number"),
              ),
            ),
          ],
        ),
    ],
  );

  Widget submitDonation(String email){
    return ElevatedButton(
      //submit button
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          print('===========Donated Successfully=============');

          Donation temp = Donation(
            donorEmail: context.read<UserAuthProvider>().getEmail()!,
            orgEmail: email,
            categories: categoryListBuilder(),
            isPickUp: isPickup,
            weight: weight!,
            date: datetime!,
          );
          context.read<DonationProvider>().addDonation(temp);

          Navigator.pop(context);
        } else {
          print('Failed');
        }
      },
      child: const Text('Submit')
    );
  } 

  List<String> categoryListBuilder() {
    List<String> categoryList = [];
    if (isFood) categoryList.add("Food");
    if (isClothes) categoryList.add("Clothes");
    if (isCash) categoryList.add("Cash");
    if (isNecessities) categoryList.add("Necessities");
    if (isOthers) categoryList.add("Others");
    return categoryList;
  }
}
