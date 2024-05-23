import 'package:flutter/material.dart';
import 'organization_list_screen.dart';
import 'donate_screen.dart';

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
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
              child: Text('Browse Organizations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonateScreen()),
                );
              },
              child: Text('Donate'),
            ),
          ],
        ),
      ),
    );
  }
}
