import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Profile'),
      ),
      body: FutureBuilder(
        future: _getCurrentUserId(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final String userId = snapshot.data!;
            return DonationList(userId: userId);
          }
        },
      ),
    );
  }

  Future<String> _getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('User not authenticated');
    }
  }
}

class DonationList extends StatelessWidget {
  final String userId;

  DonationList({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('donations')
          .where('donorId', isEqualTo: userId)
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
            final itemName = data['itemName'];
            final status = data['status'];

            return ListTile(
              title: Text(itemName),
              subtitle: Text('ID: $donationId, Status: $status'),
              trailing: status == 'Pending' // Only show cancel button for pending donations
                  ? IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () => _cancelDonation(document.reference),
                    )
                  : null, // Hide cancel button for other statuses
            );
          },
        );
      },
    );
  }

  Future<void> _cancelDonation(DocumentReference donationRef) async {
    try {
      await donationRef.update({'status': 'Cancelled'});
      // Optionally, you can show a confirmation dialog or snackbar here
    } catch (e) {
      // Handle error
      print('Error cancelling donation: $e');
    }
  }
}
