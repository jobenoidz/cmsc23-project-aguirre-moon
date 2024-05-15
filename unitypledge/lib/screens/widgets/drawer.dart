import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/providers/auth_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [const DrawerHeader(child: Text("UNITY PLEDGE", style: TextStyle(fontSize: 30),)),
        ListTile(
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));},
          title: (const Text("Orgs")),),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            context.read<UserAuthProvider>().signOut();
            Navigator.pop(context);
          },
        ),
        ],
      )
    );
  }
}