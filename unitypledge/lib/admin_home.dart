import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_drawer.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Home')),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('organizations').where('approved', isEqualTo: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty ?? true) {
            return Center(child: Text('No organizations pending approval.'));
          }
          return ListView(
            padding: EdgeInsets.all(8.0),
            children: snapshot.data!.docs.map((doc) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(doc['name']),
                  subtitle: Text(doc['description'] ?? 'No description available.'),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection('organizations').doc(doc.id).update({
                        'approved': true,
                      });
                    },
                    child: Text('Approve'),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
