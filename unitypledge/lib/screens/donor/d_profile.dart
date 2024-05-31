import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/donation_model.dart';
import 'package:unitypledge/providers/donation_provider.dart';
import 'package:unitypledge/screens/org/o_donationdetails.dart';

class DonorDetailsPage extends StatelessWidget {
  final Map<String, dynamic> donorDetails;

  const DonorDetailsPage({super.key, required this.donorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donor Profile")),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(18),
          child: Column(
            children: [
              summaryBuilder(context),
              Expanded(child: donorDonations(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryBuilder(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Summary",
          style: TextStyle(fontSize: 27),
        ),
        Column(
          children: donorDetails.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${entry.key}:',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value?.toString() ?? 'N/A',
                      style: const TextStyle(
                          fontSize: 17, fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget donorDonations(BuildContext context) {
    String donorEmail = donorDetails['email'];
    Stream<QuerySnapshot> donationStream =
        context.read<DonationProvider>().getDonorDonations(donorEmail);
    return StreamBuilder<QuerySnapshot>(
      stream: donationStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No Donations Found"),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Donation donation =
                Donation.fromJson(document.data() as Map<String, dynamic>);
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Donation ID: ${document.id}",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonationDetailsPage(
                              donationDetails: donation.toJson(donation),
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.remove_red_eye),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}
