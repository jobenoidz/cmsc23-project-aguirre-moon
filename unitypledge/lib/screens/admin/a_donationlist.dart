import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitypledge/models/donation_model.dart';
import 'package:unitypledge/providers/donation_provider.dart';
import 'package:unitypledge/screens/org/o_donationdetails.dart';

class DonationList extends StatefulWidget {
  const DonationList({super.key});

  @override
  State<DonationList> createState() => _DonationListState();
}


class _DonationListState extends State<DonationList> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donationStream = context.watch<DonationProvider>().donations;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation List"),
      ),
      body: StreamBuilder(
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
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Todos Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Donation donation = Donation.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
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
                            "Donation ID",
                        //donor.id,
                        textAlign: TextAlign.left,
                      )),
                      ElevatedButton(
                          //view donor
                          onPressed: () async {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DonationDetailsPage(donationDetails: donation.toJson(donation))
                                )
                                );
                          },
                          child: const Icon(Icons.remove_red_eye))
                    ],
                  ));
            }),
          );
        },
      ),
    );
  }
}
