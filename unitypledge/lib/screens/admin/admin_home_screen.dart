import 'package:flutter/material.dart';
import 'organization_list_screen.dart';
import 'donation_list_screen.dart';
import 'donor_list_screen.dart';

class AdminHomeScreen extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => OrganizationListScreen()),
                );
              },
              child: Text('Manage Organizations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonationListScreen()),
                );
              },
              child: Text('Manage Donations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorListScreen()),
                );
              },
              child: Text('Manage Donors'),
            ),
          ],
        ),
      ),
    );
  }
}
