import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'donate_screen.dart';

class OrganizationDonationList extends StatelessWidget {
  final String organizationId;

  OrganizationDonationList({required this.organizationId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('donations')
          .where('organizationId', isEqualTo: organizationId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final donations = snapshot.data!.docs;

        return ListView.builder(
          itemCount: donations.length,
          itemBuilder: (BuildContext context, int index) {
            final DocumentSnapshot document = donations[index];
            final donationId = document.id;
            final data = document.data() as Map<String, dynamic>;
            final donorId = data['donorId'];
            final status = data['status'];

            return ListTile(
              title: Text('Donation ID: $donationId'),
              subtitle: Text('Donor ID: $donorId, Status: $status'),
              // You can add more details or actions here
            );
          },
        );
      },
    );
  }
}