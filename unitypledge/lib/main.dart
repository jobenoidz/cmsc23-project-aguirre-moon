import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummyproject/donor_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'donor_home.dart';
import 'admin_home.dart';
import 'organization_home.dart';
import 'profile.dart';
import 'donation_drive_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
      routes: {
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/home': (context) => DonorHome(),
        '/adminHome': (context) => AdminHome(),
        '/organizationHome': (context) => OrganizationHome(organizationId: ''), // placeholder for organizationId
        '/profile': (context) => Profile(),
        '/donorProfile': (context) => DonorProfile(),
        '/donationDrives': (context) => DonationDriveList(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          User? user = snapshot.data;
          if (user != null && user.email!.contains('admin')) {
            return AdminHome();
          } else if (user != null && user.email!.contains('org')) {
            // Retrieve organizationId from user email or a specific database query
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('organizations').doc(user.uid).get(),
              builder: (context, orgSnapshot) {
                if (orgSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (orgSnapshot.hasData && orgSnapshot.data != null) {
                  return OrganizationHome(organizationId: orgSnapshot.data!.id);
                }
                return Text('Organization not found');
              },
            );
          } else {
            return DonorHome();
          }
        }
        return SignIn();
      },
    );
  }
}
