import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/providers/auth_provider.dart';
import 'package:unitypledge/screens/signin.dart';
import 'a_orglist.dart';
import 'a_donationlist.dart';
import 'a_donorlist.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrganizationList()),
                );
              },
              child: Text('Manage Organizations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonationList()),
                );
              },
              child: Text('Manage Donations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorList()),
                );
              },
              child: Text('Manage Donors'),
            ),
            ElevatedButton(
            onPressed: () {
              context.read<UserAuthProvider>().signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
            },
            child:Text("Logout")),
          ],
        ),
      ),
    );
  }
}
