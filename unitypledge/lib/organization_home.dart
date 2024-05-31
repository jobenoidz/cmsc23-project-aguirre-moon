import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Store organization ID
void storeOrganizationId(String organizationId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('organizationId', organizationId);
}

// Retrieve organization ID
Future<String?> getOrganizationId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('organizationId');
}

class OrganizationHome extends StatelessWidget {
  final String organizationId;

  OrganizationHome({required this.organizationId});

  @override
  Widget build(BuildContext context) {
    // Use organizationId to fetch organization data or display relevant content
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Home'),
      ),
      body: Center(
        child: Text('Organization ID: $organizationId'),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organization App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Routes with organization ID
      routes: {
        '/': (context) => FutureBuilder<String?>(
              future: getOrganizationId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return OrganizationHome(
                    organizationId: snapshot.data!,
                  );
                }
              },
            ),
      },
    );
  }
}
