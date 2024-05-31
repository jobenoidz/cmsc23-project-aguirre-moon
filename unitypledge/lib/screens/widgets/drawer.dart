import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/providers/auth_provider.dart';
import 'package:unitypledge/providers/donor_provider.dart';
import 'package:unitypledge/screens/donor/d_profile.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    // Stream<User?> donorDetails = context.watch<UserAuthProvider>().userStream;

    return Drawer(
        child: ListView(
      children: [
        const DrawerHeader(
            child: Text(
          "UNITY PLEDGE",
          style: TextStyle(fontSize: 30),
        )),
        ListTile(
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          title: (const Text("Orgs")),
        ),
        ListTile(
          title: const Text('Profile'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              String? donoEmail = context.watch<UserAuthProvider>().getEmail();
              Future donorDetails = context.watch<DonorListProvider>().getCurrentDono(donoEmail!);
              return DonorDetailsPage(donorDetails: donorDetails as Map<String,dynamic>);
            }));
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            context.read<UserAuthProvider>().signOut();
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}
