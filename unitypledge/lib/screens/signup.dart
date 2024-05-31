import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/donor_model.dart';
import 'package:unitypledge/models/pending_org_model.dart';
import 'package:unitypledge/providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  List<dynamic> addresses = [];
  String? contact;
  bool isOrg = false;
  String? orgName;
  String? orgProof;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading,
                  nameField,
                  emailField,
                  passwordField,
                  addressField,
                  contactField,
                  orgField,
                  submitButton
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  Widget get nameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("First Name"),
              hintText: "Enter first name"),
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter first name";
            }
            return null;
          },
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Email"),
              hintText: "Enter a valid email"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid email format";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Password"),
              hintText: "At least 8 characters"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid password";
            }
            return null;
          },
        ),
      );

  Widget get addressField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Address/es"),
              hintText: "Enter address"),
          onSaved: (value) => setState(() => addresses.add(value)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid password";
            }
            return null;
          },
        ),
      );

  Widget get contactField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Contact No."),
              hintText: "Enter contact number"),
          onSaved: (value) => setState(() => contact = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid contact";
            }
            return null;
          },
        ),
      );

  Widget get orgField => Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FormField<bool>(
                builder: (FormFieldState<bool> orgApply) {
                  return CheckboxListTile(
                      title: const Text("Apply as Organization?"),
                      value: isOrg,
                      onChanged: (val) {
                        setState(() {
                          isOrg = val!;
                          orgApply.didChange(val);
                        });
                      });
                },
              )),
          if (isOrg)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Organization Name"),
                        hintText: "Enter organization name"),
                    onSaved: (value) => setState(() => orgName = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid organization name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Organization Proof"),
                        hintText: "Enter document"),
                    onSaved: (value) => setState(() => orgProof = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid proof";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
        ],
      );

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          print("SUBMITTED ----------------");

          if (isOrg == false) {
            print("DONOR ----------------");
            Donor temp = Donor(
                name: name!,
                email: email!,
                address: addresses,
                contact: contact!);
            context.read<UserAuthProvider>().saveDonor(email!, temp);
          } else {
            print("ORG ----------------");
            PendingOrg temp = PendingOrg(
                name: name!,
                email: email!,
                address: addresses,
                contact: contact!,
                orgName: orgName!,
                orgProof: orgProof!,
                status: true);
            context.read<UserAuthProvider>().savePendingOrg(email!, temp);
          }

          print("SIGN UP ----------------");
          context.read<UserAuthProvider>().signUp(email!, password!);

          // check if the widget hasn't been disposed of after an asynchronous action
          Navigator.pop(context);
        }
      },
      child: const Text("Sign Up"));
}

//if (email in auth){
//    return email already exists
//}