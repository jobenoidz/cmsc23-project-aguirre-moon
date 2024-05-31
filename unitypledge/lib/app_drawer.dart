import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final bool isOrganization = user != null &&
        user.email!.contains(
            'org'); // Assuming organization users have 'org' in their email for simplicity
    final bool isAdmin = user != null &&
        user.email ==
            'admin@example.com'; // Change the email to match your admin email

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Donation App',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, isOrganization ? '/organizationHome' : '/donorHome');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
              Navigator.pushReplacementNamed(
                  context, isOrganization ? '/profile' : '/donorProfile');
            },
          ),
          if (isOrganization)
            ListTile(
              leading: Icon(Icons.drive_eta),
              title: Text('Donation Drives'),
              onTap: () {
                Navigator.pushNamed(context, '/donationDrives');
              },
            ),
          ListTile(
            leading: Icon(Icons.admin_panel_settings),
            title: Text('Admin'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/adminHome');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
        ],
      ),
    );
  }
}
