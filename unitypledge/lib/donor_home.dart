import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_drawer.dart';
import 'donate_screen.dart';

class DonorHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organizations')),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('organizations').where('approved', isEqualTo: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No organizations found.'));
          }
          return ListView(
            padding: EdgeInsets.all(8.0),
            children: snapshot.data!.docs.map((doc) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.business),
                  ),
                  title: Text(doc['name']),
                  subtitle: Text(doc['description'] ?? 'No description available.'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () async {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      String donorId = user.uid;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonateScreen(
                            organizationId: doc.id,
                            organizationName: doc['name'],
                            donorId: donorId,
                          ),
                        ),
                      );
                    } else {
                      // Handle user not authenticated
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User not authenticated')),
                      );
                    }
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
